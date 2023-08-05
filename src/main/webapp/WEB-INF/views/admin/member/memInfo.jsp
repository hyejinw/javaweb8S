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
		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
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
		
		function openCity(evt, cityName) {
		  var i, x, tablinks;
		  x = document.getElementsByClassName("city");
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablink");
		  for (i = 0; i < x.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" w3-black", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.className += " w3-black";
		}
		
		// 새로고침 시, 버튼 자동 클릭
		$(document).ready(function(){
			if(localStorage.getItem('addressBtn') == 'ON') {
				localStorage.removeItem('addressBtn');
				document.getElementById('addressBtn').click();
			}
			// else if
		});
		
		// 회원 프로필 변경
		function memPhotoEdit() {
			let memPhoto = document.getElementById('memPhoto').value; 
			let ext = memPhoto.substring(memPhoto.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			
		 	let defaultPhoto = $("input[type=radio][name=defaultPhoto]:checked").val();
			
			if((memPhoto.trim() == "") && (defaultPhoto == "defaultPhotoNone")) {
				alert("사진을 업로드해주세요.");
				return false;
			}
			
			if(defaultPhoto == "defaultPhotoNone") {
				let fileSize = memPhotoUpdate.file.files[0].size;
				if(ext != "JPG" && ext != "PNG") {
					alert("업로드 가능한 사진 파일은 'jpg 또는 png' 입니다.");
					return false;
				}
				if(fileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
			}
			
			memPhotoUpdate.submit();
		}
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('photoDemo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('photoDemo').src = "";
			}
		}
		
		// 파일 업로드 활성화/비활성화
		$(document).ready(function(){
 
	    // 라디오버튼 클릭시 이벤트 발생
	    $("input:radio[name=defaultPhoto]").click(function(){
	 
	        if($("input[name=defaultPhoto]:checked").val() == "defaultPhotoNone"){
	          $("input:file[name=file]").attr("disabled",false);
	          // radio 버튼의 value 값이 defaultPhotoNone이라면 활성화
	 
	        } else if($("input[name=defaultPhoto]:checked").val() != "defaultPhotoNone"){
	            $("input:file[name=file]").attr("disabled",true);
	            
	            document.getElementById('memPhoto').value = "";
	            document.getElementById('photoDemo').src = "";
	          // radio 버튼의 value 값이 defaultPhotoNone이라면 비활성화
	        }
	    });
		});

		// 소개글 수정창
		function introductionEditOpen() {
			if('${memberVO.memberDel}' == '탈퇴') {
				alert('탈퇴한 회원입니다.');
				return false;
			}
			
			$("#introduction").attr("disabled", false);
			$("#introductionEditBtn").css('display', 'inline-block');
			$("#introductionCancelBtn").css('display', 'inline-block');
		}
		
		// 소개글 수정
		function introductionUpdate() {
			let introduction = document.getElementById('introduction').value;
			
			$.ajax({
				type : "post",
				data : { 
					introduction : introduction,
					nickname : '${memberVO.nickname}'
				},
				url : "${ctp}/community/introductionUpdate",
				success : function() {
					alert('소개글이 수정되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			})
		}
			
		// 강제 탈퇴처리
		function memberForcedDelete() {
			let memberDelReason = document.getElementById('memberDelReason').value;
			
			if(memberDelReason == '') {
				alert('강제 탈퇴처리 사유를 작성해주세요.');
				document.getElementById('memberDelReason').focus();
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/member/memberForcedDelete",
				data : {
					idx : ${memberVO.idx},
					memberDelReason : memberDelReason
				},
				success : function(){
					alert('강제 탈퇴처리 되었습니다.');
					window.opener.location.reload(); // 부모창 값 업데이트
					location.reload();
				},
				error : function() {
					alert('전송 오류가 발생했습니다. 재시도 부탁드립니다.');
				}
			});
		}
		
		// 배송지 강제 삭제
		function addressDelete(idx) {
			
			if(confirm('정말로 강제 삭제처리 하시겠습니까?')) {
				$.ajax({
					type : "post",
					url : "${ctp}/admin/member/addressForcedDelete",
					data : { idx : idx },
					success : function() {
						alert('삭제되었습니다.');
						localStorage.setItem('addressBtn', 'ON');
						location.reload();
					},
					error : function() {
						alert('오류가 발생했습니다. 재시도 부탁드립니다.')
					}
				});
			}
		}
		
		// 주문 상세 정보
		function orderInfo(idx, memNickname) {
			let url ='${ctp}/admin/order/orderInfo?idx='+idx+"&memNickname="+memNickname;
			
			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 매거진 정기 구독, 주문 상세 정보
		function subOrderInfo(idx, memNickname) {
			let url ='${ctp}/admin/order/subOrderInfo?idx='+idx+"&memNickname="+memNickname;
			
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
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">회원 상세관리 유의사항</div>
			<div style="padding:20px">
				<b>※ 모든 강제변경은 신중히 처리해주세요. ※</b><br/>
				- 상세 변경처리는 해당 관리자페이지에서 가능합니다.
			</div>
			</div>
		</div>
	</div>
	
	<div class="w3-container" style="margin-bottom:50px">
	  <div class="w3-bar w3-light-grey">
	    <button class="w3-bar-item w3-button tablink w3-black" onclick="openCity(event,'member')">회원정보</button>
	    <button class="w3-bar-item w3-button tablink" id="addressBtn" onclick="openCity(event,'address')">배송지 주소록</button>
	    <button class="w3-bar-item w3-button tablink" id="pointBtn" onclick="openCity(event,'point')">포인트 적립내역</button>
	    <button class="w3-bar-item w3-button tablink" id="pointUseBtn" onclick="openCity(event,'pointUse')">포인트 사용내역</button>
	    <button class="w3-bar-item w3-button tablink" id="booksletterBtn" onclick="openCity(event,'booksletter')">뉴스레터 구독</button>
	    <button class="w3-bar-item w3-button tablink" id="subscribeBtn" onclick="openCity(event,'subscribe')">매거진 정기구독</button>
	  </div>
	  
	  <!-- 회원정보 -->
	  <div id="member" class="w3-container w3-border city">
			<table class="table table-bordered mt-3">
	      <tr>
	        <th class="text-center">아이디</th>
	        <td>
	        	${memberVO.mid}
	        	<c:if test="${memberVO.memberDel == '탈퇴'}"><span style="color:red">&nbsp;&nbsp;(탈퇴한 회원)</span></c:if>
	        </td>
	      </tr>
	      <tr>
	        <th class="text-center">성명</th>
	        <td>${memberVO.name}</td>
	      </tr>
	      <tr>
	        <th class="text-center">별명</th>
	        <td>${memberVO.nickname}</td>
	      </tr>
	      <tr>
	        <th class="text-center">이메일</th>
	        <td>${memberVO.email}</td>
	      </tr>
	      <tr>
	        <th class="text-center">전화번호</th>
	        <td>${memberVO.tel}</td>
	      </tr>
	      <tr>
	        <th class="text-center">적립금</th>
	        <td>${memberVO.point}</td>
	      </tr>
	      <tr>
	        <th class="text-center">총 방문 수</th>
	        <td>${memberVO.totCnt}</td>
	      </tr>
	      <tr>
	        <th class="text-center">오늘 방문 수</th>
	        <td>${memberVO.todayCnt}</td>
	      </tr>
	      <tr>
	        <th class="text-center">비밀번호 변경일</th>
	        <td>${fn:substring(memberVO.pwdUpdateDate,0,10)}</td>
	      </tr>
	      <tr>
	        <th class="text-center">가입일&nbsp;/&nbsp;마지막 방문일</th>
	        <td>${fn:substring(memberVO.firstVisit,0,10)}&nbsp;/&nbsp;${fn:substring(memberVO.lastVisit,0,10)}</td>
	      </tr>
	      <tr>
	        <th class="text-center">(3개의 책 커뮤니티)<br/>프로필 사진</th>
	        <td>
	        	<c:if test="${memberVO.memberDel != '탈퇴'}">
			        <a href="#" data-toggle="modal" data-target="#memPhotoEditModal">
			        	<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px"/>
			        </a>
			        <span style="font-size:14px">(클릭 시, 강제 변경가능)</span>
	        	</c:if>
	        	<c:if test="${memberVO.memberDel == '탈퇴'}">
		        	<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px"/>
	        	</c:if>
	       </td>
	      </tr>
	      <tr>
	        <th class="text-center">
	        	(3개의 책 커뮤니티)<br/>소개글&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:introductionEditOpen()">
							<i class="fa-regular fa-pen-to-square" style="font-size:16px"></i>
						</a>
	        </th>
	        <td>
	        	<textarea rows="4" id="introduction" class="form-control" disabled>${memberVO.introduction}</textarea>
	        	<button type="button" id="introductionEditBtn" onclick="introductionUpdate()" class="btn btn-outline-success btn-sm mt-3 mr-3" style="display:none">수정</button>
	        	<button type="button" id="introductionCancelBtn" onclick="javascript:location.reload();" class="btn btn-outline-dark btn-sm mt-3" style="display:none">취소</button>
		        <div class="text-right" style="font-size:12px">(강제 변경가능)</div>
	        </td>
	      </tr>
	      <c:if test="${memberVO.memberDel == '탈퇴'}">
		      <tr>
		        <th class="text-center">탈퇴 사유</th>
		        <td>${memberVO.memberDelReason}</td>
		      </tr>
	      </c:if>
	      <c:if test="${memberVO.memberDel != '탈퇴'}">
		      <tr>
		        <th class="text-center"><span style="color:red">강제</span> 탈퇴처리 사유</th>
		        <td>
		        	<textarea rows="4" id="memberDelReason" class="form-control" placeholder="강제 탈퇴처리는 철회할 수 없습니다. 신중히 처리해주세요."></textarea>
		        	<div class="text-right">
			        	<button type="button" class="btn btn-sm btn-dark mt-2 mr-3" onclick="memberForcedDelete()">탈퇴</button>
		        	</div>
		        </td>
		      </tr>
	      </c:if>
		  </table>
	  </div>
	
		<!-- 배송지 주소록 -->
	  <div id="address" class="w3-container w3-border city" style="display:none">
	    <table class="table text-center mt-3" style="margin-bottom:0px">
				<thead>
					<tr>
						<th>No.</th>
						<th>배송지 명</th>
						<th>수령인</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>배송메시지</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty addressVOS}">
						<c:forEach var="addressVO" items="${addressVOS}" varStatus="st">
							<tr>
								<c:if test="${addressVO.defaultAddress == 0}">&nbsp;&nbsp;&nbsp;
									<td>${st.count}</td>
									<td>${addressVO.addressName}
											<span class="badge badge-pill badge-success">기본 주소</span>
									</td>
								</c:if>
								<c:if test="${addressVO.defaultAddress != 0}">&nbsp;&nbsp;&nbsp;
									<td>${st.count}</td>
									<td>${addressVO.addressName}</td>
								</c:if>
								<td>${addressVO.name}</td>
								<td>${addressVO.tel}</td>
								<td>(${addressVO.postcode}) ${addressVO.roadAddress} ${addressVO.detailAddress} ${addressVO.extraAddress}</td>
								<td>
									<c:if test="${!empty addressVO.addressMsg}">${addressVO.addressMsg}</c:if>
									<c:if test="${empty addressVO.addressMsg}"><i class="fa-solid fa-text-slash"></i></c:if>
								</td>
								<td>
									<c:if test="${addressVO.addressDel == '삭제'}">
										<span style="color:red">삭제된 주소</span>
									</c:if>
									<c:if test="${addressVO.addressDel != '삭제'}">
										<button class="btn btn-sm btn-warning mb-2" onclick="addressDelete('${addressVO.idx}')">강제삭제</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<tr><td colspan="7"></td></tr> 
					</c:if>
					
					<!-- 주소록 미등록 시 -->
					<c:if test="${empty addressVOS}">
						<tr><td colspan="7" style="padding-bottom:30px"><b><br/>등록된 주소록이 없습니다.</b></td></tr> 
					</c:if>
				</tbody>
			</table>		
	  </div>
	
		<!-- 포인트 적립내역 -->
	  <div id="point" class="w3-container w3-border city" style="display:none">
	  	<table class="table text-center mt-3">
		    <thead>
		      <tr>
		        <th>No.</th>
		        <th>적립 포인트</th>
		        <th>적립 사유</th>
		        <th>적립일</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty pointVOS}">
		    		<tr><td colspan="4" class="text-center" style="padding:30px;">포인트 적립내역이 없습니다.</td></tr> 
		    	</c:if>
		    	<c:if test="${!empty pointVOS}">
	 		    	<c:forEach var="pointVO" items="${pointVOS}" varStatus="st">
				      <tr>
				      	<td>${st.count}</td>
				      	<td>${pointVO.point}</td>
				      	<td>
				      		${pointVO.pointReason}
				      		<c:if test="${pointVO.pointReason == '상품구매확정'}">
				      			<c:if test="${pointVO.type != '정기 구독'}">
						        	<button id="orderInfo${pointVO.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${pointVO.orderIdx}','${pointVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#41644A"></i></button>
										</c:if>
										<c:if test="${pointVO.type == '정기 구독'}">
						        	<button id="orderInfo${pointVO.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${pointVO.orderIdx}','${pointVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#41644A"></i></button>
										</c:if>
				      		</c:if>
				      		<c:if test="${pointVO.pointReason == '반품 포인트반환'}">
				      			<c:if test="${pointVO.type != '정기 구독'}">
						        	<button id="orderInfo${pointVO.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${pointVO.orderIdx}','${pointVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
										</c:if>
										<c:if test="${pointVO.type == '정기 구독'}">
						        	<button id="orderInfo${pointVO.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${pointVO.orderIdx}','${pointVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
										</c:if>
				      		</c:if>
				      		<c:if test="${pointVO.pointReason == '정기구독취소 포인트반환'}">
				      			<c:if test="${pointVO.type != '정기 구독'}">
						        	<button id="orderInfo${pointVO.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${pointVO.orderIdx}','${pointVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
										</c:if>
										<c:if test="${pointVO.type == '정기 구독'}">
						        	<button id="orderInfo${pointVO.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${pointVO.orderIdx}','${pointVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#FD8D14"></i></button>
										</c:if>
				      		</c:if>
			      		</td>
				      	<td>${fn:substring(pointVO.pointStartDate,0,10)}</td>
				      </tr>
			    	</c:forEach>
		    	</c:if>
		    	
		    	<tr><td colspan="4"></td></tr> 
		    </tbody>
		  </table>
	  </div>
	  
	  
	  <!-- 포인트 사용내역 -->
	  <div id="pointUse" class="w3-container w3-border city" style="display:none">
	    <table class="table text-center mt-3">
		    <thead>
		      <tr>
		        <th>No.</th>
		        <th>사용 포인트</th>
		        <th>사용일</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty pointUseVOS}">
		    		<tr><td colspan="3" class="text-center" style="padding:30px;">포인트 사용내역이 없습니다.</td></tr> 
		    	</c:if>
		    	<c:if test="${!empty pointUseVOS}">
	 		    	<c:forEach var="pointUseVO" items="${pointUseVOS}" varStatus="st">
				      <tr>
				      	<td>${st.count}</td>
				      	<td>
				      		${pointUseVO.usedPoint}
			      			<c:if test="${pointUseVO.type != '정기 구독'}">
					        	<button id="orderInfo${pointUseVO.idx}" style="border:0px; background-color:transparent;" onclick="orderInfo('${pointUseVO.orderIdx}','${pointUseVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#282828"></i></button>
									</c:if>
									<c:if test="${pointUseVO.type == '정기 구독'}">
					        	<button id="orderInfo${pointUseVO.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${pointUseVO.orderIdx}','${pointUseVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:17px; color:#282828"></i></button>
									</c:if>
			      		</td>
				      	<td>${fn:substring(pointUseVO.pointUseDate,0,10)}</td>
				      </tr>
			    	</c:forEach>
		    	</c:if>
		    	<tr><td colspan="3"></td></tr> 
		    </tbody>
		  </table>
	  </div>
	  
	  <!-- 뉴스레터 구독정보 -->
	  <div id="booksletter" class="w3-container w3-border city" style="display:none">
			<table class="table text-center mt-3">
				<thead>
					<tr>
						<th>No.</th>
						<th>구독 이메일</th>
						<th>구독일</th>
						<th>발송 횟수</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty booksletterVOS}">
		    		<tr><td colspan="5" class="text-center" style="padding:30px;">뉴스레터를 구독하지 않은 회원입니다.</td></tr> 
		    	</c:if>
			    <c:if test="${!empty booksletterVOS}">
						<c:forEach var="booksletterVO" items="${booksletterVOS}" varStatus="st">
							<tr>
								<td>${st.count}</td>
								<td>${booksletterVO.email}</td>
								<td>${fn:substring(booksletterVO.booksletterDate,0,10)}</td>
								<td>${booksletterVO.sendNum}&nbsp;회</td>
								<td>
									<c:if test="${booksletterVO.booksletterStatus == '구독취소'}">
										<span style="color:red">${booksletterVO.booksletterStatus}</span>
									</c:if>
									<c:if test="${booksletterVO.booksletterStatus != '구독취소'}">
										${booksletterVO.booksletterStatus}
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<tr><td colspan="5"></td></tr>
				</tbody>
			</table>
	  </div>
	  
	  <!-- 매거진 구독정보 -->
	  <div id="subscribe" class="w3-container w3-border city" style="display:none">
			<table class="table text-center mt-3">
				<thead>
					<tr>
						<th>No.</th>
						<th>구독 종류</th>
						<th>구독 기간</th>
						<th>발송 잔여 횟수</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty subscribeVOS}">
		    		<tr><td colspan="5" class="text-center" style="padding:30px;">매거진 정기구독을 신청한 이력이 없는 회원입니다.</td></tr> 
		    	</c:if>
			    <c:if test="${!empty subscribeVOS}">
						<c:forEach var="subscribeVO" items="${subscribeVOS}" varStatus="st">
							<tr>
								<td>${st.count}</td>
								<td>${subscribeVO.prodName}</td>
								<td>${fn:substring(subscribeVO.subStartDate,0,10)} ~ ${fn:substring(subscribeVO.subExpireDate,0,10)}</td>
								<td>
									${subscribeVO.subSendNum}&nbsp;회
									<button id="orderInfo${subscribeVO.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${subscribeVO.orderIdx}','${subscribeVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:18px"></i></button>
								</td>
								<td>
									<c:if test="${subscribeVO.subStatus == '구독취소신청'}">
										${subscribeVO.subStatus}<span style="color:red"><b>&nbsp;&nbsp;(구독취소 승인 처리 필요)</b></span>
									</c:if>
									<c:if test="${subscribeVO.subStatus != '구독취소신청'}">
										${subscribeVO.subStatus}
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<tr><td colspan="5"></td></tr>
				</tbody>
			</table>
	  </div>
	</div>
	
	
	
 	<!-- The Modal -->
  <div class="modal fade" id="memPhotoEditModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">프로필 사진 변경</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee; padding:30px">
          	<form name="memPhotoUpdate" method="post" action="${ctp}/community/myPage/memPhotoUpdate" enctype="multipart/form-data">
				  		<div class="row">
				  			<div class="col-8">
					  			<input type="file" name="file" id="memPhoto" onchange="imgCheck(this)" class="form-control-file border form-control"/>
				  				<input type="hidden" name="memPhoto" value="${memberVO.memPhoto}"/>
				  				<input type="hidden" name="nickname" value="${memberVO.nickname}"/>
				  				<br/><br/>
  								<label for="defaultPhotoNone"><span style="padding:20px; border-radius:50%; background-color:#ddd">직접 선택</span></label>
				  				<input type="radio" id="defaultPhotoNone" name="defaultPhoto" value="defaultPhotoNone" checked/>
				  				&nbsp;&nbsp;&nbsp;&nbsp;
  								<label for="defaultImage"><img src="${ctp}/admin/member/defaultImage.jpg" style="width:80px"/></label>
				  				<input type="radio" id="defaultImage" name="defaultPhoto" value="defaultImage.jpg"/>
				  				&nbsp;&nbsp;&nbsp;&nbsp;
				  				<c:forEach var="i" begin="1" end="6">
	  								<label for="defaultPhoto${i}"><img src="${ctp}/admin/member/defaultPhoto${i}.png" style="width:80px"/></label>
					  				<input type="radio" id="defaultPhoto${i}" name="defaultPhoto" value="defaultPhoto${i}.png" />
					  				&nbsp;&nbsp;&nbsp;&nbsp;
				  				</c:forEach>
				  			</div>
				  			<div class="col-4">
					  			<img id="photoDemo" width="200px"/>
				  			</div>
				  		</div>
				  		<input type="hidden" name="flag" value="admin"/>
          	</form>
				  </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="memPhotoEdit()">변경</button>
        </div>
        
      </div>
    </div>
  </div>
	
</body>
</html>