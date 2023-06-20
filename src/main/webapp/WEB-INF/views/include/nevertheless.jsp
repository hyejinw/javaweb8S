<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	/* .topNav {font-family: 'SUIT-Regular';}   */
	.topNav {font-family: 'OTWelcomeRA';}  

	.popup-dismiss {color:white}

	.notice {width:100%; height:50px; overflow:hidden;}
	.rolling {position:relative; width:100%; height:auto;}
	.rolling li {width:100%; height:50px; line-height:20px; color:white}
	
	.navContent {
		color: black;
		font-size: 17px;
		margin-right: 10px
	}
	
	
</style>
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
		noticeRollingOff = setInterval(noticeRolling,5000); //자동롤링답게 setInterval를 사용해서 1000 = 1초마다 함수 실행!!
		$(".rolling").append($(".rolling li").first().clone()); //올리다보면 마지막이 안보여서 clone을 통해 첫번째li 복사!
	
		$(".rolling_stop").click(function(){
			clearInterval(noticeRollingOff); //stop을 누르면 clearInterval을 통해 자동롤링을 해제합니다.
		});
		$(".rolling_start").click(function(){
			noticeRollingOff = setInterval(noticeRolling,1000); //다시 start를 누르면 자동롤링이 실행하도록 !!
		});
	});
</script>
<div class="topNav">
	<!-- Navbar (sit on top) -->
	<div class="w3-panel w3-round-xlarge" style="margin:0px; background-color:#191919">
		<span onclick="this.parentElement.style.display='none'" class="w3-button w3-round-xlarge w3-large w3-display-topright popup-dismiss">&nbsp;X&nbsp;</span>
		<div class="notice">
			<ul class="rolling">
				<li><a href="#" class="link">[공지] 공지1 알려드립니다.</a></li>
				<li><a href="#" class="link">[공지] 공지2 알려드립니다.</a></li>
			</ul>
		</div>
	</div>	
	
	<div>
	  
		<div class="w3-row w3-border">
			<div class="w3-twothird w3-container">
			</div>
			<div class="w3-third w3-container w3-cell w3-cell-bottom">
		  	<div class="w3-tag w3-round w3-green w3-right" style="padding:3px">
			    <div class="w3-tag w3-round w3-green w3-border w3-border-white">
			     	로 입장
			    </div>
 			 </div>
		</div>
	    <!-- Right-sided navbar links -->
	  <div class="w3-bar w3-card" id="myNavbar" style="background-color:#FAFAFA; margin-top:50px; padding:10px 30px 10px 10px">
	<!--   <div class="w3-bar w3-black w3-card" id="myNavbar"> -->
			<div>
				<a href="${ctp}/" class="justify-content-center"><img src="${ctp}/resources/images/logo.png" style="width:100%; height:100%; padding:15px; max-width:600px" class="w3-hover-opacity"></a>
			</div>
	    <div class="w3-hide-small">
	      <a href="#about" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>매거진</b></a>
	      <a href="#team" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>책(의)세계란</b></a>
	      <a href="#team" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>3개의 책</b></a>
	      <a href="#work" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>컬렉션</b></a>
	      <a href="#pricing" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>독립서점</b></a>
	      <a href="#contact" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>뉴스레터</b></a>
	      <a href="#contact" class="w3-bar-item w3-button w3-round-xxlarge navContent"><b>게임</b></a>
	    </div>
	    <!-- Hide right-floated links on small screens and replace them with a menu icon -->
	
	    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
	      <i class="fa fa-bars"></i>
	    </a>
	  </div>
		
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
</div>
	