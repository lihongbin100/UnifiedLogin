<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tree - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/easyui.css">
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.easyui.min.js"></script>

</head>
<body>

<ul id="tt2" class="easyui-tree" data-options="url:'<%=basePath%>/platform/addressbook/treejson',
            checkbox:true,
            method:'get',
			onClick: function(node){
				$(this).tree('toggle', node.target);
			},
			onContextMenu: function(e,node){
				e.preventDefault();
				$(this).tree('select',node.target);
				$('#mm').menu('show',{
					left: e.pageX,
					top: e.pageY
				});
			}"
        ></ul>


</body>
</html>