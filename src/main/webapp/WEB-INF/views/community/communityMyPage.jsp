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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
			display:grid;
			grid-template-columns:repeat(7,1fr);
			grid-gap:48px 24px;
			padding:0 2%;
		}
		@media screen and (max-width: 1770px) {
			.infoBox{
				display:grid;
				grid-template-columns:repeat(6,1fr);
				grid-gap:48px 24px;
			}
		}
		@media screen and (max-width: 1440px) {
			.infoBox{
				display:grid;
				grid-template-columns:repeat(4,1fr);
				grid-gap:48px 24px;
			}
		}
		@media screen and (max-width: 1200px) { 
			.infoBox{
				display:grid;
				grid-template-columns:repeat(2,1fr);
				grid-gap:48px 24px;
			}
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
		
		// 책 검색 관련해, location.reload() 되었다면 그 상태 유지
		$(document).ready(function(){
			if(sessionStorage.getItem('bookSelectionSW') != null) {
				let sw = sessionStorage.getItem('bookSelectionSW');
				sessionStorage.removeItem('bookSelectionSW');
				document.getElementById('bookSaveBtnEdit'+sw).click();
			}
		});
		
		// 책 자료 검색 내용이 있다면 띄워주기
		$(document).ready(function() {
			if(${bookVOS != null}) {
				document.getElementById('bookBtn1').click();
				$('#demo').css("display","block");
			}
		});
		
		// 책 검색 모달로 값 넘기기
		function bookSelectOpen(categoryName) {
			document.getElementById('selectedCategoryName').value = categoryName;
		}
		
		// 책 자료 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	location.href = "${ctp}/community/communityMyPage?searchString="+searchString+"&memNickname=${memberVO.nickname}";
		}
		
		// 책 선택
		function bookSelection(title, publisher) {
    	let ans = confirm('책을 추가하시겠습니까?');
			if(!ans) return false;
			
			let categoryName = document.getElementById('selectedCategoryName').value;
			
			let sw = 0;
			if(categoryName == '인생책') sw = 1;
			else if(categoryName == '추천책') sw = 2;
			else if(categoryName == '읽은책') sw = 3;
			else sw = 4;
				
			$.ajax({
				type : "post",
				url : "${ctp}/community/bookSaveInsert",
				data : {
					memNickname : '${sNickname}',
					title : title,
					publisher : publisher,
					categoryName : categoryName
				},
				success : function() {
					alert('책이 추가되었습니다.');
					sessionStorage.setItem('bookSelectionSW', sw); 
					location.href = "${ctp}/community/communityMyPage?memNickname=${memberVO.nickname}";
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 책 저장 카테고리별 열기
		function bookSaveOpen(id) {
		  var x = document.getElementById(id);
		  if (x.className.indexOf("w3-show") == -1) {
		    x.className += " w3-show";
		  } else { 
		    x.className = x.className.replace(" w3-show", "");
		  }
		}
		
		// 책 저장 카테고리별 열기
		function bookSaveEditOpen(id, flag) {
		  var x = document.getElementById(id);
		  if (x.className.indexOf("w3-show") == -1) {
		    x.className += " w3-show";
		  } else { 
		    x.className = x.className.replace(" w3-show", "");
		  }
		  document.getElementById('bookSaveOpen'+flag).disabled = true;
		  
		  $('.bookEditBtn'+flag).css('display','block');
		  $('#bookSaveUpdate'+flag).css('display','block');
		  $('#bookSaveBtnDone'+flag).css('display','inline-block');
		  $('#bookSaveBtnEdit'+flag).css('display','none');
		}
		
		// 책 저장 카테고리별 닫기
		function bookSaveEditClose(id, flag) {
		  var x = document.getElementById(id);
		  if (x.className.indexOf("w3-show") == -1) {
		    x.className += " w3-show";
		  } else { 
		    x.className = x.className.replace(" w3-show", "");
		  }
		  document.getElementById('bookSaveOpen'+flag).disabled = false;
		  
		  $('.bookEditBtn'+flag).css('display','none');
		  $('#bookSaveUpdate'+flag).css('display','none');
		  $('#bookSaveBtnDone'+flag).css('display','none');
		  $('#bookSaveBtnEdit'+flag).css('display','inline-block');
		}
		
		// 책 저장 카테고리 변경
		function bookSaveCategoryChange(sw, categoryName, idx, bookIdx) {
			
			if(categoryName == '인생책') {
				if(${bookSave1VOSNum} >= 30) {
					alert('인생책 저장공간이 가득 찼습니다.');
					return false;
				}
			}
			if(categoryName == '추천책') {
				if(${bookSave1VOSNum} >= 99) {
					alert('추천책 저장공간이 가득 찼습니다.');
					return false;
				}
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/bookSaveCategoryChange",
				data : {
					memNickname : '${sNickname}',
					idx : idx,
					bookIdx : bookIdx,
					categoryName : categoryName
				},
				success : function() {
					alert(categoryName+'으로 이동됐습니다.');
					sessionStorage.setItem('bookSelectionSW', sw); 
					location.href = "${ctp}/community/communityMyPage?memNickname=${memberVO.nickname}";
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 책 저장 삭제
		function bookSaveDelete(sw, idx) {
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/bookSaveDelete",
				data : { idx : idx },
				success : function() {
					alert('책이 삭제되었습니다.');
					sessionStorage.setItem('bookSelectionSW', sw); 
					location.href = "${ctp}/community/communityMyPage?memNickname=${memberVO.nickname}";
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
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
				 				<button id="bookSaveOpen1" onclick="bookSaveOpen('bookSave1')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">인생책&nbsp;&nbsp;&nbsp;(${bookSave1VOSNum} / 30)</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>내 인생에 영향을 준 책 30권</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit1" onclick="bookSaveEditOpen('bookSave1', '1')">편집</button>
		 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone1" onclick="bookSaveEditClose('bookSave1', '1')" style="display:none">완료</button>
		 					</div>
		 				</div>
						
						<div id="bookSave1" class="w3-container w3-hide">
							<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>
						  <div class="infoBox text-center" style="margin:30px 0px">
						  <c:if test="${bookSave1VOSNum < 30}">
						  	<div id="bookSaveUpdate1" style="display:none;">
							  	<a href="#" id="bookBtn1" onclick="bookSelectOpen('인생책')" data-toggle="modal" data-target="#myModal">
								  	<div style="width:120px; height:174px; background-color:#eee; margin-left:auto; margin-right:auto;">
								  		<i class="fa-solid fa-plus" style="font-size:30px; line-height: 5.5;"></i>
								  	</div>
							  	</a>
						  	</div>
						  </c:if>
					  	<c:forEach var="bookSave1VO" items="${bookSave1VOS}" varStatus="st">
					  		<div>
				  				<a href="javascript:bookPage(${bookSave1VO.idx})"><img src="${bookSave1VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave1VO.idx})"><span style="color:grey"><b>${bookSave1VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn1" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('1','추천책','${bookSave1VO.idx}','${bookSave1VO.bookIdx}')">추천책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('1','읽은책','${bookSave1VO.idx}','${bookSave1VO.bookIdx}')">읽은책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('1','관심책','${bookSave1VO.idx}','${bookSave1VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('1','${bookSave1VO.idx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
		 				<div class="row">
		 					<div class="col-8">
				 				<button id="bookSaveOpen2" onclick="bookSaveOpen('bookSave2')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">추천책&nbsp;&nbsp;&nbsp;(${bookSave2VOSNum} / 99)</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>알리고 싶은 좋은 책 99권</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit2" onclick="bookSaveEditOpen('bookSave2', '2')">편집</button>
		 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone2" onclick="bookSaveEditClose('bookSave2', '2')" style="display:none">완료</button>
		 					</div>
		 				</div>
						
						<div id="bookSave2" class="w3-container w3-hide">
							<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>
						  <div class="infoBox text-center" style="margin:30px 0px">
						  <c:if test="${bookSave2VOSNum < 99}">
						  	<div id="bookSaveUpdate2" style="display:none;">
							  	<a href="#" id="bookBtn2" onclick="bookSelectOpen('추천책')" data-toggle="modal" data-target="#myModal">
								  	<div style="width:120px; height:174px; background-color:#eee; margin-left:auto; margin-right:auto;">
								  		<i class="fa-solid fa-plus" style="font-size:30px; line-height: 5.5;"></i>
								  	</div>
							  	</a>
						  	</div>
						  </c:if>
					  	<c:forEach var="bookSave2VO" items="${bookSave2VOS}" varStatus="st">
					  		<div>
				  				<a href="javascript:bookPage(${bookSave2VO.idx})"><img src="${bookSave2VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave2VO.idx})"><span style="color:grey"><b>${bookSave2VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn2" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('2','인생책','${bookSave2VO.idx}','${bookSave2VO.bookIdx}')">인생책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('2','읽은책','${bookSave2VO.idx}','${bookSave2VO.bookIdx}')">읽은책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('2','관심책','${bookSave2VO.idx}','${bookSave2VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('2','${bookSave2VO.idx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
		 				<div class="row">
		 					<div class="col-8">
				 				<button id="bookSaveOpen3" onclick="bookSaveOpen('bookSave3')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">읽은책&nbsp;&nbsp;&nbsp;(${bookSave3VOSNum})</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>읽었어요. 같이 이야기해요</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit3" onclick="bookSaveEditOpen('bookSave3', '3')">편집</button>
		 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone3" onclick="bookSaveEditClose('bookSave3', '3')" style="display:none">완료</button>
		 					</div>
		 				</div>
						
						<div id="bookSave3" class="w3-container w3-hide">
							<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>
						  <div class="infoBox text-center" style="margin:30px 0px">
						  	<div id="bookSaveUpdate3" style="display:none;">
							  	<a href="#" id="bookBtn3" onclick="bookSelectOpen('읽은책')" data-toggle="modal" data-target="#myModal">
								  	<div style="width:120px; height:174px; background-color:#eee; margin-left:auto; margin-right:auto;">
								  		<i class="fa-solid fa-plus" style="font-size:30px; line-height: 5.5;"></i>
								  	</div>
							  	</a>
						  	</div>
					  	<c:forEach var="bookSave3VO" items="${bookSave3VOS}" varStatus="st">
					  		<div>
				  				<a href="javascript:bookPage(${bookSave3VO.idx})"><img src="${bookSave3VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave3VO.idx})"><span style="color:grey"><b>${bookSave3VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn3" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('3','인생책','${bookSave3VO.idx}','${bookSave3VO.bookIdx}')">인생책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('3','추천책','${bookSave3VO.idx}','${bookSave3VO.bookIdx}')">추천책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('3','관심책','${bookSave3VO.idx}','${bookSave3VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('3','${bookSave3VO.idx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
							
		 				<div class="row">
		 					<div class="col-8">
				 				<button id="bookSaveOpen4" onclick="bookSaveOpen('bookSave4')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">추천책&nbsp;&nbsp;&nbsp;(${bookSave4VOSNum})</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>아직 읽지 않았지만 관심있어요</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit4" onclick="bookSaveEditOpen('bookSave4', '4')">편집</button>
		 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone4" onclick="bookSaveEditClose('bookSave4', '4')" style="display:none">완료</button>
		 					</div>
		 				</div>
						
						<div id="bookSave4" class="w3-container w3-hide">
							<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>
						  <div class="infoBox text-center" style="margin:30px 0px">
						  	<div id="bookSaveUpdate4" style="display:none;">
							  	<a href="#" id="bookBtn4" onclick="bookSelectOpen('관심책')" data-toggle="modal" data-target="#myModal">
								  	<div style="width:120px; height:174px; background-color:#eee; margin-left:auto; margin-right:auto;">
								  		<i class="fa-solid fa-plus" style="font-size:30px; line-height: 5.5;"></i>
								  	</div>
							  	</a>
						  	</div>
					  	<c:forEach var="bookSave4VO" items="${bookSave4VOS}" varStatus="st">
					  		<div>
				  				<a href="javascript:bookPage(${bookSave4VO.idx})"><img src="${bookSave4VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave4VO.idx})"><span style="color:grey"><b>${bookSave4VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn4" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('4','인생책','${bookSave4VO.idx}','${bookSave4VO.bookIdx}')">인생책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('4','추천책','${bookSave4VO.idx}','${bookSave4VO.bookIdx}')">추천책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('4','관심책','${bookSave4VO.idx}','${bookSave4VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('4','${bookSave4VO.idx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
		 			
		 			</div>
	 			</div>
	 		</div>
	 		
	 		
 		</div>
		
	<!-- 책 자료 검색 -->	
 	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="margin:10px 100px 10px 100px">
	          <form name="searchForm">
	          	<div class="input-group">
					      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요" />
					      <div class="input-group-append">
					     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#0cc621;"></i></a>
					     	</div>
				     	</div>
				    </form>
			    </div>
			    <div id="demo" style="display:none;">
			  	  <hr/>
			  	  <c:if test="${empty bookVOS}">
			  	  	<div class="container text-center"><br/>관련 도서가 없습니다 😲</div>
			  	  </c:if>
			  	  <c:if test="${!empty bookVOS}">
				  	  <c:forEach var="bookVO" items="${bookVOS}">
			  	  		<div class="row">
			  	  			<div class="col-3 text-center"><a href="${bookVO.url}" target="_blank"><img src="${bookVO.thumbnail}"/></a></div>
			  	  			<div class="col-7 text-center">
			  	  				<div class="row"><div class="col"><a href="${bookVO.url}" target="_blank"><b>${bookVO.title}</b></a></div></div>
			  	  				<div class="row"><div class="col">${bookVO.authors}&nbsp;&nbsp; | &nbsp;&nbsp;${bookVO.publisher}</div></div>
			  	  				<div class="row m-3"><div class="col">${bookVO.contents}...</div></div>
			  	  			</div>
			  	  			<div class="col-2 text-center">
			  	  				<button class="btn btn-outline-primary" onclick="bookSelection('${bookVO.title}', '${bookVO.publisher}')" data-dismiss="modal">선택</button>
			  	  			</div>
			  	  		</div>
								<hr/>				
				  	  </c:forEach>
			  	  </c:if>
			  	  <input type="hidden" id="selectedCategoryName"/>
					</div>
        </div>
        
      </div>
    </div>
  </div>
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>