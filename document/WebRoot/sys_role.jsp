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
				<th field="roleId" width="10" >角色ID</th>
				<th field="roleName" width="10" editor='text'>角色</th>
				<th field=" " width="10" formatter=grantRoleMenu>操作</th>
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
	 	
	 	          菜单名称:<input id="roleName" style="width:150px">
	 	         
            <a href="#" class="easyui-linkbutton" iconCls="icon-filter" onclick="query()">查询</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearForm()">清空</a>        
        </div> 
         </form>
</div>


<div id="RoleWin1" class="easyui-window" title="系统账号设置" 
    data-options="modal:true,closed:true,iconCls:'icon-save',footer:'#ft',onClose:refeach"
     style="width:50%;height:60%;padding:1px;">
     <iframe name="child"  id="child"  width="100%"
					height="100%" marginwidth=0 marginheight=0 frameborder=0 scrolling="no"></iframe>
</div> 
 <div id="ft" style="padding:5px;">
 	<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="callChild()"  plain="true">授权</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-undo" onclick="closeWin()"  plain="true" >关闭</a>
 </div>
</body>	
<script type="text/javascript">
var lastIndex;
$(document).ready(function(){
	collectionFunctions.init();
});
/*
child 为iframe的name属性值，
不能为id，因为在FireFox下id不能获取iframe对象
*/
function callChild() {
	 var nodes = child.window.getSelectedNode();
	 $.each(nodes, function(idx, node){
			 console.log("parent name "+node['name']+" id "+node['id']);
	});	 
	confirm1(nodes);
}

function confirm1(nodes){
    $.messager.confirm('系统提示', '是否确认授权?', function(r){
        if (r){
        	child.window.grantMenu(nodes);
        	$.messager.progress({
				title:'请等待',
				msg:'授权中请稍后.....',
				timeout:5000,
                showType:'slide'
			});
        }
    });
}
function messageClose(){
	$.messager.alert('系统提示','授权成功');
	$.messager.progress('close');
}

function messageWaring(){
	$.messager.alert('系统提示','授权失败,通讯异常,请联系管理员','warning');
	$.messager.progress('close');
	closeWin();
}

function grantRoleMenu(value,row,index){

	 return "<a class='ll_button' onclick='openWin(\""+row.roleId+"\");' href='javascript:void(0);'>菜单授权</a>";   
}

function openWin(value){
	var action = '<%=basePath%>manager4/doPreRoleMenu.action?param.roleId='+value;
	console.log(action);
	$('iframe').attr("src",action);
	$('#RoleWin1').window('open');
}

function refeach(){
	$('#tabelist1').datagrid('reload');
}
function closeWin(){
	$('#RoleWin1').window('close');
}
function clearForm(){
    $('#from1').form('clear');
}
function query(){
	var roleName = $('#roleName').val();
	console.log(roleName);
	$('#tabelist1').datagrid({
		queryParams:{
	    	'param.roleName':roleName
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
		    url: '<%=basePath %>manager6/changeRows.action',
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
		var roleName = $('#roleName').val();
		$('#tabelist1').datagrid({
			url:'<%=basePath %>manager6/querySysRoleList.action',  
			queryParams:{
						'param.roleName':roleName
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