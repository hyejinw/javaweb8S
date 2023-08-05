<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">마이페이지</h2>
		
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
							<button class="btn btn-outline-dark btn-sm" onclick="location.href='${ctp}/member/myPage/point';">조회</button>
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
							<button class="btn btn-outline-dark btn-sm" onclick="location.href='${ctp}/member/myPage/point';">조회</button>
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
							<i class="fa-solid fa-angle-right"></i>&nbsp;&nbsp;총 주문
						</div>
						<div class="col text-right mr-5">
							<c:if test="${empty orderVO.totalPaidPrice}">
								0&nbsp;원&nbsp;&nbsp;
								(0&nbsp;회)
							</c:if>
							<c:if test="${!empty orderVO.totalPaidPrice}">
								<fmt:formatNumber value="${orderVO.totalPaidPrice}" pattern="#,###"/>&nbsp;원&nbsp;&nbsp;
								(${orderVO.orderNum}&nbsp;회)
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:60px">
				<div class="col">
					<div class="infoBox2">
						<div style="background-color:#eee; padding:15px">
							<span style=" font-size:20px; font-weight:bold;">나의 주문처리 현황&nbsp;&nbsp;&nbsp;</span><span>(최근 <b>3개월</b> 기준)</span>
						</div>
						<div style="padding:20px">
							<div class="row text-center">
								<div class="col">
									<a href="${ctp}/member/myPage/order?sort=결제완료">
										<span style="font-size:15px; font-weight:bold">결제완료</span><br/>
										<span style="font-size:25px; font-weight:bold; color:grey">
											<c:if test="${!empty orderLevel1Num}">${orderLevel1Num}</c:if>
											<c:if test="${empty orderLevel1Num}">0</c:if>
										</span>
									</a>
								</div>
								<div class="col">
									<a href="${ctp}/member/myPage/order?sort=배송준비중">
										<span style="font-size:15px; font-weight:bold">배송 준비 중</span><br/>
										<span style="font-size:25px; font-weight:bold; color:grey">
											<c:if test="${!empty orderLevel2Num}">${orderLevel2Num}</c:if>
											<c:if test="${empty orderLevel2Num}">0</c:if>
										</span>
									</a>
								</div>
								<div class="col">
									<a href="${ctp}/member/myPage/order?sort=배송중">
										<span style="font-size:15px; font-weight:bold">배송 중</span><br/>
										<span style="font-size:25px; font-weight:bold; color:grey">
											<c:if test="${!empty orderLevel3Num}">${orderLevel3Num}</c:if>
											<c:if test="${empty orderLevel3Num}">0</c:if>
										</span>
									</a>
								</div>
								<div class="col">
									<a href="${ctp}/member/myPage/order?sort=배송완료">
										<span style="font-size:15px; font-weight:bold">배송 완료</span><br/>
										<span style="font-size:25px; font-weight:bold; color:grey">
											<c:if test="${!empty orderLevel4Num}">${orderLevel4Num}</c:if>
											<c:if test="${empty orderLevel4Num}">0</c:if>
										</span>
									</a>
								</div>
								<div class="col">
									<a href="${ctp}/member/myPage/order?sort=반품완료">
										<span style="font-size:15px; font-weight:bold">반품 완료</span><br/>
										<span style="font-size:25px; font-weight:bold; color:grey">
											<c:if test="${!empty orderLevel5Num}">${orderLevel5Num}</c:if>
											<c:if test="${empty orderLevel5Num}">0</c:if>
										</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<!-- 회원관련 상세내용 6개 -->
			<div class="row text-center" style="margin-top:60px">
				<div class="col">
					<a href="${ctp}/member/myPage/order">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>ORDER</b></h6>
									<h5 style="color:#282828"><b>주문내역 조회</b></h5>
								</p>
								<span style="color:grey">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</span><br/><br/>
							</div>
						</div>
					</a>
				</div>
				<div class="col">
					<a href="${ctp}/member/myPage/profile">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>PROFILE</b></h6>
									<h5 style="color:#282828"><b>회원 정보</b></h5>
								</p>
								<span style="color:grey">회원이신 고객님의 개인정보를 관리하는 공간입니다. 개인정보를 최신 정보로 유지하시면 보다 간편히 책(의)세계를 즐기실 수 있습니다.</span>
							</div>
						</div>
					</a>
				</div>
				<div class="col">
					<a href="${ctp}/member/myPage/wishlist">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>WISHLIST</b></h6>
									<h5 style="color:#282828"><b>관심 상품</b></h5>
								</p>
								<span style="color:grey">관심상품으로 등록하신 상품의 목록을 보여드립니다.</span><br/><br/>
							</div>
						</div>
					</a>
				</div>
			</div>
			<div class="row text-center">
				<div class="col">
					<a href="${ctp}/member/myPage/point">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>POINT</b></h6>
									<h5 style="color:#282828"><b>포인트</b></h5>
								</p>
								<span style="color:grey">포인트는 상품 구매 시 사용하실 수 있습니다. 적립된 금액은 현금으로 환불되지 않습니다.</span>
							</div>
						</div>
					</a>
				</div>
				<div class="col">
					<a href="${ctp}/member/myPage/ask">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>ASK</b></h6>
									<h5 style="color:#282828"><b>문의</b></h5>
								</p>
								<span style="color:grey">고객님의 궁금하신 문의사항에 대해 1:1 맞춤상담 내용을 확인하실 수 있습니다.</span>
							</div>
						</div>
					</a>
				</div>
				<div class="col">
					<a href="${ctp}/member/myPage/address">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>ADDRESS</b></h6>
									<h5 style="color:#282828"><b>배송 주소록 관리</b></h5>
								</p>
								<span style="color:grey">자주 사용하는 배송지를 등록하고 관리하실 수 있습니다.</span>
							</div>
						</div>
					</a>
				</div>
			</div>
			<div class="row text-center">
				<div class="col">
					<a href="${ctp}/member/myPage/subscribe">
						<div class="w3-panel w3-hover-shadow w3-card">
							<div style="padding:20px">
								<p>
									<h6 style="color:grey"><b>SUBSCRIBE</b></h6>
									<h5 style="color:#282828"><b>구독 관리</b></h5>
								</p>
								<span style="color:grey">책(의)편지 뉴스레터, 책Chaeg 매거진 정기구독 관리창입니다.</span>
							</div>
						</div>
					</a>
				</div>
				<div class="col">
				</div>
				<div class="col">
				</div>
			</div>
			
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>