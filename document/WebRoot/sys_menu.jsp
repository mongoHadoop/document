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

    <table id="tabelist1"  class="easyui-datagrid" title="系统菜单管理" rownumbers="true" striped="true" pagination="true" fit=true
    		 data-options="
    		 	iconCls:'icon-search',
    		 	closable:false,
                fitColumns: true,
                singleSelect: true,
                rownumbers: true,
                toolbar:'#tb'">  
        <thead>  
            <tr>
				<th field="menuId" width="10" >菜单ID</th>
				<th field="menuName" width="10" editor='text'>菜单名称</th>
				<th field="url" width="20" editor='text'>URL</th>
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
        </div>  
        <form id="from1">
	 	<div style="margin-bottom:5px">  
	 	
	 	          菜单名称:<input id="menuName" style="width:150px">
	 	         
            <a href="#" class="easyui-linkbutton" iconCls="icon-filter" onclick="query()">查询</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearForm()">清空</a>        
        </div> 
         </form>
</div>
</body>	
<script type="text/javascript">
var lastIndex;
$(document).ready(function(){
	collectionFunctions.init();
});


function clearForm(){
    $('#from1').form('clear');
}
function query(){
	var menuName = $('#menuName').val();
	console.log(menuName);
	$('#tabelist1').datagrid({
		queryParams:{
	    	'param.menuName':menuName
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
		    url: '<%=basePath %>manager5/changeRows.action',
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
		var menuName = $('#menuName').val();
		$('#tabelist1').datagrid({
			url:'<%=basePath %>manager5/querySysMenuList.action',  
			queryParams:{
						'param.menuName':menuName
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
	return{
		init : function(){
			initDataGrid();
		}
		
	}
}();
</script>
</html>