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
		
		// 배송지 수정
		function addressUpdate() {
			// 기본 주소 등록 확인
			// 체크: true, 미 체크: false
			let defaultAddress = document.getElementById('defaultAddress').checked;
			if(!defaultAddress) defaultAddress = 1;
			else defaultAddress = 0;
				
			let idx = addressForm.idx.value;
			
			let addressName = addressForm.addressName.value;
			let name = addressForm.name.value;
			
			let postcode = addressForm.postcode.value;
			let roadAddress = addressForm.roadAddress.value;
			let detailAddress = addressForm.detailAddress.value;
			let extraAddress = addressForm.extraAddress.value;

			let tel = addressForm.tel.value;
			let addressMsg = addressForm.addressMsg.value;

			
			let regex1 = /^[가-힣a-zA-Z0-9!@#$%^&*()._-]{1,20}$/g; 
			// (주소명)4자 이상 20자 이하,한글,영문,숫자,특수문자 허용
			let regex2 = /^[가-힣a-zA-Z]{2,10}$/;  // (수령인 성명)한글,영문 2~10자
			let regex3 = /^[\d]{5}$/;  // (우편번호)숫자 5자리
			let regex4 = /^[가-힣a-zA-Z0-9()\s-_]{2,100}$/;  // (주소)한글,영문,숫자,(),공백 허용
			let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; // (전화번호)
			let regex6 = /^[가-힣a-zA-Z0-9!@#$%^&*()._-\s]{1,50}$/g; 
			// (배송메시지)4자 이상 100자 이하,한글,영문,숫자,특수문자 허용
			
			if(!regex1.test(addressName)){
				alert('주소명 형식에 맞춰주세요.(한글/영문/숫자/특수문자 허용, 1~20자)');
				 addressForm.addressName.focus();
		    return false;
		  }
			if(!regex2.test(name)){
				alert('수령인 성명 형식에 맞춰주세요.(한글/영문 허용, 2~10자)');
				 addressForm.name.focus();
		    return false;
		  }
			if(!regex3.test(postcode)){
				alert('우편번호 5자리를 알맞게 입력해주세요.');
				 addressForm.postcode.focus();
		    return false;
		  }
			if(!regex4.test(roadAddress)){
				alert('주소 형식에 맞춰주세요.(한글,영문,숫자,(),공백 허용, 2~100자)');
				 addressForm.roadAddress.focus();
		    return false;
		  }
			if(!regex4.test(detailAddress)){
				alert('상세주소 형식에 맞춰주세요.(한글,영문,숫자,(),공백 허용, 2~100자)');
				 addressForm.detailAddress.focus();
		    return false;
		  }
			if(extraAddress != "") {
				if(!regex4.test(extraAddress)){
					alert('참고항목 형식에 맞춰주세요.(한글,영문,숫자,(),공백 허용, 2~100자)');
					 addressForm.extraAddress.focus();
			    return false;
			  }
			}
			if(!regex5.test(tel)){
				alert('전화번호 형식에 맞춰주세요.(- 포함)');
				addressForm.tel.focus();
		    return false;
		  }
			if(addressMsg != "") {
				if(!regex6.test(addressMsg)){
					alert('배송메시지 형식에 맞춰주세요.(한글/영문/숫자/특수문자/공백 허용, 50자 이하)');
					addressForm.addressMsg.focus();
			    return false;
			  }
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/order/addressUpdate",
				data : {
					idx : idx,
					memNickname : '${sNickname}',
					defaultAddress : defaultAddress,
					addressName : addressName,
					name : name,
					tel : tel,
					postcode : postcode,
					roadAddress : roadAddress,
					detailAddress : detailAddress,
					extraAddress : extraAddress,
					addressMsg : addressMsg
				},
				success : function() {
					alert('주소가 수정되었습니다.');
					window.opener.location.reload();
					window.close();
				},
				error : function() {
					alert("전송 오류! 재시도 부탁드립니다.")
				}
			});
		}
		
		// 등록 취소
		function addressUpdateCancel() {
			window.opener.location.reload();
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
					<table class="table table-bordered" style="margin-bottom:0px">
						<thead>
				      <tr>
				        <th colspan="2">배송 수정<br/>
					        <div class="text-right">
						        &nbsp;&nbsp;&nbsp;&nbsp;<label for="defaultAddress">
						        <input type="checkbox" name="defaultAddress" id="defaultAddress" class="form-check-input" <c:if test="${vo.defaultAddress == 0}">checked disabled</c:if>/>&nbsp;기본 배송지로 설정</label>
					        </div>
				        </th>
				      </tr>
				    </thead>
				    <tbody>
							<tr>
								<th>배송지 명 <span class="must">*</span></th>
								<td><input type="text" name="addressName" id="addressName" value="${vo.addressName}" class="form-control"/></td>
							<tr>
							<tr>
								<th>받으시는 분 <span class="must">*</span></th>
								<td><input type="text" name="name" id="name" value="${vo.name}" class="form-control"/></td>
							<tr>
							<tr>
								<th>주소 <span class="must">*</span></th>
								<td>
						      <div class="input-group mb-1">
						        <input type="text" name="postcode" id="sample6_postcode" value="${vo.postcode}" placeholder="우편번호" class="form-control">
						        <div class="input-group-append">
						          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary btn-sm">
						        </div>
						      </div>
						      <input type="text" name="roadAddress" id="sample6_address" size="50" value="${vo.roadAddress}" placeholder="주소" class="form-control mb-1">
						      <div class="input-group mb-1">
						        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${vo.detailAddress}" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
						        <div class="input-group-append">
						          <input type="text" name="extraAddress" id="sample6_extraAddress" value="${vo.extraAddress}" placeholder="참고항목" class="form-control">
						          <!-- 배송 주소 고유번호 -->
						          <input type="hidden" name="idx" id="idx" value="${vo.idx}" />
						        </div>
						      </div>	
								</td>
							<tr>
							<tr>
								<th>전화번호 <span class="must">*</span></th>
								<td><input type="text" name="tel" id="tel" placeholder="-를 포함해 작성해주세요" value="${vo.tel}" class="form-control"/></td>
							<tr>
							<tr>
								<th>배송메시지</th>
								<td><textarea rows="3" cols="10" name="addressMsg" id="addressMsg" class="form-control">${vo.addressMsg}</textarea></td>
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
			<button class="btn btn-dark" onclick="addressUpdate()">수정</button>&nbsp;&nbsp;&nbsp;
			<button class="btn btn-outline-dark" onclick="addressUpdateCancel()">취소</button>
		</div>
	</div>
</body>
</html>