<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="com.doc.util.PropertiesSingleton" %>
<%@ page language="java" import="com.doc.util.SysInfo" %>
<%@ page language="java" import="java.util.Map" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String adminOrgId = PropertiesSingleton.getInstance().getProperty("user.admin.regionId");
Integer adminorgId = Integer.valueOf(adminOrgId);

Map sysUser  = (Map) session.getAttribute(SysInfo.userSessionKey);
Integer orgId =(Integer)sysUser.get("orgId");
%>  
<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8" />
    <title></title>
    <link href="./resources/dist/css/bootstrap.min.css" rel="stylesheet" media="screen">
     <link href="./resources/dist/css/dashboard.css" rel="stylesheet">
	<script src="./resources/jquery/jquery-1.8.3.min.js"></script>
</head>
<script type="text/javascript">
function loadMenu(){
	$.ajax({
        url: './manager5/loadMenu.action',
        datatype: "json",
        type: 'post',
        success: function (text) {
        	clearlist();
        	addlist(text);
        },error: function(e){
             alert("后台服务器通讯异常:"+e);
        }
});
}


function clearlist (){
	  $("#leftmenu a").remove();
};



function addlist (objs){
 	for(var i=1; i<objs.length; i++){
	 	var str1 ="<a href ='"+objs[i].url+"'  target='home_main'  class='list-group-item' >";
	 	var str2 = "<span class='label label-success'>"+objs[i].name+"</span>";
		var str4 ="</a>" 	
		$("#leftmenu").append(str1+str2+str4);
 	}
};
$(document).ready(function(){
	loadMenu();
});
</script>
<body>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">凭证录入系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right" style="padding-right:10px">
            <li><a href="#">欢迎您：<%=sysUser.get("userName")%></a></li>
            <li><a href="./loginOut.action">系统退出</a></li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar" >
        <div class="panel panel-info">
		  <div class="panel-heading">所属机构:<%=sysUser.get("orgName")%></div>
		  <div class="panel-body">
				  <div id="leftmenu" class="list-group">
				  <a href="#" class="list-group-item active">
				  </a>
				</div>
		  </div>
		</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          	<iframe name="home_main"  id="home_main" src="<%=basePath %>manager/doInitDocInfo.action" width="100%"
						height="520px" marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" ></iframe>
          </div>
        </div>
      </div>
    </div>
</html>

