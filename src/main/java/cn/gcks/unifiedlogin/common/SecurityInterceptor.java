package cn.gcks.unifiedlogin.common;

import cn.gcks.unifiedlogin.model.SessionInfo;
import cn.gcks.unifiedlogin.utils.Constants;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 权限拦截器

 *
 */
public class SecurityInterceptor implements HandlerInterceptor {

	/**
	 * 完成页面的render后调用
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception exception) throws Exception {

	}

	/**
	 * 在调用controller具体方法后拦截
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 在调用controller具体方法前拦截
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
		String requestUri = request.getRequestURI();
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(Constants.Config.SESSION_USER_NAME);
//		if (sessionInfo == null || "".equalsIgnoreCase(sessionInfo.getId())) {// 如果没有登录或登录超时
//			request.setAttribute("msg", "您还没有登录或登录已超时，请重新登录，然后再刷新本功能！");
//			if( (RequestMethod.GET).equals(request.getMethod())){
//				request.setAttribute("handlerUrl",requestUri);
//			}
//			response.sendRedirect(basePath+"/auth/login?appId=1");
//			usertype	否	redirect_uri支持登录的类型，有member(成员登录)、admin(管理员登录)、all(成员或管理员皆可登录)，默认值为admin
//			response.sendRedirect("https://qy.weixin.qq.com/cgi-bin/loginpage?corp_id=wxf54e1b5e0b62fa96&redirect_uri=http%3A%2F%2Fwww.wexue.top:8081%2Fauth%2Flogin&usertype=all");
//			return false;
//		}
		return true;
	}
}
