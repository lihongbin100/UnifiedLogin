package cn.gcks.unifiedlogin.controller;

import cn.gcks.unifiedlogin.entity.TLog;
import cn.gcks.unifiedlogin.model.Result;
import cn.gcks.unifiedlogin.repository.LogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by lihb on 9/26/16.
 */
@Controller
@RequestMapping("/log")
public class LogController {
    @Autowired
    LogRepository logRepository;
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String show(HttpServletRequest request, @RequestParam(required = false, defaultValue = "0") Integer page, @RequestParam(required = false, defaultValue = "10") Integer size) {
        Page<TLog> logs=logRepository.findAll(new PageRequest(page, size));
        request.setAttribute("logs",logs);
        return "log/show";
    }

    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public String addPage() {
        return "log/add";
    }
    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public String editPage(HttpServletRequest request,Integer id) {
        TLog log=logRepository.findOne(id);
        request.setAttribute("log",log);
        request.setAttribute("edit",true);
        return "log/add";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(TLog log) {
        Result result = new Result();
        try {
            TLog ai = logRepository.save(log);
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
