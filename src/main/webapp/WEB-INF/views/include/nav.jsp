<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	String memType = session.getAttribute("sMemType")==null ? "": (String) session.getAttribute("sMemType");
	pageContext.setAttribute("memType", memType);
%>
<style>
	/* .topNav {font-family: 'SUIT-Regular';}   */
/* 	.topNav {font-family: 'OTWelcomeRA';}   */
	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	.topNav {font-family: 'Noto Sans KR', sans-serif;}  

	.popup-dismiss {color:#282828}

	.notice {width:100%; height:50px; overflow:hidden;}
	.rolling {position:relative; width:100%; height:auto;}
	.rolling li {width:100%; height:50px; line-height:50px; color:#282828}
	
	.navContentForFont {
		font-weight:bold;
	}
	.navContent {
		color: black;
		font-size: 18px;
		margin-right: 7px
	}
	.navContent:hover {
		text-decoration:none;
	}
	.detailContent:hover {
		color: #9DB2BF;
	}
	
</style>
<script>
	'use strict';
	
	function memCheck(memType, flag) {
		if(memType == '') {        /* 비로그인 접근 */
			alert('로그인이 필요합니다');
			location.href = '${ctp}/member/memberLogin';
		}
		else if(flag == 'memPage') {
			location.href = '${ctp}/member/myPage';
		}
		else if(flag == 'cart') {
			location.href = '${ctp}/order/cart';
		}
	}
</script>

<div class="topNav">
<!-- 	<div class="w3-panel w3-round-xlarge" style="margin:0px; background-color:#E1ECC8"> -->
<!-- 	<div class="w3-panel w3-round-xlarge" style="margin:0px; background-color:#F5EBE0"> -->
	<div class="w3-panel w3-round-xlarge" style="margin:0px; background-color:rgba(254, 251, 232)">
		<span onclick="this.parentElement.style.display='none'" class="w3-button w3-round-xlarge w3-large w3-display-topright popup-dismiss"><i class="fa-solid fa-x"></i></span>
		<div class="notice">
			<ul class="rolling">
				<c:if test="${!empty sTempPwd}">
					<li><a href="${ctp}/member/myPage/profile"><b>현재 임시비밀번호를 발급받아 사용 중입니다. 개인정보를 확인하시고 <u>비밀번호를 변경해주세요.</u></b></a></li>
				</c:if>
				<c:if test="${!empty sPwdUpdateDate}">
					<li><a href="${ctp}/member/myPage/profile"><b>비밀번호 변경 후, 6개월이 경과되었습니다. 비밀번호를 변경해주세요.</b></a></li>
				</c:if>
				
				<c:if test="${!empty totCnt}">
					<li><a href="${ctp}/about/about">책(의)세계에 방문하신  <b>${sNickname}</b>님 환영합니다! 우리 책(의)세계에 대해 더 알아볼까요?</a></li>
				</c:if>
				<c:forEach var="noticeVO" items="${noticeVOS}">
					<li><a href="${ctp}/about/noticeDetail?idx=${noticeVO.idx}" class="link">${noticeVO.noticeTitle}</a></li>
				</c:forEach>
				<c:if test="${!empty extraNoticeVOS}">
					<c:forEach var="extraNoticeVO" items="${extraNoticeVOS}">
						<li><a href="${ctp}/about/noticeDetail?idx=${extraNoticeVO.idx}" class="link">${extraNoticeVO.noticeTitle}</a></li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>	
	

 <!-- Navbar (sit on top) -->
  <div class="w3-bar w3-white w3-card" id="myNavbar">
    <!-- Right-sided navbar links -->
    <div class="w3-cell-row">
    	<div class="w3-cell l4 m8 s9">
		  	<a href="${ctp}/" class="w3-bar-item w3-button w3-wide">
		    	<img src="${ctp}/resources/images/navLogo.png" style="width:100%; height:100%; max-width:350px" class="w3-hover-opacity">
		    </a>
    	</div>
    
	    <div class="w3-right w3-hide-small w3-cell w3-cell-middle l8 m4 s3">
	      <div class="w3-dropdown-hover w3-white mt-2" style="padding:16px">
		      <!-- <a href="#team" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent">책(의)세계란</a> -->
		      <a class="w3-hover-white w3-round-xxlarge navContent"><span class="detailContent navContentForFont">책(의)세계란</span>&nbsp;<i class="fa-solid fa-caret-down"></i></a>
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/about/about" class="w3-bar-item w3-button navContentForFont">소개</a>
		        <a href="${ctp}/about/notice" class="w3-bar-item w3-button navContentForFont">공지사항</a>
		      </div>
		    </div>
		    
	      <a href="${ctp}/magazine/magazineList" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent mt-2"><b><span class="detailContent navContentForFont">매거진</span></b></a>
	      
	      <div class="w3-dropdown-hover w3-white mt-2" style="padding:16px">
		      <!-- <a href="#team" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent">책(의)세계란</a> -->
		      <a class="w3-hover-white w3-round-xxlarge navContent"><b><span class="detailContent navContentForFont">3개의 책</span></b>&nbsp;<i class="fa-solid fa-caret-down"></i></a>
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/community/communityMain" class="w3-bar-item w3-button navContentForFont">입장</a>
		        <a href="${ctp}/community/guide" class="w3-bar-item w3-button navContentForFont">커뮤니티 가이드</a>
		      </div>
		    </div>
		    
		    
	      <a href="${ctp}/collection/collectionList" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent mt-2"><span class="detailContent navContentForFont">컬렉션</span></a>
	      <a href="${ctp}/about/ask" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent mt-2"><span class="detailContent navContentForFont">문의</span></a>
	      
	      <!-- <a href="#pricing" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent"><span class="detailContent">독립서점</span></a> -->
	      <a href="${ctp}/game/dice" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent mr-5 mt-2"><span class="detailContent navContentForFont">게임</span></a>
	      <c:if test="${memType == ''}">
		      <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent" style="padding-right:0px">
			      <span class="detailContent"><p class="w3-tooltip"><i class="fa-solid fa-person-running" style="color: #000000; font-size:25px" title="책(의)세계로 로그인"></i><br/>
			      <font size="2" class="w3-center" style="font-weight:400">로그인</font>
			      </p></span>
		      </a>
	      </c:if>
	      <c:if test="${memType != ''}">
		      <a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent"  style="padding-right:0px">
			      <span class="detailContent"><p class="w3-tooltip"><i class="fa-solid fa-person-walking-dashed-line-arrow-right" style="color: #000000; font-size:25px" title="책(의)세계에서 로그아웃"></i><br/>
			      <font size="2" class="w3-center" style="font-weight:400">로그아웃</font>
			      </p></span>
		      </a>
	      </c:if>
	      <c:if test="${memType != '관리자'}">
		      <a href="javascript:memCheck('${memType}', 'memPage')" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent" style="padding-right:0px">
			      <span class="detailContent"><p class="w3-tooltip"><i class="fa-regular fa-id-card" style="color: #557A46; font-size:25px" title="마이페이지"></i><br/>
			      <font size="2" class="w3-center" style="font-weight:400">마이페이지</font>
			      </p></span>
		      </a>
	      </c:if>
	      <c:if test="${memType == '관리자'}">
		      <a href="${ctp}/admin/adminPage" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent" style="padding-right:0px">
			      <span class="detailContent"><p class="w3-tooltip"><i class="fa-regular fa-id-card" style="color: #07689F; font-size:25px" title="마이페이지"></i><br/>
			      <font size="2" class="w3-center" style="font-weight:400" color="#07689F">관리자창</font>
			      </p></span>
		      </a>
	      </c:if>
	      <a href="javascript:memCheck('${memType}', 'cart')" class="w3-bar-item w3-button w3-hover-white w3-round-xxlarge navContent">
		      <span class="detailContent"><p class="w3-tooltip"><i class="fa-solid fa-cart-shopping" style="color: #000000; font-size:25px" title="장바구니"></i>
		      <br/>
		      <font size="2" class="w3-center" style="font-weight:400">장바구니
		      	<c:if test="${sCartNum != 0}"><span class="badge badge-pill badge-success">${sCartNum}</span></c:if>
	      	</font>
		      </p></span>
	      </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div>
		</div>
		
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>


	<!-- Sidebar on small screens when clicking the menu icon -->
	<nav class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large" style="display:none" id="mySidebar">
	  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">Close ×</a>
	  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">ABOUT</a>
	  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">TEAM</a>
	  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">WORK</a>
	  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">PRICING</a>
	  <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button">CONTACT</a>
	</nav>

</div>


<script>
	$(document).ready(function(){
		var height =  $(".notice").height();  //공지사항의 높이값을 구해주고~~
		var num = $(".rolling li").length;    // 공지사항의 개수를 알아볼수 있어요! length라는 것으로!
		var max = height * num;               //그렇다면 총 높이를 알 수 있겠죠 ?
		var move = 0;                         //초기값을 설정해줍니다.
		function noticeRolling(){
			move += height;                     //여기에서 += 이라는 것은 move = move + height 값이라는 뜻을 줄인 거에요.
			$(".rolling").animate({"top":-move},1000,function(){ // animate를 통해서 부드럽게 top값을 올려줄거에요.
				if( move >= max ){         //if문을 통해 최대값보다 top값을 많이 올렸다면 다시 !
					$(this).css("top",0);           //0으로 돌려주고~
					move = 0;                       //초기값도 다시 0으로!
				};
			});
		};
		noticeRollingOff = setInterval(noticeRolling,3500); //자동롤링답게 setInterval를 사용해서 1000 = 1초마다 함수 실행!!
		$(".rolling").append($(".rolling li").first().clone()); //올리다보면 마지막이 안보여서 clone을 통해 첫번째li 복사!
	
		$(".rolling_stop").click(function(){
			clearInterval(noticeRollingOff); //stop을 누르면 clearInterval을 통해 자동롤링을 해제합니다.
		});
		$(".rolling_start").click(function(){
			noticeRollingOff = setInterval(noticeRolling,1000); //다시 start를 누르면 자동롤링이 실행하도록 !!
		});
	});

	// Toggle between showing and hiding the sidebar when clicking the menu icon
	var mySidebar = document.getElementById("mySidebar");
	
	function w3_open() {
	  if (mySidebar.style.display === 'block') {
	    mySidebar.style.display = 'none';
	  } else {
	    mySidebar.style.display = 'block';
	  }
	}
	
	// Close the sidebar with the close button
	function w3_close() {
	    mySidebar.style.display = "none";
	}

</script>
	