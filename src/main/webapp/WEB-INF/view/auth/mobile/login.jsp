<%--
  Created by IntelliJ IDEA.
  User: lihb
  Date: 9/18/16
  Time: 3:27 PM
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
    <title>应用登陆</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="<%=basePath%>/lib/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFFFFF;
            position: relative;
            text-align: center;
            margin: 0;
            padding: 0;
            width: 100%;
            font-size: 20px;
        }

        .header {
            width: 100%;
            height: 50px;
            line-height: 50px;
            box-shadow: 2px 2px 2px #888888;
        }

        .actor img {
            height: 120px;
            width: 120px;
            border-radius: 50%;
            margin-top: 50px;
            margin-bottom: 50px;
            border: solid #CCCCCC 5px;
        }

        .login-btn {
            margin-top: 50px;
        }

        .footer {
            height: 30px;
            font-size: 14px;
            color: #CCCCCC;
        }
    </style>
    <script type='text/javascript' src='<%=basePath%>/js/jQuery-2.1.4.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>/lib/bootstrap-3.3.5-dist/js/bootstrap.min.js'></script>
    <script>
        function confirm() {
            $.ajax({
                url: "<%=basePath%>/auth/login/mobile/confirm?lc=${lc}&userId=${user.userId}&appId=${appid}",
                type: 'get',
                success: function (data) {
                    console.log(data);
                    closeHtml();
                }
            });
        }

        function closeHtml() {
            WeixinJSBridge.call('closeWindow');
        }
    </script>
</head>
<body>
<div class="header">
    应用登陆
</div>

<div class="actor">
    <img src="${user.avatar}">

</div>
<c:if test="${state}">
    <button onclick="confirm()" class="login-btn btn btn-info btn-lg col-xs-8 col-xs-offset-2">
        确认登陆
    </button>
</c:if>
<c:if test="${!state}">
    <div class="no-auth">
        <div class="alert alert-info">
            您没有此应用使用权限
        </div>
        <button class="btn btn-success btn-lg col-xs-8 col-xs-offset-2" onclick="closeHtml()">关闭</button>
    </div>
</c:if>

<div class="footer navbar-fixed-bottom">
    CopyRight gcks.cn
</div>
</body>
</html>
