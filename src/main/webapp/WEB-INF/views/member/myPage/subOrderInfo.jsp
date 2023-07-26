<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script> 
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
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
</head>
<body>
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">주문 관리 유의사항</div>
			<div style="padding:20px">
				- 결제완료 <i class="fa-solid fa-caret-right"></i> 배송준비중 <i class="fa-solid fa-caret-right"></i> 배송중 <i class="fa-solid fa-caret-right"></i> 
				배송완료 <br/>
	      - 정기 구독은 마이페이지 구독관리창에서 구독 취소 신청이 가능합니다.<br/>
	      - 제품 하자 시 문의를 통해 교환 가능하며, 반품은 불가능합니다.<br/>
	      - 매달 15일 일괄 배송처리되며, 구독권 기간에 따라 6/12개월 동안 지속됩니다.<br/>
			</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="infoBox">
				<form name="addressForm">
					<table class="table table-bordered" style="margin-bottom:0px">
						<thead>
				      <tr>
				        <th colspan="2" class="text-center">구매자 정보<br/></th>
				      </tr>
				    </thead>
				    <tbody>
							<tr>
								<th>구매자 ID</th>
								<td>${memberVO.mid}</td>
							<tr>
							<tr>
								<th>구매자 성명</th>
								<td>${memberVO.name}</td>
							<tr>
							<tr>
								<th>구매자 별명</th>
								<td>${memberVO.nickname}</td>
							<tr>
							<tr>
								<th>구매자 이메일</th>
								<td>${memberVO.email}</td>
							<tr>
							<tr>
								<th>구매자 전화번호</th>
								<td>${memberVO.tel}</td>
							<tr>
				    </tbody>
					</table>			
				</form>
			</div>
		</div>
	</div>
	
	<div class="row" style="margin:50px 0px 10px 0px">
		<div class="col">
			<div class="infoBox">
				<form name="addressForm">
					<table class="table table-bordered" style="margin-bottom:0px">
						<thead>
				      <tr>
				        <th colspan="2" class="text-center">주문 정보&nbsp;&nbsp;&nbsp;(${vo.orderCode})<br/></th>
				      </tr>
				    </thead>
				    <tbody>
							<tr>
								<th>상품 타입</th>
								<td>${vo.type}</td>
							</tr>
							<tr>
								<th>상품 정보</th>
								<c:if test="${vo.type == '컬렉션 상품'}">
									<td>
										${vo.prodName}<br/>
										[옵션]  ${vo.opName}&nbsp;&nbsp;&nbsp;
										(<fmt:formatNumber value="${vo.opPrice}" pattern="#,###"/> 원)
									</td>
								</c:if>
								<c:if test="${vo.type != '컬렉션 상품'}">
									<td>
										${vo.prodName}&nbsp;&nbsp;&nbsp;(<fmt:formatNumber value="${vo.prodPrice}" pattern="#,###"/> 원)
									</td>
								</c:if>
							</tr>
							<tr>
								<th>상품 수량</th>
								<td>${vo.num} 개&nbsp;&nbsp;&nbsp;(<fmt:formatNumber value="${vo.totalPrice}" pattern="#,###"/> 원)</td>
							</tr>
							<tr>
								<th>결제 금액</th>
								<td><fmt:formatNumber value="${vo.paidPrice}" pattern="#,###"/> 원</td>
							</tr>
							<tr>
								<th>사용 포인트</th>
								<td>${vo.usedPoint}</td>
							</tr>
							<tr>
								<th>주문 날짜</th>
								<td>${vo.orderDate}</td>
							</tr>
							<tr>
								<th>주문 상태</th>
								<td><span style="color:red">${vo.orderStatus}</span></td>
							</tr>
							<tr>
								<th>구독 기간&nbsp;&nbsp;&nbsp;(발송 잔여 횟수)</th>
								<td>${fn:substring(subscribeVO.subStartDate,0,10)} ~ ${fn:substring(subscribeVO.subExpireDate,0,10)}&nbsp;&nbsp;&nbsp;(${subscribeVO.subSendNum} 회)</td>
							</tr>
							<tr>
								<th>구독 유지 유무</th>
								<td>${subscribeVO.subStatus}</td>
							</tr>
							<c:if test="${!empty subscribeVO.subRefund}">
								<tr>
									<th>구독 취소 환불금</th>
									<td><fmt:formatNumber value="${subscribeVO.subRefund}" pattern="#,###"/> 원</td>
								</tr>
								<tr>
									<th>구독 취소 환불포인트</th>
									<td>${subscribeVO.subRefundPoint}</td>
								</tr>
							</c:if>
				    </tbody>
					</table>			
				</form>
			</div>
		</div>
	</div>
	
	<div class="row" style="margin:50px 0px 80px 0px">
		<div class="col">
			<div class="infoBox">
				<form name="addressForm">
					<table class="table table-bordered" style="margin-bottom:0px">
						<thead>
				      <tr>
				        <th colspan="2" class="text-center">배송지 정보<br/></th>
				      </tr>
				    </thead>
				    <tbody>
							<tr>
								<th>수령인</th>
								<td>${addressVO.name}</td>
							<tr>
							<tr>
								<th>전화번호</th>
								<td>${addressVO.tel}</td>
							<tr>
							<tr>
								<th>배송 메시지</th>
								<td>${addressVO.addressMsg}</td>
							<tr>
							<tr>
								<th>주소</th>
								<td>(${addressVO.postcode})&nbsp;&nbsp;${addressVO.roadAddress}&nbsp;&nbsp;${addressVO.detailAddress}&nbsp;&nbsp;${addressVO.extraAddress}</td>
							<tr>
				    </tbody>
					</table>			
				</form>
			</div>
		</div>
	</div>
	
	<div class="row" style="margin:50px 0px 80px 0px">
		<div class="col">
			<div class="infoBox">
				<form name="addressForm">
					<table class="table table-bordered" style="margin-bottom:0px">
						<thead>
				      <tr>
				        <th colspan="2" class="text-center">배송 정보<br/></th>
				      </tr>
				    </thead>
				    <tbody>
					    <c:forEach var="deliveryVO" items="${deliveryVOS}" varStatus="st">
								<tr>
									<th>번호</th>
									<td>${st.count}</td>
								<tr>
								<tr>
									<th>송장 번호</th>
									<td>
										<c:if test="${!empty deliveryVO.invoice}">${deliveryVO.invoice}</c:if>
										<c:if test="${empty deliveryVO.invoice}">입력 전</c:if>
									</td>
								<tr>
								<tr>
									<th>배송 상태</th>
									<td><span style="color:red">${deliveryVO.deliveryStatus}</span></td>
								<tr>
								<tr>
									<th>배송 날짜</th>
									<td>${fn:substring(deliveryVO.deliveryDate,0,10)}</td>
								<tr>
								<tr><td colspan="2"></td></tr>
				    	</c:forEach>
				    </tbody>
					</table>			
				</form>
			</div>
		</div>
	</div>
</body>
</html>