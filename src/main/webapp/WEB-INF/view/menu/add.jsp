<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<style>

    .i-star {
        color: red;
        margin-top: 8px;
    }
</style>
<script src="<%=basePath%>/lib/typeahead/bootstrap.typeahead.min.js"></script>
<!--content-->
<form action="<%=basePath%>/menu/save" id="addAppForm" enctype="multipart/form-data" method="post"
      class="form-horizontal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">编辑菜单</h4>
    </div>
    <div class="modal-body">
        <c:if test="${edit}">
            <div class="form-group">
                <label class="col-sm-3 control-label">ID :</label>
                <div class="col-sm-7">
                    <label class="label label-info">${menu.id}</label>
                    <input type="text" name="id" value="${menu.id}" class="form-control hidden"/>
                    <input type="text" name="parent" value="${menu.parent}" class="form-control hidden"/>
                    <input type="text" name="agentId" value="${menu.agentId}" class="form-control hidden"/>
                </div>
                <div class="col-sm-1 i-star">
                    <i class="glyphicon glyphicon-asterisk"></i>
                </div>
            </div>
        </c:if>
        <c:if test="${!edit}">
        <div class="form-group">
            <label class="col-sm-3 control-label">所属应用 :</label>

            <div class="col-sm-7">
                <label class="label label-info">${agent.name}</label>
                <input name="agentId" class="hidden" value="${agent.id}">
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">父菜单 :</label>

            <div class="col-sm-7">
                <label class="label label-success">${cMenu.name}</label>
                <input name="parent" class="hidden" value="${cMenu.id}">
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        </c:if>
        <div class="form-group">
            <label class="col-sm-3 control-label">菜单名 :</label>

            <div class="col-sm-7">
                <input type="text" value="${menu.name}" name="name" required class="form-control"/>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">标示 :</label>

            <div class="col-sm-7">
                <input type="text" name="sign" value="${menu.sign}" required class="form-control"/>
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