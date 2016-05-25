<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
   	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui1.4/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui1.4/themes/default/easyui.css">
	<script type="text/javascript" src="<%=basePath%>resources/easyui1.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
	</head>
	
<body>
    <div class="easyui-panel" data-options="fit:true,border:false">
        <div style="padding:10px 60px 20px 60px" fit="true">
        <form id="ff" class="easyui-form"  
        	action="<%=basePath %>upload1/uploadImage.action" 
        	enctype="multipart/form-data" method="post" 
        	data-options="novalidate:true">
            <table cellpadding="5">
                <tr id="tr1">
                    <td>文件1</td>
                    <td>
					<input class="easyui-filebox" name="image"  data-options="prompt:'Choose a file...'" style="width:100%">
					</td>
                </tr>
                <tr id="tr2">
                    <td>文件2:</td>
                    <td>
					<input class="easyui-filebox" name="image"  data-options="prompt:'Choose a file...'" style="width:100%">
					</td>
                </tr>
                <tr id="tr3">
                    <td>文件3:</td>
                    <td>
					<input class="easyui-filebox" name="image"  data-options="prompt:'Choose a file...'" style="width:100%">
					</td>
                </tr>
                <tr>
                    <td>科目类型:</td>
                    <td>
					   <select id="subject" name="param.subject" style="width:50%">
					   		<option value="" />--请选择--</option>
							<s:iterator id="map" value="#request.docSubjectList" status="sta">  
							 	<option value='<s:property value="#map['id']"/>'>
									<s:property value="#map['subject']" />
								</option>
							</s:iterator>
						</select>
					<input type="hidden" name="param.docId" value="${docId}">	
                    </td>
                </tr>
                 <tr>
                    <td>收支方向:</td>
                    <td>
					   <select id="lendType" name="param.lendType" style="width:50%">
					   		<option value="" />--请选择--</option>
							<option value="1" />收入</option>
							<option value="2" />支出</option>
						</select>
                    </td>
                </tr>
                 <tr>
                    <td>报销人员:</td>
                    <td>
						<select id="userId" name="param.userId" style="width:50%">
					   		<option value="" />--请选择--</option>
							<s:iterator id="map" value="#request.docUserList" status="sta">  
							 	<option value='<s:property value="#map['userId']"/>'>
									<s:property value="#map['userName']" />
								</option>
							</s:iterator>
						</select>
                    </td>
                </tr>
            </table>
        </form>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm()">上传</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="clearForm()">清除</a>
        </div>
        </div>
    </div>
</body>	
<script language="JavaScript">
$(document).ajaxError(function (e, xhr, settings, error) {
	  alert("ajax 调用失败");
	  console.log(error);
});

$(document).ready(function(){
	initSelectOpts();
	initFileType();
});

function initFileType(){
	var fileNum = ${fileNum};
	console.log("fileNum "+fileNum);
	switch (fileNum){
		case 1:
			console.log("1");
			$('#tr3').remove();
			break;
		case 2:
			console.log("2222");
			$('#tr2').remove();
			$('#tr3').remove();
			break;
		case 3:
			console.log("333333");
			$('#tr1').remove();
			$('#tr2').remove();
			$('#tr3').remove();
			break;	
	}
}


function initSelectOpts(){
	var subjectId = "${docInfo.subjectId}";
	var lendType = "${docInfo.lendType}";
	//console.log("subjectId "+subjectId+"lendType "+lendType);
	if(subjectId!="" && typeof(subjectId)!='undefined'&&subjectId!=null){
	 	$("#subject").find("option[value="+subjectId+"]").attr("selected",true);
	}
	if(lendType!="" && typeof(lendType)!='undefined'&&lendType!=null){
	 	$("#lendType").find("option[value="+lendType+"]").attr("selected",true);
	}
}


function submitForm(){

	if(validateForm()){
		return
	}
    $('#ff').form('submit',{
        onSubmit:function(){
        	var	win = $.messager.progress({
						title:'请等待',
						msg:'文件上传中.....'
					});
        },
        success: function(data){
        	alert(data);
			$.messager.progress('close');
			shutDownWin();
		}
    });
}
function clearForm(){
    $('#ff').form('clear');
}

function validateForm(){
  var subject = $('#subject').val();
  var lendType = $('#lendType').val();
//console.log("subject"+subject+" lendType "+lendType);
  
  if(validateNull(subject)){
	 alert("请选择科目类型");
	return true;
  }
  if(validateNull(lendType)){
	alert("请选择借贷方向");
	return true;
  }
	
}

function validateNull(value){
  if(typeof(value)!="undefined"&&value!=null&&value.length>0){
    return false;
  }else{
	return true; 
   }
	
}

function shutDownWin(){
	window.parent.closeWin();
}
</script>
</html>