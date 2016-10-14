<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!--Footer-part-->
<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="loading"><img src="<%=basePath%>/img/loading.gif"></div>
        </div>
    </div>
</div>
<div id="footer" class="center">
    <div> 2013 &copy; Copyright 微学</div>
</div>
<script src="<%=basePath%>/js/platform.js"></script>
<script>
    if($("body").height()< $(window).height()){
        $("#footer").addClass("footer");
    }
</script>
</body>
</html>

