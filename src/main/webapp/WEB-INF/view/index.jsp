<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="common/header.jsp"></jsp:include>
<!--header-->
<!--content-->
<div class="content">
    <div class="row">
        <h4>我的应用</h4>
        <hr>
        <c:forEach items="${agentInfos}" var="agentInfo" varStatus="s">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">${agentInfo.name}</div>
                    <div class="panel-body">
                            ${agentInfo.description}
                        <hr>
                        操作流程：

                        <a href="<%=basePath%>/menu?appId=${agentInfo.id}">
                            <button class="btn btn-xs btn-success">创建菜单
                            </button>
                        </a>
                        -->
                        <a href="<%=basePath%>/role?appId=${agentInfo.id}">
                            <button class="btn btn-xs btn-primary">创建角色
                            </button>
                        </a>
                        -->
                        <a href="<%=basePath%>/app/managers?id=${agentInfo.id}">
                            <button class="btn btn-xs btn-info">
                                添加管理员
                            </button>
                        </a>
                        <hr>
                        配置信息：<br>
                        <div class="alert alert-info">
                            <label>1. </label> 统一登录地址：
                            <label style="color: #0000cc;text-decoration:underline;word-wrap:break-word;">
                                <%=basePath%>/auth/login?appId=${agentInfo.id}
                            </label>
                            <br>
                            <label>2. </label> 配置应用获取code的地址：
                            <button class="btn btn-xs btn-danger"
                                    href="<%=basePath%>/app/editPage?appId=${agentInfo.id}"
                                    data-toggle="modal" data-target="#Modal">配置登陆地址
                            </button>
                            <br>
                            <label>3. </label> 使用code获取用户信息：
                            <label style="color: #0000cc;text-decoration:underline;word-wrap:break-word;"><%=basePath%>
                                /auth/user/code?appId=${agentInfo.id}&code=******
                            </label>
                            <br>
                            <label>4. </label>
                            用户信息示例：
                            <button class="btn btn-xs btn-danger"
                                    data-toggle="modal" data-target="#ModalSL">JSON示例
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="modal fade" id="ModalSL" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <img src="<%=basePath%>/img/shili.png" style="height: 600px">
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#menu li:eq(0)").addClass("active");
    })
</script>
<!--content-->

<!--bottom-->
<jsp:include page="common/bottom.jsp"></jsp:include>
<!--bottom-->
