<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>     
    
<html>
  <head>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="./resources/easyui1.4/themes/default/easyui.css">
	<script type="text/javascript" src="./resources/easyui1.4/jquery.min.js"></script>
	<script type="text/javascript" src="./resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="./resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/easyui1.4/themes/icon.css">
	</head>
<body class="easyui-layout"  style="margin: 0px; padding: 0px">

    <table id="tabelist1"  class="easyui-datagrid" title="系统人员管理" rownumbers="true" striped="true" pagination="true" fit=true
    		 data-options="
    		 	iconCls:'icon-search',
    		 	closable:false,
                fitColumns: true,
                singleSelect: true,
                rownumbers: true,
                toolbar:'#tb'">  
        <thead>  
            <tr>
				<th field="userName" width="10" editor='text'>姓名</th>
				<th field="userCode" width="10">系统账号</th>
				<th field="pwd" width="20">密码</th>
				<th field="roleName" width="10" >角色</th>
				<th field="orgName" width="10" >所属组织</th>
				<th field=" " width="10" formatter=setsysUserCode>操作</th>
				<th field="remark" width="20" editor='text'>描述</th>
			</tr>  
        </thead>  
    </table> 
<div id="tb" style="padding:5px;height:auto">  
		<div style="margin-bottom:5px">  
			<a href="#" class="easyui-linkbutton" iconCls="icon-add"  onclick="addRow()" plain="true" >添加</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="acceptChange()" plain="true">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-undo" onclick="rejectChanges()" plain="true" >撤消</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeRow()" plain="true" >删除</a>
			<a href="#" class="easyui-linkbutton" plain="true" id="importExcel" >Excel导入</a>
			<a href="<%=basePath %>templateExcel/templatesysuser.xls" class="easyui-linkbutton" plain="true" >Excel模板下载</a>
        </div>  
        <form id="from1">
	 	<div style="margin-bottom:5px">  
	 	
	 	          人员名称:<input id="userName" style="width:150px">
	 	         
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="query()">查询</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearForm()">清空</a>        
        </div> 
         </form>
</div>
	
	
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">数据导入</div>
		<form id="fm" method="post" enctype="multipart/form-data">
			<div class="fitem">
				<label>文件选择:</label>
				<input name="file" type="file">
			</div>
		</form>
</div>

<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="submitForm">导入</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>	




<div id="userWin1" class="easyui-window" title="账号设置" 
    data-options="modal:true,closed:true,iconCls:'icon-save',onClose:refeach"
     style="width:550px;height:400px;padding:1px;">
     <iframe name="main"  id="main"  width="100%"
					height="100%" marginwidth=0 marginheight=0 frameborder=0 scrolling="no"></iframe>
</div> 
</body>	
<script type="text/javascript">
var lastIndex;
$(document).ready(function(){
	collectionFunctions.init();
});

function setsysUserCode(value,row,index){
	 return "<a class='ll_button' onclick='uploadWin(\""+row.userId+"\");' href='javascript:void(0);'>账号设置</a>";   
}

function uploadWin(value){
	var action = '<%=basePath%>manager4/doSetUserCode.action?param.userId='+value;
	$('iframe').attr("src",action);
	$('#userWin1').window('open');
}

function refeach(){
	$('#tabelist1').datagrid('reload');
}

function closeWin(){
	$('#userWin1').window('close');
}
function clearForm(){
    $('#from1').form('clear');
}
function query(){
	var userName = $('#userName').val();
	console.log(userName);
	$('#tabelist1').datagrid({
		queryParams:{
	    	'param.userName':userName
    	}
  	});
	$('#tabelist1').datagrid("reload");
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


function addRow(){
	if (lastIndex != undefined) {
		$('#tabelist1').datagrid('endEdit', lastIndex);
	}
	
	$('#tabelist1').datagrid('appendRow',{
			docName:'',
			money:'',
			recordUser:'',
			recordTime:'',
			remark:''
	});
	lastIndex = $('#tabelist1').datagrid('getRows').length-1;
	$('#tabelist1').datagrid('selectRow', lastIndex);
	$('#tabelist1').datagrid('beginEdit', lastIndex);
}

function rejectChanges(){	
	$('#tabelist1').datagrid('rejectChanges');
}

function  acceptChange(){
	if (lastIndex != undefined) {
				$('#tabelist1').datagrid('endEdit', lastIndex);
	}
	var insertRows = $('#tabelist1').datagrid('getChanges','inserted');
	var updateRows = $('#tabelist1').datagrid('getChanges','updated');
	var deleteRows = $('#tabelist1').datagrid('getChanges','deleted');
	var changesRows = {
	    				inserted :[],
	    				updated : [],
	    				deleted : []
	    				};
	if (insertRows.length>0) {
			for (var i=0;i<insertRows.length;i++) {
				changesRows.inserted.push(insertRows[i]);
			}
	}

	if (updateRows.length>0) {
			for (var k=0;k<updateRows.length;k++) {
				changesRows.updated.push(updateRows[k]);
			}
	}
				
	if (deleteRows.length>0) {
			for (var j=0;j<deleteRows.length;j++) {
				changesRows.deleted.push(deleteRows[j]);
			}
	}

	saveChange(changesRows);
}

function saveChange(changesRows){
	var rowsStr = JSON.stringify(changesRows);
	$('#tabelist1').datagrid('acceptChanges');
	$.ajax({
		    url: '<%=basePath %>manager1/changeRows.action',
		    datatype: "json",
		    type: 'post',
		    data:{
					'jsonString':rowsStr
		    },
		    success: function (e) {   //成功后回调
		    	$('#tabelist1').datagrid("reload");
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


collectionFunctions = function(){
	initDataGrid = function(){
		var userName = $('#userName').val();
		$('#tabelist1').datagrid({
			url:'<%=basePath %>manager1/querySysUserList.action',  
			queryParams:{
						'param.userName':userName
			}, 
    		onClickRow:function(rowIndex){
				if (lastIndex != rowIndex){
					$('#tabelist1').datagrid('endEdit', lastIndex);
					$('#tabelist1').datagrid('beginEdit', rowIndex);
				}
				lastIndex = rowIndex;
    		},
			onAfterEdit:function(index,row){  
					$('#tabelist1').datagrid('endEdit', index);
			},
			onCancelEdit:function(){
				
			}
		});
	
	};
	
	initImportExcelClick = function(){
	$("#importExcel").on("click",function(){
			$('#dlg').dialog('open').dialog('setTitle','文件导入');
			$('#fm').form('clear');
	   });
	   $("#submitForm").on("click",function(){
			$('#fm').form('submit',{
				url: '<%=basePath %>upload2/uploadUserExcel.action',
 				dataType: "json",
				onSubmit: function(){
					return $(this).form('validate');
				},
				onSubmit: function(){
		           var	win = $.messager.progress({
								title:'请等待',
								msg:'数据导入中.....'
							});
	       			 },
					success: function(e){
	 					alert(e);
						$.messager.progress('close');
						$('#dlg').dialog('close');
						$('#tabelist1').datagrid("reload");
					}
			});

	   });
	};
	return{
		init : function(){
			initImportExcelClick();
			initDataGrid();
		}
		
	}
}();
</script>
</html>