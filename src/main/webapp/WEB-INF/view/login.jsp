<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <title>登陆-天天微学</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<%=basePath%>/css/platform.css">
    <style type="text/css">

        body {
            margin: 0px;
            overflow: hidden;
            font-family: Monospace;
            font-size: 13px;
            text-align: center;
            font-weight: bold;
            text-align: center;
            background-color: #cfcfcf;
        }

        a {
            color: #0078ff;
        }

        .login {
            width: 40%;
            height: 400px;
            background-color: rgba(255, 255, 255, 0.5);
            position: absolute;
            top: 15%;
            /*border-radius: 50%;*/
            left: 30%;
            border: solid #CCCCCC 1px;
        }

        .login-text {
            width: 400px;
            margin-top: 10%;
            border: solid #CCCCCC 1px;
        }

        .login-btn {
            width: 200px;
            margin-top: 30px;
            height: 50px;
            border-radius: 10px;
            background-color: cadetblue;
            color: #FFFFFF;
            line-height: 50px;
            font-size: 20px;
            cursor: pointer;
            margin-left: auto;
            margin-right: auto;
        }

        .login-btn:hover {
            background-color: #CCCCCC;
        }

    </style>
    <script>
        function doQYLogin() {
            window.location.href = "https://qy.weixin.qq.com/cgi-bin/loginpage?corp_id=wx2f23249cbbc08dd1&redirect_uri=http%3A%2F%2Fwww.wexue.top:8081%2Fauth%2Flogin";
        }
    </script>
</head>
<body>
<div class="header">
    <nav class="navbar navbar-default navbar-fixed-top">
        <!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
        <div class="container-fluid">
            <div class="navbar-header">
                <img style="border:solid white 2px;height: 40px;margin: 5px 20px 5px 40px;"
                     src="<%=basePath%>/img/logo.png">
            </div>
        </div>
    </nav>
</div>
</div>
<div class="content">
    <iframe style="width: 500px;height: 500px;" src="https://qy.weixin.qq.com/cgi-bin/loginpage?corp_id=wx2f23249cbbc08dd1&redirect_uri=http%3A%2F%2Fwww.wexue.top:8081%2Fauth%2Flogin">

    </iframe>
    <img class="login-text" src="<%=basePath%>/img/logo.png">

    <div class="login-btn" onclick="doQYLogin()">企业号授权登陆</div>
</div>
</body>
</html>
