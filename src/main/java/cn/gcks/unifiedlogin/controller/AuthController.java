package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.dingding.model.JsApiConfig;
import cn.gcks.unifiedlogin.entity.*;
import cn.gcks.unifiedlogin.model.LoginUser;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.repository.*;
import cn.gcks.unifiedlogin.service.CommonService;
import cn.gcks.unifiedlogin.service.DDAPI;
import cn.gcks.unifiedlogin.service.LoginCodeService;
import cn.gcks.unifiedlogin.service.QyAPI;
import cn.gcks.unifiedlogin.utils.BaseMethod;
import cn.gcks.unifiedlogin.utils.Constants;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.qy.message.NotifyMessage;
import com.foxinmy.weixin4j.qy.model.IdParameter;
import com.foxinmy.weixin4j.qy.model.User;
import com.foxinmy.weixin4j.tuple.News;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created by lihb on 9/5/15.
 */
@Controller
@RequestMapping("/auth")
@Slf4j
public class AuthController {
    @Autowired
    private QyAPI qyAPI;
    @Autowired
    private DDAPI ddapi;
    @Autowired
    private LoginCodeService loginCodeService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserAndAgentRepository userAndAgentRepository;
    @Autowired
    private AgentInfoRepository agentInfoRepository;
    @Autowired
    private LoginWebSocketHandler loginWebSocketHandler;
    @Autowired
    private UserAndMenuRepository userAndMenuRepository;
    @Autowired
    private UserAndRoleRepository userAndRoleRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private MenuRepository menuRepository;
    @Autowired
    private RoleAndMenuRepository roleAndMenuRepository;

