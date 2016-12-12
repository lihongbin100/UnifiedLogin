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
<!--header-->

<!--content-->
<div id="content" class="content">
    <!--Action boxes-->
    <div class="container-fluid">
        <div>
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
                                    <a href="<%=basePath%>/role?appId=${app.id}">${app.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <button type="button" class="btn btn-default" href="<%=basePath%>/role/addPage?agentId=${agentInfo.id}"
                        data-toggle="modal" data-target="#Modal">
                    <i class="glyphicon glyphicon-plus"></i> 新增角色
                </button>
            </div>

            <hr>
        </div>
        <!--End-Action boxes-->

        <div class="widget-box">
            <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                <%--<h5>项目</h5>--%>
            </div>
            <div class="widget-content nopadding">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>序号ID</th>
                        <th>角色名</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${roles}" var="role" varStatus="s">
                        <tr>
                            <td>${role.id}</td>
                            <td>
                                <div class="tool" data-toggle="tooltip" data-placement="right"
                                     data-title="简介：${role.description}">${role.name}</div>
                            </td>
                            <td>
                                <button class="btn btn-xs btn-success"
                                        href="<%=basePath%>/role/setMenus?agentId=${agentInfo.id}&roleId=${role.id}"
                                        data-toggle="modal" data-target="#Modal${role.id}">设置菜单
                                </button>
                                <button class="btn btn-xs btn-primary"
                                        href="<%=basePath%>/role/editPage?id=${role.id}"
                                        data-toggle="modal" data-target="#Modal${role.id}">编辑
                                </button>
                                <div class="modal fade" id="Modal${role.id}" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="loading"><img src="<%=basePath%>/img/loading.gif"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty roles}">
                    <div class="no-content">无内容</div>
                </c:if>
            </div>
            <div class="page">
                <div class="right">
                    <c:if test="${prepage>0}">
                        <button onclick="javascript:window.location.href='<%=basePath%>/platform/project?startPage=${prepage}'"
                                id="btn-pre" class="btn btn-mini">上一页
                        </button>
                    </c:if>
                    <button onclick="javascript:window.location.href='<%=basePath%>/platform/project?startPage=${nextpage}'"
                            id="btn-next" class="btn btn-mini btn-inverse">下一页
                    </button>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#menu li:eq(3)").addClass("active");
        $(".delete").click(function () {
            var deleteBtn = $(this);
            var $btn = deleteBtn.button('loading');
            $.ajax({
                url: "<%=basePath%>/role/delete?id=" + $(this).data("id"),
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
