package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import cn.gcks.unifiedlogin.entity.TMenu;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.AgentInfoRepository;
import cn.gcks.unifiedlogin.repository.MenuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    MenuRepository menuRepository;
    @Autowired
    AgentInfoRepository agentInfoRepository;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(@RequestParam(required = false, defaultValue = "0") Integer appId, HttpServletRequest request) {
        List<TAgentInfo> apps = agentInfoRepository.findAll();
        if (appId == 0) {
            appId = apps.get(0).getId();
        }
        TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
        List<TMenu> menus = menuRepository.findByAgentIdOrderByParentAsc(appId);
        List<TMenu> ts = new ArrayList<>();
        request.setAttribute("agentInfo", agentInfo);
        request.setAttribute("apps", apps);
        request.setAttribute("menus", menuTree(menus, 0, ts));
        return "menu/show";
    }

    private List menuTree(List<TMenu> menus, int m, List<TMenu> ts) {
        for (TMenu menu : menus) {
            if (m == menu.getParent()) {
                ts.add(menu);
                menuTree(menus, menu.getId(), ts);
            }
        }
        return ts;
    }

    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public String addPage(Integer appId, Integer menuId, HttpServletRequest request) {
        TAgentInfo agentInfo = agentInfoRepository.findOne(appId);
        TMenu cMenu = null;
        if (menuId == 0) {
            cMenu = new TMenu();
            cMenu.setId(0);
            cMenu.setName(agentInfo.getName() + "的菜单");
        } else {
            cMenu = menuRepository.findOne(menuId);
        }
        request.setAttribute("cMenu", cMenu);
        request.setAttribute("agent", agentInfo);
        return "menu/add";
    }

    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public String editPage(HttpServletRequest request, Integer id) {
        TMenu menu = menuRepository.findOne(id);
        request.setAttribute("menu", menu);
        request.setAttribute("edit", true);
        return "menu/add";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(TMenu menu) {
        Result result = new Result();
        try {
            TMenu tMenu = menuRepository.save(menu);
            result.setSuccess(true);
            result.setObj(tMenu);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @ResponseBody
    public Result delete(Integer id, Integer agentId) {
        Result result = new Result();
        try {
            List<TMenu> ms = menuRepository.findByAgentIdAndParent(agentId, id);
            deleteAll(ms,agentId);
            menuRepository.delete(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }

    private void deleteAll(List<TMenu> ms, int agentId) {
        if (ms != null && ms.size() != 0) {
            for (TMenu m : ms) {
                menuRepository.delete(m.getId());
                List<TMenu> mss = menuRepository.findByAgentIdAndParent(agentId, m.getId());
                deleteAll(mss, agentId);
            }
        }
    }
}

