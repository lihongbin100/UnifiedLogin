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
<!--header-->

<!--content-->
<div id="content" class="content">
    <!--Action boxes-->
    <div class="container-fluid">
        <div class="col-sm-1 list-group">
            <a href="<%=basePath%>/app" class="list-group-item active">
                应用列表
            </a>
            <a href="#" class="list-group-item">
                管理员权限
            </a>
        </div>
        <div class="col-sm-11">
            <div>
                <button type="button" class="btn btn-default" href="<%=basePath%>/app/addPage"
                        data-toggle="modal" data-target="#Modal">
                    <i class="glyphicon glyphicon-plus"></i> 新增应用
                </button>
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
                            <th>应用名</th>
                            <th>登录地址</th>
                            <th>负责人</th>
                            <th>功能</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${agentInfos.content}" var="agentInfo" varStatus="s">
                            <tr>
                                <td>${agentInfo.id}</td>
                                <td>
                                    <div class="tool" data-toggle="tooltip" data-placement="right"
                                         data-title="简介：${agentInfo.description}">${agentInfo.name}</div>
                                </td>
                                <td>${agentInfo.loginUrl}</td>
                                <td>
                                        ${agentInfo.superManager}
                                </td>
                                <td>
                                    <a href="<%=basePath%>/menu?appId=${agentInfo.id}">
                                        <button class="btn btn-xs btn-success">菜单
                                        </button>
                                    </a>
                                    <a href="<%=basePath%>/app/managers?id=${agentInfo.id}">
                                        <button class="btn btn-xs btn-info">
                                            管理员
                                        </button>
                                    </a>
                                    <button class="btn btn-xs btn-info"
                                            href="<%=basePath%>/log?id=${agentInfo.id}"
                                            data-toggle="modal" data-target="#Modal${agentInfo.id}">查看日志
                                    </button>
                                </td>
                                <td>

                                    <button class="btn btn-xs btn-primary"
                                            href="<%=basePath%>/app/editPage?appId=${agentInfo.id}"
                                            data-toggle="modal" data-target="#Modal">编辑
                                    </button>

                                    <button data-id="${agentInfo.id}" data-loading-text="删除中..."
                                            class="delete btn btn-xs btn-danger">删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty agentInfos.content}">
                        <div class="no-content">无内容</div>
                    </c:if>
                </div>
                <c:if test="${!empty agentInfos.content}">
                    <div class="page">
                        <div class="right">
                            <c:if test="${agentInfos.number>0}">
                                <button onclick="javascript:window.location.href='<%=basePath%>/app?page=${agentInfos.number-1}'"
                                        id="btn-pre" class="btn btn-mini">上一页
                                </button>
                            </c:if>
                            <button onclick="javascript:window.location.href='<%=basePath%>/app?page=${agentInfos.number+1}'"
                                    id="btn-next" class="btn btn-mini btn-inverse">下一页
                            </button>
                        </div>
                    </div>
                </c:if>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
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
</script>

<!--content-->
<!-- Modal -->

<!--bottom-->
<jsp:include page="../bottom.jsp"></jsp:include>
<!--bottom-->
