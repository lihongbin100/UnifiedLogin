<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<style>
    .deps-item {
        cursor: pointer;
    }

    .i-star {
        color: red;
        margin-top: 8px;
    }
</style>
<script src="<%=basePath%>/lib/typeahead/bootstrap.typeahead.min.js"></script>
<!--content-->
<form action="<%=basePath%>/app/save" id="addAppForm" enctype="multipart/form-data" method="post"
      class="form-horizontal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">编辑应用</h4>
    </div>
    <div class="modal-body">
        <c:if test="${edit}">
            <div class="form-group">
                <label class="col-sm-3 control-label">ID :</label>
                <div class="col-sm-7">
                    <label class="label label-info">${agentInfo.id}</label>
                    <input type="text" name="id" value="${agentInfo.id}" class="form-control hidden"/>
                </div>
                <div class="col-sm-1 i-star">
                    <i class="glyphicon glyphicon-asterisk"></i>
                </div>
            </div>
        </c:if>
        <div class="form-group">
            <label class="col-sm-3 control-label">应用名 :</label>

            <div class="col-sm-7">
                <input type="text" value="${agentInfo.name}" name="name" required class="form-control"/>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">简介 :</label>

            <div class="col-sm-7">
                <input type="text" name="description" value="${agentInfo.description}" required class="form-control"/>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">负责人 :</label>

            <div class="col-sm-7">
                <div class="input-group">
                    <input type="text" class="form-control" value="${agentInfo.superManager}" required id="userSearch"
                                                          name="superManagerName">
                    <input type="text" class="form-control hidden" value="${agentInfo.superManager}"  id="userSearchId"
                           name="superManager">
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="button">
                        <i class="glyphicon glyphicon-search"></i>
                    </button>
                    </span>
                </div>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">登录地址 :</label>
            <div class="col-sm-7">
                <input type="text" name="loginUrl" value="${agentInfo.loginUrl}" required class="form-control"
                       value="http://"/>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
    </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary" id="save">保存</button>
    </div>
</form>
<script src="<%=basePath%>/js/jquery.validate.min.js"></script>
<script>
    $(function () {
//        负责人搜索
        $('#userSearch').typeahead({
            source: function (query, process) {
                var parameter = {userName: query};
                $.get('<%=basePath%>/user/users', parameter, function (data) {
                    process(data.obj);
                });
            },
            updater:function (item) {
                $("#userSearchId").val(item.userid);
                return item.name;
            }

        });


        $("#addAppForm").validate({
            submitHandler: function (form) {
                var $btn = $("#save").button('loading');
                $(form).ajaxSubmit({
                    dataType: "",
                    success: function (data) {
                        if (data.success) {
                            showTip(data.msg, "success");
                        } else {
                            showTip(data.msg, "failure");
                        }
                        $btn.button('reset');
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                        $("#Modal").modal("hide");
                    }
                });
            }
        });
    });
</script>