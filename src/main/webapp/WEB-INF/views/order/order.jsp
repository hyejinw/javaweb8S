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
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<style>
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
			$("input[name=paidPrice]").each(function(index, item){
				res = res + parseInt($(item).val());
		  });
			
			document.getElementById("cartPrice").value = numberWithCommas(res)+ "  원";
			document.getElementById("totalPrice").value = numberWithCommas(res)+ "  원";
			document.getElementById("orderTempPrice").value = numberWithCommas(res)+ "  원";
			
			document.getElementById("totalTempPrice").value = res;
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
		
		// 포인트 사용 창
		function pointUsage() {
			let url = "${ctp}/order/pointUsage?checkRow=${checkRow}";

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 포인트 사용 후, 결제 예정 금액 변경
		function usedPointChange() {
			let totalTempPrice = document.getElementById('totalTempPrice').value;
			let usedPoint = document.getElementById('totalUsedPoint').value;
			
			document.getElementById('orderTempPrice').value = numberWithCommas(totalTempPrice - usedPoint)+ "  원";
		}
		
		// 결제
		function order() {
			let addressIdx = document.getElementById('addressIdx').value;
			
			if(addressIdx == "") {
				alert('배송 정보를 입력해주세요.');
				document.getElementById('addressList').focus();
				return false;
			}
			
			let postcode = document.getElementById('postcode').value;
			let roadAddress = document.getElementById('roadAddress').value;
			let detailAddress = document.getElementById('detailAddress').value;
			let extraAddress = document.getElementById('extraAddress').value;
			let address = "";
			
			if(extraAddress != "") address = roadAddress + " " + detailAddress + " " + extraAddress;
			if(extraAddress == "") address = roadAddress + " " + detailAddress;
			
			var IMP = window.IMP; 
	    IMP.init("imp36187871");
			
			IMP.request_pay({
		    /* pg : 'inicis', */ /* version 1.1.0부터 지원. 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다. */
		    pg : 'html5_inicis.INIpayTest',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '책(의)세계',
		    amount : 100,               //판매 가격
		    buyer_email : '${memberVO.email}',
		    buyer_name : '${memberVO.name}',
		    buyer_tel : '${memberVO.tel}',
		    buyer_addr : address,
		    buyer_postcode : postcode
			}, 
			
			function(rsp) {
		    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
			    alert(msg);
		    } 
		    else {
	        var msg = '결제에 실패하였습니다.';
	        //msg += '\n에러내용 : ' + rsp.error_msg;
			    alert(msg);
			    return false;
		    }
				orderForm.action="${ctp}/order/orderInsert";
				orderForm.submit();
			});
		}
		
		function order2() {
			let addressIdx = document.getElementById('addressIdx').value;
			
			if(addressIdx == "") {
				alert('배송 정보를 입력해주세요.');
				document.getElementById('addressList').focus();
				return false;
			}
			
			orderForm.action="${ctp}/order/orderInsert";
			orderForm.submit();
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
					<div class="infoBox" style="padding: 20px">
						책의 세계는 모두 무료배송<hr/>
						구매 완료 시, 포인트 5%가 적립됩니다. &nbsp;&nbsp;&nbsp;&nbsp;(<span style="font-weight:bold">보유 포인트</span>&nbsp;&nbsp;<span>${memberVO.point}</span>)
					</div>
				</div>
			</div>
			
			<!-- 구매할 상품 -->
			<c:if test="${(!empty vos)}">
				<div class="table-responsive" style="margin-top:80px; margin-bottom:0px;">
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
						        </td>
					        </c:if>
					        
					        <!-- 공통 -->
					        <td><input type="text" class="text-center num" value="${vo.num} 개" readonly style="width:50px; border:0px; background-color:transparent;"/></td>
					        <td>
					        	<input type=text class="text-center" value='<fmt:formatNumber value="${vo.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
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
				    </tbody>
				  </table>
			  </div>
			</c:if>
			
			<hr style="margin:50px 0px 50px 0px"/>
			<div class="text-right mr-3" style="font-size:15px;" class="mt-3">&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-circle-exclamation" style="color:#491f51;"></i>
		  	&nbsp;&nbsp;매거진 정기구독권 복수 개 구매 시, 주문 배송지로 일괄 배송됩니다:)<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;정기 배송지 변경은 마이페이지에서 가능합니다.
	  	</div>
			<div class="row" style="margin:10px 0px 50px 0px">
				<div class="col">
					<div class="infoBox">
						<table class="table table-bordered" style="margin:0px">
							<thead>
					      <tr>
					        <th colspan="2">배송정보</th>
					      </tr>
					    </thead>
					    <tbody>
								<tr>
									<th>배송지 선택</th>
									<td><button class="btn btn-primary" id="addressList" onclick="addressList()">주소록 보기 <i class="fa-solid fa-chevron-right"></i></button></td>
								<tr>
								<tr>
									<th>배송지 명</th>
									<td><input type="text" name="addressName" id="addressName" value="${addressVO.addressName}  (기본 배송지)" style="border:0px; outline: none;" readonly/></td>
								<tr>
								<tr>
									<th>받으시는 분</th>
									<td><input type="text" name="name" id="name" value="${addressVO.name}" style="border:0px; outline: none;" readonly/></td>
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
									<td><input type="text" name="tel" id="tel" value="${addressVO.tel}" style="border:0px; outline: none;" readonly/></td>
								<tr>
								<tr>
									<th>배송메시지</th>
									<td><textarea rows="5" cols="10" id="addressMsg" class="form-control" readonly>${addressVO.addressMsg}</textarea></td>
								<tr>
					    </tbody>
						</table>
					</div>
				</div>
			</div>
			<hr style="margin:50px 0px 50px 0px"/>
			
			<div class="text-right mb-4 mr-4"><button class="btn btn-dark" onclick="order()" style="font-size:25px">결제하기</button></div>
			
			<div class="row" style="margin:10px 0px 50px 0px">
				<div class="col">
					<div class="infoBox">
						<table class="table text-center">
							<thead>
								<tr>
									<th>총 주문 금액</th>
									<th>
										할인 금액&nbsp;&nbsp;&nbsp;&nbsp;
										<button class="btn btn-sm btn-outline-primary" onclick="pointUsage()">포인트 사용 <i class="fa-solid fa-chevron-right"></i></button>
									</th>
									<th>총 결제예정 금액</th>
								</tr>
							<tbody>
								<tr>
									<td>
										<input type="text" id="totalPrice" class="text-center" style="font-size:20px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
										<input type="hidden" id="totalTempPrice" />
									</td>
									<td>
										<input type="text" id="totalUsedPoint" class="text-center" style="font-size:20px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
									</td>
									<td>
										<input type="text" id="orderTempPrice" class="text-center" style="font-size:20px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div class="row" style="margin:10px 0px 30px 0px">
				<div class="col">
					<div class="infoBox">
						<form name="orderForm" method="post">
							<table class="table text-center" style="margin-bottom:0px">
								<thead>
									<tr>
										<th colspan="5">포인트 적용</th>
									</tr>
									<tr>
										<th colspan="2">적용 상품</th>
										<th>상품 가격</th>
										<th>합계</th>
										<th>사용 포인트</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="vo" items="${vos}" varStatus="st">
										<tr>
											<td>${st.count}</td>
											<!-- 컬렉션 상품 -->
							        <c:if test="${vo.type == '컬렉션 상품'}">
								        <td>
								        	<span style="font-size:15px; font-weight:bold;">${vo.prodName}</span><br/><hr style="margin:10px;"/>
								        	<span>[옵션]  ${vo.opName}&nbsp;&nbsp;&nbsp;(${vo.num} 개)</span>
								        </td>
								        <td>
								     		  <fmt:formatNumber value="${vo.opPrice}" pattern="#,###"/>원
								     	   	<%-- <input type="hidden" id="price${vo.idx}" value="${vo.opPrice}"/> --%>
								        </td>
							        </c:if>
											<!-- 매거진, 매거진 정기구독 -->
							        <c:if test="${vo.type != '컬렉션 상품'}">
								        <td>
								        	<span style="font-size:15px; font-weight:bold;">${vo.prodName}&nbsp;&nbsp;&nbsp;</span>(${vo.num} 개)
								        </td>
								        <td>
								     		  <fmt:formatNumber value="${vo.prodPrice}" pattern="#,###"/>원
								     	   	<input type="hidden" id="price${vo.idx}" value="${vo.prodPrice}"/>
								        </td>
							        </c:if>
							        <!-- 공통 -->
							        <td>
							        	<input type=text id="totalPrice${vo.idx}" class="text-center" value='<fmt:formatNumber value="${vo.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
							        </td>
							        <td>
							        	<input type="number" id="usedPoint${vo.idx}" name="usedPoint" value="0" class="text-center" style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
							        	<input type=hidden id="tempTotalPrice${vo.idx}" name="paidPrice" value="${vo.totalPrice}"/>
							        </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>		
		        	<input type="hidden" name="memNickname" value="${memberVO.nickname}"/>
		        	<input type="hidden" name="checkRow" value="${checkRow}"/>
							<input type="hidden" name="addressIdx" id="addressIdx" value="${addressVO.idx}"/> 
						</form>
					</div>
				</div>
			</div>
			
			<div class="row" style="margin:100px 0px 30px 0px">
				<div class="col">
					<div class="infoBox" style="padding:20px">
						<div>
							<h5>WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br/><br/></h5>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;Service Pack 2에 대한 Microsoft사의 상세안내<br/><hr/>

<h5>아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.<br/><br/></h5>

<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능<br/>
(단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.<br/>
(무통장, 휴대폰결제 포함)<br/><hr/>

<h5>세금계산서 발행 안내<br/><br/></h5>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;세금계산서는 사업자만 신청하실 수 있습니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.<br/><hr/>

<h5>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내<br/><br/></h5>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.<br/><hr/>

<h5>현금영수증 이용안내<br/><br/></h5>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)<br/>
<i class="fa-solid fa-circle-check"></i>&nbsp;&nbsp;현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.<br/>
						</div>
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