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
        <div>
            <button type="button" class="btn btn-default" href="<%=basePath%>/platform/project/addJsp"
                    data-toggle="modal" data-target="#Modal">
                <i class="glyphicon glyphicon-plus"></i> 新增角色
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
                        <th>角色名</th>
                        <th>角色权限</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${projects}" var="project" varStatus="s">
                        <tr>
                            <td>#${ s.index + 1}</td>
                            <td>
                                <div class="tool" data-toggle="tooltip" data-placement="right"
                                     data-title="简介：${project.prodesc}">${project.proname}</div>
                            </td>
                            <td>${project.starttime}</td>
                            <td>${project.endtime}</td>
                            <td>
                                <button class="btn btn-xs btn-success" onclick="javascript:window.location.href='<%=basePath%>/platform/course?projectid=${project.id}'">课程</button>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-xs btn-warning dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        学习小组 <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="<%=basePath%>/platform/project/createStudyGroupJsp?projectid=${project.id}">创建小组</a></li>
                                        <li><a href="<%=basePath%>/platform/group?projectid=${project.id}">已创建的小组</a></li>
                                    </ul>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-xs btn-primary"
                                        href="<%=basePath%>/platform/project/editJsp?id=${project.id}"
                                        data-toggle="modal" data-target="#Modal${project.id}">编辑
                                </button>
                                <div class="modal fade" id="Modal${project.id}" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="loading"><img src="<%=basePath%>/img/loading.gif"></div>
                                        </div>
                                    </div>
                                </div>
                                <button data-id="${project.id}" data-loading-text="删除中..."
                                        class="delete btn btn-xs btn-danger">删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty projects}">
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
        $("#menu li:eq(2)").addClass("active");
        $(".delete").click(function () {
            var deleteBtn = $(this);
            var $btn = deleteBtn.button('loading');
            $.ajax({
                url: "<%=basePath%>/platform/project/delete?id=" + $(this).data("id"),
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
