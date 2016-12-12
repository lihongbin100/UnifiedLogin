<%--
  Created by IntelliJ IDEA.
  User: lihb
  Date: 10/1/15
  Time: 2:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="en" ng-app="gcks-ul">
<head>
    <title>国创科视-统一登录系统</title>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0,initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="<%=basePath%>/lib/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/css/animate.css"/>
    <link rel="stylesheet" href="<%=basePath%>/css/platform.css"/>
    <link href="<%=basePath%>/img/dep_icon.jpg" rel="shortcut icon">
    <script src="<%=basePath%>/js/jQuery-2.1.4.min.js"></script>
    <script src="<%=basePath%>/js/jquery.form.js"></script>
    <script src="<%=basePath%>/lib/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>/lib/angularjs/angular.min.js"></script>
    <script src="<%=basePath%>/js/common.js"></script>
</head>
<body>

<div id="tip" class="tip alert alert-success animated bounceInRight hidden">
    操作成功
</div>
<div class="header">
    <nav class="navbar navbar-default navbar-fixed-top">
        <!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
        <div class="container-fluid">
            <div class="navbar-header">
                <a href="<%=basePath%>/"> <img style="height: 40px;margin: 5px 20px 5px 40px;"
                                               src="<%=basePath%>/img/logo.png"></a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-6">
                <ul class="nav navbar-nav" id="menu">
                    <li role="presentation">
                        <a href="<%=basePath%>/"><i class="glyphicon glyphicon-home"></i>
                            <span>首页</span></a>
                    </li>
                    <c:if test="${fn:contains(fn:join(userinfo.loginUser.menus,';'),'yygl')}">
                        <li role="presentation">
                            <a href="<%=basePath%>/app"><i class="glyphicon glyphicon-th"></i>
                                <span>应用管理</span></a>
                        </li>
                    </c:if>
                    <c:if test="${fn:contains(fn:join(userinfo.loginUser.menus,';'),'yhgl')}">
                        <li role="presentation">
                            <a href="<%=basePath%>/user"><i class="glyphicon glyphicon-user"></i>
                                <span>用户管理</span></a>
                        </li>
                    </c:if>
                    <c:if test="${fn:contains(fn:join(userinfo.loginUser.menus,';'),'jsgl')}">
                        <li role="presentation">
                            <a href="<%=basePath%>/role"><i class="glyphicon glyphicon-flag"></i>
                                <span>角色管理</span></a>
                        </li>
                    </c:if>
                    <c:if test="${fn:contains(fn:join(userinfo.loginUser.menus,';'),'cdgl')}">
                        <li role="presentation">
                            <a href="<%=basePath%>/menu"><i class="glyphicon glyphicon-list-alt"></i>
                                <span>菜单管理</span></a>
                        </li>
                    </c:if>
                    <c:if test="${fn:contains(fn:join(userinfo.loginUser.menus,';'),'rzgl')}">
                        <li role="presentation">
                            <a href="<%=basePath%>/log">
                                <i class="glyphicon glyphicon-volume-up"></i> <span>日志管理</span>
                            </a>
                        </li>
                    </c:if>
                </ul>

                <ul class="nav navbar-nav" style="float: right">
                    <li role="presentation">
                        <a href="<%=basePath%>/">
                            <img src="${userinfo.loginUser.user.avatar}" style="height: 40px;margin-top: -20px;">
                            <span
                                    class="div-user">${userinfo.loginUser.user.name}</span>
                        </a>
                    </li>
                    <li role="presentation">
                        <a href="<%=basePath%>/auth/logout">
                            <i class="glyphicon glyphicon-off div-user"></i> <span class="div-user">退出</span>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
    </nav>
</div>


