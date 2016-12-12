package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import cn.gcks.unifiedlogin.entity.TRole;
import cn.gcks.unifiedlogin.entity.TRoleAndMenu;
import cn.gcks.unifiedlogin.entity.TUser;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.repository.*;
import cn.gcks.unifiedlogin.service.CommonService;
import com.alibaba.fastjson.JSONObject;
import com.foxinmy.weixin4j.qy.model.AgentInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleRepository roleRepository;
    @Autowired
    RoleAndMenuRepository roleAndMenuRepository;
    @Autowired
    AgentInfoRepository agentInfoRepository;
    @Autowired
    CommonService commonService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String show(HttpServletRequest request, @RequestParam(required = false, defaultValue = "0") Integer appId) {
        List<TAgentInfo> apps = agentInfoRepository.findAll();
        if (appId == 0) {
            appId = apps.get(0).getId();
        }
        List<TRole> roles = roleRepository.findByAgentId(appId);
        TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
        request.setAttribute("agentInfo", agentInfo);
        request.setAttribute("apps", apps);
        request.setAttribute("roles", roles);
        return "role/show";
    }

    @RequestMapping(value = "/setMenus", method = RequestMethod.GET)
    public String setMenus(HttpServletRequest request, Integer roleId, Integer agentId) {
        TRole role = roleRepository.findOne(roleId);
        List<JSONObject> treeData = commonService.menuListByRole(agentId, roleId);
        request.setAttribute("treeData", treeData);
        request.setAttribute("role", role);
        request.setAttribute("agentId", agentId);
        return "role/menus";
    }

    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public String addPage(Integer agentId, HttpServletRequest request) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(agentId);
        request.setAttribute("agentInfo", agentInfo);
        return "role/add";
    }

    @RequestMapping(value = "/saveMenus", method = RequestMethod.POST)
    @ResponseBody
    public Result saveMenus(TRoleAndMenu roleAndMenu,@RequestParam(value = "menuIds[]") Integer[] menuIds) {
        Result result = new Result();
        try {
            for(Integer menuId:menuIds) {
                roleAndMenu.setMenuid(menuId);
                roleAndMenuRepository.save(roleAndMenu);
            }
            result.setSuccess(true);
            result.setMsg("保存成功");
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }

    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public String editPage(HttpServletRequest request, Integer id) {
        TRole role = roleRepository.findOne(id);
        request.setAttribute("role", role);
        request.setAttribute("edit", true);
        return "role/add";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(TRole role, SessionInfo sessionInfo) {
        Result result = new Result();
        role.setCreateTime(new Date());
        role.setCreateUser(sessionInfo.getId());
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
