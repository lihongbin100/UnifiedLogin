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
<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"><a href="index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
        </div>
    </div>
    <!--End-breadcrumbs-->

    <!--Action boxes-->
    <div class="container-fluid">
        <iframe src="test/formBuilderJsp" width="100%" height="550px" style="border: none"></iframe>

    </div>
</div>

<!--content-->

<!--bottom-->
<jsp:include page="common/bottom.jsp"></jsp:include>
<!--bottom-->
