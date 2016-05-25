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
  <script type="text/javascript" src="<%=basePath %>resources/jquery/json2.js"></script>
<script type="text/javascript" src="../resources/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../resources/ztree/js/jquery.ztree.exedit.js"></script>
	<script type="text/javascript" src="../resources/ztree/js/jquery.ztree.excheck.js"></script>
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
				selectedMulti: true
			},
			check: {
				enable: true,
				autoCheckTrigger: true
			},
			async: {
				enable: true,
				url : "<%=basePath%>manager4/queryTreeMenuList2.action",
				type: "post",
				autoParam: ["id"],
				otherParam: { "param.roleId":"${roleId}"}
			},	
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "pId",
					rootPId: 0
				}
			},
			callback: {
					beforeDrag: beforeDrag,
					beforeDrop: beforeDrop,
					onDrop: zTree2OnDrop,
					onAsyncSuccess: zTreeOnAsyncSuccess
			},
			edit: {
					enable: true,
					showRemoveBtn: false,
					showRenameBtn: false,
					isMove:false,
					isCopy:true,
			}
		};

	$(document).ready(function(){
		$.fn.zTree.init($("#tree2"), setting);
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
	
	function zTree1OnDrop(event, treeId, treeNodes, targetNode, moveType) {
		for (var i=0,k = treeNodes.length; i< k; i++) {
			console.log("tree1 "+k +" treeNodes["+i+"]"+treeNodes[i]['name']);
		}
	
	}


	function zTree2OnDrop(event, treeId, treeNodes, targetNode, moveType) {
		for (var i=0,k = treeNodes.length; i< k; i++) {
			console.log("tree2 "+k +" treeNodes["+i+"]"+treeNodes[i]['name']);
		}
	
	}
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg){
		initAjaxNodeTree();
	}
	function initAjaxNodeTree(){
		$.ajax({
		    url: '<%=basePath %>manager4/queryTreeMenuList1.action',
		    dataType: "json", 
		    type: 'post',
		    data:{
					'param.roleId':${roleId}
		    },
		    success: function (json) {   //成功后回调
		    	seletedGrantMenu(json);
		    },
		    error: function(e){    //失败后回调
		         alert("Services通讯失败:");
		    },
		    beforeSend: function(){
			    
		    },
		    complete: function(XMLHttpRequest, textStatus){

			}
		});
	}


	function seletedGrantMenu(json){
	    $.each(json, function(idx, obj) {
	    	 //console.log("name "+obj['name']+" id "+obj['id']);
	    	 var treeObj = $.fn.zTree.getZTreeObj("tree2");
	    	 var nodes = treeObj.getNodesByParam("id", obj['id'], null);
	    	 $.each(nodes, function(idx, node){
	    		 treeObj.checkNode(node, true, true);
	    		 console.log("name "+node['name']+" id "+node['id']);
			  })
	    	 
	    });
	}

	function getSelectedNode(){
		var treeObj = $.fn.zTree.getZTreeObj("tree2");
		var nodes = treeObj.getCheckedNodes(true);
		 $("div").empty();
   	 	$.each(nodes, function(idx, node){
   	 	  $("div").append("name "+node['name']+" id "+node['id']);
   	 	 $("div").append("<br/>");
		 ///console.log("name "+node['name']+" id "+node['id']);
	  });
  	  return nodes;
	}
     function grantMenu(nodes){
    	 var selectedRow  = getpushRow(nodes);
    	 var rowsStr = JSON.stringify(selectedRow);
 		$.ajax({
 		    url: '<%=basePath %>manager4/doGrantRoleMenu.action',
 		    dataType: "json", 
 		    type: 'post',
 		    data:{
 					'param.roleId':${roleId},
 					'jsonString':rowsStr
 		    },
 		    success: function (json) {   //成功后回调
 		    	window.parent.messageClose();
 		    },
 		    error: function(e){    //失败后回调
 		    	window.parent.messageWaring()
 		    },
 		    beforeSend: function(){
 			    
 		    },
 		    complete: function(XMLHttpRequest, textStatus){

 			}
 		});
    }
     function getpushRow(selectedRow){
    		var changesRows = {
    				selected :[]
    		};
    		if (selectedRow.length>0) {
    				for (var i=0;i<selectedRow.length;i++) {
    					changesRows.selected.push(selectedRow[i]);
    				}
    		}
    		return changesRows
    }
  </SCRIPT>
 </HEAD>

<BODY>
<TABLE border=0 height=600px align=left>
	<TR>
		<TD width=300px align=left valign=top style="BORDER-RIGHT: #999999 1px dashed">
		</TD>
		<TD width=500px align=left valign=top>
		<ul id="tree2" class="ztree" style="width:260px; overflow:auto;"></ul></TD>
	</TR>
</TABLE>

</BODY>
</HTML>
