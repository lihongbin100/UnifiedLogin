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
<!--header-->
<script src="<%=basePath%>/lib/JQuery_z_tree/js/jquery.ztree.core-3.5.min.js"></script>
<script src="<%=basePath%>/lib/JQuery_z_tree/js/jquery.ztree.excheck-3.5.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>/lib/JQuery_z_tree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="<%=basePath%>/lib/bootstrap-3.3.5-dist/css/green.css"/>
<script src="<%=basePath%>/lib/bootstrap-3.3.5-dist/js/icheck.min.js"></script>
<div class="content">
    <div class="col-sm-1 shu">
        <a href="<%=basePath%>/platform/addressbook">
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
                <span id="info">
                上次更新时间：${createtime} ${task.state}</span>
                <hr>
            </div>
        </div>
        <%--<div class="panel panel-info">--%>
        <%--<div class="panel-heading">--%>
        <%--通讯录--%>
        <%--<span>--%>
        <%--<c:if test="${pTask=='1'}">--%>
        <%--<label class="label label-danger">任务状态:</label>部门同步任务开始--%>
        <%--</c:if>--%>
        <%--<c:if test="${pTask=='2'}">--%>
        <%--<label class="label label-danger">任务状态:</label>部门同步任务进行中--%>
        <%--</c:if>--%>
        <%--<c:if test="${pTask=='3'}">--%>
        <%--<label class="label label-danger">任务状态:</label> 部门同步任务已完成--%>
        <%--</c:if>--%>
        <%--<c:if test="${pTask!='1'&&pTask!='2'&&pTask!='3'}">--%>
        <%--<label class="label label-danger">任务状态:</label>部门同步错误：${pTask}--%>
        <%--</c:if>--%>
        <%--<c:if test="${uTask=='1'}">--%>
        <%--:成员同步任务开始--%>
        <%--</c:if>--%>
        <%--<c:if test="${uTask=='2'}">--%>
        <%--:成员同步任务进行中--%>
        <%--</c:if>--%>
        <%--<c:if test="${uTask=='3'}">--%>
        <%--:成员同步任务已完成--%>
        <%--</c:if>--%>
        <%--<c:if test="${uTask!='1'&&uTask!='2'&&uTask!='3'}">--%>
        <%--:成员同步错误：${uTask}--%>
        <%--</c:if>--%>
        <%--</span>--%>
        <%--&lt;%&ndash;<c:if test="${pTask=='3'&&uTask=='3'}">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<button class="right btn btn-warning btn-xs" onclick="syncAddressboolToWechat()"><i&ndash;%&gt;--%>
        <%--&lt;%&ndash;class="glyphicon glyphicon-arrow-up"></i>同步到微信&ndash;%&gt;--%>
        <%--&lt;%&ndash;</button>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>

        <%--&lt;%&ndash;<button class="right btn btn-success btn-xs"><i class="glyphicon glyphicon-arrow-down"></i>同步到本地</button>&ndash;%&gt;--%>
        <%--</div>--%>
        <%--<div class="panel-body">--%>
        <div class="row">
            <div class="col-sm-3">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        部门
                        <%--<button class="btn btn-xs btn-warning" href="<%=basePath%>/platform/addressbook/addDepJsp"--%>
                        <%--data-toggle="modal" data-target="#Modal"><i class="glyphicon glyphicon-plus"></i>新增部门--%>
                        <%--</button>--%>
                    </div>
                    <div class="panel-body">
                        <div id="departmentTree" class="ztree">

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        员工
                        <%--<button class="btn btn-xs btn-warning" href="<%=basePath%>/platform/addressbook/addUserJsp"--%>
                        <%--data-toggle="modal" data-target="#Modal"><i class="glyphicon glyphicon-plus"></i>新增成员--%>
                        <%--</button>--%>
                    </div>
                    <div class="panel-body">
                        <table class="table table-hover">
                            <thead>
                            <th>姓名</th>
                            <th>账号</th>
                            <%--<th>职位</th>--%>
                            <th>手机</th>
                            <%--<th>邮箱</th>--%>
                            <th>状态</th>
                            <th>权限</th>
                            </thead>
                            <tbody id="userContent" class="center">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</div>--%>
    <%--</div>--%>
