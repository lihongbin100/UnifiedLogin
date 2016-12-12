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
    <title>应用登陆-钉钉登陆</title>
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
            margin-bottom: 20px;
            border: solid #CCCCCC 5px;
            background-color: #F2F2F2;
        }

        .login-btn {
            margin-top: 20px;
        }

        .footer {
            height: 30px;
            font-size: 14px;
            color: #CCCCCC;
        }

        .hidden {
            display: none;
        }
    </style>
    <script type='text/javascript' src='<%=basePath%>/js/jQuery-2.1.4.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>/lib/bootstrap-3.3.5-dist/js/bootstrap.min.js'></script>
    <%--钉钉js--%>
    <script type="text/javascript" src="http://g.alicdn.com/dingding/open-develop/0.8.4/dingtalk.js"></script>
    <script>
        var userid = "";
        dd.config({
            debug: true,
            agentId: '${jsApiConfig.agentId}', // 必填，微应用ID
            corpId: '${jsApiConfig.corpId}',//必填，企业ID
            timeStamp: "${jsApiConfig.timeStamp}", // 必填，生成签名的时间戳
            nonceStr: '${jsApiConfig.nonceStr}', // 必填，生成签名的随机串
            signature: '${jsApiConfig.signature}', // 必填，签名
            type: 0,   //选填。0表示微应用的jsapi,1表示服务窗的jsapi。不填默认为0。该参数从dingtalk.js的0.8.3版本开始支持
            jsApiList: ['runtime.info', 'biz.contact.choose',
                'device.notification.confirm', 'device.notification.alert',
                'device.notification.prompt', 'biz.ding.post',
                'biz.util.openLink', 'biz.user.get']
        });
        dd.ready(function () {

            dd.biz.user.get({
                onSuccess: function (info) {
                    userid = info.emplId;
                    $("#avatarImg").attr("src", info.avatar);
                    $("#manager").text(info.nickName);
                    $.ajax({
                        url: "<%=basePath%>/auth/login/ding/user?userid=" + info.emplId + "&appid=${agentInfo.id}&lc=${lc}",
                        type: 'get',
                        success: function (data) {
//                            alert(JSON.stringify(data.success));
                            if (data.success) {
                                $("#auth").removeClass("hidden");
                                $("#noAuth").addClass("hidden");
                            } else {
                                $("#auth").addClass("hidden");
                                $("#noAuth").removeClass("hidden");
                            }
                        }
                    });
                },
                onFail: function (err) {
                    $("#auth").hide();
                    $("#noAuth").show();
                }
            });

            <%--dd.runtime.permission.requestAuthCode({--%>
            <%--corpId: "${jsApiConfig.corpId}",--%>
            <%--onSuccess: function (result) {--%>
            <%--$(".header").html(JSON.stringify(result));--%>

            <%--},--%>
            <%--onFail: function (err) {--%>

            <%--}--%>
            <%--})--%>


        });

        dd.error(function (error) {
            alert('dd error: ' + JSON.stringify(error));
        });


        function confirm() {
            <%--$(".header").html("<%=basePath%>/auth/login/ding/confirm?lc=${lc}&userId="+userid+"&appId=${appid}");--%>
            $.ajax({
                url: "<%=basePath%>/auth/login/ding/confirm?lc=${lc}&userId=" + userid + "&appId=${agentInfo.id}",
                type: 'get',
                success: function (data) {
                    var msg = data.msg;
                    if (data.success) {
                        msg = "登陆成功";
                    }
                    dd.device.notification.alert({
                        message: msg,
                        title: "提示",//可传空
                        buttonName: "确定",
                        onSuccess: function () {
                            //onSuccess将在点击button之后回调
                            /*回调*/
                        },
                        onFail: function (err) {
                        }
                    });

                }
            });
        }
        function closeHtml() {
        }
    </script>
</head>
<body>
<div class="header">
    <img src="<%=basePath%>/img/logo.png" style="height: 98%">
</div>

<div class="actor row">
    <img src="<%=basePath%>/img/avator.gif" id="avatarImg">
    <br>
    <label id="manager"></label>
</div>
<div class="row">
    <br>
    登陆应用：<label class="label label-success">${agentInfo.name}</label>
    <hr>
    <button onclick="confirm()" id="auth" class="hidden login-btn btn btn-info btn-lg col-xs-8 col-xs-offset-2">
        确认登陆
    </button>
</div>
<div class="no-auth hidden" id="noAuth">
    <div class="alert alert-info">
        您没有此应用使用权限
    </div>
    <button class="btn btn-success btn-lg col-xs-8 col-xs-offset-2" onclick="closeHtml()">关闭</button>
</div>
<div class="alert alert-info" style="margin: 30px;text-align: left;font-size: 14px">
    欢迎使用钉钉登陆登陆国创科视应用系统，如有问题请发送邮件到<span style="color: #953b39"> lihb@gcks.cn</span>
</div>
<div class="footer navbar-fixed-bottom">
    CopyRight gcks.cn
</div>
</body>
</html>
