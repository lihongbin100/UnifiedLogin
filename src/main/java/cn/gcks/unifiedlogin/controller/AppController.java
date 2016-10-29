package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import cn.gcks.unifiedlogin.entity.TUser;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.AgentInfoRepository;
import com.foxinmy.weixin4j.qy.model.AgentInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/app")
public class AppController {
    @Autowired
    AgentInfoRepository agentInfoRepository;

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
    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public String editPage(HttpServletRequest request,Integer appId) {
        TAgentInfo agentInfo=agentInfoRepository.findOne(appId);
        request.setAttribute("agentInfo",agentInfo);
        request.setAttribute("edit",true);
        return "app/add";
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
