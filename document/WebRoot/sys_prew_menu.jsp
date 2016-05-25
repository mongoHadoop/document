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

    <table id="tabelist1"  class="easyui-datagrid"  rownumbers="true" striped="true" pagination="true" fit=true
    		 data-options="
    		 	iconCls:'icon-search',
    		 	closable:false,
                fitColumns: true,
                checkOnSelect:true,
				selectOnCheck:true,
                rownumbers: true,
                toolbar:'#tb'">  
        <thead>  
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th field="menuId" width="10" >菜单ID</th>
				<th field="menuName" width="10" editor='text'>菜单名称</th>
				<th field="url" width="20" editor='text'>URL</th>
				<th field="remark" width="20" editor='text'>描述</th>
			</tr>  
        </thead>  
    </table> 
<div id="tb" style="padding:5px;height:auto">  
		<div style="margin-bottom:5px">  
			<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="acceptChange()" plain="true">确认</a>
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

function acceptChange(){
	var selectedRow	= $('#tabelist1').datagrid('getSelections');
	selectedRow = JSON.stringify(selectedRow);
	console.log(selectedRow);
	sendajax();
}

function sendajax(){
	var roleId = ${roleId};
	$.ajax({
	    url: '<%=basePath %>manager4/doGrantRoleMenu.action',
	    datatype: "json",
	    type: 'post',
	    data:{
				'jsonString':rowsStr,
				'param.roleId':roleId
	    },
	    success: function (e) {   //成功后回调

		    
	    },
	    error: function(e){    //失败后回调
	         alert("Services通讯失败:");
	         shutDownWin();
	    },
	    beforeSend: function(){
	    },
	    complete: function(XMLHttpRequest, textStatus){

		}
	 });
}

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

function shutDownWin(){
	window.parent.closeWin();
}

collectionFunctions = function(){
	initDataGrid = function(){
		var menuName = $('#menuName').val();
		$('#tabelist1').datagrid({
			url:'<%=basePath %>manager5/querySysMenuList.action',  
			queryParams:{
						'param.menuName':menuName
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