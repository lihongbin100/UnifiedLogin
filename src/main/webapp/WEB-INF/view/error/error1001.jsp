<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="../common/header.jsp"></jsp:include>
<!--header-->
<div class="error-content">
    <div class="error_ex">
        <h1>1001</h1>

        <h3>Code非法，请重新登陆</h3>

        <p>Access to this page is forbidden</p>
        <a class="btn btn-warning btn-big" href="<%=basePath%>">重新登录</a></div>
</div>
<!--Footer-part-->
<jsp:include page="../common/bottom.jsp"></jsp:include>