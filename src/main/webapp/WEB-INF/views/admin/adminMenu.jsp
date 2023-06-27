<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
		a {
			color: #282828;
		}
		a:hover {
			text-decoration:none;
			color: blue;
		}

</style>

	<!-- Top container -->
	<div class="w3-bar w3-top w3-black w3-large" style="z-index:6;">
	  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
	  <a href="${ctp}/">
	  	<span class="w3-bar-item w3-right"><img src="${ctp}/resources/images/logo.png" style="width:100%; height:100%; max-width:120px" class="w3-hover-opacity" /></span>
	  </a>
	</div>
	
	<!-- Sidebar/menu -->
	<nav class="w3-sidebar w3-collapse w3-white" style="z-index:3;width:300px;" id="mySidebar"><br>
	  <div class="w3-container w3-row" style="margin-top:50px;">
	    <div class="w3-col w3-center">
	      <%-- <img src="${ctp}/admin/member/adminPhoto.png" class="w3-circle w3-margin-right" style="width:46px"> --%>
	    </div>
	  </div>
	  <div class="w3-container w3-row">
	    <div class="w3-col w3-bar w3-center">
	      <span><strong>관리자</strong>님 반갑습니다</span><br>
			  <a href="${ctp}/admin/adminPage" class="w3-btn w3-round-xxlarge w3-black">관리자 창</a>
	    </div>
	  
	  </div>
	 	<hr style="border:1px solid #9DB2BF"/>
	  
	  <div class="w3-bar-block" style="margin-top:50px">
	    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
		  
		  <div id="accordion">
		    <div class="card">
		      <div class="card-header" style="padding:0px">
				    <a href="#collapseOne" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
				    	<i class="fa fa-users fa-fw"></i>  회원관리
			    	</a>
		      </div>
		      <div id="collapseOne" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/member/memberList">회원 정보 관리</a><hr/>
			        <a href="${ctp}/admin/member/memberPhoto">기본 프로필 사진 관리</a>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
		      	<a href="#collapseTwo" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
		     	 		<i class="fa fa-eye fa-fw"></i>  매거진
     	 			</a>
		      </div>
		      <div id="collapseTwo" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">  <!-- 판매관리로 가는 링크, 매거진 문의로 가는 링크 -->
			        <a href="${ctp}/admin/memberList">매거진 정보 관리</a><hr/>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
	  			  <a href="#collapseThree" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
	  			 		<i class="fa fa-bullseye fa-fw"></i>  3개의 책
  			  	</a>
		      </div>
		      <div id="collapseThree" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/memberList">한 줄 ___ 관리</a><hr/>
			        <a href="${ctp}/admin/memberList">등록 책 관리</a>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
	  			  <a href="#collapseFour" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
	  			 		<i class="fa fa-cog fa-fw"></i>  컬렉션
  			  	</a>
		      </div>
		      <div id="collapseFour" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/memberList">컬렉션 등록</a><hr/>
			        <a href="${ctp}/admin/memberList">컬렉션 관리</a><hr/>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
	  			  <a href="#collapseFive" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
	  			 		<i class="fa-solid fa-truck"></i>  판매 / 배송
  			  	</a>
		      </div>
		      <div id="collapseFive" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/memberList">통합 주문 관리</a><hr/>
			        <a href="${ctp}/admin/memberList">배송 처리 관리</a><hr/>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
	  			  <a href="#collapseSix" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
	  			 		<i class="fa fa-bank fa-fw"></i>  독립서점
  			  	</a>
		      </div>
		      <div id="collapseSix" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/memberList">독립서점 관리</a>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
	  			  <a href="#collapseSeven" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
	  			 		<i class="fa fa-diamond fa-fw"></i>  게임
  			  	</a>
		      </div>
		      <div id="collapseSeven" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/memberList">게임 정보 관리</a><hr/>
			        <a href="${ctp}/admin/memberList">게임 결과 조회</a>
		        </div>
		      </div>
		    </div>
		    
		    <div class="card">
		      <div class="card-header" style="padding:0px">
	  			  <a href="#collapseEight" class="collapsed card-link w3-bar-item w3-button w3-padding dropdown-toggle" data-toggle="collapse">
	  			 		<i class="fa fa-bell fa-fw"></i>  문의 / 공지 / 기타
  			  	</a>
		      </div>
		      <div id="collapseEight" class="collapse" data-parent="#accordion">
		        <div class="card-body" style="margin:10px">
			        <a href="${ctp}/admin/memberList">문의 관리</a><hr/>
			        <a href="${ctp}/admin/memberList">공지사항 관리</a>
			        <a href="${ctp}/admin/memberList">임시 파일 관리</a>
		        </div>
		      </div>
		    </div>
		    
		  </div>
	  </div>
	</nav>
	
	
	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
	
	
	<script>
	// Get the Sidebar
	var mySidebar = document.getElementById("mySidebar");
	
	// Get the DIV with overlay effect
	var overlayBg = document.getElementById("myOverlay");
	
	// Toggle between showing and hiding the sidebar, and add overlay effect
	function w3_open() {
	  if (mySidebar.style.display === 'block') {
	    mySidebar.style.display = 'none';
	    overlayBg.style.display = "none";
	  } else {
	    mySidebar.style.display = 'block';
	    overlayBg.style.display = "block";
	  }
	}
	
	// Close the sidebar with the close button
	function w3_close() {
	  mySidebar.style.display = "none";
	  overlayBg.style.display = "none";
	}
	</script>
	