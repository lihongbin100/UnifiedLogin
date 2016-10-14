<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--header-->
<jsp:include page="header.jsp"></jsp:include>
<!--header-->

<!--content-->
<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"><a href="<%=basePath%>/platform/index" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
            <a href="#" title="Go to 门户" class="tip-bottom"><i class="icon-asterisk"></i>学院门户</a>
        </div>
    </div>
    <!--End-breadcrumbs-->

    <!--Action boxes-->
    <div class="container-fluid">
        <%--<iframe style="float:left;background: url('/img/cms/ajax-loader.gif') center no-repeat"--%>
            <%--src="http://www.wexue.top/pxkc/portalWebJsp" width="320px" height="568px">--%>

            <%--</iframe>--%>
        <jsp:include page="portal/show.jsp"></jsp:include>

    </div>
</div>

<!--content-->

<!--bottom-->
<jsp:include page="bottom.jsp"></jsp:include>
<!--bottom-->
