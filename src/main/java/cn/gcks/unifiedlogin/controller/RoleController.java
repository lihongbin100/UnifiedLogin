package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import cn.gcks.unifiedlogin.entity.TRole;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleRepository roleRepository;
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String show(HttpServletRequest request) {
        List<TRole> roles=roleRepository.findAll();
        request.setAttribute("roles",roles);
        return "role/show";
    }

    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public String addPage() {
        return "role/add";
    }
    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public String editPage(HttpServletRequest request,Integer id) {
        TRole role=roleRepository.findOne(id);
        request.setAttribute("role",role);
        request.setAttribute("edit",true);
        return "role/add";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(TRole role) {
        Result result = new Result();
        try {
            TRole ai = roleRepository.save(role);
            result.setSuccess(true);
            result.setObj(ai);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }

}
