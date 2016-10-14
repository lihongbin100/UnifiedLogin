<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="keywords" content="天天微学,微信,移动办公">
  <meta name="description" content="">
  <title>登陆-天天微学</title>
  <script src="<%=basePath%>/js/jQuery-2.1.4.min.js"></script>
  <script src="<%=basePath%>/js/jquery.form.js"></script>
  <style>
    body {
      margin: 0px;
    }

    a {
      text-decoration: none;
    }

    .index_text:hover {
      color: green;
      background-color: white;
    }

    .logo {
      margin-left: 100px;
    }
    .footer {
      background-color: #f4f3f3;
      border-top: solid #dddddd 1px;
      height: 50px;
      bottom: 0px;
      padding-top: 20px;
      width: 100%;
      color: #f87b00;
    }

    .index {
      float: right;
      margin-top: 15px;
      margin-right: 200px;
    }

    .header {
      background-color: rgba(250, 250, 250, 0.9);
      height: 69px;
      width: 100%;
      z-index: 999;
      top: 0px;
      border-bottom: 1px solid #dcdbdb;
    }

    .mind-container {
      height: 500px;
      width: 100%;
      background: url(/img/cms/bg_qy.jpg) repeat-y;
    }

    .login_box {
      width: 300px;
      height: auto;
      float: right;
      margin-top: 50px;
      margin-right: 100px;
      border: solid #cccccc 1px;
      background-color: white;
      border-radius: 5px;
      padding: 20px;
    }

    input {
      border: solid green 1px;
      height: 30px;
      width: 280px;
      margin-bottom: 20px;
      border-radius: 3px;
    }

    .login_btn {
      width: 300px;
      background-color: green;
      height: 80px;
      border: solid #ececec 1px;
      color: white;
      font-size: 16px;
      border-radius: 5px;
      cursor: pointer;
    }

    .login_btn:hover {
      background-color: white;
      color: green;
      border: solid green 1px;
    }

    .ff {
      font-size: 12px;
      color: green;
      margin-bottom: 10px;
    }

    .admin {
      color: green;
    }

    .reg_box {
      width: 300px;
      height: auto;
      float: right;
      margin-top: 50px;
      margin-right: 100px;
      border: solid #cccccc 1px;
      background-color: white;
      border-radius: 5px;
      padding: 20px;
      color: #f87b00;
    }

    .reg_box input {
      border: solid #f87b00 1px;
    }

    .reg_btn {
      width: 280px;
      background-color: #f87b00;
      height: 40px;
      border: solid #ececec 1px;
      color: white;
      font-size: 16px;
      border-radius: 5px;
      cursor: pointer;
    }

    .reg_btn:hover {
      background-color: white;
      color: #f87b00;
      border: solid #f87b00 1px;
    }
     html * {
            -webkit-font-smoothing: antialiased;
            font-family: "Lantinghei SC", "Open Sans", Arial, "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", "STHeiti", "WenQuanYi Micro Hei", SimSun, sans-serif;
        }
  </style>
</head>
<body>
<div class="header">
  <div style="height: 5px;background-color:green;"></div>
  <a href="http://www.wexue.top" class="logo" target="_blank">
    <img src="<%=basePath%>/img/logo.png" style="height: 65px;" alt="">
  </a>

  <div class="index">
    <a href="http://www.wexue.top" target="_blank">
      <div class="index_text"
           style="padding: 10px 20px 10px 20px;background-color: green;-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;color: white ">
        官网
      </div>
    </a>
  </div>
