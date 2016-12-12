package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TUser;
import cn.gcks.unifiedlogin.entity.TUserAndMenu;
import cn.gcks.unifiedlogin.model.LoginUser;
import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.repository.MenuRepository;
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
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/loginUser")
public class LoginUserController {
    @Autowired
    UserRepository userRepository;
    @Autowired
    LoginCodeService loginCodeService;
    @Autowired
    UserAndMenuRepository userAndMenuRepository;
    @Value("${unifiedlogin.appid}")
    int appId;
    @Autowired
    MenuRepository menuRepository;


    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(String code, HttpServletRequest request) {
        User user = loginCodeService.getUser(code + appId);
        if (user == null) {
        } else {
            List<TUserAndMenu> tUserAndMenus = userAndMenuRepository.findByUseridAndAgentid(user.getUserId(), appId);
            LoginUser loginUser = new LoginUser();
            loginUser.setUser(new TUser(user.getUserId(), user.getName(), user.getAvatar(), "0"));
            String[] menus = new String[tUserAndMenus.size()];
            for (int i = 0; i < tUserAndMenus.size(); i++) {
                Integer menuId = tUserAndMenus.get(i).getMenuid();
                menus[i] = menuRepository.findOne(menuId).getSign();
            }
            loginUser.setMenus(menus);
            SessionInfo sessionInfo = new SessionInfo();
            sessionInfo.setId(BaseMethod.createUUID("SI"));
            sessionInfo.setLoginUser(loginUser);
            request.setAttribute(Constants.Config.SESSION_USER_NAME, sessionInfo);
        }
        return "loginUser/index";
    }


}
