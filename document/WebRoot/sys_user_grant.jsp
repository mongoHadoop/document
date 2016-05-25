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
    <div class="easyui-panel"  style="width:400px" region="center">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" action="<%=basePath %>/manager4/updateUserRight.action"
        class="easyui-form" method="post" data-options="novalidate:true">
            <table cellpadding="5">
                <tr>
                    <td>用户名称:</td>
                    <td><input id="userName" class="easyui-textbox" type="text" name="param.userName"  
                    value="${userBean.userName}"
                    data-options="required:true"></input>
                    <s:set id="userBean" value="#request.userBean"/>
                    <s:hidden name="param.userId"value="%{#userBean.userId}"></s:hidden>
                    </td>
                </tr>
                <tr>
                    <td>系统账号:</td>
                    <td><input id="userCode" class="easyui-textbox" type="text" name="param.userCode" 
                     value="${userBean.userCode}"
                     data-options="required:true,validType:'email'"></input></td>
                </tr>
                <tr>
                    <td>密码:</td>
                    <td><input id="password"  class="easyui-textbox" type="password" name="param.pwd" 
                    value="${userBean.pwd}"
                    data-options="required:true"></input></td>
                </tr>
                 <tr>
                    <td>密码确认:</td>
                    <td>
                    <input id="rpwd" name="rpwd" type="password" class="easyui-validatebox" 
                     value="${userBean.pwd}"
    					required="required" validType="equals['#password']">
                    </td>
                </tr>
                <tr>
                    <td>角色:</td>
                    <td>
                        <select id="roleId" name="param.roleId">
                        <option value="" />--请选择--</option>
							<s:iterator id="map" value="#request.roleList" status="sta">  
							 	<option value='<s:property value="#map['roleId']"/>'>
									<s:property value="#map['roleName']" />
								</option>
							</s:iterator>
                    </td>
                </tr>
                <tr>
                    <td>组织机构:</td>
                    <td>
                        <select id="orgId"   name="param.orgId">
                         <option value="" />--请选择--</option>
                        	<s:iterator id="map" value="#request.orgList" status="sta">  
							 	<option value='<s:property value="#map['orgId']"/>'>
									<s:property value="#map['orgName']" />
								</option>
							</s:iterator>
                    </td>
                </tr>
                
            </table>
        </form>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton"  iconCls="icon-ok" onclick="submitForm()">提交</a>
            <a href="javascript:void(0)" class="easyui-linkbutton"  iconCls="icon-no"  onclick="shutDownWin()">关闭</a>
        </div>
        </div>
    </div>
<script type="text/javascript">
$.extend($.fn.validatebox.defaults.rules, {
    equals: {
        validator: function(value,param){
            return value == $(param[0]).val();
        },
        message: '密码前后设置不一致'
    }
});

$(document).ready(function(){
	initSelectOpts();
});
function initSelectOpts(){
	var roleId = "${userBean.roleId}";
	var orgId = "${userBean.orgId}";
	console.log("roleId "+roleId +" orgId "+orgId);
	if(roleId!="" && typeof(roleId)!='undefined'&&roleId!=null){
	 	$("#roleId").find("option[value="+roleId+"]").attr("selected",true);
	}
	if(orgId!="" && typeof(orgId)!='undefined'&&orgId!=null){
	 	$("#orgId").find("option[value="+orgId+"]").attr("selected",true);
	}
}
function submitForm(){
    $('#ff').form('submit',{
        onSubmit:function(){
	       $.messager.progress({
				title:'请等待',
				msg:'授权中请稍后.....'
			});
    		var isValid =$(this).form('enableValidation').form('validate');
			if (!isValid){
				$.messager.progress('close');	// hide progress bar while the form is invalid
			}
			return isValid;
        },
        success: function(data){
			shutDownWin();
		}
    });
}

function shutDownWin(){
	window.parent.closeWin();
}
</script>    
    
</body>