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
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui1.4/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui1.4/themes/default/easyui.css">
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/jquery/json2.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
	</head>
<body class="easyui-layout"  style="margin: 0px; padding: 0px">

    <table id="tabelist1"  class="easyui-datagrid" title="凭证数据初始化" rownumbers="true" striped="true" pagination="true" fit=true
    sortName="id" sortOrder="desc"
    		 data-options="
    		 	iconCls:'icon-search',
    		 	closable:false,
                fitColumns: true,
                singleSelect: true,
                rownumbers: true,
                toolbar:'#tb'">  
        <thead>  
            <tr>
				<th field="docName" width="10" editor='text' sortable="true">凭证名称</th>
				<th data-options="field:'money',width:10,align:'right',editor:{type:'numberbox',options:{precision:2}}" sortable="true">发生金额</th>
				<th field="orgName" width="10" sortable="true">所属机构</th>
				<th field="recordTime" width="10" sortable="true">录入时间</th>
				<th field="remark" width="30" editor='text' >描述</th>
				<th field="status" width="10" formatter="docStatusDesc">提交状态</th>
			</tr>  
        </thead>  
    </table> 
<div id="tb" style="padding:5px;height:auto">  
		<div style="margin-bottom:5px">  
			<a href="#" class="easyui-linkbutton" iconCls="icon-add"  onclick="addRow()" plain="true" >添加</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="accept()" plain="true">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-undo" onclick="rejectChanges()" plain="true" >撤消</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeRow()" plain="true" >删除</a>
			<a href="#" class="easyui-linkbutton" plain="true" id="importExcel" >Excel导入</a>
			<a href="<%=basePath %>templateExcel/templatedoc.xls" class="easyui-linkbutton" plain="true" >Excel模板下载</a>
        </div>  
        	<form id="from1">
	 	<div style="margin-bottom:5px">  
	 
	 	          凭证名称<input id="docName" style="width:150px">
                               开始时间点:<input id="recordTimeBegin" class="easyui-datebox"  style="width:150px">
           	截止时间点:<input id="recordTimeEnd" class="easyui-datebox"  style="width:150px"> 	   
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
				<input id="excelFile" name="file" type="file">
			</div>
		</form>
</div>

<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="submitForm">导入</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
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
	var docName = $('#docName').val();
	var docType = $('#docType').val();
	var recordTimeBegin = $('#recordTimeBegin').datebox('getValue');
	var recordTimeEnd = $('#recordTimeEnd').datebox('getValue');
	//alert("recordTimeBegin:"+recordTimeBegin+"recordTimeEnd"+recordTimeEnd)
	$('#tabelist1').datagrid({
		url:'<%=basePath %>manager/queryDocList.action',
		queryParams:{
	    	'param.docName':docName,
	    	'param.recordTimeBegin':recordTimeBegin,
	    	'param.recordTimeEnd':recordTimeEnd
    	}
  	});

	
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

function  accept(){
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
	var sendFlag = true;
	if (insertRows.length>0) {
			for (var i=0;i<insertRows.length;i++) {
				changesRows.inserted.push(insertRows[i]);
			}
	  sendFlag = false;
	}

	if (updateRows.length>0) {
			for (var k=0;k<updateRows.length;k++) {
				changesRows.updated.push(updateRows[k]);
			}
	   sendFlag = false;		
	}
				
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
	    url: '<%=basePath %>manager/changeRows.action',
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
	        //alert("正在加载");
	        //ShowLoading();
	    },
	    complete: function(XMLHttpRequest, textStatus){


		}
	});
}



collectionFunctions = function(){
	initDataGrid = function(){
		var docName = $('#docName').val();
		$('#tabelist1').datagrid({
			url:'<%=basePath %>manager/queryDocList.action',  
						queryParams:{
							'param.docName':docName
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
			   var  flag = validateExcel();
			   if(flag){
					return;
				}
				$('#fm').form('submit',{
					url: '<%=basePath %>upload2/uploadDocInfoExcel.action',
	 				dataType: "json",
					onSubmit: function(){
			           var	win = $.messager.progress({
									title:'请等待',
									msg:'数据导入中.....'
								});
		       			 },
						success: function(data){
		 					$.messager.alert('Info', data);
							$.messager.progress('close');
							$('#dlg').dialog('close');
							$('#tabelist1').datagrid("reload");
						}
				});

	    });
	    
	};
	validateExcel = function(){
			var obj = $('#excelFile').val();
			console.log('obj :'+obj);
		    var file_suffix =obj.substr(obj.lastIndexOf(".")).toLowerCase();//获得文件后缀名
			console.log('file_suffix :'+file_suffix);
		    if(file_suffix!='.xls'){
		        alert("请上传后缀名为xls的Excel文档!");
		        return true;
		    }
	};
	return{
		init : function(){
			initImportExcelClick();
			initDataGrid();
		},
		validateExcel:function (){
			validateExcel();
		}
		
	}
}();


docStatusDesc= function(value,row,index){
	var value = row.status;
	if(value=='1'){
		var span = "<span style='color:blue'>未提交</span>";
		return span;
	}
	if(value=='2'){
		var span = "<span style='color:red'>审核中</span>";
		return span;
	}
	if(value=='3'){
		var span = "<span ><strong>审核中</strong></span>";
		return span;
	}
	
}
</script>
</html>    