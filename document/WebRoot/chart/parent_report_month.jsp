<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basic Layout - jQuery EasyUI Demo</title>

	<link rel="stylesheet" type="text/css" href="../resources/easyui1.4/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../resources/easyui1.4/themes/default/easyui.css">
	<script type="text/javascript" src="../resources/easyui1.4/jquery.min.js"></script>
a	<script type="text/javascript" src="../resources/easyui1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../resources/easyui1.4/locale/easyui-lang-zh_CN.js"></script>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',title:'按月查询',split:false" style="height:100px;">
<div id="tb" style="padding:5px;height:auto">
 <form id="from1">
	 	<div style="margin-bottom:5px">  
            科目类型<input id="subject" class="easyui-combobox" name="language" style="width:150px;z-index:10" data-options="
                   url:'./manager8/querySubjtctList.action',
                    method:'post',
                    valueField:'id',
                    textField:'subject',
                    value:[1,2,3],
                    multiple:true,
                    panelHeight:'auto'
                    ">
 				 	    组织机构 : <select id="orgId" name="orgId" panelHeight="auto" style="width:100px">  
            			<option value="" /> 所有站点 </option>
							<s:iterator id="map" value="#request.orgList" status="sta">  
							 	<option value='<s:property value="#map['orgId']"/>'>
									<s:property value="#map['orgName']" />
								</option>
							</s:iterator>
            	</select>
     	 审核状态 : <select id="docstatus" name="docstatus" panelHeight="auto" style="width:100px">  
            			<option value="2" selected="true" /> 待审核 </option>
            			<option value="3" /> 审核办结 </option>
            	</select>	
        </div>
       <div style="margin-bottom:5px" >  
       		开始时间:<input id="recordTimeBegin" class="easyui-datebox"  style="width:150px">
           	截止时间:<input id="recordTimeEnd" class="easyui-datebox"  style="width:150px"> 

            	
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="reportChart.query()">查询</a>
        </div>  
</form>        
</div>
    </div>
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
					<div id="container" style="min-width:700px;height:400px"></div>
    </div> 
    </div> 
  <script type="text/javascript" src="../resources/highcharts/highcharts.js"></script>
   <script>
   var chart1 = null;
  $(function () {
	 chart1 = new Highcharts.Chart({
        chart: {
		  	renderTo : 'container',
            type: 'column'
        },
        colors: ['#FF6666','#3399CC'], 
		credits: {                                                         
            enabled: false                                                 
        }, 
        title: {
            text: 'X月某基站各科目收支情况'
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            min: 0,
            title: {
                text: '单位(元)'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: '收入',
            data: [],
			dataLabels: {
                enabled: true,
                rotation: 0,
                color: '#000000',
                align: 'right',
                x: 4,
                y: 10,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }

        }, {
            name: '支出',
            data: [],
			dataLabels: {
                enabled: true,
                rotation: 0,
                color: '#000000',
                align: 'right',
                x: 4,
                y: 10,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }

        }]
    });

});							
  </script>
<script type="text/javascript">
var reportChart = {};
var param = {};
function getSubjectId(subjectIds){
	var record = {
			subject :[]
			};
	if (subjectIds.length>0) {
		for (var i = 0; i < subjectIds.length;i++) {
			record.subject.push(subjectIds[i]);
		}
	}
	var rowsStr = JSON.stringify(record);
	return rowsStr;
}

function sendAjax(webUrl,param){
	$.ajax({
	    url: webUrl,
	    datatype: "json",
	    type: 'post',
	    data:{
			'param.subjectIds':param.subjectIds,
			'param.recordTimeBegin':param.recordTimeBegin,
			'param.recordTimeEnd':param.recordTimeEnd,
			'param.lendType':param.lendType,
			'param.orgId':param.orgId,
			'param.docstatus':param.docstatus
    	},
	    success: function (data) {   //成功后回调
    		var obj2 = JSON.stringify(data);
	    	console.log("jsonMap ="+obj2);
	       // data = $.parseJSON(data);
	    	reportChart.updateChart(data); 
	    },
	    error: function(e){    //失败后回调
	         alert("Services通讯失败:");
	    },
	    beforeSend: function(){
	    	reportChart.chart.showLoading("数据查询中请稍后...");
	    },
	    complete: function(XMLHttpRequest, textStatus){
	    	reportChart.chart.hideLoading();
		}
	});
}

$(document).ready(function(){
	reportChart.chart = $('#container').highcharts();         
	reportChart.query(); 
});


reportChart.query = function (){
	var subjectIds = $('#subject').combobox('getValues');

	param.orgId = $("select[name='orgId']").find("option:selected").val();
	param.subjectIds = getSubjectId(subjectIds);

	var orgName = $("select[name='orgId']").find("option:selected").text();
	var docstatus = $("select[name='docstatus']").find("option:selected").text();
	param.orgName = orgName;
	param.docstatusText = docstatus;
	
	var recordTimeBegin = $('#recordTimeBegin').datebox('getValue');
	var recordTimeEnd = $('#recordTimeEnd').datebox('getValue');
	param.recordTimeBegin = recordTimeBegin;
	param.recordTimeEnd = recordTimeEnd;
	
	param.lendType = $("#lendType").val();
	param.docstatus = $("#docstatus").val();
	var webUrl ="./manager8/qryReportChart.action";
	sendAjax(webUrl,param);

}
reportChart.updateChart = function(objs){
	var categories = [];
	var data1 =[];
	var data2 =[];
	for(var i=0; i<objs.length; i++){
		categories[i] = objs[i].subject;
		//console.log("cate "+categories[i]);
		var debnum = objs[i].debitNum.money;
		var creditnum = objs[i].creditNum.money;
		data1.push(debnum);
		data2.push(creditnum);
	}
	console.log("data1 "+data1);
	console.log("data1 "+data1);
	console.log("categories "+categories);
	var title = param.recordTimeBegin+param.orgName;
	var docstatusText = param.docstatusText;
	reportChart.chart.setTitle({
        text: title
    },{text:docstatusText}); 
	reportChart.chart.xAxis[0].setCategories(categories);
	reportChart.chart.series[0].setData(data1);
	reportChart.chart.series[1].setData(data2);
}

  </script>
</body>
</html>