</div>

<script>

    $(function () {
        $("#menu li:eq(1)").addClass("active");
        $('.icheck').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
            increaseArea: '20%' // optional
        });
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
                beforeClick: beforeClick,
                onClick: onClick
            }
        };

        function beforeClick(treeId, treeNode, clickFlag) {
            return true;
        }

        function onClick(event, treeId, treeNode, clickFlag) {
            showUsers(treeNode.id);
        }

        showUsers(1);

        function showUsers(depId) {
            $.ajax({
                url: "<%=basePath%>/platform/addressbook/getUserByPartId?startPage=1&partyId=" + depId,
                type: "get",
                success: function (data) {
                    var table = "";
                    if (data != null && data.length != 0) {
                        for (var i = 0; i < data.length; i++) {
                            table = table + "<tr id='userid" + data[i].userid + "'>" +
                                    "<td class='left'>" + "<img src='" + data[i].avatar + "' style='width:25px;margin-right:10px;'>" + data[i].username +
                                    "</td>" +
                                    "<td>" + data[i].userid +
                                    "</td>" +
//                            "<td>" + data[i].position +
//                            "</td>" +
                                    "<td>" + data[i].mobile +
                                    "</td>" +
//                            "<td>" + data[i].email +
//                            "</td>" +
                                    "<td>" + data[i].status +
                                    "</td>" +
                                    <%--"<td>" +--%>
                                    <%--&lt;%&ndash;"<button class='btn btn-xs btn-success' href='<%=basePath%>/platform/addressbook/editJsp?id=" + data[i].userid +&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;"' data-toggle='modal' data-target='#Modal'>编辑</button>" +&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;"<button class='delete btn btn-xs btn-danger' data-id='" + data[i].userid + "' data-loading-text='删除中...'>删除</button>" +&ndash;%&gt;--%>
                                    <%--"</td>" +--%>
                                    "</tr>";
                        }
                        $("#userContent").html(table);
                        $(".delete").click(function () {
                            var userid = $(this).data("id");
                            var deleteBtn = $(this);
                            var $btn = deleteBtn.button('loading');
                            $.ajax({
                                url: "<%=basePath%>/platform/addressbook/userDelete?depId=" + depId + "&userid=" + userid,
                                success: function (data) {
                                    if (data.success) {
                                        showTip(data.msg, "success");
                                        $("#userid" + userid).remove();
                                    } else {
                                        showTip(data.msg, "failure");
                                    }
                                    $btn.button('reset');
                                }
                            });
                        });
                    } else {
                        $("#userContent").text("空");
                    }
                }

            });
        }

        $.ajax({
            url: "<%=basePath%>/platform/addressbook/departmentTree",
            type: "get",
            success: function (data) {
                if (data != null && data.length != 0) {
                    $.fn.zTree.init($("#departmentTree"), setting, data);
                } else {
                    $("#departmentTree").text("空");
                }
            }
        });

//        setCheck();
//        $("#py").bind("change", setCheck);
//        $("#sy").bind("change", setCheck);
//        $("#pn").bind("change", setCheck);
//        $("#sn").bind("change", setCheck);
    });


    function syncAddressboolToWechat(e) {
        var $btn = $(e).button('loading');
        $.ajax({
            url: "<%=basePath%>/platform/addressbook/syncUsersToWechat",
            type: "get",
            success: function (data) {
                $btn.button('reset');
                if (data.success) {
                    showTip(data.msg, "success");
                } else {
                    showTip(data.msg, "failure");
                }
            }
        });
    }

    //微信通讯录同步到本地
    function syncLocation(e) {
        var $btn = $(e).button('loading');
        $.ajax({
            url: "<%=basePath%>/platform/addressbook/syncLocation",
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
