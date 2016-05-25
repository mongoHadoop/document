<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>     
<html>
  <head>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui1.4/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui1.4/themes/default/easyui.css">
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/jquery/json2.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
	</head>

<body class="easyui-layout"  style="margin: 0px; padding: 0px">

<table id="tabelist1"  class="easyui-datagrid" title="文件管理" rownumbers="true" striped="true"  fit=true
    		 data-options="
    		 	iconCls:'icon-search',
    		 	closable:false,
                fitColumns: true,
                ctrlSelect:true,
                rownumbers: true,
                toolbar:'#tb'">  
        <thead>  
            <tr>
            	<th field="fileId" width="5" formatter="optionsView">查看</th>
				<th field="filePath" width="50" formatter="fileURL">文件名称</th>
				<th field="fileType" width="5"  formatter="fileTypeDesc">文件类型</th>
			</tr>  
        </thead>  
    </table> 
    
<div id="tb" style="padding:5px;height:auto">  
		<div style="margin-bottom:5px">  
			<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="accept()" plain="true">确认</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-undo" onclick="rejectChanges()" plain="true" >撤消</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeRow()" plain="true" >删除</a>
        </div>  
</div>    
    <div id="preWin" class="easyui-window" title="原始凭证图片展示" data-options="modal:true,closed:true,iconCls:'icon-save'" 
    style="width:550px;height:350px;padding:1px;">
	<iframe name="main"  id="main" width="100%"
					height="100%" marginwidth=0 marginheight=0 frameborder=0 scrolling="no"></iframe>
    </div> 

<script type="text/javascript">
$(document).ready(function(){
	initDataGrid();
});

function initDataGrid(){
	var docId = ${docId};
	$('#tabelist1').datagrid({
		url:'<%=basePath%>upload1/querFilePathList.action',
		queryParams:{
	    	'param.docId':docId
    	}
  	});
};

function fileTypeDesc(value,row,index){
	var value = row.fileType;
	if(value=='1'){
		return "图片";
	}else if(value=='2'){
		return "附件";
	}else{
		return '';
	}
}

function fileURL(value,row,index){
	var filePath = row.filePath;
	var fileType = row.fileType;
	if(fileType == '1'){
		return "<a href='javascript:void(0);'>"+filePath+"</a>"; 
	}
	if(fileType == '2'){
		var filePath2 = "<%=basePath%>images/"+filePath;
		return "<a  href='javascript:void(0);'>"+filePath+"</a>"; 
	}
	
}

function optionsView(value,row,index){
	var filePath = row.filePath;
	var fileType = row.fileType;
	if(fileType == '1'){
		return "<a  onclick='showPic(\""+row.docId+"\");' href='javascript:void(0);'>查看</a>"; 
	}
	if(fileType == '2'){
		var filePath2 = "<%=basePath%>images/"+filePath;
		return "<a   href="+filePath2+">查看</a>"; 
	}
}

function showPic(value){
	
	var action = '<%=basePath%>upload1/doviewImage.action?param.docId='+value;
	$('iframe').attr("src",action);
	$('#preWin').window('open');
}


function removeRow(){
	var deleteRows	= $('#tabelist1').datagrid('getSelections');
	if(deleteRows.length > 0){
		for (var j=0;j<deleteRows.length;j++) {
			var index = $('#tabelist1').datagrid('getRowIndex',deleteRows[j]);
	 		$('#tabelist1').datagrid('deleteRow', index);
		}
	}
}

function  accept(){
	var deleteRows = $('#tabelist1').datagrid('getChanges','deleted');
	var changesRows = {
	    				inserted :[],
	    				updated : [],
	    				deleted : []
	    				};
	var sendFlag = true;
	if (deleteRows.length>0) {
			for (var j=0;j<deleteRows.length;j++) {
				changesRows.deleted.push(deleteRows[j]);
			}
		sendFlag = false;				
	}
	if(sendFlag){
		return ;
	}
	saveChange(changesRows);
}


saveChange = function(changesRows){
	var rowsStr = JSON.stringify(changesRows);
	$('#tabelist1').datagrid('acceptChanges');
	$.ajax({
	    url: '<%=basePath %>upload1/changeRows.action',
	    dataType: "json",
	    type: 'post',
	    data:{
				'jsonString':rowsStr
	    },
	    success: function (data) {   //成功后回调
	    	$.messager.alert('Info', data);
	    	$('#tabelist1').datagrid("reload");
	    },
	    error: function(e){    //失败后回调
	         alert("Services通讯失败:"+e);
	    },
	    beforeSend: function(){
		    
	    },
	    complete: function(XMLHttpRequest, textStatus){


		}
	});
}

function rejectChanges(){	
	$('#tabelist1').datagrid('rejectChanges');
}

</script>
</body>