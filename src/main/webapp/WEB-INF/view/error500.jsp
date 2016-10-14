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
        <h1>500</h1>

        <h3>Something is wrong here. Method not allowed!</h3>

        <p>Access to this page is forbidden</p>
        <a class="btn btn-warning btn-big" href="<%=basePath%>">Back to Home</a></div>
</div>
<!--Footer-part-->
<jsp:include page="bottom.jsp"></jsp:include>