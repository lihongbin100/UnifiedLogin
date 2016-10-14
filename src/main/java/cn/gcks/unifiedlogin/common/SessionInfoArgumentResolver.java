package cn.gcks.unifiedlogin.common;

import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.utils.Constants;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebArgumentResolver;
import org.springframework.web.context.request.NativeWebRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by lihb on 8/31/16.
 */
public class SessionInfoArgumentResolver implements WebArgumentResolver {
    public Object resolveArgument(MethodParameter methodParameter, NativeWebRequest webRequest) {
        if (methodParameter.getParameterType() != null
                && methodParameter.getParameterType().equals(SessionInfo.class)) {
            // 判断controller方法参数有没有写当前用户，如果有，这里返回即可，通常我们从session里面取出来
            HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
            SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(Constants.Config.SESSION_USER_NAME);
            return sessionInfo;
        }
        return UNRESOLVED;
    }
}