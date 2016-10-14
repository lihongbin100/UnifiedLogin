package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TUserAndMenu;
import cn.gcks.unifiedlogin.model.LoginUser;
import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.repository.UserAndMenuRepository;
import cn.gcks.unifiedlogin.repository.UserRepository;
import cn.gcks.unifiedlogin.service.LoginCodeService;
import cn.gcks.unifiedlogin.utils.BaseMethod;
import cn.gcks.unifiedlogin.utils.Constants;
import com.foxinmy.weixin4j.qy.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping
public class IndexController {
    @Autowired
    UserRepository userRepository;
    @Autowired
    LoginCodeService loginCodeService;
    @Autowired
    UserAndMenuRepository userAndMenuRepository;
    @Value("${unifiedlogin.appid}")
    int appId;

    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String error(int type) {
        if (type == 403) {
            return "error403";
        }
        if (type == 404) {
            return "error404";
        }
        if (type == 405) {
            return "error405";
        }
        if (type == 1001) {
            return "error1001";
        }
        return "error500";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public void login(String code, HttpServletRequest request, HttpServletResponse response) {
        User user = loginCodeService.getUser(code + appId);
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        if (user == null) {
            try {
                response.sendRedirect(basePath + "/error?type=1001");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            List<TUserAndMenu> tUserAndMenus = userAndMenuRepository.findByUseridAndAgentid(user.getUserId(), appId);
            LoginUser loginUser = new LoginUser();
            loginUser.setUser(user);
            String[] menus = new String[tUserAndMenus.size()];
            for (int i = 0; i < tUserAndMenus.size(); i++) {
                menus[i] = tUserAndMenus.get(i).getMenusign();
            }
            loginUser.setMenus(menus);
            SessionInfo sessionInfo = new SessionInfo();
            sessionInfo.setId(BaseMethod.createUUID("SI"));
            sessionInfo.setLoginUser(loginUser);
            HttpSession session = request.getSession();
            session.setAttribute(Constants.Config.SESSION_USER_NAME, sessionInfo);
            try {
                response.sendRedirect(basePath + "/");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public void login(HttpSession session, HttpServletResponse response, HttpServletRequest request) {
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        session.removeAttribute(Constants.Config.SESSION_USER_NAME);
        try {
            response.sendRedirect(basePath + "/");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
