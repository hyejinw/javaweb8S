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
	</script>
</head>
<body>
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">주문 관리 유의사항</div>
			<div style="padding:20px">
				- 결제완료 <i class="fa-solid fa-caret-right"></i> 배송준비중 <i class="fa-solid fa-caret-right"></i> 배송중 <i class="fa-solid fa-caret-right"></i> 
				배송완료 <br/>
	      - 반품은 배송완료 후, 7일 이내에 신청가능합니다.<br/>
	      - 반품신청 <i class="fa-solid fa-caret-right"></i> 반품처리중 <i class="fa-solid fa-caret-right"></i> 반품완료<br/>
			</div>
			</div>
		</div>
	</div>
	
	<div class="w3-container" style="margin-bottom:50px">
	  <div class="w3-bar w3-light-grey">
	    <button class="w3-bar-item w3-button tablink w3-black" onclick="openCity(event,'member')">회원정보</button>
	    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'address')">배송지 주소록</button>
	    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'point')">포인트 적립내역</button>
	    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'pointUse')">포인트 사용내역</button>
	    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'booksletter')">뉴스레터 구독</button>
	    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'subscribe')">매거진 정기구독</button>
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
	        <td><img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px"/></td>
	      </tr>
	      <tr>
	        <th class="text-center">(3개의 책 커뮤니티)<br/>소개글</th>
	        <td>${memberVO.introduction}</td>
	      </tr>
	      <c:if test="${memberVO.memberDel == '탈퇴'}">
		      <tr>
		        <th class="text-center">탈퇴 사유</th>
		        <td>
		        	<textarea rows="4" class="form-control">${memberVO.memberDelReason}</textarea>
		        </td>
		      </tr>
	      </c:if>
	      <c:if test="${memberVO.memberDel != '탈퇴'}">
		      <tr>
		        <th class="text-center"><span style="color:red">강제</span> 탈퇴처리 사유</th>
		        <td>
		        	<textarea rows="4" id="memberDelReason" class="form-control" placeholder="강제 탈퇴처리는 철회될 수 없습니다. 신중히 처리해주세요."></textarea>
		        	<div class="text-right">
			        	<button type="button" class="btn btn-sm btn-dark mt-2 mr-3" onclick="memberForcedDelete()">탈퇴</button>
		        	</div>
		        </td>
		      </tr>
	      </c:if>
		  </table>
	    
	  </div>
	
	  <div id="address" class="w3-container w3-border city" style="display:none">
	    <h2>Paris</h2>
	    <p>Paris is the capital of France.</p> 
	  </div>
	
	  <div id="point" class="w3-container w3-border city" style="display:none">
	    <h2>Tokyo</h2>
	    <p>Tokyo is the capital of Japan.</p>
	  </div>
	  <div id="pointUse" class="w3-container w3-border city" style="display:none">
	    <h2>Tokyo</h2>
	    <p>Tokyo is the capital of Japan.</p>
	  </div>
	  <div id="booksletter" class="w3-container w3-border city" style="display:none">
	    <h2>Tokyo</h2>
	    <p>Tokyo is the capital of Japan.</p>
	  </div>
	  <div id="subscribe" class="w3-container w3-border city" style="display:none">
	    <h2>Tokyo</h2>
	    <p>Tokyo is the capital of Japan.</p>
	  </div>
	</div>
	
	
	
</body>
</html>