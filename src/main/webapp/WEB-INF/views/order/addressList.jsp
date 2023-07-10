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
		// 주소록 등록
		function addressInsert() {
			
			if(${addressNum} >= 5) {
				alert('배송 주소록은 최대 5개까지 등록 가능합니다.');
				return false;
			}
			
			let url = "${ctp}/order/addressInsert";

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
	</script>
</head>
<body>
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">배송주소록 유의사항</div>
			<div style="padding:20px">
				- 배송 주소록은 최대 5개까지 등록 가능합니다.<br/>
	      - 기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.<br/>
			</div>
			</div>
		</div>
	</div>
	
	<div class="row" style="margin:10px 0px 20px 0px">
		<div class="col">
			<div class="infoBox">
				<table class="table text-center">
					<thead>
						<tr>
							<th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
							<th>배송지 명</th>
							<th>수령인</th>
							<th>전화번호</th>
							<th>주소</th>
							<th>배송메시지</th>
							<th>선택</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty vos}">
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<tr>
									<td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${st.count}</label></td>
									<td>${vo.addressName}
										<c:if test="${vo.defaultAddress == 0}">&nbsp;&nbsp;&nbsp;
											<span class="badge badge-pill badge-success">기본 주소</span>
										</c:if>
									</td>
									<td>${vo.name}</td>
									<td>${vo.tel}</td>
									<td>(${vo.postcode}) ${vo.roadAddress} ${vo.detailAddress} ${vo.extraAddress}</td>
									<td>
										<c:if test="${!empty vo.addressMsg}">${vo.addressMsg}</c:if>
										<c:if test="${empty vo.addressMsg}"><i class="fa-solid fa-text-slash"></i></c:if>
									</td>
									<td>
										<button class="btn btn-sm btn-warning">적용</button>
										<button class="btn btn-sm btn-outline-secondary">수정</button>
									</td>
								</tr>
							</c:forEach>
							<tr><td colspan="7"></td></tr> 
						</c:if>
						
						<!-- 주소록 미등록 시 -->
						<c:if test="${empty vos}">
							<tr><td colspan="7"><b><br/>등록된 주소록이 없습니다.</b></td></tr> 
						</c:if>
					</tbody>
				</table>			
			</div>
		</div>
	</div>
	
	<div class="row text-center">
		<div class="col">
			<button class="btn btn-dark" onclick="addressInsert()">배송지 등록</button>
		</div>
	</div>
</body>
</html>