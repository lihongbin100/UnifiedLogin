package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.dingding.model.DDDepartment;
import cn.gcks.unifiedlogin.dingding.model.DDUser;
import cn.gcks.unifiedlogin.entity.TDepartment;
import cn.gcks.unifiedlogin.entity.TTask;
import cn.gcks.unifiedlogin.entity.TUser;
import cn.gcks.unifiedlogin.entity.TUserAndDepartment;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.model.TaskType;
import cn.gcks.unifiedlogin.repository.DepartmentRepository;
import cn.gcks.unifiedlogin.repository.TaskRepository;
import cn.gcks.unifiedlogin.repository.UserAndDepartmentRepository;
import cn.gcks.unifiedlogin.repository.UserRepository;
import cn.gcks.unifiedlogin.service.CommonService;
import cn.gcks.unifiedlogin.service.DDAPI;
import cn.gcks.unifiedlogin.utils.BaseMethod;
import com.alibaba.fastjson.JSONObject;
import com.foxinmy.weixin4j.exception.WeixinException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserRepository userRepository;
    @Autowired
    DepartmentRepository departmentRepository;
    @Autowired
    DDAPI ddapi;
    @Autowired
    UserWebSocketHandler userWebSocketHandler;
    @Autowired
    UserAndDepartmentRepository userAndDepartmentRepository;
    @Autowired
    TaskRepository taskRepository;
    @Autowired
    CommonService commonService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String show(HttpServletRequest request) {
        Page<TTask> tTasks = taskRepository.findAll(new PageRequest(0, 1, new Sort(Sort.Direction.ASC, "createtime")));
        TTask tTask = new TTask();
        if (tTasks.iterator().hasNext()) {
            tTask = tTasks.iterator().next();
        }
        request.setAttribute("task", tTask);
        return "user/show";
    }

    @RequestMapping(value = "/departmentUsers", method = RequestMethod.GET)
    @ResponseBody
    public Result departmentUsers(int departmentId, int start) {
        Result result = new Result();
        try {
            List<TUser> userLists = new ArrayList<>();
            List<TUserAndDepartment> users = userAndDepartmentRepository.findByDepartmentid(departmentId);
            for (TUserAndDepartment userAndDepartment : users) {
                TUser user = userRepository.findOne(userAndDepartment.getUserid());
                userLists.add(user);
            }
            result.setSuccess(true);
            result.setObj(userLists);
        } catch (Exception e) {
            result.setSuccess(false);
        } finally {
            return result;
        }
    }

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    @ResponseBody
    public Result usersByName(String userName) {
        Result result = new Result();
        List<TUser> users = userRepository.findByNameLike("%" + userName + "%");
        result.setSuccess(true);
        result.setObj(users);
        return result;
    }

    @RequestMapping(value = "/departmentList", method = RequestMethod.GET)
    @ResponseBody
    public Result departmentList() {
        Result result = new Result();
        try {
            List data = commonService.depList();
            result.setSuccess(true);
            result.setObj(data);
        } catch (Exception e) {
            result.setSuccess(false);
        } finally {
            return result;
        }
    }

    @RequestMapping(value = "/updateUsers", method = RequestMethod.GET)
    @ResponseBody
    public Result updateDDUsers(String webSocketId, SessionInfo sessionInfo) {
        Result result = new Result();
        TTask tTask = new TTask();
        if (sessionInfo != null) {
            tTask.setUserid(sessionInfo.getLoginUser().getUser().getUserid());
        }
        tTask.setCreatetime(new Date());
        tTask.setType(TaskType.SYNCLOCATION.name());
        try {
            Set<TDepartment> ds = new HashSet<>();
            Set<TUser> us = new HashSet<>();
            List<DDDepartment> ddDepartments = ddapi.departmentList();
            for (DDDepartment ddDepartment : ddDepartments) {
                //部门保存数据库
                TDepartment department = new TDepartment();
                department.setDepartmentid(ddDepartment.getId());
                department.setDepartmentname(ddDepartment.getName());
                department.setParentid(ddDepartment.getParentid());
                ds.add(department);
                userWebSocketHandler.sendMessageToUser(new TextMessage("USER:更新部门：" + ddDepartment.getName()), webSocketId);
                //保存用户
                List<DDUser> users = ddapi.departmentUsers(ddDepartment.getId());
                for (DDUser ddUser : users) {
                    TUser tUser = new TUser();
                    BeanUtils.copyProperties(ddUser, tUser);
                    tUser.setUpdatetime(BaseMethod.getCurrentTime());
                    TUserAndDepartment tUserAndDepartment = new TUserAndDepartment();
                    tUserAndDepartment.setUserid(ddUser.getUserid());
                    tUserAndDepartment.setDepartmentid(ddDepartment.getId());
                    userAndDepartmentRepository.saveAndFlush(tUserAndDepartment);
                    us.add(tUser);
                }
            }
            departmentRepository.save(ds);
            userRepository.save(us);
            tTask.setState("更新成功");
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMsg(e.getMessage());
            tTask.setState("更新失败，错误信息>" + e.getMessage());
        } finally {
            taskRepository.save(tTask);
            return result;
        }
    }


}
