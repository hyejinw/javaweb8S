<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>책(의)세계</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  	.w3-row-padding img {margin-bottom: 12px}
		/* Set the width of the sidebar to 120px */
		.w3-sidebar {width: 120px;background: #222;}
		/* Add a left margin to the "page content" that matches the width of the sidebar (120px) */
		#main {margin-left: 120px}
		/* Remove margins from "page content" on small screens */
		@media only screen and (max-width: 600px) {#main {margin-left: 0}}

		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}

  	#back-to-top {
		  display: inline-block;
		  background-color: #282828;
		  width: 50px;
		  height: 50px;
		  text-align: center;
		  border-radius: 4px;
		  position: fixed;
		  bottom: 30px;
		  right: 30px;
		  transition: background-color .3s, opacity .5s, visibility .5s;
		  opacity: 0;
		  visibility: hidden;
		  z-index: 1000;
		}
		#back-to-top::after {
		  content: "\f077";
		  font-family: FontAwesome;
		  font-weight: normal;
		  font-style: normal;
		  font-size: 2em;
		  line-height: 50px;
		  color: #fff;
		}
		#back-to-top:hover {
		  cursor: pointer;
		  text-decoration: none;
		  background-color: #333;
		}
		#back-to-top:active {
		  background-color: #555;
		}
		#back-to-top.show {
		  opacity: 1;
		  visibility: visible;
		}
		.nowPart {
     color : #282828;
     font-weight: bold;
     border-bottom: 5px solid #282828;
     padding-bottom:14px;
    }
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px;
    }
  </style>
  <script>
		'use strict';
	
		// 맨 위로 스크롤
		$(function(){
	 		$('#back-to-top').on('click',function(e){
	     	e.preventDefault();
	     		$('html,body').animate({scrollTop:0},600);
	  	});
	  
	 		$(window).scroll(function() {
	    	if ($(document).scrollTop() > 100) {
	    		$('#back-to-top').addClass('show');
	    	} else {
	    		$('#back-to-top').removeClass('show');
	   		}
	  	});
		});
		
		function bookSaveOpen(id) {
		  var x = document.getElementById(id);
		  if (x.className.indexOf("w3-show") == -1) {
		    x.className += " w3-show";
		  } else { 
		    x.className = x.className.replace(" w3-show", "");
		  }
		}
  </script>
</head>
<body>
<div id="back-to-top"></div>
<jsp:include page="/WEB-INF/views/community/communityMenu.jsp" />
	
	<!-- Page Content -->
	<div id="main">
		<a href="${ctp}/community/communityMain">
			<img src = "${ctp}/images/communityBanner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div class="row">
					<div class="col ml-5">
						<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="text-center" style="font-size:20px; text-align:center; font-weight:bold">${memberVO.nickname}</span>
					</div>
					<div class="col text-right mr-5">
						<c:if test="${memberVO.nickname == sNickname}">
							<button class="btn btn-secondary">로그아웃</button>
						</c:if>
					</div>
				</div>
				
				<div style="margin-top:100px">
					<a href="${ctp}/community/communityMyPage?memNickname=${memberVO.nickname}"><span class="nowPart mr-5">서재 / 문장수집</span></a>
					<a href="${ctp}/community/communityMyPage/reflection?memNickname=${memberVO.nickname}"><span class="mr-5">기록</span></a>
					<a href="${ctp}/community/communityMyPage/reply?memNickname=${memberVO.nickname}"><span class="mr-5">작성 댓글</span></a>
					<c:if test="${memberVO.nickname == sNickname}">
						<a href="${ctp}/community/communityMyPage/memInfo?memNickname=${memberVO.nickname}"><span class="mr-5">회원 정보</span></a>
						<a href="${ctp}/community/communityMyPage/ask?memNickname=${memberVO.nickname}"><span>문의 / 신고</span></a>
					</c:if>
					<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
				</div>
	 		</div>
	 		
	 		<div style="padding:20px 50px 50px 50px;">
	 			<div>
					<div>
						<i class="fa-solid fa-book-bookmark" style="font-size:50px;"></i>
						<span style="font-size:30px; margin-left:20px">책장</span>
					</div> 			
		 			<div style="margin:50px 0px 0px 0px">
		 				<div class="row">
		 					<div class="col-8">
				 				<button onclick="bookSaveOpen('bookSave1')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">인생책&nbsp;&nbsp;&nbsp;(${bookSave1VOSNum} / 30)</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>내 인생에 영향을 준 책 30권</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<button class="btn btn-outline-dark btn-sm" id="bookSave1BtnDone" onclick="bookSaveOpen('bookSave1')">편집</button>
		 						<button class="btn btn-outline-dark btn-sm" id="bookSave1BtnDone" style="display:none">완료</button>
		 					</div>
		 				</div>
						
						<div id="bookSave1" class="w3-container w3-hide">
							<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>
						  <div id="infoBox" class="text-center">
			  			<c:set var="bookSave1VOcnt" value="${0}"/>
					  	<c:forEach var="bookSave1VO" items="${bookSave1VOS}" varStatus="st">
					  		<span>
				  				<img src="${bookSave1VO.thumbnail}" style="margin:15px"/><br/>
				  				<span>${bookSave1VO.title}</span>
					  		</span>
			  				<c:set var="bookSave1VOcnt" value="${bookSave1VOcnt + 1}"/>
				  			<c:if test="${bookSave1VOcnt % 8 == 0}">
									<br/>
								</c:if>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
		 			
		 				<div class="row">
		 					<div class="col-8">
				 				<button onclick="bookSaveOpen('bookSave2')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">추천책&nbsp;&nbsp;&nbsp;(${bookSave2VOSNum} / 99)</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>알리고 싶은 좋은 책 99권</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<button class="btn btn-outline-dark btn-sm" id="bookSave2BtnEdit" onclick="bookSaveOpen('bookSave2')">편집</button>
		 						<button class="btn btn-outline-dark btn-sm" id="bookSave2BtnDone" style="display:none">완료</button>
		 					</div>
		 				</div>
						
						<div id="bookSave2" class="w3-container w3-hide">
							<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>
						  <div id="infoBox" class="text-center">
			  			<c:set var="bookSave2VOcnt" value="${0}"/>
					  	<c:forEach var="bookSave1VO" items="${bookSave2VOS}" varStatus="st">
			  				<img src="${bookSave2VO.thumbnail}" style="margin:15px"/>
			  				<c:set var="bookSave2VOcnt" value="${bookSave2VOcnt + 1}"/>
				  			<c:if test="${bookSave2VOcnt % 8 == 0}">
									<br/>
								</c:if>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
		 			
		 			
		 			</div>
	 			</div>
	 		</div>
	 		
	 		
 		</div>
		
	  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>