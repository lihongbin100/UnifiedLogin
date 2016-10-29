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
<form action="<%=basePath%>/role/save" id="addAppForm" enctype="multipart/form-data" method="post"
      class="form-horizontal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">编辑角色</h4>
    </div>
    <div class="modal-body">
        <c:if test="${edit}">
            <div class="form-group">
                <label class="col-sm-3 control-label">ID :</label>
                <div class="col-sm-7">
                    <label class="label label-info">${role.id}</label>
                    <input type="text" name="id" value="${role.id}" class="form-control hidden"/>
                </div>
                <div class="col-sm-1 i-star">
                    <i class="glyphicon glyphicon-asterisk"></i>
                </div>
            </div>
        </c:if>
        <div class="form-group">
            <label class="col-sm-3 control-label">角色名 :</label>

            <div class="col-sm-7">
                <input type="text" value="${role.name}" name="name" required class="form-control"/>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">简介 :</label>

            <div class="col-sm-7">
                <input type="text" name="description" value="${role.description}" required class="form-control"/>
            </div>
            <div class="col-sm-1 i-star">
                <i class="glyphicon glyphicon-asterisk"></i>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">权限 :</label>

            <div class="col-sm-7">

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