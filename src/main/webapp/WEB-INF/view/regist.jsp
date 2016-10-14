<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>天天微学-登陆</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="<%=basePath%>/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/css/bootstrap-responsive.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/css/matrix-login.css"/>
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

</head>
<body>
<div id="loginbox">
    <form id="form_reg" class="form-vertical" action="<%=basePath%>/user/reg" method="post">
        <div class="control-group normal_text"><h3><img src="${userheader}" style="width: 50px;height: 50px" alt="Logo"/></h3></div>

        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-home"></i></span><input type="text"
                                                                                      placeholder="企业号" name="corpid"
                                                                                      value="${corpid}"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-user"></i></span><input type="text"
                                                                                      placeholder="用户名"
                                                                                      id="rusername"
                                                                                      name="rusername"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" id="rpassword"
                                                                                      placeholder="密码"
                                                                                      name="rpassword"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" id="rpasswordr"
                                                                                      placeholder="重新输入密码"
                                                                                      name="rpasswordr"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-phone"></i></span><input type="text"
                                                                                      placeholder="手机号" name="tel"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <button class="login_btn btn-success" type="button" onclick="doReg()"> 注册
                    </button>
                    </span>
                </div>
            </div>
        </div>
    </form>
</div>

<script src="<%=basePath%>/js/jquery.min.js"></script>
<script src="<%=basePath%>/js/jquery.form.js"></script>
<script src="<%=basePath%>/js/matrix.login.js"></script>
<script>

    function doReg() {
        //autoApply();//暂时去掉记住账号的功能

        //var dqdp = new Dqdp();
        //个人网页版
        if ($("#rusername").val() == "") {
            alert("请输入账号");
            return;
        }
        if ($("#rpassword").val() == "") {
            alert("请输入密码");
            return;
        }
        if ($("#rpasswordr").val() != $("#rpassword").val()) {
            alert("密码不一致");
            return;
        }
        $('#form_reg').ajaxSubmit({
            url: "/user/reg",
            dataType: "text",
            success: function (data) {
                var json= $.parseJSON(data);
                if (json.success) {
                    window.location.href="<%=basePath%>/login";
                } else {
                    alert(json.msg);
                }
            }
        });
    }
</script>
</body>

</html>
