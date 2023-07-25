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
			
			let url = "${ctp}/member/myPage/addressInsert";

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'insert', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 주소록 수정
		function addressUpdate(idx) {
			
			let url = "${ctp}/member/myPage/addressUpdate?idx="+idx;

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'update', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		/* 개별 박스 선택할 때도 똑같이 처리 */
		function addressCheckChange() {

			// 전체 해제한 경우 '전체 선택' 체크박스도 해제시켜주기
			if($( "input[name='checkRow']:checked" ).length == 0) {
				$("input[name=checkAll]").prop("checked", false);
			}

			// 전체 선택한 경우 '전체 선택' 체크박스도 선택시켜주기
			if($( "input[name='checkRow']:checked" ).length == ${addressNum} - 1) {
				$("input[name=checkAll]").prop("checked", true);
			}
		}
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function() {
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 주소를 선택해주세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 주소를 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/order/addressIdxesDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
    				alert("선택한 주소가 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		
		// 배송 주소 적용 + 매거진 정기배송지 변경
		function addressChoose(idx) {
			let orderIdx = localStorage.getItem("sSubAddressChangeOrderIdx");
			
			if(confirm("선택한 주소로 변경하시겠습니까?")) {
			      
	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/member/myPage/orderAddressIdxChange",
	    	  data : {
	    		  idx : orderIdx,
	    		  addressIdx : idx
    		  },
	    	  success : function(res) {
	  				alert("매거진 정기배송지가 변경되었습니다.");
	  				window.opener.location.reload();
	  				window.close();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			} 
			
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
	      - 기본 배송지는 삭제가 불가능합니다.<br/>
			</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col" style="margin-left:30px"><button class="btn btn-outline-danger" onclick="deleteAction()">선택삭제</button></div>
	</div>	
	
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
				<table class="table text-center" style="margin-bottom:0px">
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
									<c:if test="${vo.defaultAddress == 0}">&nbsp;&nbsp;&nbsp;
										<td><label for="chk${vo.idx}"><input type="checkbox" disabled class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${st.count}</label></td>
										<td>${vo.addressName}
												<span class="badge badge-pill badge-success">기본 주소</span>
										</td>
									</c:if>
									<c:if test="${vo.defaultAddress != 0}">&nbsp;&nbsp;&nbsp;
										<td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" onclick="addressCheckChange()" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${st.count}</label></td>
										<td>${vo.addressName}</td>
									</c:if>
									<td>${vo.name}</td>
									<td>${vo.tel}</td>
									<td>(${vo.postcode}) ${vo.roadAddress} ${vo.detailAddress} ${vo.extraAddress}</td>
									<td>
										<c:if test="${!empty vo.addressMsg}">${vo.addressMsg}</c:if>
										<c:if test="${empty vo.addressMsg}"><i class="fa-solid fa-text-slash"></i></c:if>
									</td>
									<td>
										<button class="btn btn-sm btn-warning mb-2" onclick="addressChoose('${vo.idx}')">적용</button>
										<button class="btn btn-sm btn-outline-secondary" onclick="addressUpdate(${vo.idx})">수정</button>
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
	
	<div class="row text-center" style="margin-bottom:50px">
		<div class="col">
			<button class="btn btn-dark" onclick="addressInsert()">배송지 등록</button>
		</div>
	</div>
</body>
</html>