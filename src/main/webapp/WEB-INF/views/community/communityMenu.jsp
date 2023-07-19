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
		/* Set the width of the sidebar to 120px */
		.w3-sidebar {width: 120px;background: #222;}
		/* Add a left margin to the "page content" that matches the width of the sidebar (120px) */
		#main {margin-left: 120px}
		/* Remove margins from "page content" on small screens */
		@media only screen and (max-width: 600px) {#main {margin-left: 0}}

  </style>
  <script>
  	'use strick';
  	
  	function nicknameCheck() {
  		if('${sNickname}' == '') {
  			alert('로그인 후 이용해주세요.');
  			return false;
  		}
  		location.href = "${ctp}/community/communityMyPage?memNickname=${sNickname}";
  	}
  </script>
</head>
<body>
<div id="back-to-top"></div>
	<!-- Icon Bar (Sidebar - hidden on small screens) -->
	<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center" style="padding-top:70px; background-color:rgba(254, 251, 232)">
	  <!-- Avatar image in top left corner -->
	  <c:if test="${empty sNickname}">
	  	비회원 입장 중입니다
	  </c:if>
	  <c:if test="${!empty sNickname}">
	  	<a href="javascript:memPage('${sNickname}')">
		  	<img src="${ctp}/admin/member/${sMemPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
		  </a>
	  </c:if>
	  <br/><br/>
	  <a href="javascript:nicknameCheck()" class="w3-bar-item w3-button w3-padding-large w3-hover-sand">
	    <i class="fa fa-user w3-xxlarge"></i>
	    <p>마이페이지</p>
	  </a>
	  <a href="${ctp}/community/reflection" class="w3-bar-item w3-button w3-padding-large w3-hover-sand">
	    <i class="fa-solid fa-pencil" style="font-size:30px"></i>
<!-- 	    <i class="fa fa-envelope w3-xxlarge"></i> -->
	    <p>기록</p>
	  </a>
	  <a href="${ctp}/community/communityMain" class="w3-bar-item w3-button w3-padding-large w3-hover-sand">
 	    <i class="fa fa-home w3-xxlarge"></i>
	    <p>홈</p>
	  </a>
	  <a href="${ctp}/" class="w3-bar-item w3-button w3-padding-large w3-hover-sand">
<!-- 	    <i class="fa fa-home w3-xxlarge"></i> -->
	    <img src="${ctp}/images/communityMenu1.png" style="width:100%; max-width:30px">
	    <p>책(의)세계로 퇴장</p>
	  </a>
	  <a href="#photos" class="w3-bar-item w3-button w3-padding-large w3-hover-sand">
	    <i class="fa fa-eye w3-xxlarge"></i>
	    <p>공지사항</p>
	  </a>
	</nav>
	
	<!-- Navbar on small screens (Hidden on medium and large screens) -->
	<div class="w3-top w3-hide-large w3-hide-medium" id="myNavbar">
	  <div class="w3-bar w3-center w3-small" style="background-color:rgba(254, 251, 232)">
	    <a href="#" class="w3-bar-item w3-button w3-hover-sand" style="width:25% !important">HOME</a>
	    <a href="#about" class="w3-bar-item w3-button w3-hover-sand" style="width:25% !important">ABOUT</a>
	    <a href="#photos" class="w3-bar-item w3-button w3-hover-sand" style="width:25% !important">PHOTOS</a>
	    <a href="#contact" class="w3-bar-item w3-button w3-hover-sand" style="width:25% !important">CONTACT</a>
	  </div>
	</div>


</body>
</html>