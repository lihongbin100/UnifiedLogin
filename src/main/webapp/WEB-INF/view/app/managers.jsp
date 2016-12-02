<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="../header.jsp"></jsp:include>
<style>

    label {
        cursor: pointer;
        margin-left: 10px;
        display: inline-block !important;
    }

    label:hover {
        color: red;
    }

</style>
<!--header-->

<!--content-->
<link rel="stylesheet" href="<%=basePath%>/lib/icheck/blue.css"/>
<script src="<%=basePath%>/lib/icheck/icheck.min.js"></script>
<div id="content" class="content">
    <!--Action boxes-->
    <div class="container-fluid">
        <div class="col-sm-2 list-group">
            <a href="<%=basePath%>/app" class="list-group-item">
                应用列表
            </a>
            <a href="<%=basePath%>/app/managers" class="list-group-item active">
                管理员权限
            </a>
        </div>
        <div class="col-sm-10">
            <div class="btn-group">
                <button type="button" class="btn btn-primary" href="<%=basePath%>/app/addManagerPage?id=${agentInfo.id}"
                        data-toggle="modal" data-target="#Modal">
                    <i class="glyphicon glyphicon-user"></i> 编辑管理员
                </button>
                <button type="button" class="btn btn-info" href="<%=basePath%>/app/menus?id=${agentInfo.id}"
                        data-toggle="modal" data-target="#Modal">
                    <i class="glyphicon glyphicon-edit"></i> 编辑权限
                </button>
                <button type="button" class="btn btn-danger" onclick="setRole()">
                    <i class="glyphicon glyphicon-cog"></i> 设置角色
                </button>

            </div>
            <hr>
            <!--End-Action boxes-->

            <div class="widget-box">
                <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                    <h5>该应用管理员</h5>
                </div>
                <div class="widget-content nopadding">
                    <table class="table table-bordered">
                        <thead>
                        <th>
                            姓名
                        </th>
                        <th>
                            角色
                        </th>
                        <th style="width: 100px;text-align: left">
                            <input type="checkbox" checked id="allCheck"> 全选
                        </th>
                        </thead>
                        <c:forEach items="${managers}" var="manager">
                            <tr>
                                <td>
                                    <c:if test="${not empty manager.avatar}">
                                        <img src="${manager.avatar}"
                                             style="height: 20px;width: 20px;margin-right: 5px">
                                    </c:if>
                                    <c:if test="${empty manager.avatar}">
                                        <img src="<%=basePath%>/img/gckslogo.png"
                                             style="height: 20px;width: 20px;margin-right: 5px">
                                    </c:if>
                                    <label id="user-${manager.userid}" data-id="${manager.userid}"
                                           class="current-users">
                                            ${manager.name}
                                    </label>
                                </td>
                                <td>
                                        ${manager.roleName}
                                </td>
                                <td>
                                    <input id="input-${manager.userid}" class="check" data-id="${manager.userid}"
                                           data-avatar="${manager.avatar}" data-name="${manager.name}" checked
                                           type="checkbox">
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        var setRoleUrl = "<%=basePath%>/app/menus?id=${agentInfo.id}";

        $('input').iCheck({
            checkboxClass: 'icheckbox_flat-blue',
            radioClass: 'iradio_flat-blue',
            increaseArea: '20%',// optional
        });

        $("#menu li:eq(0)").addClass("active");
        $(".delete").click(function () {
            var deleteBtn = $(this);
            var $btn = deleteBtn.button('loading');
            $.ajax({
                url: "<%=basePath%>/app/delete?appId=" + $(this).data("id"),
                success: function (data) {
                    location.reload();
                }
            });

        });

    });

    $("#allCheck").on("ifChecked",function () {
        $('input.check').iCheck("check");
    })
    $("#allCheck").on("ifUnchecked",function () {
        $('input.check').iCheck("uncheck");
    })

    function setRole() {
        var managers = "";
        $('input:checked.check').each(function () {
            var id = $(this).data('id');
            managers = managers + "&managers=" + id;
        });
        $("#Modal").modal({
            remote: "<%=basePath%>/app/roles?id=${agentInfo.id}" + managers
        });
    }
</script>

<!--content-->
<!-- Modal -->

<!--bottom-->
<jsp:include page="../bottom.jsp"></jsp:include>
<!--bottom-->
