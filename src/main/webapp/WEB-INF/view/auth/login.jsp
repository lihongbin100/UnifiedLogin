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
    String serverPath = request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <title>登陆</title>
    <link href="<%=basePath%>/lib/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath%>/css/zzsc.css" rel="stylesheet">
    <link rel="icon" href="<%=basePath%>/img/logo.png">
    <style>
        body {
            background-color: #FFFFFF;
            position: relative;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .header {
            height: 50px;
            box-shadow: 2px 2px 2px #888888;
            text-align: left;
        }

        .header img {
            height: 40px;
            margin-top: 5px;
            margin-left: 50px;
        }

        .login-div {
            width: 500px;
            height: 350px;
            background-color: #FFFFFF;
            box-shadow: 2px 2px 2px 2px #888888;
            margin: 100px 50px;
            position: relative;
            float: right;
            display: inline-block;
        }

        #wxQrcode {
            width: 180px;
            height: 180px;
            margin: 50px 0px 0px 50px;
            float: left;
        }
        #ddQrcode {
            width: 180px;
            height: 180px;
            margin: 50px 50px 0px 0px;
            float: right;
        }

        table td {
            border: solid #CCCCCC 1px;
        }

        .footer {
            height: 50px;
            border-top: solid #F2F2F2 1px;
            color: #CCCCCC;
            line-height: 50px;
        }
    </style>
    <script type='text/javascript' src='<%=basePath%>/js/jQuery-2.1.4.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>/lib/bootstrap-3.3.5-dist/js/bootstrap.min.js'></script>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.qrcode.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/socket.min.js"></script>
    <script>
        $(function () {
            var websocket = new SockJS("<%=basePath%>/webSocketServer/login", false);
            websocket.onmessage = function (evnt) {
                $(".progress").hide();
                if (evnt.data.indexOf("login:") > -1) {
                    window.location.href = "${redirect_uri}?code=" + evnt.data.replace("login:", "");
                    return;
                }
                if (evnt.data == "scan:success") {
                    $("#qrcode").html('<div class="label label-success">扫码成功,请确认登陆</div>');
                    return;
                }
                $('#wxQrcode').qrcode({
                    render: "canvas",//设置渲染方式
                    width: 180,     //设置宽度
                    height: 180,     //设置高度
                    background: "#ffffff",//背景颜色
                    foreground: "green",
                    text: '<%=basePath%>/auth/login/mobile?appid=${appid}&lc=' + evnt.data
                });
                $('#ddQrcode').qrcode({
                    render: "canvas",//设置渲染方式
                    width: 180,     //设置宽度
                    height: 180,     //设置高度
                    background: "#ffffff",//背景颜色
                    foreground: "#00BCD4",
                    text: '<%=basePath%>/auth/login/ding?appId=${appid}&lc=' + evnt.data
                });
            };
        });
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="header row">
        <img src="<%=basePath%>/img/logo.png">
    </div>

    <div id="level">
        <div id="content">
            <div id="gears">
                <div id="gears-static"></div>
                <div id="gear-system-1">
                    <div class="shadow" id="shadow15"></div>
                    <div id="gear15"></div>
                    <div class="shadow" id="shadow14"></div>
                    <div id="gear14"></div>
                    <div class="shadow" id="shadow13"></div>
                    <div id="gear13"></div>
                </div>
                <div id="gear-system-2">
                    <div class="shadow" id="shadow10"></div>
                    <div id="gear10"></div>
                    <div class="shadow" id="shadow3"></div>
                    <div id="gear3"></div>
                </div>
                <div id="gear-system-3">
                    <div class="shadow" id="shadow9"></div>
                    <div id="gear9"></div>
                    <div class="shadow" id="shadow7"></div>
                    <div id="gear7"></div>
                </div>
                <div id="gear-system-4">
                    <div class="shadow" id="shadow6"></div>
                    <div id="gear6"></div>
                    <div id="gear4"></div>
                </div>
                <div id="gear-system-5">
                    <div class="shadow" id="shadow12"></div>
                    <div id="gear12"></div>
                    <div class="shadow" id="shadow11"></div>
                    <div id="gear11"></div>
                    <div class="shadow" id="shadow8"></div>
                    <div id="gear8"></div>
                </div>
                <div class="shadow" id="shadow1"></div>
                <div id="gear1"></div>
                <div id="gear-system-6">
                    <div class="shadow" id="shadow5"></div>
                    <div id="gear5"></div>
                    <div id="gear2"></div>
                </div>
                <div class="shadow" id="shadowweight"></div>
                <div id="chain-circle"></div>
                <div id="chain"></div>
                <div id="weight"></div>
            </div>
        </div>
    </div>


    <div class="login-div row">
        <c:if test="${register}">
            <div id="wxQrcode">
                <div class="progress">
                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100"
                         aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                    </div>
                </div>
            </div>

            <div id="ddQrcode">
                <div class="progress">
                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100"
                         aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="label label-success" style="float: left;margin: 30px 0px 0px 100px;">微信扫码登陆</div>
            <div class="label label-info" style="float: right;margin: 30px 100px 0px 0px;">钉钉扫码登陆</div>
        </c:if>
        <c:if test="${!register}">
            <div class="alert alert-danger">
                此应用未注册，或者未配置登录地址，请联系管理员
            </div>
        </c:if>
    </div>
    <div class="footer navbar-fixed-bottom">
        CopyRight GCKS.cn 2016
    </div>
</div>
</body>
</html>
