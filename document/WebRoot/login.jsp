<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>系统登录</title>
		<!-- Bootstrap Core CSS -->
		<link href="./resources/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- MetisMenu CSS -->
		<link href="./resources/dist/css/metisMenu.min.css" rel="stylesheet">
		<!-- Custom CSS -->
		<link href="./resources/dist/css/sb-admin-2.css" rel="stylesheet">
		<!-- Custom Fonts -->
		<link href="./resources/dist/css/font-awesome.min.css"
			rel="stylesheet" type="text/css">

		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	</head>

	<body>

		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								凭证管理系统
							</h3>
						</div>
						<div class="panel-body">
							<form role="form" action="<%=basePath%>doLoginOn.action"
								method="post">
								<fieldset>

									<s:if test="hasActionErrors()">
										<div class="form-group">
											<div class="alert alert-warning alert-dismissable">
												<button type="button" class="close" data-dismiss="alert"
													aria-hidden="true">
													&times;
												</button>
												<s:actionerror />
											</div>
										</div>
									</s:if>
									<div class="form-group">
										<input id="userCode" class="form-control" placeholder="账号"
											name="userCode" type="text" autofocus>
									</div>
									<div class="form-group">
										<input id="password" class="form-control" placeholder="密码"
											name="password" type="password" value="">
									</div>
									<div class="checkbox">
										<label>
											<input id="saveUserInfo" type="checkbox" value="Remember Me">
											记住账号
										</label>
									</div>
									<button class="btn btn-lg btn-success btn-block" type="submit">
										登录
									</button>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- jQuery -->
		<script type="text/javascript"
			src="./resources/jquery/jquery-1.8.3.min.js"></script>
		<!-- Bootstrap Core JavaScript -->
		<script type="text/javascript"
			src="./resources/dist/js/bootstrap.min.js"></script>
		<!-- Metis Menu Plugin JavaScript -->
		<script type="text/javascript"
			src="./resources/dist/js/metisMenu.min.js"></script>
		<!-- cookies -->
		<script type="text/javascript"
			src="./resources/jquery/jquery.cookie.js"></script>
		<!-- Custom Theme JavaScript -->
		<script type="text/javascript" src="./resources/dist/js/sb-admin-2.js"></script>

		<script type="text/javascript">

$(document).ready(function(){
	$("input[type='checkbox']").on("click",saveUserInfo);  
	 init_cookies();
});

function saveUserInfo() {
	var userCode = $("#userCode").val();  
	var password = $("#password").val();  
	var status =  $("#status").val();  
	console.log("userCode:"+userCode);
	var checkBoxStatus = $("input[type='checkbox']").attr('checked');
	
	if(checkBoxStatus){
		$.cookie("saveFlag", "true", {
			 expires : 5  
		});
		//console.log("checked");
	}else{
		$.cookie("saveFlag", "false");
		//console.log("unchecked");
	}
	$.cookie("userCode", userCode, {
	 expires : 5  
	});
	$.cookie("password", password, {
	 expires : 5  
	}); // 存储一个带5天期限的 cookie   
}  


function init_cookies(){
	  if ($.cookie("saveFlag") == "true") {
  		var userCode = $.cookie("userCode");
  		var password = $.cookie("password");
  		$("input[type='checkbox']").attr("checked","checked");
  		//console.log("userCode:"+userCode);
		$("input[name='userCode']").val(userCode);
		//$("input[name='password']").val(password);
	}
}
</script>
	</body>

</html>
