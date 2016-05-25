<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link href="<%=basePath %>resources/dist/css/bootstrap.min.css" rel="stylesheet" media="screen">
	<script src="<%=basePath %>resources/jquery/jquery-1.8.3.min.js"></script>
   <script src="<%=basePath %>resources/dist/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
</script>
<body>
<div id="myCarousel" class="carousel slide">
   <!-- 轮播（Carousel）指标 -->
   <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
   </ol>   
   <!-- 轮播（Carousel）项目 -->
   <div class="carousel-inner">
      	<s:iterator id="map" value="#request.imageList" status="sta">
		      <c:choose>
				<c:when test="${sta.index==0}">
					<div class="item active">
        			   <img src="<%=basePath%>images/<s:property value="#map['filePath']"/>" alt="第  ${sta.index+1}张"/>
      				</div>	
				</c:when>
				<c:otherwise>
				      <div class="item">
        					<img src="<%=basePath%>images/<s:property value="#map['filePath']"/>" alt="第  ${sta.index+1}张"/>
      				  </div>
				</c:otherwise>
			</c:choose>
	   </s:iterator>
   </div>
   <!-- 轮播（Carousel）导航 -->
   <a class="carousel-control left" href="#myCarousel" 
      data-slide="prev">&lsaquo;
	  <button type="button" class="btn btn-default">PREV</button>
	  </a>
   <a class="carousel-control right" href="#myCarousel" 
      data-slide="next">&rsaquo;
	  <button type="button" class="btn btn-default">NEXT</button>
	  </a>
</div> 

</body>
</html>