</div>
<div class="mind-container">
  <div class="login_box">
    <h2><span class="admin">管理员</span></h2>

    <form id="form_login" action="/user/login" method="post"
          autocomplete="off">
      <div id="idInputLine" class="loginFormIpt"><b class="ico ico-uid-mail"></b>
        <input class="loginFormTdIpt search-input" tabindex="1" title="请输入账号"
               placeholder="请输入账号" onkeydown="onKeyUp(event)" name="username" id="username"
               type="text" maxlength="50" value="admin" autocomplete="on"
               valid="{&quot;must&quot;:true,&quot;tip&quot;:&quot;帐号&quot;}"><span
                class="input_colse"></span>
      </div>
      <div id="pwdInputLine" class="loginFormIpt"><b class="ico ico-pwd"></b>
        <input class="loginFormTdIpt search-input" tabindex="2" title="请输入密码"
               placeholder="请输入密码" value="admin" name="password" id="password" type="password"
               onkeydown="onKeyUp(event)">
      </div>
      <div id="login_state" style="color: red;padding-bottom:5px;font-size: 14px;">

      </div>
      <div>
        <div class="ff">
          <a class="fl"
             href="http://qy.do1.com.cn/qwy/qiweipublicity/experience2/Retrieve1.jsp">忘记密码？</a>
          还没有帐号？
          <%--<span--%>
                <%--style="color:#f87b00;cursor: pointer" id="regBtn">马上开通&gt;</span>--%>
        </div>
      </div>
      <div>
        <button class="login_btn" type="button" onclick="doLogin()">登录
        </button>
        <%--<a href="https://qy.weixin.qq.com/cgi-bin/loginpage?corp_id=wxf54e1b5e0b62fa96&redirect_uri=http%3A%2F%2Fwww.wexue.top%2FqyAuth"><img src="https://res.wx.qq.com/mmocbiz/zh_CN/tmt/home/dist/img/logo_blue_b_c97f8734.png" alt="企业号登录"/></a>--%>
      </div>
    </form>
    <button class="login_btn" type="button" onclick="doQYLogin()">使用企业号登陆</button>
  </div>
  <div class="reg_box" hidden>
    <h2><span>注册</span></h2>

    <form id="form_reg" action="/user/reg" method="post"
          autocomplete="off">
      <div class="loginFormIpt"><b class="ico ico-uid-mail"></b>
        <input class="loginFormTdIpt search-input" tabindex="1" title="请输入账号"
               placeholder="请输入账号" onkeydown="onKeyUp(event)" name="rusername"
               type="text" maxlength="50" value="admin" autocomplete="on"
               valid="{&quot;must&quot;:true,&quot;tip&quot;:&quot;帐号&quot;}"><span
                class="input_colse"></span>
      </div>
      <div class="loginFormIpt"><b class="ico ico-pwd"></b>
        <input class="loginFormTdIpt search-input" tabindex="2" title="请输入密码"
               placeholder="请输入密码" name="rpassword" type="password"
               onkeydown="onKeyUp(event)">
      </div>
      <div class="loginFormIpt"><b class="ico ico-pwd"></b>
        <input class="loginFormTdIpt search-input" tabindex="2" title="请输入手机号"
               placeholder="手机号" name="tel" type="text"
               onkeydown="onKeyUp(event)">
      </div>
      <div id="reg_state" style="color: red;padding-bottom:5px;font-size: 14px;">

      </div>
      <div>
        <div class="ff">
          有帐号？<span
                style="color:#f87b00;cursor: pointer" id="loginBtn">立即登录&gt;</span>
        </div>
      </div>
      <div>
        <button class="reg_btn" type="button" onclick="doReg()">免费体验
        </button>
      </div>
    </form>
  </div>
</div>
<div class="footer">
  <a href="" target="_blank">关于我们</a>&nbsp;&nbsp;|&nbsp;&nbsp;咨询电话：18612055774&nbsp;&nbsp;|&nbsp;&nbsp;Copyright©2014-2015
  lihb All Rights Reserved 粤B2-20062018号
</div>
</div>