    @Autowired
    private CommonService commonService;
    @Value("${wx.auth_redirect_url}")
    private String wxAuthRedirectUrl;
    @Value("${app.id}")
    private String wxAppId;
    @Value("${dd.auth_redirect_url}")
    private String ddAuthRedirectUrl;
    @Value("${dd.appid}")
    private String ddAppId;
    @Value("${unifiedlogin.appid}")
    private Integer unifiedLoginAppId;


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Integer appId, HttpServletRequest request) {
        //判断appId是否有,判断是否是信任地址
        TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
        if (agentInfo == null) {
            request.setAttribute("register", false);
        } else {
            request.setAttribute("redirect_uri", agentInfo.getLoginUrl());
            request.setAttribute("appid", appId);
            request.setAttribute("register", true);
        }
        request.setAttribute("agentInfo", agentInfo);
        return "auth/login";
    }

    @RequestMapping(value = "/login/mobile", method = RequestMethod.GET)
    public String mobile(String lc, Integer appid, HttpServletRequest request) throws UnsupportedEncodingException {
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Cookie[] cookies = request.getCookies();
        request.setAttribute("appid", appid);
        request.setAttribute("lc", lc);
        if (cookies != null && cookies.length != 0) {
            for (Cookie cookie : cookies) {
                if ("authUserId".equals(cookie.getName()) && cookie.getValue() != null && cookie.getValue() != "") {
                    User user = null;
                    try {
                        user = qyAPI.getUser(cookie.getValue());
                        List<TUserAndAgent> apps = userAndAgentRepository.findByUseridAndAgentid(user.getUserId(), appid);
                        if (apps != null && apps.size() != 0) {
                            //有权限
                            request.setAttribute("state", true);
                            loginCodeService.cacheUser(lc + appid, user);
                            loginWebSocketHandler.sendMessageToUser(new TextMessage("scan:success"), lc);
                        } else {
                            request.setAttribute("state", false);
                        }
                        request.setAttribute("user", user);
                    } catch (Exception e) {
                        //报错 重新获取cookie
                        return "redirect:" + String.format(wxAuthRedirectUrl, wxAppId, URLEncoder.encode(basePath + "/auth/login/mobile/code?lc=" + request.getAttribute("lc") + "&appid=" + request.getAttribute("appid"), "UTF-8"), "app1");
                    }
                    return "auth/mobile/wxLogin";
                }
            }
        }
        return "redirect:" + String.format(wxAuthRedirectUrl, wxAppId, URLEncoder.encode(basePath + "/auth/login/mobile/code?lc=" + request.getAttribute("lc") + "&appid=" + request.getAttribute("appid"), "UTF-8"), "app1");
    }

    /**
     * 企业号使用
     *
     * @param lc
     * @param appid
     * @param code
     * @param request
     * @param response
     * @return
     * @throws WeixinException
     */
    @RequestMapping(value = "/login/mobile/code", method = RequestMethod.GET)
    public String mobileCode(String lc, Integer appid, String code, HttpServletRequest request, HttpServletResponse response) throws WeixinException {
        if (code != null && !"".equals(code)) {
            //添加user到redis
            try {
                User user = qyAPI.getUserByCode(code);
                request.setAttribute("user", user);
                request.setAttribute("lc", lc);
                //添加cookie
                Cookie cookie = new Cookie("authUserId", user.getUserId());
                response.addCookie(cookie);
                List<TUserAndAgent> apps = userAndAgentRepository.findByUseridAndAgentid(user.getUserId(), appid);
                if (apps != null && apps.size() != 0) {
                    //有权限
                    request.setAttribute("state", true);
                    request.setAttribute("appid", appid);
                    loginCodeService.cacheUser(lc + appid, user);
                    loginWebSocketHandler.sendMessageToUser(new TextMessage("scan:success"), lc);
                } else {
                    request.setAttribute("state", false);
                }
            } catch (Exception e) {
                request.setAttribute("state", false);
                return "auth/mobile/wxlogin";
            }
        }
        return "auth/mobile/wxlogin";
    }


    /**
     * 打开钉钉确认登陆页面 并获取用户信息
     *
     * @param lc
     * @param appId
     * @param request
     * @return
     */
    @RequestMapping(value = "/login/ding", method = RequestMethod.GET)
    public String dingLogin(String lc, Integer appId, HttpServletRequest request) {
        try {
            String urlString = request.getRequestURL().toString();
            String queryString = request.getQueryString();
            String queryStringEncode = null;
            String url;
            TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
            if (queryString != null) {
                queryStringEncode = URLDecoder.decode(queryString);
                url = urlString + "?" + queryStringEncode;
            } else {
                url = urlString;
            }
            JsApiConfig js = ddapi.jsApiConfig(url);
            request.setAttribute("jsApiConfig", js);
            request.setAttribute("lc", lc);
            request.setAttribute("agentInfo", agentInfo);
            request.setAttribute("url", url);
            loginWebSocketHandler.sendMessageToUser(new TextMessage("scan:success"), lc);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return "auth/mobile/ddlogin";
    }

    /**
     * 企业号登陆 暂时不用
     *
     * @param lc
     * @param userId
     * @param appId
     * @param request
     * @return
     */
    @RequestMapping(value = "/login/mobile/confirm", method = RequestMethod.GET)
    @ResponseBody
    public Result mobileConfirm(String lc, String userId, int appId, HttpServletRequest request) {
        //判断其对应用是否有权限
        Result result = new Result(true, "");
        loginWebSocketHandler.sendMessageToUser(new TextMessage("login:" + lc), lc);
        try {
            TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
            IdParameter idParameter = new IdParameter();
            idParameter.putUserIds(userId);
            News news = new News();
            String path = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
            news.addArticle("登陆提醒", "您登录了国创科视的内部应用\n\n 应用ID：" + appId + "\n 应用名：" + agentInfo.getName() + "\n", "", basePath + "/loginUser/index?userId=" + userId);
            qyAPI.sendNotifyMessage(new NotifyMessage(0, news, idParameter, false));
        } catch (WeixinException e) {
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 钉钉扫码登陆
     *
     * @return
     * @throws WeixinException
     */
    @RequestMapping(value = "/login/ding/user", method = RequestMethod.GET)
    @ResponseBody
    public Result getUserInfo(String userid, String lc, Integer appid) {
        Result result = new Result();
        if (userid != null && !"".equals(userid)) {
            try {
                List<TUserAndAgent> apps = userAndAgentRepository.findByUseridAndAgentid(userid, appid);
                if (apps != null && apps.size() != 0) {
                    //有权限
                    loginWebSocketHandler.sendMessageToUser(new TextMessage("scan:success"), lc);
                    result.setSuccess(true);
                } else {
                    result.setSuccess(false);
                    result.setMsg("对该应用无权限");
                }
            } catch (Exception e) {
                result.setSuccess(false);
                result.setObj(e);
                result.setMsg(e.getLocalizedMessage());
            }
        } else {
            result.setSuccess(false);
            result.setMsg("code 不能为空");
        }
        return result;
    }

    /**
     * 钉钉手机端 登陆确认
     *
     * @param lc
     * @param userId
     * @param appId
     * @return
     */
    @RequestMapping(value = "/login/ding/confirm", method = RequestMethod.GET)
    @ResponseBody
    public Result dingConfirm(String lc, String userId, int appId) {
        //判断其对应用是否有权限
        List<TUserAndAgent> apps = userAndAgentRepository.findByUseridAndAgentid(userId, appId);
        Result result = new Result(true, "");
        if (apps != null && apps.size() != 0) {
            TUser ddUser = userRepository.findOne(userId);
            User user = new User(ddUser.getUserid(), ddUser.getName());
            user.setAvatar(ddUser.getAvatar());
            user.setEmail(ddUser.getEmail());
            loginCodeService.cacheUser(lc + appId, user);
            loginWebSocketHandler.sendMessageToUser(new TextMessage("login:" + lc), lc);
        } else {
            result.setSuccess(false);
            result.setMsg("没有权限");
        }
        return result;
    }

    /**
     * 使用手机号验证用户是否有权限
     *
     * @param tel
     * @return
     */
    @RequestMapping(value = "/userCheck", method = RequestMethod.GET)
    @ResponseBody
    public Result userCheck(String tel) {
        Result result = new Result();
        try {
            TUser tUser = userRepository.findByMobile(tel);
            if (tUser == null) {
                result.setSuccess(false);
            } else {
                result.setSuccess(true);
                result.setObj(tUser);
            }
        } catch (Exception e) {
            result.setSuccess(false);
        } finally {
            return result;
        }
    }

    /**
     * 通过CODE获取用户信息和菜单权限
     *
     * @param code
     * @param appId
     * @return
     */
    @RequestMapping(value = "/user/code", method = RequestMethod.GET)
    @ResponseBody
    public Result loginCode(String code, Integer appId, HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        User user = loginCodeService.getUser(code + appId);
        Result result = new Result();
        if (user == null) {
            result.setSuccess(false);
            result.setMsg("CODE不存在或者已过期");
        } else {
            LoginUser loginUser = new LoginUser();
            loginUser.setUser(new TUser(user.getUserId(), user.getName(), user.getAvatar(), "0"));

            TUserAndRole tUserAndRole = userAndRoleRepository.findByUseridAndAgentid(user.getUserId(), appId);
            if (tUserAndRole != null) {
                TRole tr = roleRepository.findOne(tUserAndRole.getRoleid());
                loginUser.setRole(tr);
                if (tr != null && tr.getId() != null) {
                    List<TMenu> tMenus = roleAndMenuRepository.findMenusByRoleidAndAgentid(tr.getId(), appId);
                    String[] menus = new String[tMenus.size()];
                    for (int i = 0; i < tMenus.size(); i++) {
                        menus[i] = tMenus.get(i).getSign();
                    }
                    loginUser.setMenus(menus);
                }
            }

            List<TUserAndMenu> tUserAndMenus = userAndMenuRepository.findByUseridAndAgentid(user.getUserId(), appId);
            String[] menus = new String[tUserAndMenus.size()];
            for (int i = 0; i < tUserAndMenus.size(); i++) {
                Integer menuId = tUserAndMenus.get(i).getMenuid();
                menus[i] = menuRepository.findOne(menuId).getSign();
            }
            if (tUserAndMenus != null && tUserAndMenus.size() != 0) {
                loginUser.setMenus(menus);
            }
            result.setSuccess(true);
            result.setObj(loginUser);
        }
        if (result.isSuccess()) {
            commonService.loginLog(user.getUserId(), "登陆", appId);
        } else {
            commonService.loginLog("", "登陆失败：user为空" + result.getMsg(), appId);
        }
        return result;
    }


    /**
     * 登陆本系统
     *
     * @param code
     * @param request
     * @return
     */
    @RequestMapping(value = "/loginThis", method = RequestMethod.GET)
    public String loginThis(String code, HttpServletRequest request) {
        User user = loginCodeService.getUser(code + unifiedLoginAppId);
        if (user == null) {
        } else {
            List<TUserAndMenu> tUserAndMenus = userAndMenuRepository.findByUseridAndAgentid(user.getUserId(), unifiedLoginAppId);
            LoginUser loginUser = new LoginUser();
            loginUser.setUser(new TUser(user.getUserId(), user.getName(), user.getAvatar(), "0"));
            String[] menus = new String[tUserAndMenus.size()];
            for (int i = 0; i < tUserAndMenus.size(); i++) {
                Integer menuId = tUserAndMenus.get(i).getMenuid();
                menus[i] = menuRepository.findOne(menuId).getSign();
            }
            TRole role = userAndRoleRepository.findRoleByByUseridAndAgentid(user.getUserId(), unifiedLoginAppId);
            loginUser.setMenus(menus);
            loginUser.setRole(role);
            SessionInfo sessionInfo = new SessionInfo();
            sessionInfo.setId(user.getUserId());
            sessionInfo.setLoginUser(loginUser);
            request.getSession().setAttribute(Constants.Config.SESSION_USER_NAME, sessionInfo);
            commonService.loginLog(user.getUserId(), "登陆", unifiedLoginAppId);
        }
        return "redirect:/";

    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String login(HttpSession session, HttpServletResponse response, HttpServletRequest request) {
        session.removeAttribute(Constants.Config.SESSION_USER_NAME);
        return "redirect:/";
    }
}
