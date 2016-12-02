package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.*;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.*;
import cn.gcks.unifiedlogin.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/app")
public class AppController {
    @Autowired
    private AgentInfoRepository agentInfoRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserAndAgentRepository userAndAgentRepository;
    @Autowired
    private UserAndRoleRepository userAndRoleRepository;
    @Autowired
    private CommonService commonService;
    @Autowired
    private RoleRepository roleRepository;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(@RequestParam(required = false, defaultValue = "0") Integer page, @RequestParam(required = false, defaultValue = "10") Integer size, HttpServletRequest request) {
        Page<TAgentInfo> tAgentInfos = agentInfoRepository.findAll(new PageRequest(page, size));
        request.setAttribute("agentInfos", tAgentInfos);
        return "app/show";
    }

    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public String addPage() {
        return "app/add";
    }

    @RequestMapping(value = "/addManagerPage", method = RequestMethod.GET)
    public String addManagerPage(Integer id, HttpServletRequest request) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(id);
        List treeData = commonService.depList();
        List<TUserAndAgent> ts = userAndAgentRepository.findByAgentid(id);
        List<TUser> users = new ArrayList<TUser>();
        for (TUserAndAgent ta : ts) {
            TUser tUser = userRepository.findOne(ta.getUserid());
            users.add(tUser);
        }
        request.setAttribute("managers", users);
        request.setAttribute("agentInfo", agentInfo);
        request.setAttribute("treeData", treeData);
        return "app/addManager";
    }

    @RequestMapping(value = "/managers", method = RequestMethod.GET)
    public String managers(Integer id, HttpServletRequest request) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(id);
        List<TUser> users = userRepository.usersHaveRole(id);
        request.setAttribute("managers", users);
        request.setAttribute("agentInfo", agentInfo);
        return "app/managers";
    }

    @RequestMapping(value = "/menus", method = RequestMethod.GET)
    public String menus(Integer id, HttpServletRequest request) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(id);
        List treeData = commonService.menuList(id);
        List<TUserAndAgent> ts = userAndAgentRepository.findByAgentid(id);
        List<TUser> users = new ArrayList<TUser>();
        for (TUserAndAgent ta : ts) {
            TUser tUser = userRepository.findOne(ta.getUserid());
            users.add(tUser);
        }
        request.setAttribute("managers", users);
        request.setAttribute("agentInfo", agentInfo);
        request.setAttribute("treeData", treeData);
        return "app/menus";
    }

    @RequestMapping(value = "/roles", method = RequestMethod.GET)
    public String roles(Integer id, String[] managers, HttpServletRequest request) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(id);
        List<TUser> users = new ArrayList<TUser>();
        for (String manager : managers) {
            TUser tUser = userRepository.findOne(manager);
            users.add(tUser);
        }
        List<TRole> tr = roleRepository.findByAgentId(id);
        request.setAttribute("roles", tr);
        request.setAttribute("managers", users);
        request.setAttribute("agentInfo", agentInfo);
        return "app/roles";
    }

    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public String editPage(HttpServletRequest request, Integer appId) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
        request.setAttribute("agentInfo", agentInfo);
        request.setAttribute("edit", true);
        return "app/add";
    }

    @RequestMapping(value = "/saveManager", method = RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestParam(value = "users[]") String[] users, Integer agentId) {
        return commonService.saveManagers(users, agentId);
    }

    @RequestMapping(value = "/saveRole", method = RequestMethod.POST)
    @ResponseBody
    public Result saveRole(@RequestParam(value = "users[]") String[] users, Integer agentId, Integer roleId) {
        return commonService.saveRole(users, agentId, roleId);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(TAgentInfo agentInfo) {
        Result result = new Result();
        try {
            TAgentInfo ai = agentInfoRepository.save(agentInfo);
            result.setSuccess(true);
            result.setObj(ai);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @ResponseBody
    public Result delete(Integer appId) {
        Result result = new Result();
        try {
            agentInfoRepository.delete(appId);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }
}
