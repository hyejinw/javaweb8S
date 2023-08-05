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
	<script>
		'use strict';
		
		// 구독취소 승인
		function subscribeCancel() {
			let subRefund = document.getElementById('subRefund').value;
			let subRefundPoint = document.getElementById('subRefundPoint').value;
			
			if(subRefund == '') {
				alert('환불금을 입력해주세요.');
				document.getElementById('subRefund').focus();
				return false;
			}
			if(subRefund > ${vo.paidPrice}) {
				alert('환불금이 결제 금액을 초과할 수 없습니다.');
				document.getElementById('subRefund').value = ${vo.paidPrice};
				return false;
			}
			if(subRefundPoint == '') {
				alert('환불포인트를 입력해주세요.');
				document.getElementById('subRefundPoint').focus();
				return false;
			}
			if(subRefundPoint > ${vo.usedPoint}) {
				alert('환불포인트가 사용 포인트를 초과할 수 없습니다.');
				document.getElementById('subRefundPoint').value = ${vo.usedPoint};
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/magazine/subscribeCancel",
				data : {
					idx : ${subscribeVO.idx},
					orderIdx : ${vo.idx},
					paidPrice : ${vo.paidPrice},
					memNickname : '${memberVO.nickname}',
					email : '${memberVO.email}',
					subRefund : subRefund,
					subRefundPoint : subRefundPoint
				},
				success : function() {
					alert('구독취소 승인되었습니다.');
					opener.document.location.reload();
					location.reload();
				},
				error : function() {
					alert('전송 오류가 발생했습니다. 재시도 부탁드립니다.');
				}
			});
		}
	</script>
</head>
<body>
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">구독취소 유의사항</div>
			<div style="padding:20px">
	      - 승인 철회는 불가능합니다.<br/>
	      - 승인 완료 후, 환불금 / 환불포인트가 환불됩니다.<br/>
	      - 구독취소 승인 후, 회원 이메일로 구독 유지 유도 메일이 발송됩니다.<br/>
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
							<c:if test="${subscribeVO.subStatus == '구독취소'}">
								<tr>
									<th>구독 취소 환불금</th>
									<td><fmt:formatNumber value="${subscribeVO.subRefund}" pattern="#,###"/> 원</td>
								</tr>
								<tr>
									<th>구독 취소 환불포인트</th>
									<td>${subscribeVO.subRefundPoint}</td>
								</tr>
							</c:if>
							<c:if test="${subscribeVO.subStatus == '구독취소신청'}">
								<tr>
									<th>구독 취소 환불금</th>
									<td><input type="number" name="subRefund" id="subRefund" class="form-control" min="0" placeholder="관리자 직접 입력 (최대 <fmt:formatNumber value="${vo.paidPrice}" pattern="#,###"/> 원)"/></td>
								</tr>
								<tr>
									<th>구독 취소 환불포인트</th>
									<td><input type="number" name="subRefundPoint" id="subRefundPoint" class="form-control" min="0" placeholder="관리자 직접 입력 (최대 <fmt:formatNumber value="${vo.usedPoint}" pattern="#,###"/> 원)"/></td>
								</tr>
								<tr>
									<td colspan="2" class="text-center">
										<span>※ 승인 철회는 불가능합니다. 신중하게 처리해주세요. ※</span><br/>
										<span>※ 승인 완료 후, 회원에게 이메일이 전송됩니다. 화면전환까지 잠시 기다려주세요. ※</span><br/><br/>
										<button type="button" class="btn btn-warning" onclick="subscribeCancel()">구독취소 승인</button>
									</td>
								</tr>
							</c:if>
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