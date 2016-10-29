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

        <div class="widget-box">
            <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                <%--<h5>项目</h5>--%>
            </div>
            <div class="widget-content nopadding">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>序号ID</th>
                        <th>时间</th>
                        <th>描述</th>
                        <th>操作员</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${logs}" var="log" varStatus="s">
                        <tr>
                            <td>${log.id}</td>
                            <td>
                                ${log.createTime}
                            </td>
                            <td>
                                ${log.description}
                            </td>
                            <td>
                                ${log.operator}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty logs}">
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
        $("#menu li:eq(4)").addClass("active");
        $(".delete").click(function () {
            var deleteBtn = $(this);
            var $btn = deleteBtn.button('loading');
            $.ajax({
                url: "<%=basePath%>/log/delete?id=" + $(this).data("id"),
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
