<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//response.setHeader("Access-Control-Allow-Origin:*");
	//response.setHeader("Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE");
	//response.setHeader("Access-Control-Allow-Headers:x-requested-with,content-type");
	
	
%>
<!DOCTYPE html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
	<script type="text/javascript" src="./resources/jquery/jquery-1.8.3.min.js"></script>
  </head>
<script type="text/javascript">
function getDominResponse(){
	var webUrl ="http://127.0.0.1:8089/push2/servlet/testPushServlet.do";
	$.getJSON(webUrl,function(data){
		console.log(data);
	});
}

function aa(data){
    console.log(data);
 }
//第一种方案
function getDomainResp(){
    var script=document.createElement("script");
    script.type="text/javascript";
//   script.src="http://localhost:8080/test1/DomainServlet?callback=aa";
	script.src = "http://127.0.0.1:8089/push2/servlet/testPushServlet.do?callback=aa";
document.getElementsByTagName("head")[0].appendChild(script);
}
//第二种方案
function getDomainResp2(){
    $.ajax({
       url:'http://127.0.0.1:8089/push2/servlet/testPushServlet.do',
       crossDomain:true,
       dataType:'jsonp',
       type:'post',
       data:{
          jsonp:'callback'
       },
       jsonpCallback:'aa'
    });
}
</script>
<body>
<input type="button" onclick="getDomainResp2()" value="测试">
</body>
</html>
