<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>     
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
 <HEAD>
  <TITLE> ZTREE DEMO </TITLE>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="../resources/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
  <script type="text/javascript" src="../resources/ztree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../resources/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../resources/ztree/js/jquery.ztree.exedit.js"></script>
  <style>
	body {
	background-color: white;
	margin:0; padding:0;
	text-align: center;
	}
	div, p, table, th, td {
		list-style:none;
		margin:0; padding:0;
		color:#333; font-size:12px;
		font-family:dotum, Verdana, Arial, Helvetica, AppleGothic, sans-serif;
	}
	#testIframe {margin-left: 10px;}
  </style>

  <SCRIPT type="text/javascript" >
	var zTree;
	var demoIframe;

	var setting = {
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false
		},
		async: {
			enable: false,
			type: "post",
			url: "<%=basePath%>manager4/queryTreeMenuList2.action",
			autoParam: ["id"],
			otherParam: { "param.roleId":"${roleId}", "name":"test"}
		},	
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: "0"
			}
		},
		callback: {
				beforeDrag: beforeDrag,
				beforeDrop: beforeDrop,
				onDrop: zTreeOnDrop
		},
		edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false,
				isMove:false,
				isCopy:true,
		}
	};

	var zNodes =[
		{id:101, pId:1, name:"最简单的树 --  标准 JSON 数据", file:"core/standardData"},
		{id:102, pId:1, name:"最简单的树 --  简单 JSON 数据", file:"core/simpleData"},
		{id:103, pId:1, name:"不显示 连接线", file:"core/noline"},
		{id:104, pId:1, name:"不显示 节点 图标", file:"core/noicon"},
		{id:105, pId:1, name:"自定义图标 --  icon 属性", file:"core/custom_icon"},
		{id:106, pId:1, name:"自定义图标 --  iconSkin 属性", file:"core/custom_iconSkin"},
		{id:107, pId:1, name:"自定义字体", file:"core/custom_font"},
		{id:115, pId:1, name:"超链接演示", file:"core/url"},
		{id:108, pId:1, name:"异步加载 节点数据", file:"core/async"},
		{id:109, pId:1, name:"用 zTree 方法 异步加载 节点数据", file:"core/async_fun"},
		{id:110, pId:1, name:"用 zTree 方法 更新 节点数据", file:"core/update_fun"},
		{id:111, pId:1, name:"单击 节点 控制", file:"core/click"},
		{id:112, pId:1, name:"展开 / 折叠 父节点 控制", file:"core/expand"},
		{id:113, pId:1, name:"根据 参数 查找 节点", file:"core/searchNodes"},
		{id:114, pId:1, name:"其他 鼠标 事件监听", file:"core/otherMouse"}
	];

	var zNodes2 =[
	     		
	     		{id:101, pId:1, name:"最简单的树 --  标准 JSON 数据", file:"core/standardData"},
	     		{id:102, pId:1, name:"最简单的树 --  简单 JSON 数据", file:"core/simpleData"},
	     		{id:103, pId:1, name:"不显示 连接线", file:"core/noline"},
	     		{id:104, pId:1, name:"不显示 节点 图标", file:"core/noicon"},
	     		{id:105, pId:1, name:"自定义图标 --  icon 属性", file:"core/custom_icon"},
	     		{id:106, pId:1, name:"自定义图标 --  iconSkin 属性", file:"core/custom_iconSkin"},
	     		{id:107, pId:1, name:"自定义字体", file:"core/custom_font"},
	     		{id:115, pId:1, name:"超链接演示", file:"core/url"},
	     		{id:108, pId:1, name:"异步加载 节点数据", file:"core/async"},
	     		{id:109, pId:1, name:"用 zTree 方法 异步加载 节点数据", file:"core/async_fun"},
	     		{id:110, pId:1, name:"用 zTree 方法 更新 节点数据", file:"core/update_fun"},
	     		{id:111, pId:1, name:"单击 节点 控制", file:"core/click"},
	     		{id:112, pId:1, name:"展开 / 折叠 父节点 控制", file:"core/expand"},
	     		{id:113, pId:1, name:"根据 参数 查找 节点", file:"core/searchNodes"},
	     		{id:114, pId:1, name:"其他 鼠标 事件监听", file:"core/otherMouse"}
	     	];
	

	$(document).ready(function(){
		var treeObj1 = $("#tree1");
		var treeObj2 = $("#tree2");
		var rootNode1 = { id:1, pId:0, name:"系统菜单列表", open:true, iconOpen:"../resources/ztree/css/zTreeStyle/img/diy/1_open.png",
				 iconClose:"../resources/ztree/css/zTreeStyle/img/diy/1_close.png"};

		var rootNode2 = { id:1, pId:0, name:"已授权菜单列表", open:true, iconOpen:"../resources/ztree/css/zTreeStyle/img/diy/1_open.png",
				 iconClose:"../resources/ztree/css/zTreeStyle/img/diy/1_close.png"}; 
		zNodes.push(rootNode1);
		zNodes2.push(rootNode2);
		treeObj1 = $.fn.zTree.init(treeObj1, setting, zNodes);
		treeObj2 = $.fn.zTree.init(treeObj2, setting, zNodes2);
	});

	function beforeDrag(treeId, treeNodes) {
		for (var i=0,k = treeNodes.length; i< k; i++) {
			
			if (treeNodes[i]['pId'] == "0") {//禁止拖ROOT
				return false;
			}
		}
		return true;
	}
	function beforeDrop(treeId, treeNodes, targetNode, moveType) {
		var flag = moveType
		var targetNodeId = targetNode['pId'];
		console.log("pid "+targetNodeId+" targetNode = "+targetNode['name']+" moveType "+moveType);
		if(targetNodeId=="0" && moveType=="inner"){//必须是放在ROOT节点内部
			return true;
		}else if(targetNodeId=="1"&&moveType=="prev"){
			return true;
		}else if(targetNodeId=="1"&&moveType=="next"){
			return true;
		}else{
			return false;
		}
	}	
	
	function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
	
		for (var i=0,k = treeNodes.length; i< k; i++) {
			console.log(k +" treeNodes["+i+"]"+treeNodes[i]['name']);
		}
	
	};
  </SCRIPT>
 </HEAD>

<BODY>
<TABLE border=0 height=600px align=left>
	<TR>
		<TD width=260px align=left valign=top style="BORDER-RIGHT: #999999 1px dashed">
			<ul id="tree1" class="ztree" style="width:260px; overflow:auto;"></ul>
		</TD>
		<TD width=770px align=left valign=top>
		
		<ul id="tree2" class="ztree" style="width:260px; overflow:auto;"></ul></TD>
	</TR>
</TABLE>

</BODY>
</HTML>
