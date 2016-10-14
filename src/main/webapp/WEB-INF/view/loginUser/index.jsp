<%--
  Created by IntelliJ IDEA.
  User: lihb
  Date: 10/10/16
  Time: 4:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <title>个人中心</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="<%=basePath%>/lib/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type='text/javascript' src='<%=basePath%>/js/jQuery-2.1.4.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>/lib/bootstrap-3.3.5-dist/js/bootstrap.min.js'></script>
    <style>
        .imgDiv {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row navbar-fixed-bottom">
        <div class="col-xs-offset-9 col-xs-2 ">
            <img src="${user.avatar}" class="imgDiv">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <h1>我的应用</h1>
        </div>
    </div>
    <div class="row"></div>
    <div class="row"></div>
    <div class="row"></div>
</div>
</body>
</html>