<script type="text/javascript">
  var login_type = 1;
  $(function () {
    $('#username').focus();
    $('#idInputLine').addClass('focus');
    //高度自适应
    function juzhong() {
      var mttop = ($(window).height() - $('.frontHome.page').height() - 20) / 2
      if (mttop < 0) {
        mttop = 0
      }
      $('.frontHome.page').css('marginTop', mttop);
    }

    $("#regBtn").click(function () {
      $(".login_box").hide();
      $(".reg_box").show();
    });
    $("#loginBtn").click(function () {
      $(".login_box").show();
      $(".reg_box").hide();
    });

    juzhong();
    $(window).resize(function () {
      juzhong();
    })
    //登录框效果
    $('.loginFormTdIpt').focus(function () {
      $(this).parent('.loginFormIpt').addClass('focus')
    }).blur(function () {
      $(this).parent('.loginFormIpt').removeClass('focus')
    })
    // 登录框清空文字
    $('.search-input').on('input click', function (event) {
      var input_colse = $('<span class="input_colse"></span>');
      if ($(this).val().length > 0) {
        $('.input_colse').remove();
        $(this).after(input_colse)
      } else {
        $('.input_colse').remove();
      }
      $('.input_colse').on('click', function () {
        $(this).prev('.search-input').val('');
        $(this).remove();
      })
    })
    //菜单更多弹出层
    $('#nav_more').mouseover(function () {
      $(this).children('.hide_nav').show();
    }).mouseout(function () {
      $(this).children('.hide_nav').hide();
    })

  })
  function onKeyUp(event) {
    var e = event ? event : (window.event ? window.event : null);
    if (e.keyCode == 13)doLogin(login_type);
  }
  function doQYLogin(){
    window.location.href="https://qy.weixin.qq.com/cgi-bin/loginpage?corp_id=wxf54e1b5e0b62fa96&redirect_uri=http%3A%2F%2Fwww.wexue.top%2Fauth%2Flogin";
  }
  function doLogin() {
    //autoApply();//暂时去掉记住账号的功能

    //var dqdp = new Dqdp();
    //个人网页版
    if ($("#username").val() == "") {
      alert("请输入账号");
      return;
    }
    if ($("#password").val() == "") {
      alert("请输入密码");
      return;
    }
    $('#form_login').ajaxSubmit({
      url: "<%=basePath%>/user/login",
      dataType: "text",
      success: function (data) {
        var json= $.parseJSON(data);
        if (json.success) {
          window.top.location.href="/";
        } else {
          $("#login_state").text(json.msg);
        }
      }
    });
  }
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
    $('#form_reg').ajaxSubmit({
      url: "/user/reg",
      dataType: "text",
      success: function (data) {
        var json= $.parseJSON(data);
        if (json.success) {
          $("#reg_state").text(json.msg);
        } else {
          $("#reg_state").text(json.msg);
        }
      }
    });
  }
  /**
   *将用户的帐号信息放入cookie中
   */
  function autoApply() {

    var f1 = $("#username").val();
    var f2 = $("#password").val();
    var expiresDate = new Date();
    expiresDate.setTime(expiresDate.getTime() + (30 * 24 * 60 * 60 * 1000));

    /**  不记住密码
     var jsonData={fielda:f1,fieldb:f2};*/
    var jsonData = {fielda: f1};

    $.cookie.json = true;
    if ($("#ckAutoLogin")[0].checked) {
      $.cookie("_do1@xyh_", jsonData, {path: '/', expires: expiresDate});
      $.cookie("_do1@xyh_Logout", "false", {path: '/', expires: expiresDate});
    }
    else {
      $.cookie("_do1@xyh_", {fielda: '', fieldb: ''}, {path: '/', expires: expiresDate});
    }


  }

  /**
   *验证是否为企业微信网页版用户登录
   */
  function checkWeixinUser() {
    var isNotCheck = true;
    $("#gerenban").attr("action", "/qwy/portal/userLoginAction!checkUser.action");
    $("#gerenban").ajaxSubmit({
      dataType: 'json',
      async: false,
      success: function (result) {
        if (result.code == "0") {
          isNotCheck = false;

          window.top.location.href = "/qwy/qwweb/main.jsp";

          //验证通过，需要form提交到后台登录并重定向页面
          //$("#id_form_login").attr("action", "/qwy/portal/userLoginAction!weixinWebLogin.action");
          //$("#id_form_login").submit();
        }
        else {
          isNotCheck = false;
          $("#gerenban_pass").val("");
          _alert("提示信息", result.desc);
        }
      },
      error: function () {
      }
    });
    $("#org_edit").attr("action", "/qwy/j_spring_security_check");
    return isNotCheck;

  }
  function removeUpdate0424() {
    $('.Update0424').fadeOut(600);
    $('#overlayDiv').hide();
  }

</script>
</body>
</html>