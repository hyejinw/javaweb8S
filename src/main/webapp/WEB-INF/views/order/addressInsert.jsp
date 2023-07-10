<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    .must {
  		color: red;
		}
	</style>
	<script>
		'use strict'
		
		// 배송지 등록 취소
		function addressInsertCancel() {
			window.close();
		}
		
		// 배송지 등록
		function addressInsert() {
			let defaultAddress = 
			
			let addressName = addressForm.addressName.value;
			let name = addressForm.name.value;
			let tel = addressForm.tel.value;
			let postcode = addressForm.postcode.value;
			let roadAddress = addressForm.roadAddress.value;
			let detailAddress = addressForm.detailAddress.value;
			let extraAddress = addressForm.extraAddress.value;
			
			/* 여기부터 하면 된당 내일의 혜진앙! */
			
			window.close();
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
	      - 별(<span class="must">*</span>) 표시는 필수 입력입니다.<br/>
			</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="infoBox">
				<form name="addressForm">
					<table class="table table-bordered">
						<thead>
				      <tr>
				        <th colspan="2">배송정보<br/>
					        <div class="text-right">
						        &nbsp;&nbsp;&nbsp;&nbsp;<label for="defaultAddress"><input type="checkbox" name="defaultAddress" id="defaultAddress" class="form-check-input" />&nbsp;기본 배송지로 설정</label>
					        </div>
				        </th>
				      </tr>
				    </thead>
				    <tbody>
							<tr>
								<th>배송지 명 <span class="must">*</span></th>
								<td><input type="text" name="addressName" id="addressName" class="form-control"/></td>
							<tr>
							<tr>
								<th>받으시는 분 <span class="must">*</span></th>
								<td><input type="text" name="name" id="name" class="form-control"/></td>
							<tr>
							<tr>
								<th>주소 <span class="must">*</span></th>
								<td>
						      <div class="input-group mb-1">
						        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
						        <div class="input-group-append">
						          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary btn-sm">
						        </div>
						      </div>
						      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
						      <div class="input-group mb-1">
						        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
						        <div class="input-group-append">
						          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
						        </div>
						      </div>	
								</td>
							<tr>
							<tr>
								<th>전화번호 <span class="must">*</span></th>
								<td><input type="text" name="tel" id="tel" placeholder="-를 포함해 작성해주세요" class="form-control"/></td>
							<tr>
							<tr>
								<th>배송메시지</th>
								<td><textarea rows="3" cols="10" name="addressMsg" id="addressMsg" class="form-control"></textarea></td>
							<tr>
				    </tbody>
					</table>			
				</form>
			</div>
		</div>
	</div>
	
	<div class="row text-center" style="margin-bottom:80px">
		<div class="col">
			<br/>
			<button class="btn btn-dark" onclick="addressInsert()">등록</button>&nbsp;&nbsp;&nbsp;
			<button class="btn btn-outline-dark" onclick="addressInsertCancel()">취소</button>
		</div>
	</div>
</body>
</html>