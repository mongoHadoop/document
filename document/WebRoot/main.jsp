<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basic Layout - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="./resources/easyui1.4/themes/default/easyui.css">
	<script type="text/javascript" src="./resources/easyui1.4/jquery.min.js"></script>
	<script type="text/javascript" src="./resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="./resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/easyui1.4/themes/icon.css">
</head>
<body>
 <body class="easyui-layout">
	<div data-options="region:'west',split:true" title="菜单导航" style="width:280px;padding1:1px;overflow:hidden;">
		<iframe name="home_main1"  id="home_main" src="<%=basePath%>manager5/doLeftMenuInit.action" width="100%"
					height="100%" marginwidth=0 marginheight=0 frameborder=0 scrolling="no" ></iframe>
	</div>
	<div data-options="region:'center'"  style="overflow:hidden;">
		<iframe name="home_main"  id="home_main" src="<%=basePath%>manager/doInitDocInfo.action" width="100%"
					height="100%" marginwidth=0 marginheight=0 frameborder=0 scrolling="no" ></iframe>
	</div>
</body>
</body>
</html>