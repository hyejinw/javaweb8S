<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
		#back-to-top {
		  display: inline-block;
		  background-color: #282828;
		  width: 50px;
		  height: 50px;
		  text-align: center;
		  border-radius: 4px;
		  position: fixed;
		  bottom: 30px;
		  right: 30px;
		  transition: background-color .3s, opacity .5s, visibility .5s;
		  opacity: 0;
		  visibility: hidden;
		  z-index: 1000;
		}
		#back-to-top::after {
		  content: "\f077";
		  font-family: FontAwesome;
		  font-weight: normal;
		  font-style: normal;
		  font-size: 2em;
		  line-height: 50px;
		  color: #fff;
		}
		#back-to-top:hover {
		  cursor: pointer;
		  text-decoration: none;
		  background-color: #333;
		}
		#back-to-top:active {
		  background-color: #555;
		}
		#back-to-top.show {
		  opacity: 1;
		  visibility: visible;
		}
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
    }
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
	</style>
	<script>
		'use strict';
		// 맨 위로 스크롤
		$(function(){
		  $('#back-to-top').on('click',function(e){
		      e.preventDefault();
		      $('html,body').animate({scrollTop:0},600);
		  });
		  
		  $(window).scroll(function() {
		    if ($(document).scrollTop() > 100) {
		      $('#back-to-top').addClass('show');
		    } else {
		      $('#back-to-top').removeClass('show');
		    }
		  });
		});
		
		function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/member/myPage/order?pag=${pageVO.pag}&pageSize="+pageSize+"&sort=${sort}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}";
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
    	location.href = "${ctp}/member/myPage/order?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
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
    	location.href = "${ctp}/member/myPage/order?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
		}
		
		// 주문 상세 정보
		function orderInfo(idx, memNickname) {
			let url ='${ctp}/member/myPage/orderInfo?idx='+idx;
			
			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 매거진 정기 구독, 주문 상세 정보
		function subOrderInfo(idx, memNickname) {
			let url ='${ctp}/member/myPage/subOrderInfo?idx='+idx;
			
			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 구매확정
		function orderComplete(idx) {
			let ans = confirm('구매확정 시, 반품이 불가합니다. 확정하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/myPage/orderComplete",
				data : { 
					memNickname : '${sNickname}',
					idx : idx 
				},
				success : function() {
					alert('구매확정 포인트가 지급되었습니다. 감사합니다:)');
					location.reload();
				},
				error : function() {
					alert('재시도 부탁드립니다. 오류가 계속될 경우, 문의를 남겨주세요.');
				}
			});
		}
		
		// 반품 모달창에 값 전달
		function refundOpen(idx) {
			document.getElementById('orderIdx').value = idx;
			document.getElementById('refundNum').value = document.getElementById('tempRefundNum' + idx).value;
			document.getElementById('maxRefundNum').value = document.getElementById('tempRefundNum' + idx).value;
			
			document.getElementById('refundPrice').value = numberWithCommas(document.getElementById('tempRefundPrice' + idx).value) + "  원";
			document.getElementById('finalRefundPrice').value = document.getElementById('tempRefundPrice' + idx).value;
			document.getElementById('originReturnPrice').value = document.getElementById('tempRefundPrice' + idx).value;
			
			document.getElementById('refundPoint').value = document.getElementById('tempRefundPoint' + idx).value;
			document.getElementById('originReturnPoint').value = document.getElementById('tempRefundPoint' + idx).value;
			document.getElementById('individualPrice').value = document.getElementById('individualPrice' + idx).value;
			document.getElementById('maIdx').value = document.getElementById('maIdx' + idx).value;
			document.getElementById('opIdx').value = document.getElementById('opIdx' + idx).value;
		}
		
		// 반품 개수 변경
		function refundNumChange() {
			let refundNum = document.getElementById('refundNum').value;
			let maxRefundNum = document.getElementById('maxRefundNum').value;
			
			let individualPrice = document.getElementById('individualPrice').value;
			let refundPrice = document.getElementById('refundPrice').value;
			let finalRefundPrice = document.getElementById('finalRefundPrice').value;
			let refundPoint = document.getElementById('refundPoint').value;
			
			if(refundNum >= maxRefundNum) {
				alert('반품 가능한 최대 개수는 '+maxRefundNum+'개 입니다.');
				document.getElementById('refundNum').value = maxRefundNum;
				refundNum = maxRefundNum;
			}

			document.getElementById('finalRefundPrice').value = individualPrice * refundNum - refundPoint;
			document.getElementById('refundPrice').value = numberWithCommas(individualPrice * refundNum - refundPoint) + "  원";
			deliveryPriceChange();
		}
		
		// 반품 배송비 변경
		function refundReasonCheck() {
			let refundReason = $('#refundReason').val();
			
			if(refundReason != "상품하자") {
				document.getElementById('deliveryPrice').value = numberWithCommas(3000) + "  원";
				document.getElementById('finalDeliveryPrice').value = 3000;
			}
			else {
				document.getElementById('deliveryPrice').value = "0  원";
				document.getElementById('finalDeliveryPrice').value = 0;
			}
			// 초기값으로 전부 변경
			let originReturnPrice = document.getElementById('originReturnPrice').value;
			let originReturnPoint = document.getElementById('originReturnPoint').value;
			let maxRefundNum = document.getElementById('maxRefundNum').value;
			
			document.getElementById('refundPrice').value = numberWithCommas(originReturnPrice) + "  원";
			document.getElementById('finalRefundPrice').value = originReturnPrice;
			document.getElementById('refundPoint').value = originReturnPoint;
			document.getElementById('refundNum').value = maxRefundNum;
			
			deliveryPriceChange();
		}
		
		// 배송비 변경 시 처리
		function deliveryPriceChange() {
			let finalDeliveryPrice = document.getElementById('finalDeliveryPrice').value;
			
			let refundPoint = document.getElementById('refundPoint').value;
			let refundPrice = document.getElementById('refundPrice').value;
			let finalRefundPrice = document.getElementById('finalRefundPrice').value;
			
			// 반환 포인트에서 배송비를 먼저 빼기
			let tempPoint = refundPoint - finalDeliveryPrice;
			if(tempPoint >= 0) document.getElementById('refundPoint').value = tempPoint;
			
			// 배송비가 더 크다면 환불금액에서 빼기
			else {
				document.getElementById('refundPoint').value = 0;
				document.getElementById('finalRefundPrice').value = parseInt(finalRefundPrice) +  parseInt(tempPoint);
				
				document.getElementById('refundPrice').value = numberWithCommas(parseInt(finalRefundPrice) +  parseInt(tempPoint)) + "  원";
			}
		}
		
		// 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('photoDemo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('photoDemo').src = "";
			}
		}
		
		// 반품 신청
		function refundInsert() {
 			let refundReason = $('#refundReason').val();
			let refundDetail = $('#refundDetail').val();
			
			if(refundReason == "기타") {
				if(refundDetail == "") {
					alert('\'기타\'선택 시, 반품사유는 필수로 작성해주셔야 합니다.');
					refundForm.refundDetail.focus();
					return false;
				}
			}
			
			let refundPhoto = document.getElementById('refundPhoto').value; 
			let ext = refundPhoto.substring(refundPhoto.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			
			if(refundPhoto != "") {
				let fileSize = refundForm.file.files[0].size;
				if(ext != "JPG" && ext != "PNG") {
					alert("업로드 가능한 사진 파일은 'jpg 또는 png' 입니다.");
					return false;
				}
				if(fileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
			} 
			let ans = confirm('반품 신청하시겠습니까?');
			if(!ans) return false;
			
			refundForm.submit();
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">주문 조회</h2>
			
			<div style="margin-top:10px">
				<div class="infoBox">
					<div class="row">
						<div class="col-9">
							-  &nbsp;기본적으로 전체 내역이 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.<br/>
							-  &nbsp;상세버튼을 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.<br/>
							-  &nbsp;반품 신청은 배송완료 후, &nbsp;<b>7일 이내</b> 가능합니다.    (정기구독의 경우, 문의로 구독 취소 신청이 가능합니다.)<br/><br/>
						</div>
						<div class="col-3 text-right pr-4">
							<a class="btn btn-dark btn-sm mb-4" href="${ctp}/member/myPage/order" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
						</div>
					</div>
					-  &nbsp;배송완료 후, 구매자 직접 구매확정 하실 수 있으며, 그렇지 않을 경우 배송완료 7일 이후 자동 구매확정 됩니다.<br/>
					-  &nbsp;구매확정 후, 결제액의 5%가 포인트로 지급됩니다.
					<div class="text-right mr-3">
						<span style="font-size:15px; font-weight:300;">
						 	<span class="badge badge-pill badge-success">M</span> (매거진) &nbsp;&nbsp;&nbsp;&nbsp;
						 	<span class="badge badge-pill badge-warning">S</span> (정기 구독)
					  </span>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:50px">
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
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'prodName'}">selected</c:if> value="prodName">상품명</option>
				          <option <c:if test="${search == 'orderCode'}">selected</c:if> value="orderCode">주문 코드</option>
				          <option <c:if test="${search == 'invoice'}">selected</c:if> value="invoice">송장번호</option>
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
		          <a href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="다음페이지로">▶</a>
		          <a href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead>
			      <tr>
			        <th>(No.)&nbsp;&nbsp;주문 코드</th>
			        <th>상품명</th>
			        <th>수량</th>
			        <th>결제 가격</th>
			        <th>사용 포인트</th>
			        <th>주문 상태</th>
			        <th>주문 일자</th>
			        <th>상세</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${empty vos}">
			    		<tr><td colspan="8" class="text-center" style="padding:30px;">주문 내역이 존재하지 않습니다.</td></tr> 
			    	</c:if>
			    	
			    	<c:if test="${!empty vos}">
				    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
		 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
					      <tr>
					        <td>(${curScrStartNo})&nbsp;&nbsp;${vo.orderCode}</td>
					        <td>
					        	<c:if test="${vo.type == '컬렉션 상품'}">
					        		<a href="${ctp}/collection/colProduct?idx=${vo.prodIdx}">
						        		${vo.prodName}<br/>[옵션]  ${vo.opName}
						        	</a>
					        	</c:if>
					        	<c:if test="${vo.type != '컬렉션 상품'}">
					        		<a href="${ctp}/magazine/maProduct?idx=${vo.maIdx}">
						        		${vo.prodName}
						        	</a>
						        	<c:if test="${vo.type == '매거진'}"><span class="badge badge-pill badge-success">M</span></c:if>
						        	<c:if test="${vo.type == '정기 구독'}"><span class="badge badge-pill badge-warning">S</span></c:if>
					        	</c:if>
				        	</td>
					        <td>${vo.num}  개</td>
					        <td><fmt:formatNumber value="${vo.paidPrice}" pattern="#,###"/> 원</td>
					        <td>${vo.usedPoint}</td>
					        <td>
					        	<c:if test="${!fn:contains(vo.orderStatus,'반품')}">
						        	${vo.orderStatus}
						        	<c:if test="${vo.orderStatus == '배송완료'}">
						        		<br/><button class="btn btn-sm btn-outline-primary mt-2" onclick="orderComplete('${vo.idx}')">구매확정</button>
						        		&nbsp;&nbsp;<button type="button" class="btn btn-sm btn-outline-dark mt-2" onclick="refundOpen(${vo.idx})" data-toggle="modal" data-target="#refundModal">반품 신청</button>
						        		<input type="hidden" id="orderIdx${vo.idx}" value="${vo.idx}"/>
						        		<input type="hidden" id="tempRefundNum${vo.idx}" value="${vo.num}"/>
						        		<input type="hidden" id="tempRefundPrice${vo.idx}" value="${vo.paidPrice}"/>
						        		<input type="hidden" id="tempRefundPoint${vo.idx}" value="${vo.usedPoint}"/>
						        		<input type="hidden" id="individualPrice${vo.idx}" value="${vo.totalPrice / vo.num}"/>
						        		<input type="hidden" id="maIdx${vo.idx}" value="${vo.maIdx}"/>
						        		<input type="hidden" id="opIdx${vo.idx}" value="${vo.opIdx}"/>
						        	</c:if>
					        	</c:if>
					        	<c:if test="${fn:contains(vo.orderStatus,'반품')}">
					        		<span style="color:blue"><b>${vo.orderStatus}&nbsp;&nbsp;(${vo.refundNum}개)</b></span>
					        	</c:if>
					        </td>
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
			    	</c:if>
			    	
			    	<tr><td colspan="8"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/order?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}&startDate=${startDate}&endDate=${endDate}&sort=${sort}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
	
	
	<!-- The Modal -->
  <div class="modal fade" id="refundModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">반품 신청</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
        	<form name="refundForm" method="post" action="${ctp}/member/myPage/refundInsert" enctype="multipart/form-data">
	          <div class="w3-container w3-border" style="background-color:#eee;">
	          	<div class="row mt-2">
	          		<div class="col-8">
			          	<select name="refundReason" id="refundReason" class="form-control" onchange="refundReasonCheck()">
			          		<option selected>상품하자</option>
			          		<option>단순변심</option>
			          		<option>기타</option>
			          	</select>
					  			<textarea rows="4" cols="10" id="refundDetail" name="refundDetail" class="form-control mt-3" placeholder="반품 사유를 상세히 입력해주세요."></textarea>
 				  				<input type="hidden" name="memNickname" value="${sNickname}"/>
				  				<input type="hidden" name="orderIdx" id="orderIdx" value="0" />
				  				<input type="hidden" name="deliveryPrice" id="finalDeliveryPrice" value="0" />
				  				<input type="hidden" name="refundPrice" id="finalRefundPrice" value="0" />
				  				<input type="hidden" name="originOrderNum" id="maxRefundNum" value="0" />
				  				<input type="hidden" id="individualPrice" value="0" />
				  				<input type="hidden" name="originPaidPrice" id="originReturnPrice" value="0" />
				  				<input type="hidden" id="originReturnPoint" value="0" />
				  				<input type="hidden" name="maIdx" id="maIdx"/>
				  				<input type="hidden" name="opIdx" id="opIdx"/>
				  				<input type="file" name="file" id="refundPhoto" onchange="imgCheck(this)" class="form-control-file border form-control mt-3"/>
	          		</div>
	          		<div class="col-4">
					  			<img id="photoDemo" width="200px"/>
				  			</div>
	          	</div>
			  			
			  			<div class="row ml-4 mr-3 mt-2 mb-4">
			  				<div class="col">
					  			<div>
					  				<br/>
					  				<div style="color:red"><i class="fa-solid fa-triangle-exclamation" style="font-size:17px; margin-bottom:15px"></i>&nbsp;&nbsp;반품 철회는 불가능합니다.  배송비는 상품 하자일 경우만 무료입니다.</div>
					  				<p><i class="fa-solid fa-triangle-exclamation" style="font-size:17px; margin-bottom:15px"></i>&nbsp;&nbsp;일부 반품의 경우에 나머지 상품은 자동으로 구매확정됩니다.</p>
					  				<span>신청자 : <b>${sNickname}</b></span><br/>
					  				<span>배송비 : <b><input type="text" id="deliveryPrice" value='0  원' style="background-color:transparent; border:0px" readonly/></b></span>
					  				<span>환불 상품 개수 : <b><input type="number" name="refundNum" id="refundNum" min="1" style="width:50px" onchange="refundNumChange()"/></b></span><br/>
					  				<span>환불 예정액 : <b><input type="text" id="refundPrice" style="background-color:transparent; border:0px" readonly/></b></span>
					  				<span>반환 포인트 : <b><input type="number" name="refundPoint" id="refundPoint" style="background-color:transparent; border:0px" readonly/></b></span>
					  			</div>
			  				</div>
			  			</div>
					  </div>
        	</form>
				  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="refundInsert()">신청</button>
        </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>