package cn.gcks.unifiedlogin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/app")
public class AppController {
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "app/show";
    }
}
