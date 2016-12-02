<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<style>
    .i-star {
        color: red;
        margin-top: 8px;
    }

    .dp, .ul {
        height: 300px;
        overflow-y: auto;
    }

    .ul div {
        float: right;
        margin-right: 50px;
    }

    label {
        cursor: pointer;
        margin-left: 10px;
        display: inline-block !important;
    }

    label:hover {
        color: red;
    }

</style>
<script src="<%=basePath%>/lib/JQuery_z_tree/js/jquery.ztree.core-3.5.min.js"></script>
<script src="<%=basePath%>/lib/JQuery_z_tree/js/jquery.ztree.excheck-3.5.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>/lib/JQuery_z_tree/css/zTreeStyle/zTreeStyle.css">

<!--content-->
<div class="model-div" ng-controller="addManager">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">
            选择角色:${agentInfo.name}
        </h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="form-group">
                <label class="col-sm-2 control-label">管理员 :</label>
                <div class="col-sm-9" id="usersCurrent">
                    <c:forEach items="${managers}" var="manager">
                        <label id="user-${manager.userid}" data-id="${manager.userid}"
                               class="current-users label alert-info">
                            <c:if test="${not empty manager.avatar}">
                                <img src="${manager.avatar}"
                                     style="height: 15px;width: 15px;margin-right: 5px">
                            </c:if>
                            <c:if test="${empty manager.avatar}">
                                <i class="glyphicon glyphicon-user"></i>
                            </c:if>
                                ${manager.name}
                        </label>

                    </c:forEach>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="form-group">
                <label class="col-sm-2 control-label">选择角色 :</label>
                <div class="col-sm-9">
                    <select class="form-control" id="roleId">
                            <option value="0">未选择</option>
                        <c:forEach items="${roles}" var="role">
                            <option value="${role.id}">${role.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary" id="save">保存</button>
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>/lib/icheck/green.css"/>
<script src="<%=basePath%>/lib/icheck/icheck.min.js"></script>
<script src="<%=basePath%>/js/jquery.validate.min.js"></script>
<script>


    $("#save").click(function () {
        var $btn = $("#save").button('loading');
        var users = [];
        $("#usersCurrent").find("label").each(function () {
            users.push($(this).data("id"));
        });
        var roleId=$("#roleId").select().val();
        var url = "<%=basePath%>/app/saveRole";
        var data = {
            users: users,
            roleId:roleId,
            agentId:${agentInfo.id}
        };
        $.post(url, data, function (res) {
            if (res.success) {
                $btn.button('reset');
                setTimeout(function () {
                    location.reload();
                }, 1000);
                $("#Modal").modal("hide");
            } else {
                showTip(res.msg, "success");
                $btn.button('reset');
            }
        });


    });
</script>
