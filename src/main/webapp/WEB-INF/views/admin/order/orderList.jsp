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
    	location.href = "${ctp}/admin/order/orderList?pag=${pageVO.pag}&pageSize="+pageSize;
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
    	if(search.trim() != "" && searchString.trim() == "" && startDate.trim() == "" && endDate.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/order/orderListSearch?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
		}
		
		// 분류 검색
		function sortCheck() {
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
    	location.href = "${ctp}/admin/order/orderListSearch?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
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
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/admin/order/orderList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
					  <a class="btn btn-warning" href="${ctp}/admin/collection/colProdInsert" style="margin-right:20px;">상품 등록</a>
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">통합 주문 관리</span></div>
			  <div class="row">
			  	<div class="col-3">
					  <span style="font-size:15px; text-align:center; font-weight:300;">
						 	<br/><span class="badge badge-pill badge-success">M</span> (매거진) &nbsp;&nbsp;&nbsp;&nbsp;
						 	<span class="badge badge-pill badge-warning">S</span> (정기 구독)
					  </span>
			  	</div>
			  	<div class="col-6 text-center">
			  		<br/>
					  <a href="#" title="배송처리 과정" data-toggle="popover" data-content="결제완료 > 배송준비중(24시간 후) > 배송중(12시간 후) >
						 	 배송완료(120시간 후/5일 후)    로 자동 처리">배송처리 과정</a>
						<hr style="margin:8px"/>
					  <a href="#" title="반품처리 과정" data-toggle="popover" data-content="[배송완료 후, 7일 이내 반품 신청 가능]
					      반품신청 > 반품처리중(24시간 후) > 반품완료(120시간 후/5일 후)    로 자동 처리">반품처리 과정</a>
					  
						<hr style="margin:8px"/>
					  <a href="#" title="포인트 처리" data-toggle="popover"
					  data-content="구매확정 후, 결제액의 5% 포인트 지급 (구매자 직접 구매확정 or 배송완료 후, 7일 이후)">포인트 처리</a>
						<hr style="margin:8px"/>
					  <a href="#" title="매거진 정기구독 정보" data-toggle="popover"  
					  data-content="①문의로 구독 취소 신청이 가능 ②교환 가능, 반품 불가능 ③매달 15일 일괄 배송 ④구독권 기간에 따라 6/12개월 간 지속 ⑤구독 종료 후, 회원 이메일로 구독 유도 메일 발송">
					  매거진 정기구독 정보</a>
						<hr style="margin:8px 8px 0px 8px"/> 	 
			  	</div>
			  	<div class="col-3"></div>
			  </div>
	 		</div>
			<div class="row">
				<div class="col-7 text-left">
					<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="sortCheck()">
		        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
		        <option <c:if test="${sort == '결제완료'}">selected</c:if> value="결제완료">결제완료</option>
		        <option <c:if test="${sort == '배송준비중'}">selected</c:if> value="배송준비중">배송준비중</option>
		        <option <c:if test="${sort == '배송중'}">selected</c:if> value="배송중">배송중</option>
		        <option <c:if test="${sort == '배송완료'}">selected</c:if> value="배송완료">배송완료</option>
		        <option <c:if test="${sort == '반품신청'}">selected</c:if> value="반품신청">반품신청</option>
		        <option <c:if test="${sort == '반품처리중'}">selected</c:if> value="반품처리중">반품처리중</option>
		        <option <c:if test="${sort == '반품완료'}">selected</c:if> value="반품완료">반품완료</option>
		      </select>
					<a class="btn btn-secondary mr-3 mb-4" href="${ctp}/">주문 문의</a>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
						<div class="row mb-3">
							<div class="col">
								<div class="row">
									<div class="col"></div>
					        <div class="col">
						    		<input type="date" class="mr-2 form-control" name="startDate" id="startDate"/>
					        </div>
					        <div class="col">
						    		<input type="date" class="mr-2 form-control" name="endDate" id="endDate"/>
					        </div>
								</div>
							</div>
						</div>
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'orderCode'}">selected</c:if> value="orderCode">주문 코드</option>
				          <option <c:if test="${search == 'invoice'}">selected</c:if> value="invoice">송장번호</option>
				          <option <c:if test="${search == 'prodName'}">selected</c:if> value="prodName">상품명</option>
				          <option <c:if test="${search == 'memNickname'}">selected</c:if> value="memNickname">구매자 별명</option>
				        </select>
				    	</div>
				      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
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
		          <a href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead class="thead-dark">
			      <tr>
			        <th>회원 별명</th>
			        <th>주문 코드</th>
			        <th>상품명</th>
			        <th>수량</th>
			        <th>결제 가격</th>
			        <th>사용 포인트</th>
			        <th>주문 상태</th>
			        <th>주문 처리</th>
			        <th>주문 일자</th>
			        <th>상세</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
	 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
				      <tr>
				        <td>${vo.memNickname}</td>
				        <td>${vo.orderCode}</td>
				        <td>
				        	<c:if test="${vo.type == '컬렉션 상품'}">
					        	${vo.prodName}<br/>[옵션]  ${vo.opName}
				        	</c:if>
				        	<c:if test="${vo.type != '컬렉션 상품'}">
					        	${vo.prodName}
					        	<c:if test="${vo.type == '매거진'}"><span class="badge badge-pill badge-success">M</span></c:if>
					        	<c:if test="${vo.type == '정기 구독'}"><span class="badge badge-pill badge-warning">S</span></c:if>
				        	</c:if>
			        	</td>
				        <td>${vo.num}  개</td>
				        <td><fmt:formatNumber value="${vo.paidPrice}" pattern="#,###"/> 원</td>
				        <td>${vo.usedPoint}</td>
				        <td>${vo.orderStatus}</td>
				        <td><button class="btn btn-sm btn-dark">관리</button></td>
				        <td>${fn:substring(vo.orderDate,0,10)}</td>
								<td>
									<c:if test="${vo.type != '정기 구독'}">
					        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${vo.idx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:22px"></i></button>
									</c:if>
									<c:if test="${vo.type == '정기 구독'}">
					        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${vo.idx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:22px"></i></button>
									</c:if>
				        </td>
				      </tr>
				    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			    	</c:forEach>
			    	<tr><td colspan="10"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/order/orderList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>
	
</body>
</html>