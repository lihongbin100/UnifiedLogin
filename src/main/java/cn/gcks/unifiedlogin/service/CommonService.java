package cn.gcks.unifiedlogin.service;

import cn.gcks.unifiedlogin.entity.TDepartment;
import cn.gcks.unifiedlogin.entity.TMenu;
import cn.gcks.unifiedlogin.entity.TUserAndAgent;
import cn.gcks.unifiedlogin.entity.TUserAndRole;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.DepartmentRepository;
import cn.gcks.unifiedlogin.repository.MenuRepository;
import cn.gcks.unifiedlogin.repository.UserAndAgentRepository;
import cn.gcks.unifiedlogin.repository.UserAndRoleRepository;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lihb on 11/16/16.
 */
@Service
public class CommonService {
    @Autowired
    private DepartmentRepository departmentRepository;
    @Autowired
    private UserAndRoleRepository userAndRoleRepository;
    @Autowired
    private UserAndAgentRepository userAndAgentRepository;
    @Autowired
    private MenuRepository menuRepository;

    public List depList() {
        List<TDepartment> departments = departmentRepository.findAll();
        List jsonArray = new ArrayList<JSONObject>();
        for (TDepartment department : departments) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", department.getDepartmentid());
            jsonObject.put("name", department.getDepartmentname());
            if (department.getParentid() == null || department.getParentid() == 1) {
                jsonObject.put("open", true);
            } else {
                jsonObject.put("open", false);
            }
            jsonObject.put("pId", department.getParentid());
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    public List menuList(Integer agentId) {
        List<TMenu> menus = menuRepository.findByAgentIdOrderByParentAsc(agentId);
        List jsonArray = new ArrayList<JSONObject>();
        for (TMenu menu : menus) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", menu.getId());
            jsonObject.put("name", menu.getName());
            jsonObject.put("open", true);
            jsonObject.put("pId", menu.getParent());
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    @Transactional
    public Result saveManagers(String[] users, Integer agentId) {
        Result result = new Result();
        try {
            //删除全部
            List<TUserAndAgent> ts = userAndAgentRepository.findByAgentid(agentId);
            userAndAgentRepository.deleteInBatch(ts);
            for (String userId : users) {
                TUserAndAgent ug = new TUserAndAgent();
                ug.setAgentid(agentId);
                ug.setUserid(userId);
                userAndAgentRepository.saveAndFlush(ug);
            }
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getLocalizedMessage());
        } finally {
            return result;
        }
    }

    @Transactional
    public Result saveRole(String[] users, Integer agentId, Integer roleId) {
        for (String user : users) {
            userAndRoleRepository.deleteByUseridAndAgentid(user, agentId);
            TUserAndRole userAndRole = new TUserAndRole();
            userAndRole.setUserid(user);
            userAndRole.setAgentid(agentId);
            userAndRole.setRoleid(roleId);
            userAndRoleRepository.saveAndFlush(userAndRole);
        }
        return new Result(true, "");
    }
}
