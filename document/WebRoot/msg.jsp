<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui1.4/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/easyui1.4/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/jq_scroll.css">
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/jq_scroll.js"></script>
    <script type="text/javascript" src="<%=basePath %>resources/js/ajax-pushlet-client.js"></script>
  </head>
<script type="text/javascript">
	//PL.userId = "zsy";
	var webUrl ="http://127.0.0.1:8080/push2";
	PL.webRoot=webUrl+"/";
	PL.joinListen('/push/message2');
	function onData(event) {
		document.getElementById("status").innerHTML="您有最新消息,请注意查收！";
		msglistHtml.init2();
		//bottomRight();
	}
    function bottomRight(){
    	$(".messager-body").window('close');
        $.messager.show({
            title:'您有最新条消息',
            href:'./msglist.html',
            showType:'slide',
            showSpeed:2000,
            timeout:0,
            width:400,
            height:250,
            onLoad:function(){
        		msglistHtml.init();
        		 $("#scrollDiv").Scroll({line:1,speed:2000,timer:5000,up:"but_up",down:"but_down"});
        	}
        });
    }

    $(document).ready(function(){
    	 msglistHtml.init2();
     });

</script>
</head>

<body>
<div id="status">

</div>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="bottomRight()">我的消息【右下角】<span>29</span></a>

<div id="userWin1" class="easyui-window" title="系统消息" 
    data-options="modal:true,closed:true,iconCls:'icon-save'"
     style="width:600px;height:400px;padding:1px;">
     
       <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center'" style="padding:10px;">
               <iframe name="msgiframe"  id="msgiframe"  width="100%" 
					height="100%" marginwidth=0 marginheight=0 frameborder=0 scrolling="no"></iframe>
            </div>
            <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="closeWin()" style="width:80px">已读</a>
            </div>
        </div>
     
</div> 
<script type="text/javascript">
var webUrl ="http://127.0.0.1:8080/push2";
function closeWin(){
	$('#userWin1').window('close');
}
msglistHtml =function (){
	var params={};
	params['userId']='zsy';//userId
	function getMsg(){
			$.ajax({
				        url: webUrl+'/servlet/msgLoad.do',
				        datatype: "json",
				        type: 'post',
				        data:params,
				        success: function (text) {
				        	var obj2 = $.parseJSON(text);
				        	clearlist();
				        	addlist(obj2);
				        },error: function(e){
				             alert("后台服务器通讯异常:"+e);
				        }
				});
		 };
	function queryMsNum(){
		$.ajax({
	        url: webUrl+'/servlet/msgLoad.do',
	        datatype: "json",
	        type: 'get',
	        data:params,
	        success: function (text) {
	        	var num = $.parseJSON(text);
	        	showMsgNum(num);
	        },error: function(e){
	             alert("后台服务器通讯异常:"+e);
	        }
		});
	 };
	 function showMsgNum(value){
		 //console.log("show:"+value);
	  	 if(value>0){
		  		bottomRight();
		  }
	 };
		 
	 function clearlist (){
	    	  $("#datalist2 li").remove();
	 };
	 function readMenu(obj){
		  console.log("value id "+obj.id);
		  var msgId = obj.id;
		  $(obj).remove();
		  var action = webUrl+"/servlet/msgQuery.do?msgId="+msgId+"&userId="+params['userId'];
		  console.log();
		  $('iframe').attr("src",action);
		  $('#userWin1').window('open');
	 }
	 
	 function addlist (objs){
	 	for(var i=0; i<objs.length; i++){
		 	var str1 ="<li id="+objs[i].MSGID+"  onclick='msglistHtml.readMenu(this)'><a href ='javascript:void(0);'>";
		 	var str2 = "<span>"+objs[i].MSGTIME+"</span>";
		 	var str0 = "<span>&nbsp;</span>";
		 	var str3 ="<span>"+contentDesc(objs[i].MSGTITLE)+"</span>";
			var str4 ="</a></li>" 	
			$("#datalist2").append(str1+str2+str0+str3+str4);
	 	}
	 };

	 function contentDesc(value){
		if(value.length > 15){
			value =  value.substring(0,15)+"......";
		}	
		return value
     };
	 return {
				init:function(){
		 				getMsg();
				},
				init2:function(){
					 queryMsNum();
				},
				readMenu:function(obj){
					readMenu(obj);
				}
		 }
}();
</script>
</html>
