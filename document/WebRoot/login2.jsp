<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>XX科技</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=basePath%>resources/dist/css/bootstrap.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="<%=basePath%>resources/dist/css/signin.css" rel="stylesheet">
    <script src="<%=basePath%>resources/jquery/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/dist/js/bootstrap.min.js"></script>
  <style type="text/css">
.errors {
	background-color:#FFCCCC;
	border:1px solid #CC0000;
	width:300px;
	margin-bottom:8px;
}
.errors li{ 
	list-style: none; 
}
</style>
  </head>
  <body>
    <div class="container">
      <form id="form1" class="form-signin" action="<%=basePath%>doLoginOn.action" role="form"  method="post">
	     <div style="text-align:center;margin:20px;overflow:hidden">
			<h2>凭证统计系统</h2>
        </div>
        <div>
        <s:if test="hasActionErrors()">
				   <div class="errors">
				      <s:actionerror/>
				   </div>
		</s:if>
        </div>
        <input name="userCode" type="text" class="form-control" placeholder="请输入 账户" required autofocus>
        <input name="password" type="password" class="form-control" placeholder="请输入 密码" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
      </form>
    </div>
  </body>
  <script type="text/javascript">

  function loginSystem(){
	var weburl = '<%=basePath%>/syslogin/loginOn.action';
	var param =  $("#form1").serialize();//序列化表格内容为字符串  
	sendAjax(webUrl,param,callbackMethod);
	
  }

  function callbackMethod(msg){
	alert(msg);
  }
  
  function sendAjax(webUrl,param,callbackFunction){
		$.ajax({
		    url: webUrl,
		    datatype: "json",
		    type: 'post',
		    data:param,
		    success: function (e) {   //成功后回调
			      callBackFunction(e);
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
  </script>
</html>

