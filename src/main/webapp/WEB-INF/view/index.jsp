<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="header.jsp"></jsp:include>
<!--header-->
<!--content-->
<div class="content">
    <div class="jumbotron" style="text-align: center">
            <h1>Hello, world!</h1>
    </div>
</div>

<!--content-->

<!--bottom-->
<jsp:include page="bottom.jsp"></jsp:include>
<!--bottom-->
