<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>left.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="<%=basePath %>resources/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
  <script type="text/javascript" src="<%=basePath %>resources/ztree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/ztree/js/jquery.ztree.exedit.js"></script>
  </head>
  <SCRIPT type="text/javascript">
		var setting = {
			data: {
				simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: 0
			}
		},
		};
 
		var zNodes =${menuList};
		var zNodes2 =[];
		$.each(zNodes,function(index,node){
			var url = node['url'];
			node['url']='<%=basePath %>'+url;
			node['target'] ='home_main';
			zNodes2.push(node);
		});
		
 
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes2);
		});
		
	</SCRIPT>
  
  <body>
    <ul id="treeDemo" class="ztree"></ul>
  </body>
</html>
