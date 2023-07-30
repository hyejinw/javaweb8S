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
    	max-height: 200px;
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
    
    .pill-nav a {
		  display: inline-block;
		  color: black;
		  text-align: center;
		  padding: 8px 20px;
		  text-decoration: none;
		  font-size: 17px;
		  border-radius: 5px;
		}
		.pill-nav a:hover {
		  background-color: #ddd;
		  color: black;
		}
		.pill-nav a.active {
		  background-color: #F5EBE0;
		  color: #282828;
		}
		.nowPart {
     color : #282828;
     font-weight: bold;
     border-bottom: 5px solid #282828;
     padding-bottom:14px;
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
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<div class="row">
				<div class="col-3 text-left">
					<a class="btn btn-dark mb-4" href="${ctp}/member/myPage" style="margin-left:20px;">
						<i class="fa-solid fa-chevron-left"></i>
					</a>
 				</div>
 				<div class="col-6 text-center">
					<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">포인트</h2>
 				</div>
 				<div class="col-3 text-right">
 				</div>
			</div>
			
 			<div style="margin:30px 0px 50x 0px" class="text-right">
				<a href="${ctp}/member/myPage/point"><span class="nowPart mr-5">적립 포인트 내역</span></a>
				<a href="${ctp}/member/myPage/pointUse"><span class="mr-5">사용 포인트 내역</span></a>
				<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
			</div>
 			
 			<div style="margin-top:10px">
				<div class="infoBox">
					<div class="row">
						<div class="col ml-5">
							<i class="fa-solid fa-angle-right"></i>&nbsp;&nbsp;가용 포인트
						</div>
						<div class="col text-right mr-5">
							<c:if test="${(empty memberVO.point) || memberVO.point == ''}">
								0&nbsp;원&nbsp;&nbsp;
							</c:if>
							<c:if test="${!empty memberVO.point}">
								<fmt:formatNumber value="${memberVO.point}" pattern="#,###"/>&nbsp;원&nbsp;&nbsp;
							</c:if>
						</div>
						<div class="col ml-5">
							<i class="fa-solid fa-angle-right"></i>&nbsp;&nbsp;총 적립 포인트
						</div>
						<div class="col text-right mr-5">
							<c:if test="${empty totalPoint}">
								0&nbsp;원&nbsp;&nbsp;
							</c:if>
							<c:if test="${!empty totalPoint}">
								<fmt:formatNumber value="${totalPoint}" pattern="#,###"/>원&nbsp;&nbsp;
							</c:if>
						</div>
					</div>
					<hr/>
					<div class="row">
						<div class="col ml-5">
							<i class="fa-solid fa-angle-right"></i>&nbsp;&nbsp;사용 포인트
						</div>
						<div class="col text-right mr-5">
							<c:if test="${empty totalUsedPoint}">
								0&nbsp;원&nbsp;&nbsp;
							</c:if>
							<c:if test="${!empty totalUsedPoint}">
								<fmt:formatNumber value="${totalUsedPoint}" pattern="#,###"/>&nbsp;원&nbsp;&nbsp;
							</c:if>
						</div>
						<div class="col ml-5">
						</div>
						<div class="col text-right mr-5">
						</div>
					</div>
				</div>
			</div>
			
			<div class="row" style="margin-top:60px">
				<div class="col">
					<div class="infoBox2">
						<div style="background-color:#eee; padding:15px">
							<span style=" font-size:18px; font-weight:bold;">포인트 안내&nbsp;&nbsp;&nbsp;</span>
						</div>
						<div style="padding:20px">
							-&nbsp;&nbsp;상품 구매확정 시, 결제액의 5% 가 포인트로 적립됩니다.<br/>
							-&nbsp;&nbsp;부분 반품의 경우에 나머지 상품은 <u>자동으로 구매확정 포인트가 지급</u>됩니다.<br/>
							-&nbsp;&nbsp;1) <u>단순변심</u> 반품의 경우, 배송비가 사용 포인트에서 선차감됩니다.&nbsp;&nbsp;2) <u>정기구독</u> 의 경우, 구독종료 / 구독취소승인 후 포인트가 지급됩니다.
							<br/>이런 이유로, 총 적립금과 적립/사용 적립금의 합이 상이할 수 있습니다.<br/><br/>
							-&nbsp;&nbsp;반품완료 후, 반환된 포인트는 내역을 통해 확인하실 수 있습니다.<br/>
							-&nbsp;&nbsp;포인트 적립 및 사용에 대한 궁금증은&nbsp;&nbsp;<a href="${ctp}/member/myPage/ask"><b><u>문의</u></b></a>를 통해 남겨주세요.<br/>
							-&nbsp;&nbsp;<u>분류를 통해 주요 포인트 적립 내역을 확인해보세요.</u>
						</div>
					</div>
				</div>
			</div>
			
	    <div class="row" style="margin:50px 0px 30px 0px">
				<div class="col-2 text-left">
				</div>
				<div class="col-10 text-right">
					<div class="pill-nav" style="margin-left:100px">
					  <a class="<c:if test="${sort=='전체'}">active</c:if> mr-2" href="${ctp}/member/myPage/point?sort=전체">전체</a>
					  <a class="<c:if test="${sort=='상품구매확정'}">active</c:if> mr-2" href="${ctp}/member/myPage/point?sort=상품구매확정">상품구매확정</a>
					  <a class="<c:if test="${sort=='반품 포인트반환'}">active</c:if> mr-2" href="${ctp}/member/myPage/point?sort=반품 포인트반환">반품 포인트반환</a>
					  <a class="<c:if test="${sort=='게임'}">active</c:if> mr-2" href="${ctp}/member/myPage/point?sort=게임">게임</a>
					</div>
				</div>
			</div>
			
			<div class="table-responsive">
				<table class="table text-center">
			    <thead>
			      <tr>
			        <th>No.</th>
			        <th>적립 포인트</th>
			        <th>적립 사유</th>
			        <th>적립일</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${empty vos}">
			    		<tr><td colspan="4" class="text-center" style="padding:30px;">포인트 내역이 없습니다.</td></tr> 
			    	</c:if>
			    	<c:if test="${!empty vos}">
				    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
		 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
					      <tr>
					      	<td>${curScrStartNo}</td>
					      	<td>${vo.point}</td>
					      	<td>
					      		${vo.pointReason}
					      		<c:if test="${vo.pointReason == '상품구매확정'}">
					      			<c:if test="${vo.type != '정기 구독'}">
							        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#41644A"></i></button>
											</c:if>
											<c:if test="${vo.type == '정기 구독'}">
							        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#41644A"></i></button>
											</c:if>
					      		</c:if>
					      		<c:if test="${vo.pointReason == '반품 포인트반환'}">
					      			<c:if test="${vo.type != '정기 구독'}">
							        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
											</c:if>
											<c:if test="${vo.type == '정기 구독'}">
							        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
											</c:if>
					      		</c:if>
					      		<c:if test="${vo.pointReason == '정기구독취소 포인트반환'}">
					      			<c:if test="${vo.type != '정기 구독'}">
							        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
											</c:if>
											<c:if test="${vo.type == '정기 구독'}">
							        	<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${vo.orderIdx}','${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
											</c:if>
					      		</c:if>
				      		</td>
					      	<td>${fn:substring(vo.pointStartDate,0,10)}</td>
					      </tr>
					      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				    	</c:forEach>
			    	</c:if>
			    	
			    	<tr><td colspan="4"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/point?pageSize=${pageVO.pageSize}&pag=1&sort=${sort}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/point?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&sort=${sort}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/member/myPage/point?pageSize=${pageVO.pageSize}&pag=${i}&sort=${sort}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/point?pageSize=${pageVO.pageSize}&pag=${i}&sort=${sort}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/point?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&sort=${sort}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/point?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&sort=${sort}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>