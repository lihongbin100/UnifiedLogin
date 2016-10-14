package cn.gcks.unifiedlogin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String show() {
        return "user/show";
    }
}
