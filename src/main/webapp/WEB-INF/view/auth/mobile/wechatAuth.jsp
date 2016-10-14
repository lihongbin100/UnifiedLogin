<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  User: lihb
  Date: 9/30/16
  Time: 5:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
//    response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf54e1b5e0b62fa96&redirect_uri=" + URLEncoder.encode(basePath + "/auth/login/mobile/code?lc=" + request.getAttribute("lc") + "&appid=" + request.getAttribute("appid"), "UTF-8") + "&response_type=code&scope=snsapi_base&state=app1#wechat_redirect");
    response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx2f23249cbbc08dd1&redirect_uri=" + URLEncoder.encode(basePath + "/auth/login/mobile/code?lc=" + request.getAttribute("lc") + "&appid=" + request.getAttribute("appid"), "UTF-8") + "&response_type=code&scope=snsapi_base&state=app1#wechat_redirect");

%>
<html>
<head>
    <title>跳转</title>
</head>
<body>
获取个人信息...
</body>
</html>
