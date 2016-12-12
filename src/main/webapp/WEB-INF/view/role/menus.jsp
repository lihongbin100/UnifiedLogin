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
            ${role.name}的菜单:
        </h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1 ">
                <div class="panel panel-default">
                    <div class="panel-heading center">
                        <h3 class="panel-title">菜单</h3>
                    </div>
                    <div class="panel-body">
                        <div id="menusTree" class="ztree">

                        </div>
                    </div>
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

    var setting = {
        check: {
            enable: true
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
            }
        }
    };

    var treeObj = $.fn.zTree.init($("#menusTree"), setting, ${treeData});


    $("#save").click(function () {
        var nodes = treeObj.getChangeCheckedNodes();

        var $btn = $("#save").button('loading');
        var users = [];
        $("#usersCurrent").find("label").each(function () {
            users.push($(this).data("id"));
        });

        var menus=[];
        for(var i=0;i<nodes.length;i++){
            menus.push(nodes[i].id);
        }

        console.log(menus);
        var url = "<%=basePath%>/role/saveMenus";
        var data = {
            roleid: ${role.id},
            agentid:${agentId},
            menuIds:menus
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
