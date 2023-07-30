<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
		body,h1,h2,h3,h4,h5,h6 {font-family: 'SUIT-Regular', 'Noto Sans KR', sans-serif;}
 		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
	  .head {
	 		font-size: 20px;
	  }
	  .must {
  		color: red;
		}
		.wrapper {
		  /* width: 50px;
		  height: 50px; */
		  text-align: center;
		  /* margin: 50px auto; */
		}
		.switch {
		  position: absolute;
		  /* hidden */
		  appearance: none;
		  -webkit-appearance: none;
		  -moz-appearance: none;
		}
		.switch_label {
		  position: relative;
		  cursor: pointer;
		  display: inline-block;
		  width: 53px;
		  height: 23px;
		  background: #fff;
		  border: 2px solid #daa;
		  border-radius: 20px;
		  transition: 0.2s;
		}
		.switch_label:hover {
		  background: #efefef;
		}
		.onf_btn {
		  position: absolute;
		  top: 2px;
		  left: 3px;
		  display: inline-block;
		  width: 15px;
		  height: 15px;
		  border-radius: 20px;
		  background: #daa;
		  transition: 0.2s;
		}
		/* checking style */
		.switch:checked+.switch_label {
		  background: #c44;
		  border: 2px solid #c44;
		}
		
		.switch:checked+.switch_label:hover {
		  background: #e55;
		}
		
		/* move */
		.switch:checked+.switch_label .onf_btn {
		  left: 34px;
		  background: #fff;
		  box-shadow: 1px 2px 3px #00000020;
		}
	</style>
	<script>
		'use strict';

		function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/admin/magazine/subscribeList?pag=${pageVO.pag}&pageSize="+pageSize+"&sort=${sort}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}";
    }
		
		// 상품 검색(날짜 기간으로도 가능)
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let startDate = $("#startDate").val();
			let endDate = $("#endDate").val();
			let sort = $("#sort").val();
	    	
    	if((startDate.trim() != "" && endDate.trim() == "") || (startDate.trim() == "" && endDate.trim() != "") || (startDate.trim() > endDate.trim())) {
    		alert("시작날짜와 종료날짜를 알맞게 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	// 오늘 날짜
    	let today = new Date();

    	let year = today.getFullYear();
    	let month = ('0' + (today.getMonth() + 1)).slice(-2);
    	let day = ('0' + today.getDate()).slice(-2);
    	let todayString = year + '-' + month  + '-' + day;
    	
    	if(endDate.trim() > todayString) {
    		alert("검색일자는 오늘보다 빠를 수 없습니다.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm.search.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/magazine/subscribeList?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
		}
		
		// 주문 상세 정보
		function orderInfo(idx, memNickname) {
			let url ='${ctp}/admin/order/orderInfo?idx='+idx+'&memNickname='+memNickname;
			
			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 매거진 정기 구독, 주문 상세 정보
		function subOrderInfo(idx, memNickname) {
			let url ='${ctp}/admin/order/subOrderInfo?idx='+idx+'&memNickname='+memNickname;
			
			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		$(document).ready(function(){
		  $('[data-toggle="popover"]').popover();   
		});
		
		// 회원정보 상세창
		function memInfo(nickname) {
			let url = "${ctp}/admin/member/memInfo?nickname="+nickname;

			let popupWidth = 1000;
			let popupHeight = 800;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'memInfo', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 구독취소 승인 상세창
		function subCancelOpen(idx, nickname) {
			let url = "${ctp}/admin/magazine/subscribeCancel?idx="+idx+"&memNickname="+nickname;

			let popupWidth = 1000;
			let popupHeight = 800;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'subscribeCancel', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 매거진 정기구독 문의창으로 이동
		function move() {
			if(confirm('매거진 정기구독 문의창으로 이동하시겠습니까?')) {
				location.href = '${ctp}/admin/manage/askList?sort=정기구독';
			}
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/admin/magazine/subscribeList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">매거진 정기구독 관리</span></div>
				<div class="row">
					<div class="col-2"></div>
					<div class="col-8">
					  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
						 	<br/>
					 		-  &nbsp;매달 15일 일괄 발송되며, 구독권 기간에 따라 6/12개월 동안 지속됩니다.<br/>
							-  &nbsp;<u>구독취소 신청 승인 후, 환불금과 환불 포인트가 지급됩니다.</u><br/>
							-  &nbsp;구독종료 후, 결제액의 5% 가 포인트가 적립됩니다.  (구독취소 시, 결제액과 환불금 차액의 5% 적립.)<hr/>
							①마이페이지에서 구독 취소 신청이 가능 ②문의로 교환 가능, 반품 불가능 ③구독 종료 후, 회원 이메일로 구독 유도 메일 발송<br/><br/>
					  </span>
					</div>
					<div class="col-2"></div>
			  </div>
	 		</div>
			<div class="row">
				<div class="col-7 text-left">
					<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
		        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
		        <option <c:if test="${sort == '구독중'}">selected</c:if> value="구독중">구독중</option>
		        <option <c:if test="${sort == '구독취소신청'}">selected</c:if> value="구독취소신청">구독취소신청</option>
		        <option <c:if test="${sort == '구독취소'}">selected</c:if> value="구독취소">구독취소</option>
		        <option <c:if test="${sort == '구독종료'}">selected</c:if> value="구독종료">구독종료</option>
		      </select>
					<a class="btn btn-secondary mr-3 mb-4" href="javascript:move()">정기구독 문의</a>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
						<div class="row mb-3">
							<div class="col">
								<div class="row">
									<div class="col"></div>
					        <div class="col">
						    		<input type="date" class="mr-2 form-control" name="startDate" id="startDate" value="${startDate}"/>
					        </div>
					        <div class="col">
						    		<input type="date" class="mr-2 form-control" name="endDate" id="endDate" value="${endDate}"/>
					        </div>
								</div>
							</div>
						</div>
			    	<div class="input-group">
			    		<input type="hidden" name="search" id="search" value="memNickname"/>
				      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="회원 별명으로 검색"/>
				      <div class="input-group-append">
				     		<a href="#" class="btn btn-success my-2 my-sm-0" onclick="javascript:searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#282828;"></i></a>
				     	</div>
			     	</div>
			    </form>
				</div>
			</div>
			
		  <table class="table table-borderless mb-0 p-0">
		    <tr>
		      <td>
		        <select name="pageSize" id="pageSize" onchange="pageCheck()">
		          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
		          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
		          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
		          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
		          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
		        </select> 건
		      </td>
		      <td class="text-right">
		        <!-- 첫페이지 / 이전페이지 / (현재페이지번호/총페이지수) / 다음페이지 / 마지막페이지 -->
		        <c:if test="${pageVO.pag > 1}">
		          <a href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
		  	<table class="table text-center">
					<thead class="thead-dark">
						<tr>
							<th>No.</th>
							<th>회원 별명</th>
							<th>구독 종류</th>
							<th>구독 기간</th>
							<th>발송 잔여 횟수</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty vos}">
			    		<tr><td colspan="6" class="text-center" style="padding:30px;"><b>정보가 없습니다.</b></td></tr> 
			    	</c:if>
				    <c:if test="${!empty vos}">
				    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<tr>
									<td>${curScrStartNo}</td>
									<td>${vo.memNickname}&nbsp;
										<button id="memInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="memInfo('${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:15px; color:grey"></i></button>
									</td>
									<td><a href="${ctp}/magazine/maProduct?idx=${vo.maIdx}">${vo.prodName}</a></td>
									<td>${fn:substring(vo.subStartDate,0,10)} ~ ${fn:substring(vo.subExpireDate,0,10)}</td>
									<td>
										${vo.subSendNum}&nbsp;회
										<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:18px"></i></button>
									</td>
									<td>
										<c:if test="${fn:contains(vo.subStatus, '취소')}">
											<span style="color:red">${vo.subStatus}</span>
											<c:if test="${vo.subStatus == '구독취소신청'}">
												<button type="button" class="btn btn-outline-dark btn-sm ml-2" onclick="subCancelOpen('${vo.orderIdx}', '${vo.memNickname}')">승인</button>
											</c:if>
										</c:if>
										<c:if test="${!fn:contains(vo.subStatus, '취소')}">
											${vo.subStatus}
										</c:if>
									</td>
								</tr>
								<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
							</c:forEach>
						</c:if>
						<tr><td colspan="6"></td></tr>
					</tbody>
				</table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/subscribeList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>
	
</body>
</html>