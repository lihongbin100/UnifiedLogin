<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="../header.jsp"></jsp:include>
<style>
    .ztree, .userlist {
        max-height: 600px;
        overflow-y: auto;
    }
</style>
<!--header-->
<script src="<%=basePath%>/lib/JQuery_z_tree/js/jquery.ztree.core-3.5.min.js"></script>
<script src="<%=basePath%>/lib/JQuery_z_tree/js/jquery.ztree.excheck-3.5.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>/lib/JQuery_z_tree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="<%=basePath%>/lib/icheck/green.css"/>
<script src="<%=basePath%>/lib/icheck/icheck.min.js"></script>
<div class="content" ng-controller="userShow">
    <div class="col-sm-1 shu">
        <a href="#">
            <div class="active">通讯录</div>
        </a>
    </div>
    <!--Action boxes-->
    <div class="col-sm-11">
        <div class="row">
            <div class="col-sm-12">
                <button type="button" class="btn btn-success" data-loading-text="同步中..." onclick="syncLocation(this)">
                    <i class="glyphicon glyphicon-download"></i> 同步到本地
                </button>
                <span ng-model="info" ng-bind="info">
                </span>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        部门
                    </div>
                    <div class="panel-body">
                        <div id="departmentTree" class="ztree">

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="panel-body" ng-if="users.length==0">
                    <label> 无数据</label>
                </div>
                <div class="panel-body userlist" ng-if="users.length!=0">
                    <table class="table table-hover">
                        <thead>
                        <th>姓名</th>
                        <th>账号</th>
                        <th>职位</th>
                        <th>手机</th>
                        <th>邮箱</th>
                        </thead>
                        <tbody id="userContent" class="center">
                        <tr ng-repeat="user in users" ng-model="users">
                            <td style="float: left">
                                <img ng-if="user.avatar" src="{{user.avatar}}"
                                     style="height: 20px;width: 20px;margin-right: 10px">
                                <i ng-if="!user.avatar" class="glyphicon glyphicon-user"></i>
                                {{user.name}}
                            </td>
                            <td>{{user.userid}}</td>
                            <td>{{user.position}}</td>
                            <td>{{user.mobile}}</td>
                            <td>{{user.email}}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<%=basePath%>/js/socket.min.js"></script>
<script>
    var webSocket = "";
    gcksApp.controller('userShow', function ($scope, $http) {
        $scope.info = "上次更新时间：${task.createtime}，更新状态：${task.state}。";
        var websocket = new SockJS("<%=basePath%>/webSocketServer/user", false);
        websocket.onmessage = function (evnt) {
            if (evnt.data.indexOf("USER:") > -1) {
                $scope.info = (evnt.data).replace("USER:", "");
                return;
            }
            webSocket = evnt.data;
        };
        $("#menu li:eq(1)").addClass("active");
        $('.icheck').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
            increaseArea: '20%' // optional
        });

        showUsers(15564632);
        function showUsers(depId) {
            $http.get("<%=basePath%>/user/departmentUsers?start=0&departmentId=" + depId)
                    .success(function (response) {
                        $scope.users = response.obj;
                    });
        }


        var setting = {
            check: {
                enable: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: function (treeId, treeNode, clickFlag) {
                    return true;
                },
                onClick: function (event, treeId, treeNode, clickFlag) {
                    showUsers(treeNode.id);
                }
            }
        };


        $.ajax({
            url: "<%=basePath%>/user/departmentList",
            type: "get",
            success: function (data) {
                if (data != null && data.length != 0) {
                    $.fn.zTree.init($("#departmentTree"), setting, data.obj);
                } else {
                    $("#departmentTree").text("空");
                }
            }
        });
    });


    //微信通讯录同步到本地
    function syncLocation(e) {
        var $btn = $(e).button('loading');
        $.ajax({
            url: "<%=basePath%>/user/updateUsers?webSocketId=" + webSocket,
            type: "get",
            success: function (data) {
                $btn.button('reset');
                $("#info").html(data.msg);
                if (data.success) {
                    showTip(data.msg, "success");
                } else {
                    showTip(data.msg, "failure");
                }
            }
        });
    }


</script>

<!--bottom-->
<jsp:include page="../bottom.jsp"></jsp:include>
<!--bottom-->
