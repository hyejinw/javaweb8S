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
/* 		.pill-nav a {
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
		} */
		a:link {text-decoration: none;}
		a:visited {text-decoration: none;}
		a:hover {text-decoration: none;}
		a:active {text-decoration: none;}
		
		.magazineHover:hover { 
	    text-decoration: none;
	  	color: #ffa0c5;
		}
		
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
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
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
		
		// 총 상품 금액 보여주기
		$(function() {
			let res = 0;
			$("input[name=tempTotalPrice]").each(function(index, item){
				res = res + parseInt($(item).val());
		  });
			
			document.getElementById("cartPrice").value = numberWithCommas(res)+ "  원";
		});
		
		// 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
		
		
		// 주소록 리스트
		function addressList() {
			let url = "${ctp}/order/addressList";

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
			<h2 class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">주문서 작성</h2>
		
			<div class="row" style="margin:10px 0px 50px 0px">
				<div class="col">
					<div class="infoBox">
						책의 세계는 모두 무료배송<hr/>
						구매 완료 시, 포인트 5%가 적립됩니다. &nbsp;&nbsp;&nbsp;&nbsp;(<span style="font-weight:bold">보유 포인트</span>&nbsp;&nbsp;<span>${memberVO.point}</span>)
					</div>
				</div>
			</div>
			
			<!-- 구매할 상품 -->
			<c:if test="${(!empty vos)}">
				<div class="table-responsive" style="margin-top:80px">
					<table class="table text-center" style="margin-top:10px">
				    <thead>
				      <tr>
				        <th>번호</th>
				        <th>이미지</th>
				        <th>상품정보</th>
				        <th>판매가</th>
				        <th>수량</th>
				        <th>합계</th>
				      </tr>
				    </thead>
				    <tbody>
		 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
					      <tr>
					        <td>${st.count}</td>
					        
					        <!-- 컬렉션 상품 -->
					        <c:if test="${vo.type == '컬렉션 상품'}">
						        <td>
						        	<a href="${ctp}/collection/colProduct?idx=${vo.prodIdx}">
						        	<img src="${ctp}/collection/${vo.prodThumbnail}" style="width:100%; max-width:100px"/>
					        		</a>
					        	</td>
						        <td>
						        	<a href="${ctp}/collection/colProduct?idx=${vo.prodIdx}">
						        	<span style="font-size:16px; font-weight:bold;">${vo.prodName}</span><br/><hr style="margin:10px;"/>
						        	<span>[옵션]  ${vo.opName}</span>
						        	</a>
						        </td>
						        <td>
						     		  <fmt:formatNumber value="${vo.opPrice}" pattern="#,###"/>원
						     	   	<input type="hidden" id="price${vo.idx}" name="totalPrice" value="${vo.opPrice}"/>
						        </td>
					        </c:if>
					        
					        <!-- 매거진, 매거진 정기구독 -->
					        <c:if test="${vo.type != '컬렉션 상품'}">
						        <td>
						        	<a href="${ctp}/magazine/maProduct?idx=${vo.maIdx}">
						        	<img src="${ctp}/magazine/${vo.prodThumbnail}" style="width:100%; max-width:100px"/>
					        		</a>
					        	</td>
						        <td>
						        	<a href="${ctp}/magazine/maProduct?idx=${vo.maIdx}">
						        	<span style="font-size:16px; font-weight:bold;">${vo.prodName}</span>
						        	</a>
						        </td>
						        <td>
						     		  <fmt:formatNumber value="${vo.prodPrice}" pattern="#,###"/>원
						     	   	<input type="hidden" id="price${vo.idx}" name="totalPrice" value="${vo.prodPrice}"/>
						        </td>
					        </c:if>
					        
					        <!-- 공통 -->
					        <td><input type="text" class="text-center num" name="num" id="num${vo.idx}" value="${vo.num} 개" readonly style="width:50px; border:0px; background-color:transparent;"/></td>
					        <td>
					        	<input type=text id="totalPrice${vo.idx}" class="text-center" value='<fmt:formatNumber value="${vo.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
					        	<input type=hidden id="tempTotalPrice${vo.idx}" name="tempTotalPrice" value="${vo.totalPrice}"/>
					        </td>
					      </tr>
				    	</c:forEach>
				    	<tr>
				    		<td colspan="6">
				    			<div class="text-right" style="font-size:20px; font-weight:bold; padding-right:20px">합계 &nbsp;&nbsp;&nbsp;&nbsp;
				    				<input type=text id="cartPrice" class="text-center" style="font-size:20px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
				    			</div>
				    		</td>
			    		</tr> 
				    	<tr><td colspan="6"></td></tr> 
				    </tbody>
				  </table>
			  </div>
			</c:if>
			
			<hr style="margin:50px 0px 50px 0px"/>
			
			<div class="row" style="margin:10px 0px 50px 0px">
				<div class="col">
					<div class="infoBox">
						<table class="table table-bordered">
							<thead>
					      <tr>
					        <th colspan="2">배송정보</th>
					      </tr>
					    </thead>
					    <tbody>
								<tr>
									<th>배송지 선택</th>
									<td><button class="btn btn-primary" onclick="addressList()">주소록 보기 <i class="fa-solid fa-chevron-right"></i></button></td>
								<tr>
								<tr>
									<th>배송지 명</th>
									<td><input type="text" name="" value="${addressVO.addressName}" class="form-control" readonly/></td>
								<tr>
								<tr>
									<th>받으시는 분</th>
									<td><input type="text" name="" value="${addressVO.name}" class="form-control" readonly/></td>
								<tr>
								<tr>
									<th>주소</th>
									<td>
							      <div class="input-group mb-1">
							        <input type="text" name="postcode" id="postcode" value="${addressVO.postcode}" placeholder="우편번호" class="form-control" readonly>
							      </div>
							      <input type="text" name="roadAddress" id="roadAddress" size="50" value="${addressVO.roadAddress}" placeholder="주소" class="form-control mb-1" readonly>
							      <div class="input-group mb-1">
							        <input type="text" name="detailAddress" id="detailAddress" value="${addressVO.detailAddress}" placeholder="상세주소" class="form-control" readonly> &nbsp;&nbsp;
							        <div class="input-group-append">
							          <input type="text" name="extraAddress" id="extraAddress" value="${addressVO.extraAddress}" placeholder="참고항목" class="form-control" readonly>
							        </div>
							      </div>	
									</td>
								<tr>
								<tr>
									<th>전화번호</th>
									<td><input type="text" name="tel" value="${addressVO.tel}" class="form-control"/></td>
								<tr>
								<tr>
									<th>배송메시지</th>
									<td><textarea rows="5" cols="10" class="form-control">${addressVO.addressMsg}</textarea></td>
								<tr>
					    </tbody>
						</table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>