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
</style>
<link href="<%=basePath%>/css/fileinput.min.css" rel="stylesheet">
<!--content-->
<form action="<%=basePath%>/platform/addressbook/addUser" id="addUserForm" enctype="multipart/form-data" method="post"
      class="form-horizontal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">编辑成员</h4>
    </div>
    <div class="modal-body">

        <input name="id" ${user.userid}" class="hidden">

        <div class="form-group">
            <label class="col-sm-3 control-label">头像<i class="require-input">*</i> :</label>

            <div class="col-sm-8">
                <input id="file-0a" class="file" name="file" required type="file" multiple
                       data-min-file-count="1"
                       data-show-upload="false">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">账号 <i class="require-input">*</i>:</label>

            <div class="col-sm-8">
                <input type="text" name="userid" required class="form-control"/>

                <div class="alert alert-danger hidden" id="userid-state"></div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">姓名 :</label>

            <div class="col-sm-8">
                <input type="text" name="name" required class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">性别 :</label>

            <div class="col-sm-8">
                <label>

                    <input type="radio" name="gender"/>
                    男</label>

                <label>
                    <input type="radio" name="gender"/>
                    女</label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">微信号 :</label>

            <div class="col-sm-8">
                <input type="text" name="weixinid" required class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">手机号 :</label>

            <div class="col-sm-8">
                <input type="tel" name="mobile" id="number_validate" class="form-control"
                placeholder="手机号码"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">邮箱 :</label>

            <div class="col-sm-8">
                <input type="email" class="form-control"  name="email" placeholder="邮箱"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">部门 :</label>

            <div class="col-sm-8">


                <div class="alert alert-success">
                    <div id="deps">
                        <br class="clear">
                    </div>
                    <hr>
                    <div id="departmentTreeEdit" class="alert alert-info ztree">

                    </div>

                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">职位 :</label>

            <div class="col-sm-8">
                <input type="text" class="form-control" name="position" placeholder="地址"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary" id="save">保存</button>
    </div>
</form>
<script src="<%=basePath%>/js/fileinput.min.js"></script>
<script src="<%=basePath%>/js/fileinput_locale_zh.js"></script>
<script src="<%=basePath%>/js/jquery.validate.min.js"></script>
<script>
    var depArray = [];
    function removeDepItem(elem, node) {
        console.log(depArray);
        elem.parentNode.removeChild(elem);
        var index = depArray.indexOf(node);
        depArray.splice(index, 1);
    }
    $(function () {
        $("input[name=userid]").change(function () {
            isUserId();
        });
        $("#addUserForm").validate({
            messages: {
                file: {
                    required: ""
                }
            },
            submitHandler: function (form) {
//                $(form).append('<input type="text" class="hidden" ' + depArray.toString() + '" name="departmentid"/>');
                var $btn = $("#save").button('loading');
                $(form).ajaxSubmit({
                    data: {
                        "departmentid": depArray
                    },
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
            if (depArray.indexOf(treeNode.id) != -1) {
                return;
            }
            var index = depArray.push(treeNode.id);
            $("#deps").prepend('<label class="deps-item label label-success left" onclick="removeDepItem(this,' + treeNode.id + ')">' + treeNode.name +
            '<i class="glyphicon glyphicon-remove">' +
            '</i>' +
            '</label>');
        }

        //部门
        $.ajax({
            url: "<%=basePath%>/platform/addressbook/departmentTree",
            type: "get",
            success: function (data) {
                if (data != null && data.length != 0) {
                    $.fn.zTree.init($("#departmentTreeEdit"), setting, data);
                } else {
                    $("#departmentTreeEdit").text("空");
                }
            }
        });
    });
    function isUserId() {
        var userid = $("input[name=userid]").val();
        var url = "<%=basePath%>/platform/addressbook/isUserId?userId=" + userid;
        var success = function (data) {
            if (data.success) {
                $("#userid-state").removeClass("hidden");
                $("#userid-state").html('<font color=red>' + userid + '账户已经存在</font>');
            } else {
                $("#userid-state").removeClass("hidden");
                $("#userid-state").html('<font color=green>' + userid + '账户可用</font>');
            }
        }
        $.ajax({
            url: url,
            type: "get",
            success: success
        });
    }

</script>