<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
  <script type="text/javascript" src="../resources/jquery/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="../resources/highcharts/highcharts.js"></script>
  <script type="text/javascript" src="../resources/highcharts/exporting.js"></script>
  <script type="text/javascript" src="../resources/highcharts/highcharts-3d.js"></script>
   <script>
  $(function () {
    $('#container').highcharts({
        chart: {
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
            categories: [
                '管理费用',
                '销售费用',
                '原材料',
                '库存现金',
                '人员工资',
                '财务费用'
            ]
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
            data: [37, 46, 29, 43, 30,30],
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
            data: [2, 1, 1, 4, 2, 3],
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
</head>
<body>
  <div id="container" style="min-width:700px;height:400px"></div>
</body>
</html>
  </body>
</html>
