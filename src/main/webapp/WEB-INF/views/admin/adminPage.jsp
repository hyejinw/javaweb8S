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
      ['2004/05',  165,      938,         522,      614.6],
      ['2005/06',  135,      1120,        599,      682],
      ['2006/07',  157,      1167,        587,      623],
      ['2007/08',  139,      1110,        615,      609.4],
      ['2008/09',  136,      691,         629,      569.6]
    ]);

    var options = {
      title : '판매량',
      vAxis: {title: '판매량'},
      hAxis: {title: '기간'},
      seriesType: 'bars',
      series: {3: {type: 'line'}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
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
<%-- 		        	<tr>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품신청">최신 기록</a></td>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품중">최신 문장수집</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품신청">${c1}</a></td>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품중">${c2}</a></td>
		        	</tr> --%>
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
<%-- 		        	<tr>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품신청">최신 기록</a></td>
			        	<td><a href="${ctp}/admin/order/orderListSearch?sort=반품중">최신 문장수집</a></td>
		        	</tr>
	        	</thead>
	        	<tbody>
		        	<tr>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품신청">${c1}</a></td>
		        		<td><a href="${ctp}/admin/order/orderListSearch?sort=반품중">${c2}</a></td>
		        	</tr> --%>
	        	</tbody>
	        </table>
	      </div>
	    </div>
	  </div>
	  
	  
	
	  <div class="w3-panel">
	    <div class="w3-row-padding" style="margin:50px">
	      <h2>수평 막대 차트</h2>
	 			<div id="chart_div" style="width: 1000px; height: 500px;"></div>
	    </div>
	  </div>
	  <hr>
	  
	  
	  <div class="w3-container">
	    <h5>General Stats</h5>
	    <p>New Visitors</p>
	    <div class="w3-grey">
	      <div class="w3-container w3-center w3-padding w3-green" style="width:25%">+25%</div>
	    </div>
	
	    <p>New Users</p>
	    <div class="w3-grey">
	      <div class="w3-container w3-center w3-padding w3-orange" style="width:50%">50%</div>
	    </div>
	
	    <p>Bounce Rate</p>
	    <div class="w3-grey">
	      <div class="w3-container w3-center w3-padding w3-red" style="width:75%">75%</div>
	    </div>
	  </div>
	  <hr>
	
	  <div class="w3-container">
	    <h5>Countries</h5>
	    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
	      <tr>
	        <td>United States</td>
	        <td>65%</td>
	      </tr>
	      <tr>
	        <td>UK</td>
	        <td>15.7%</td>
	      </tr>
	      <tr>
	        <td>Russia</td>
	        <td>5.6%</td>
	      </tr>
	      <tr>
	        <td>Spain</td>
	        <td>2.1%</td>
	      </tr>
	      <tr>
	        <td>India</td>
	        <td>1.9%</td>
	      </tr>
	      <tr>
	        <td>France</td>
	        <td>1.5%</td>
	      </tr>
	    </table><br>
	    <button class="w3-button w3-dark-grey">More Countries  <i class="fa fa-arrow-right"></i></button>
	  </div>
	  <hr>
	  <div class="w3-container">
	    <h5>Recent Users</h5>
	    <ul class="w3-ul w3-card-4 w3-white">
	      <li class="w3-padding-16">
	        <img src="/w3images/avatar2.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
	        <span class="w3-xlarge">Mike</span><br>
	      </li>
	      <li class="w3-padding-16">
	        <img src="/w3images/avatar5.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
	        <span class="w3-xlarge">Jill</span><br>
	      </li>
	      <li class="w3-padding-16">
	        <img src="/w3images/avatar6.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
	        <span class="w3-xlarge">Jane</span><br>
	      </li>
	    </ul>
	  </div>
	  <hr>
	
	  <div class="w3-container">
	    <h5>Recent Comments</h5>
	    <div class="w3-row">
	      <div class="w3-col m2 text-center">
	        <img class="w3-circle" src="/w3images/avatar3.png" style="width:96px;height:96px">
	      </div>
	      <div class="w3-col m10 w3-container">
	        <h4>John <span class="w3-opacity w3-medium">Sep 29, 2014, 9:12 PM</span></h4>
	        <p>Keep up the GREAT work! I am cheering for you!! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><br>
	      </div>
	    </div>
	
	    <div class="w3-row">
	      <div class="w3-col m2 text-center">
	        <img class="w3-circle" src="/w3images/avatar1.png" style="width:96px;height:96px">
	      </div>
	      <div class="w3-col m10 w3-container">
	        <h4>Bo <span class="w3-opacity w3-medium">Sep 28, 2014, 10:15 PM</span></h4>
	        <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><br>
	      </div>
	    </div>
	  </div>
	  <br>
	  <div class="w3-container w3-dark-grey w3-padding-32">
	    <div class="w3-row">
	      <div class="w3-container w3-third">
	        <h5 class="w3-bottombar w3-border-green">Demographic</h5>
	        <p>Language</p>
	        <p>Country</p>
	        <p>City</p>
	      </div>
	      <div class="w3-container w3-third">
	        <h5 class="w3-bottombar w3-border-red">System</h5>
	        <p>Browser</p>
	        <p>OS</p>
	        <p>More</p>
	      </div>
	      <div class="w3-container w3-third">
	        <h5 class="w3-bottombar w3-border-orange">Target</h5>
	        <p>Users</p>
	        <p>Active</p>
	        <p>Geo</p>
	        <p>Interests</p>
	      </div>
	    </div>
	  </div>
	
	  <!-- Footer -->
	  <footer class="w3-container w3-padding-16 w3-light-grey">
	    <h4>FOOTER</h4>
	    <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
	  </footer>
	  <!-- End page content -->
	</div>
	

</body>
</html>