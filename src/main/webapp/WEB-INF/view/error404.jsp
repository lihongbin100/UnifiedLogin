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
<jsp:include page="header.jsp"></jsp:include>
<!--header-->
<div class="error-content">
    <div class="error_ex">
        <h1>404</h1>

        <h3>Opps, You're lost.</h3>

        <p>We can not find the page you're looking for.</p>
        <a class="btn btn-warning btn-big" href="<%=basePath%>">Back to Home</a></div>

</div>
<jsp:include page="bottom.jsp"></jsp:include>
