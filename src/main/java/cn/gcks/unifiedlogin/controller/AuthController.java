package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import cn.gcks.unifiedlogin.entity.TUserAndAgent;
import cn.gcks.unifiedlogin.entity.TUserAndMenu;
import cn.gcks.unifiedlogin.model.LoginUser;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.AgentInfoRepository;
import cn.gcks.unifiedlogin.repository.UserAndAgentRepository;
import cn.gcks.unifiedlogin.repository.UserAndMenuRepository;
import cn.gcks.unifiedlogin.service.LoginCodeService;
import cn.gcks.unifiedlogin.service.QyAPI;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.qy.message.NotifyMessage;
import com.foxinmy.weixin4j.qy.model.IdParameter;
import com.foxinmy.weixin4j.qy.model.User;
import com.foxinmy.weixin4j.tuple.News;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    private LoginCodeService loginCodeService;
    @Autowired
    private UserAndAgentRepository userAndAgentRepository;
    @Autowired
    private AgentInfoRepository agentInfoRepository;
    @Autowired
    private LoginWebSocketHandler loginWebSocketHandler;
    @Autowired
    private UserAndMenuRepository userAndMenuRepository;

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
        return "auth/login";
    }

    @RequestMapping(value = "/login/mobile", method = RequestMethod.GET)
    public String mobile(String lc, Integer appid, HttpServletRequest request) {
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
                        return "auth/mobile/wechatAuth";
                    }
                    return "auth/mobile/login";
                }
            }
        }
        return "auth/mobile/wechatAuth";
    }

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
                return "auth/mobile/login";
            }
        }
        return "auth/mobile/login";
    }

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

    @RequestMapping(value = "/user/code", method = RequestMethod.GET)
    @ResponseBody
    public Result loginCode(String code, Integer appId) {
        User user = loginCodeService.getUser(code + appId);
        Result result = new Result();
        if (user == null) {
            result.setSuccess(false);
            result.setMsg("CODE不存在或者已过期");
        } else {
            List<TUserAndMenu> tUserAndMenus = userAndMenuRepository.findByUseridAndAgentid(user.getUserId(), appId);
            LoginUser loginUser = new LoginUser();
            loginUser.setUser(user);
            String[] menus = new String[tUserAndMenus.size()];
            for (int i = 0; i < tUserAndMenus.size(); i++) {
                menus[i] = tUserAndMenus.get(i).getMenusign();
            }
            loginUser.setMenus(menus);
            result.setSuccess(true);
            result.setObj(loginUser);
        }
        return result;
    }
}
