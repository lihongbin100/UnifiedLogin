package cn.gcks.unifiedlogin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String show() {
        return "role/show";
    }
}