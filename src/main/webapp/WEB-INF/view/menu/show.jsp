<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="../common/header.jsp"></jsp:include>
<style>
    .treegrid-parent-0 {
        background-color: #aad1ee;
    }

    .treegrid-indent {
        width: 16px;
        height: 16px;
        display: inline-block;
        position: relative;
    }

    .treegrid-expander {
        width: 16px;
        height: 16px;
        display: inline-block;
        position: relative;
        cursor: pointer;
    }
</style>
<!--header-->

<!--content-->

<div id="content" class="content">
    <!--Action boxes-->
    <div class="container-fluid">
        <div class="btn-group">
            <c:if test="${userinfo.loginUser.role.sign =='superman'}">
                <button class="btn btn-info">
                    选择应用：
                </button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        <span id="selectBtn">${agentInfo.name}</span>
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <c:forEach items="${apps}" var="app" varStatus="s">
                            <li>
                                <a href="<%=basePath%>/menu?appId=${app.id}">${app.name}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <button type="button" class="btn btn-default" onclick="addMenu(0)">
                <i class="glyphicon glyphicon-plus"></i> 新增菜单
            </button>
        </div>
        <hr>
        <!--End-Action boxes-->

        <div class="widget-box">
            <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                <%--<h5>项目</h5>--%>
            </div>
            <div class="widget-content nopadding">
                <table class="tree table table-bordered">
                    <thead>
                    <tr class="treegrid-0">
                        <th style="width: 100px">菜单树</th>
                        <th>序号ID</th>
                        <th>菜单名称</th>
                        <th>菜单标示</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="treeBody">
                    <c:forEach items="${menus}" var="menu" varStatus="s">
                        <tr class="treegrid-${menu.id} treegrid-parent-${menu.parent}">
                            <td>
                                    <%--<span class="badge bg-info">${menu.parent}</span>--%>
                            </td>
                            <td>
                                <span class="badge"> ${menu.id}</span>
                            </td>
                            <td>
                                    ${menu.name}
                            </td>
                            <td>
                                    ${menu.sign}
                            </td>
                            <td class="reverse">
                                <button class="btn btn-xs btn-success" onclick="addMenu(${menu.id})">添加子菜单
                                </button>
                                <button class="btn btn-xs btn-primary"
                                        href="<%=basePath%>/menu/editPage?id=${menu.id}"
                                        data-toggle="modal" data-target="#Modal${menu.id}">编辑
                                </button>
                                <div class="modal fade" id="Modal${menu.id}" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="loading"><img src="<%=basePath%>/img/loading.gif"></div>
                                        </div>
                                    </div>
                                </div>
                                <button data-id="${menu.id}" data-loading-text="删除中..."
                                        data-toggle="tooltip" data-placement="right" title="递归删除菜单下所有子菜单"
                                        class="tool delete btn btn-xs btn-danger">删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty menus}">
                    <div class="no-content">无内容</div>
                </c:if>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<script src="<%=basePath%>/lib/treegrid/jquery.treegrid.js"></script>
<script>
    //    添加菜单
    function addMenu(parentId) {
        $("#Modal").modal({
            remote: "<%=basePath%>/menu/addPage?appId=${agentInfo.id}&menuId=" + parentId,
            show: true
        });
    }

    $(function () {
        $("#menu li:eq(4)").addClass(" alert-success");
        // treegrid刷新

        $('.tree').treegrid(
                {
                    expanderExpandedClass: 'glyphicon glyphicon-chevron-down',
                    expanderCollapsedClass: 'glyphicon glyphicon-chevron-right'
                }
        );


        $(".delete").click(function () {
            var deleteBtn = $(this);
            var $btn = deleteBtn.button('loading');
            $.ajax({
                url: "<%=basePath%>/menu/delete?agentId=${agentInfo.id}&id=" + $(this).data("id"),
                success: function (data) {
                    location.reload();
                }
            });

        });
    });
</script>

<!--content-->
<!-- Modal -->

<!--bottom-->
<jsp:include page="../common/bottom.jsp"></jsp:include>
<!--bottom-->
