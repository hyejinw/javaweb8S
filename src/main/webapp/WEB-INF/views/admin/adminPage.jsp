<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>책(의)세계</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
	  google.charts.load('current', {'packages':['corechart']});
	  google.charts.setOnLoadCallback(drawVisualization);
	
	  function drawVisualization() {
	    // Some raw data (not necessarily accurate)
	    var data = google.visualization.arrayToDataTable([
	      ['Month', '컬렉션 상품', '매거진', '매거진 정기구독', '평균'],
	      <c:forEach var="chartVO" items="${chartVOS}">
	      	[${chartVO.date}+'월', ${chartVO.colCnt}, ${chartVO.maCnt}, ${chartVO.subCnt}, ${chartVO.average}],
	      </c:forEach>
	    ]);
	
	    var options = {
	      vAxis: {title: '판매량'},
	      hAxis: {title: '기준 달'},
	      seriesType: 'bars',
	      series: {3: {type: 'line'}}
	    };
	
	    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	    chart.draw(data, options);
	  }
	  
	  
    google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart2);

	  function drawChart2() {
	
			//날짜형식 변경하고 싶으시면 이 부분 수정하세요.
      var chartDateformat 	= 'yyyy-MM-dd';
      //라인차트의 라인 수
      var chartLineCount    = 10;
      //컨트롤러 바 차트의 라인 수
      var controlLineCount	= 10;
	    var data = new google.visualization.DataTable();
	    data.addColumn('datetime', '날짜');
	    data.addColumn('number', '매거진 정기구독 구독자');
	    data.addColumn('number', '뉴스레터 구독자');
	
	    data.addRows([
 	    	<c:forEach var="subChartVO" items="${subChartVOS}">
	    	 [new Date(${subChartVO.year}, ${subChartVO.month-1}, ${subChartVO.day}, '10'), ${subChartVO.subNum},  ${subChartVO.letterNum}],
	      </c:forEach> 
	    ]);
	
	    var options = {
    		chart: {
	        title: ' ',
	        subtitle: ' '
	      },
	      width: 900,
	      height: 500,
	      hAxis			  : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
              years : {format: ['yyyy년']},
              months: {format: ['MM월']},
              days  : {format: ['dd일']},
              hours : {format: ['HH시']}}
            },textStyle: {fontSize:12}},
	      axes: {
	        x: {
	          0: {side: 'top'}
	        }
	      }
	    };
	
	    var chart = new google.charts.Line(document.getElementById('line_top_x'));
	
	    chart.draw(data, google.charts.Line.convertOptions(options));
	  }
	  
	  
	  google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart3);
    function drawChart3() {
      var data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        <c:forEach var="askVO" items="${askVOS}">
		   	 ['${askVO.category}', ${askVO.askNum}],
		    </c:forEach> 
      ]);

      var options = {
        title: '',
        is3D: true,
      };

      var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
      chart.draw(data, options);
    }
    
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart4);

    function drawChart4() {
      var data = google.visualization.arrayToDataTable([
        ['상품명', '총 판매량'],
        <c:forEach var="prodChartVO" items="${prodChartVOS}">
		   	 ['${prodChartVO.prodName}', ${prodChartVO.salesNum}],
		    </c:forEach> 
      ]);

      var options = {
        chart: {
          title: ' ',
          subtitle: ' ',
        },
        bars: 'horizontal' // Required for Material Bar Charts.
      };

      var chart = new google.charts.Bar(document.getElementById('barchart_material'));

      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
	  /* $(document).ready(function() {
		  <c:forEach var="subChartVO" items="${subChartVOS}">
		  	alert('전체 : '+${subChartVO.year}+ '-'+${subChartVO.month}+'-'+${subChartVO.day})
		  	alert('${subChartVO.subNum} : '+${subChartVO.subNum})
      </c:forEach>
	  }) */
  </script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	
	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left:300px; margin-top:43px;">
	
	  <!-- Header -->
	  <header class="w3-container" style="padding-top:60px">
	    <h5><b><i class="fa fa-dashboard"></i> 주요 통계</b></h5>
	  </header>
	
	  <div class="w3-row-padding w3-margin-bottom">
	    <div class="w3-quarter">
	      <div class="w3-container w3-red w3-padding-16">
	        <div style="font-size:20px">매거진 정기구독</div>
	        <table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독중">구독중</a></td>
			        	<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독종료">구독종료</a></td>
			        	<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독취소신청">구독취소신청</a></td>
			        	<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독취소">구독취소</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독중">${s1}</a></td>
		        		<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독종료">${s2}</a></td>
		        		<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독취소신청">${s3}</a></td>
		        		<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독취소">${s4}</a></td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-blue w3-padding-16">
	      	<div style="font-size:20px">주문</div>
	      	<table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=결제완료">결제완료</a></td>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=배송준비중">배송준비중</a></td>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=배송중">배송중</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=결제완료">${o1}</a></td>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=배송준비중">${o2}</a></td>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=배송중">${o3}</a></td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	    <div class="w3-quarter">
	    	<div class="w3-container w3-teal w3-padding-16">
	      	<div style="font-size:20px">미확인 문의</div>
	      	<table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td><a href="${ctp}/admin/manage/askList">책(의)세계</a></td>
			        	<td><a href="${ctp}/admin/manage/askList?sort=커뮤니티">3개의 책</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/manage/askList">${a1}</a></td>
		        		<td><a href="${ctp}/admin/manage/askList?sort=커뮤니티">${a2}</a></td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-orange w3-text-white w3-padding-16">
	  	    <div style="font-size:20px">3개의 책 (최근 1개월)</div>
	  	    <table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td>최신 기록</td>
			        	<td>최신 문장수집</td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td>${c1}</td>
		        		<td>${c2}</td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	  </div>
	  
	  <div class="w3-row-padding w3-margin-bottom">
	    <div class="w3-quarter">
	      <div class="w3-container w3-red w3-padding-16">
	        <div style="font-size:20px">뉴스레터 구독</div>
	        <table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr><!-- 수정 필요! -->
			        	<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독중">구독중</a></td>
			        	<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독종료">구독취소</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독중">${l1}</a></td>
		        		<td><a href="${ctp}/admin/magazine/subscribeList?sort=구독종료">${l2}</a></td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-blue w3-padding-16">
	      	<div style="font-size:20px">반품</div>
	      	<table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품신청">반품신청</a></td>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품중">반품중</a></td>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품완료">반품완료</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품신청">${r1}</a></td>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품중">${r2}</a></td>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품완료">${r3}</a></td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-teal w3-padding-16">
	      	<div style="font-size:20px">미확인 신고</div>
	      	<table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td><a href="${ctp}/admin/community/report?sort=기록">기록</a></td>
			        	<td><a href="${ctp}/admin/community/report?sort=댓글">댓글</a></td>
			        	<td><a href="${ctp}/admin/community/report?sort=문장수집">문장수집</a></td>
			        	<td><a href="${ctp}/admin/community/report?sort=회원">회원</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/community/report?sort=기록">${p1}</a></td>
		        		<td><a href="${ctp}/admin/community/report?sort=댓글">${p2}</a></td>
		        		<td><a href="${ctp}/admin/community/report?sort=문장수집">${p3}</a></td>
		        		<td><a href="${ctp}/admin/community/report?sort=회원">${p4}</a></td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-orange w3-text-white w3-padding-16">
	  	    <div style="font-size:20px">게임 <span style="font-size:17px">(성공률 / 지급 포인트)</span></div>
	  	    <table class="table text-center mt-3" style="background-color:white">
	        	<thead style="background-color:#eee">
		        	<tr>
			        	<td>주사위 게임</td>
			        	<td>룰렛 게임</td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td>${diceStat.successPercentage} / ${diceStat.totPoint}p</td>
		        		<td>${rouletteStat.successPercentage} / ${rouletteStat.totPoint}p</td>
		        	</tr>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	  </div>
	  
	  
	
	  <div class="w3-panel mt-5">
	    <div class="w3-row-padding text-center" style="margin:50px">
	      <h3 class="mb-3"><b>최근 5개월 판매량 추이</b></h3>
	 			<div id="chart_div" style="width: 1000px; margin:0px auto; height: 500px;"></div>
	    </div>
	  </div>
	  <hr>
	  
	  <div class="w3-panel mt-5" style="margin:0px auto;">
	    <div class="w3-row-padding text-center" style="margin:50px;">
	      <h3 class="mb-3"><b>구독자 추이</b></h3>
	 			<div id="line_top_x" style="width: 1000px; margin:0px auto; height: 500px;"></div>
	    </div>
	  </div>
	  <hr>
		
		<div class="row" style="margin-bottom:100px">
			<div class="col">
		    <div class="w3-row-padding text-center" style="margin:50px;">
		      <h3 class="mb-3"><b>문의 카테고리</b></h3>
		 			<div id="piechart_3d" style="width:100%; max-width:1000px; margin:0px auto; height: 500px;"></div>
			  </div>
			
			</div>
			<div class="col">
		    <div class="w3-row-padding text-center" style="margin:50px;">
		      <h3 class="mb-3"><b>컬렉션 상품 판매율 TOP5</b></h3>
		 			<div id="barchart_material" style="width:100%; max-width:1000px; margin:0px auto; height: 500px;"></div>
			  </div>
			
			</div>
		</div>	  

	</div>
	

</body>
</html>