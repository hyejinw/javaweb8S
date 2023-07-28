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
		.save:hover {
			cursor: pointer;
		}
		.contentBox{
		  display:table;
		  table-layout:fixed;
		  width:100%;
		  max-width:600px;
		  height:100px;
		  background:#ddd;
		  text-align:center;
		  margin-left: auto; 
		  margin-right: auto;
		  margin-top: 10px;
		}
		.contentBox__item{
		  display:table-cell;
		  vertical-align:middle;
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
				document.getElementById('bookSaveOpen'+sw).click();
				document.getElementById('bookSaveBtnEdit'+sw).click();
				
				if(${bookVOS != null}) {
					document.getElementById('bookBtn'+sw).click();
					$('#demo').css("display","block");
				}
				
				sessionStorage.removeItem('bookSelectionSW');
			}
				
			// 문장수집 등록용 책 검색
			if(sessionStorage.getItem('inspiredSW') == 'ON') {
				sessionStorage.removeItem('inspiredSW');
				document.getElementById('bookInsertSelectBtn').click();
				$('#insDemo').css("display","block");
			}
		});
		
		// 책 자료 검색 내용이 있다면 띄워주기
/* 		$(document).ready(function() {
			if(${bookVOS != null}) {
				
				document.getElementById('bookBtn2').click();
				$('#demo').css("display","block");
			}
		});
		 */
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
    	let categoryName = document.getElementById('selectedCategoryName').value;
			let sw = 0;
			if(categoryName == '인생책') sw = 1;
			else if(categoryName == '추천책') sw = 2;
			else if(categoryName == '읽은책') sw = 3;
			else sw = 4;
			sessionStorage.setItem('bookSelectionSW', sw); 
			
    	location.href = "${ctp}/community/myPage?searchString="+searchString+"&memNickname=${memberVO.nickname}";
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
					location.href = "${ctp}/community/myPage?memNickname=${memberVO.nickname}";
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		
		// 문장수집용 책 자료 검색
		function inspiredSearchCheck() {
			let inspiredSearchString = $("#inspiredSearchString").val();
	    	
    	if(inspiredSearchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		inspiredSearchForm.inspiredSearchString.focus();
    		return false;
    	}
    	
			sessionStorage.setItem('inspiredSW', 'ON'); 
			
    	location.href = "${ctp}/community/myPage?inspiredSearchString="+inspiredSearchString+"&memNickname=${memberVO.nickname}";
		}
		
		// 문장수집용 책 선택
		function insBookSelection(title, publisher, authors) {
    	let ans = confirm('해당 책을 선택하시겠습니까?');
			if(!ans) return false;
			
			document.getElementById('bookTitle').value = title;
			document.getElementById('publisher').value = publisher;
			document.getElementById('authors').value = authors;
			
		  $('#bookInsertSelectDone').css('display','block');
		  $('#bookInsertSelectEdit').css('display','none');
		}
		
		$(document).ready(function() {
			$('#bookSaveBtnEdit1').attr("disabled", true);
			$('#bookSaveBtnEdit2').attr("disabled", true);
			$('#bookSaveBtnEdit3').attr("disabled", true);
			$('#bookSaveBtnEdit4').attr("disabled", true);
		});
		
		
		// 책 저장 카테고리별 열기
		function bookSaveOpen(id, flag) {
		  var x = document.getElementById(id);
		  if (x.className.indexOf("w3-show") == -1) {
		    x.className += " w3-show";
		    $('#bookSaveBtnEdit'+flag).attr("disabled", false);
		  } else { 
		    x.className = x.className.replace(" w3-show", "");
		    $('#bookSaveBtnEdit'+flag).attr("disabled", true);
		  }
		}
		
		// 책 저장 카테고리별 수정 열기
		function bookSaveEditOpen(id, flag) {
		  document.getElementById('bookSaveOpen'+flag).disabled = true;
		  
		  $('.bookEditBtn'+flag).css('display','inline-block');
		  $('#bookSaveUpdate'+flag).css('display','block');
		  $('#bookSaveBtnDone'+flag).css('display','inline-block');
		  $('#bookSaveBtnEdit'+flag).css('display','none');
		}
		
		// 책 저장 카테고리별 수정 닫기
		function bookSaveEditClose(id, flag) {
		  document.getElementById('bookSaveOpen'+flag).disabled = false;
		  
		  $('.bookEditBtn'+flag).css('display','none');
		  $('#bookSaveUpdate'+flag).css('display','none');
		  $('#bookSaveBtnDone'+flag).css('display','none');
		  $('#bookSaveBtnEdit'+flag).css('display','inline-block');
		  
		  bookSaveOpen(id, flag);
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
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 책 저장 삭제
		function bookSaveDelete(sw, idx, bookIdx) {
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/bookSaveDelete",
				data : {
					idx : idx,
					bookIdx : bookIdx
				},
				success : function() {
					alert('책이 삭제되었습니다.');
					sessionStorage.setItem('bookSelectionSW', sw); 
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 로그아웃
		function logout() {
			let ans = confirm('책(의)세계에서 로그아웃하시겠습니까?');
			if(!ans) return false;
			
			location.href = "${ctp}/member/memberLogout";
		}
		
		function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/community/myPage?pag=${pageVO.pag}&pageSize="+pageSize+"&memNickname=${memberVO.nickname}";
    }
		
		// 문장수집 저장
		function insSave(insIdx, insSaveIdx) {
			
			if('${sNickname}' == "") {
				alert('로그인 후 사용해주세요.');
				return false;
			}
			
			if(insSaveIdx == 0) {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/insSave",
	    		data  : {
					  memNickname  : '${sNickname}',
					  insIdx : insIdx
					},
	    		success:function() {
	    			alert("문장수집이 저장되었습니다.");
	    			location.href = "${ctp}/community/myPage?memNickname=${memberVO.nickname}";
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
			else {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/insSaveDelete",
	    		data  : {
	    			memNickname  : '${sNickname}',
	    			insIdx : insIdx,
	    			idx : insSaveIdx
					},
	    		success:function() {
	    			alert("문장수집 저장이 취소되었습니다.");
	    			location.href = "${ctp}/community/myPage?memNickname=${memberVO.nickname}";
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
		}
		
		// 문장 수집 삭제
		function inspiredDelete(inspiredIdx) {
			let ans = confirm('삭제 후 복구 불가능합니다. 삭제하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
    		type  : "post",
    		url   : "${ctp}/community/inspiredDelete",
    		data  : { idx : inspiredIdx },
    		success:function() {
    			alert("문장수집이 삭제되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
		}
		
		// 문장 수집 수정창
		function inspiredEditOpen(idx) {
			document.getElementById('insEditIdx').value = idx;
			document.getElementById('insEditContent').value = document.getElementById('insContent'+idx).value;
			document.getElementById('editPage').value = document.getElementById('page'+idx).value;
			document.getElementById('editExplanation').value = document.getElementById('explanation'+idx).value;
			document.getElementById('editBookTitle').value = document.getElementById('bookTitle'+idx).value;
			document.getElementById('editAuthors').value = document.getElementById('authors'+idx).value;
			document.getElementById('editPublisher').value = document.getElementById('publisher'+idx).value;
		}
		
		// 문장 수집 수정
		function inspiredEdit() {
			let idx = document.getElementById('insEditIdx').value;
			let insContent = document.getElementById('insEditContent').value;
			let page = document.getElementById('editPage').value;
			let explanation = document.getElementById('editExplanation').value;
			
			if(insContent == '') {
				alert('문장 수집란을 완성해주세요.');
				document.getElementById('insEditContent').focus();
		    return false;
		  }
			if(page == '') {
				alert('페이지 및 기타 정보를 작성해주세요.');
				document.getElementById('editPage').focus();
		    return false;
		  }
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/inspiredUpdate",
				data : {
					idx : idx,
					insContent : insContent,
					page : page,
					explanation : explanation
				},
				success : function() {
					alert('문장 수집이 수정되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		
		// 문장 수집 작성
		function inspiredInsert() {
			let insContent = document.getElementById('insContent').value; 
			let page = document.getElementById('page').value; 
			let explanation = document.getElementById('explanation').value; 
			let insHostIp = document.getElementById('insHostIp').value; 
			let bookTitle = document.getElementById('bookTitle').value; 
			let publisher = document.getElementById('publisher').value; 

			if(insContent == '') {
				alert('문장 수집란을 완성해주세요.');
				document.getElementById('insContent').focus();
		    return false;
		  }
			if(page == '') {
				alert('페이지 및 기타 정보를 작성해주세요.');
				document.getElementById('page').focus();
		    return false;
		  }
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/inspiredInsertMyPage",
				data : {
					memNickname : '${sNickname}',
					insContent : insContent,
					page : page,
					explanation : explanation,
					bookTitle : bookTitle,
					publisher : publisher,
					insHostIp : insHostIp
				},
				success : function() {
					alert('문장 수집이 등록되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 회원 차단
		function block() {
			if('${sNickname}' == "") {
				alert('로그인 후 사용해주세요.');
				return false;
			}
			
			if('${blockVO}' == '') {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/blockInsert",
	    		data  : {
					  memNickname  : '${sNickname}',
					  blockedNickname : '${memberVO.nickname}'
					},
	    		success:function() {
	    			alert("해당 회원이 차단되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
			else {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/blockDelete",
	    		data  : {
	    			memNickname  : '${sNickname}',
					  blockedNickname : '${memberVO.nickname}'
					},
	    		success:function() {
	    			alert("차단이 해제되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
		}
		
		// 신고 모달창에 값 주기
		function reportCategory(reportCategory, originWriter, originIdx) {
			document.getElementById('reportCategory').value = reportCategory;
			document.getElementById('originWriter').value = originWriter;
			document.getElementById('originIdx').value = originIdx;
		}
		
		// 신고
		function reportInsert() {
			if('${sNickname}' == "") {
				alert('로그인 후 이용해주세요.');
				return false;
			}			
			
			let reportCategory = document.getElementById('reportCategory').value;
			let originIdx = document.getElementById('originIdx').value;
			let reportHostIp = document.getElementById('reportHostIp').value;
			let message = document.getElementById('message').value;
			
			if(message == '') {
				alert('신고 내용을 입력해주세요.');
				document.getElementById('message').focus();
		    return false;
		  }
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/reportInsert",
				data : {
					memNickname : '${sNickname}',
					reportCategory : reportCategory,
					originIdx : originIdx,
					message : message,
					reportHostIp : reportHostIp
				},
				success : function() {
					alert('소중한 의견 감사합니다. 빠르게 처리해드리겠습니다.');
//					if(reportCategory == '문장수집') sessionStorage.setItem('inspiredSW', 'ON'); 
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 회원 페이지에서 회원 상세페이지로 왔다면 session값 없애기
		$(document).ready(function(){
			if(localStorage.getItem('myPageDetailSW') == 'ON') {
				localStorage.removeItem('myPageDetailSW');
				localStorage.removeItem('memNicknameSW');
			}
		});
		
  </script>
</head>
<body>
<div id="back-to-top"></div>
<jsp:include page="/WEB-INF/views/community/communityMenu.jsp" />
	
	<!-- Page Content -->
	<div id="main">
		<a href="${ctp}/community/communityMain">
			<img src = "${ctp}/images/banner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div class="row">
					<div class="col ml-5">
						<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="text-center" style="font-size:20px; text-align:center; font-weight:bold">${memberVO.nickname}</span>
						&nbsp;&nbsp;&nbsp;
					</div>
					<div class="col text-right mr-5">
						<c:if test="${memberVO.nickname == sNickname}">
							<button class="btn btn-secondary" onclick="logout()">로그아웃</button>
						</c:if>
						<c:if test="${memberVO.nickname != sNickname}">
							<c:if test="${!empty blockVO}">
								<button class="btn btn-outline-success" onclick="block()">차단 해제</button>
							</c:if>
							<c:if test="${empty blockVO}">
								<button class="btn btn-outline-danger" onclick="block()">차단</button>
							</c:if>
						</c:if>
					</div>
				</div>
				<div style="width:50%; margin:0px 0px 0px 150px">
					<div class="alert alert-success">
				    소개글)&nbsp;&nbsp;&nbsp;&nbsp;
				    <c:if test="${(memberVO.introduction == '') || (empty memberVO.introduction)}">소개글이 없습니다</c:if>
				    <c:if test="${memberVO.introduction != ''}"><strong>${memberVO.introduction}</strong></c:if>
					</div>
				</div>
					
				<div style="margin-top:100px">
					<a href="${ctp}/community/myPage?memNickname=${memberVO.nickname}"><span class="nowPart mr-5">서재 / 문장수집</span></a>
					<a href="${ctp}/community/myPage/reflection?memNickname=${memberVO.nickname}"><span class="mr-5">기록</span></a>
					<a href="${ctp}/community/myPage/reply?memNickname=${memberVO.nickname}"><span class="mr-5">작성 댓글</span></a>
					<c:if test="${memberVO.nickname == sNickname}">
						<a href="${ctp}/community/myPage/memInfo?memNickname=${memberVO.nickname}"><span class="mr-5">회원 정보</span></a>
						<a href="${ctp}/community/myPage/ask?memNickname=${memberVO.nickname}"><span>문의 / 신고</span></a>
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
				 				<button id="bookSaveOpen1" onclick="bookSaveOpen('bookSave1','1')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">인생책&nbsp;&nbsp;&nbsp;(${bookSave1VOSNum} / 30)</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>내 인생에 영향을 준 책 30권</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<c:if test="${memberVO.nickname == sNickname}">
			 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit1" onclick="bookSaveEditOpen('bookSave1', '1')">편집</button>
			 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone1" onclick="bookSaveEditClose('bookSave1', '1')" style="display:none">완료</button>
		 						</c:if>
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
				  				<a href="javascript:bookPage(${bookSave1VO.bookIdx})"><img src="${bookSave1VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave1VO.bookIdx})"><span style="color:grey"><b>${bookSave1VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn1" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('1','추천책','${bookSave1VO.idx}','${bookSave1VO.bookIdx}')">추천책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('1','읽은책','${bookSave1VO.idx}','${bookSave1VO.bookIdx}')">읽은책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('1','관심책','${bookSave1VO.idx}','${bookSave1VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('1','${bookSave1VO.idx}', '${bookSave1VO.bookIdx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
		 				<div class="row">
		 					<div class="col-8">
				 				<button id="bookSaveOpen2" onclick="bookSaveOpen('bookSave2','2')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">추천책&nbsp;&nbsp;&nbsp;(${bookSave2VOSNum} / 99)</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>알리고 싶은 좋은 책 99권</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<c:if test="${memberVO.nickname == sNickname}">
			 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit2" onclick="bookSaveEditOpen('bookSave2', '2')">편집</button>
			 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone2" onclick="bookSaveEditClose('bookSave2', '2')" style="display:none">완료</button>
		 						</c:if>
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
				  				<a href="javascript:bookPage(${bookSave2VO.bookIdx})"><img src="${bookSave2VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave2VO.bookIdx})"><span style="color:grey"><b>${bookSave2VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn2" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('2','인생책','${bookSave2VO.idx}','${bookSave2VO.bookIdx}')">인생책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('2','읽은책','${bookSave2VO.idx}','${bookSave2VO.bookIdx}')">읽은책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('2','관심책','${bookSave2VO.idx}','${bookSave2VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('2','${bookSave2VO.idx}', '${bookSave2VO.bookIdx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
		 				<div class="row">
		 					<div class="col-8">
				 				<button id="bookSaveOpen3" onclick="bookSaveOpen('bookSave3','3')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">읽은책&nbsp;&nbsp;&nbsp;(${bookSave3VOSNum})</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>읽었어요. 같이 이야기해요.</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<c:if test="${memberVO.nickname == sNickname}">
			 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit3" onclick="bookSaveEditOpen('bookSave3', '3')">편집</button>
			 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone3" onclick="bookSaveEditClose('bookSave3', '3')" style="display:none">완료</button>
		 						</c:if>
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
				  				<a href="javascript:bookPage(${bookSave3VO.bookIdx})"><img src="${bookSave3VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave3VO.bookIdx})"><span style="color:grey"><b>${bookSave3VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn3" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('3','인생책','${bookSave3VO.idx}','${bookSave3VO.bookIdx}')">인생책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('3','추천책','${bookSave3VO.idx}','${bookSave3VO.bookIdx}')">추천책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('3','관심책','${bookSave3VO.idx}','${bookSave3VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('3','${bookSave3VO.idx}', '${bookSave3VO.bookIdx}')">삭제</a>
								    </div>
								  </div>
					  		</div>
					  	</c:forEach>
						  </div>
						</div>
						<hr style="margin:10px"/>
							
							
		 				<div class="row">
		 					<div class="col-8">
				 				<button id="bookSaveOpen4" onclick="bookSaveOpen('bookSave4','4')" class="w3-btn w3-left-align">
				 					<span style="font-size:20px">관심책&nbsp;&nbsp;&nbsp;(${bookSave4VOSNum})</span>	
			 					</button>
			 					<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
			 						<span class="w3-text w3-tag" style="font-style:italic;"><b>아직 읽지 않았지만 관심있어요.</b></span>
		 						</span>
		 					</div>
		 					<div class="col-4 text-right pr-5">
		 						<c:if test="${memberVO.nickname == sNickname}">
			 						<button class="btn btn-outline-dark btn-sm" id="bookSaveBtnEdit4" onclick="bookSaveEditOpen('bookSave4', '4')">편집</button>
			 						<button class="btn btn-outline-warning btn-sm" id="bookSaveBtnDone4" onclick="bookSaveEditClose('bookSave4', '4')" style="display:none">완료</button>
		 						</c:if>
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
				  				<a href="javascript:bookPage(${bookSave4VO.bookIdx})"><img src="${bookSave4VO.thumbnail}"/></a><br/>
				  				<a href="javascript:bookPage(${bookSave4VO.bookIdx})"><span style="color:grey"><b>${bookSave4VO.title}</b></span></a><br/>
				  				<div class="dropdown bookEditBtn4" style="display:none; margin-top:10px">
								    <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown">
								      이동&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
								    </button>
								    <div class="dropdown-menu">
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('4','인생책','${bookSave4VO.idx}','${bookSave4VO.bookIdx}')">인생책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('4','추천책','${bookSave4VO.idx}','${bookSave4VO.bookIdx}')">추천책</a>
								      <a class="dropdown-item" href="javascript:bookSaveCategoryChange('4','관심책','${bookSave4VO.idx}','${bookSave4VO.bookIdx}')">관심책</a>
								      <a class="dropdown-item text-danger" href="javascript:bookSaveDelete('4','${bookSave4VO.idx}', '${bookSave4VO.bookIdx}')">삭제</a>
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
	 		
	 		
	 		<!-- 문장수집(페이징 처리) -->
	 		<div style="padding:50px 0px;">
	 			<div>
					<div style="padding:0px 50px; margin-bottom:30px">
						<i class="fa-solid fa-highlighter" style="font-size:45px;"></i>
						<span style="font-size:30px; margin-left:15px">문장수집</span>
					</div> 	
							
		 			<div style="width:90%; margin:0px auto; class="border">
					  <c:if test="${memberVO.nickname == sNickname}">
						  <div class="w3-container w3-border" style="background-color:#eee; margin-bottom:30px">
					  		<div class="row">
					  			<div class="col-8">
						  			<textarea rows="4" cols="10" id="insContent" class="form-control mt-3" placeholder="여기에 문장을 입력해주세요."></textarea>
					  			</div>
					  			<div class="col-4">
						  			<textarea rows="4" cols="10" id="explanation" class="form-control mt-3" placeholder="추가 설명을 적어주세요(선택)."></textarea>
					  			</div>
					  		</div>
				  			<input type="text" id="page" class="form-control mt-3" placeholder="페이지 및 기타 정보  예) p.29"/>
				  			<hr style="border:0px; height:2px; width:200px; background:#41644A; margin:10px 0px"/>
				  			
				  			<div class="row ml-4 mr-3 mt-2 mb-4">
				  				<div class="col">
										<div class="contentBox" style="margin-bottom:10px" id="bookInsertSelectEdit">
										  <span class="contentBox__item">
												<a href="#" class="btn btn-primary" id="bookInsertSelectBtn" data-toggle="modal" data-target="#bookInsertSelectModal">도서 추가</a>
										  </span>
										</div>
						  			<div style="display:none;" id="bookInsertSelectDone">
						  				<div class="text-right">
						  					<a class="btn btn-dark btn-sm" href="${ctp}/community/myPage?memNickname=${memberVO.nickname}" style="margin-right:20px;">
						  						<i class="fa-solid fa-arrows-rotate"></i>
					  						</a>
						  				</div>
						  				<h3><b><input type="text" id="bookTitle" style="width:1000px; background-color:transparent; border:0px" readonly/></b><br/></h3>
						  				<span>출판사 : <input type="text" id="publisher" style="width:500px; background-color:transparent; border:0px" readonly/></span><br/>
						  				<span>저자 : <input type="text" id="authors" style="width:500px; background-color:transparent; border:0px" readonly/></span>
							  			<input type="hidden" id="insHostIp" value="${pageContext.request.remoteAddr}"/>
							  			<div>
								  			<div class="text-right"><button class="btn btn-dark" onclick="inspiredInsert()">작성</button></div>
						  				</div>
						  			</div>
				  				</div>
				  			</div>
						  </div>
					  </c:if>
					  
					  
					  <table class="table table-borderless mb-0 p-0">
					    <tr>
					      <td>
					        <select name="pageSize" id="pageSize" onchange="pageCheck()">
					          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
					          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
					          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
					          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
					          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
					        </select> 건
					      </td>
					      <td class="text-right">
					        <!-- 첫페이지 / 이전페이지 / (현재페이지번호/총페이지수) / 다음페이지 / 마지막페이지 -->
					        <c:if test="${pageVO.pag > 1}">
					          <a href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
					          <a href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
					        </c:if>
					        ${pageVO.pag}/${pageVO.totPage}
					        <c:if test="${pageVO.pag < pageVO.totPage}">
					          <a href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
					          <a href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
					        </c:if>
					      </td>
					    </tr>
					  </table>
					  
					  <div class="table-responsive">
							<table class="table">
						    <thead>
						      <tr class="text-center">
						        <th>내용</th>
						      </tr>
						    </thead>
						    <tbody>
						    	<c:if test="${empty inspiredVOS}">
						    		<tr><td class="text-center" style="padding:30px"><b>문장수집을 남겨주세요.</b></td></tr> 
						    		<tr><td></td></tr>
						    	</c:if>
						    	<c:if test="${!empty inspiredVOS}">
							    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
					 		    	<c:forEach var="inspiredVO" items="${inspiredVOS}" varStatus="st">
								      <tr>
								        <td>
								        	<div class="w3-panel w3-sand" style="margin:15px">
									        	<div class="row">
												    	<div class="col-11">
												    	
														    <span style="font-size:80px; line-height:0.6em; opacity:0.2">❝</span>
														    <p class="w3-xlarge" style="margin:-40px 0px 0px 0px; padding:10px">
														    	<input type="hidden" id="insContent${inspiredVO.idx}" value="${inspiredVO.insContent}"/>
														    	<i style="font-size:19px;">${inspiredVO.insContent}</i>
														    	
														    	<c:if test="${(inspiredVO.memNickname == sNickname)}">&nbsp;
													  				<a href="#" onclick="inspiredEditOpen('${inspiredVO.idx}')" data-toggle="modal" data-target="#inspiredEditModal">
																			<i class="fa-regular fa-pen-to-square" style="font-size:16px"></i>
																		</a>			
																</c:if>	
														    </p>
												    	
												    	</div>
												    	<div class="col-1 mt-3 text-right">
												    		<c:if test="${(inspiredVO.memNickname == sNickname) || (sMemType == '관리자')}">
												  				<a href="javascript:inspiredDelete('${inspiredVO.idx}')">
												  					<i class="fa-solid fa-xmark" style="font-size:30px"></i>
												  					&nbsp;&nbsp;&nbsp;
												  				</a>
												  			</c:if>
												    	</div>
												    </div>

										    	<p class="ml-4" style="color:grey;">『 ${inspiredVO.bookTitle} 』(${inspiredVO.authors})&nbsp;&nbsp;${inspiredVO.page}</p>
										    	<input type="hidden" id="page${inspiredVO.idx}" value="${inspiredVO.page}"/>
											    <hr style="margin:0px"/>
											    <div class="row">
											    	<div class="col">
													    <div style="padding:10px">
													    	<span>by. ${inspiredVO.memNickname}</span>
													    	<c:if test="${inspiredVO.explanation!= ''}">
													    		&nbsp;&nbsp;&nbsp;
													    		<span class="dropdown dropright">
																    <button type="button" class="dropdown-toggle" data-toggle="dropdown" style="border:0px; background-color:transparent;">
																      <i class="fa-solid fa-circle-info" style="font-size:20px; padding:5px"></i>
																    </button>
																    <div class="dropdown-menu" style="padding:5px">
																      <p>${inspiredVO.explanation}</p>
																      <input type="hidden" id="explanation${inspiredVO.idx}" value="${inspiredVO.explanation}"/>
																      <input type="hidden" id="bookTitle${inspiredVO.idx}" value="${inspiredVO.bookTitle}"/>
																      <input type="hidden" id="authors${inspiredVO.idx}" value="${inspiredVO.authors}"/>
																      <input type="hidden" id="publisher${inspiredVO.idx}" value="${inspiredVO.publisher}"/>
																    </div>
																  </span>
													    	</c:if>
													    	<c:if test="${inspiredVO.explanation == ''}">
														      <input type="hidden" id="explanation${inspiredVO.idx}" value="${inspiredVO.explanation}"/>
														      <input type="hidden" id="bookTitle${inspiredVO.idx}" value="${inspiredVO.bookTitle}"/>
														      <input type="hidden" id="authors${inspiredVO.idx}" value="${inspiredVO.authors}"/>
														      <input type="hidden" id="publisher${inspiredVO.idx}" value="${inspiredVO.publisher}"/>
													    	</c:if>
													    	
													    </div>
											    	</div>
											    	<div class="col text-right">
											    		<div style="padding:10px">
												    		<c:if test="${inspiredVO.insSaveIdx == 0}"><i class="fa-regular fa-bookmark save" style="font-size:25px" onclick="insSave('${inspiredVO.idx}', '${inspiredVO.insSaveIdx}')" title="관심등록되지 않은 문장수집 입니다"></i></c:if>
																<c:if test="${inspiredVO.insSaveIdx != 0}"><i class="fa-solid fa-bookmark save" style="font-size:25px" onclick="insSave('${inspiredVO.idx}', '${inspiredVO.insSaveIdx}')" title="관심등록된 문장수집"></i></c:if>
											  				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											  				<a href="#" class="btn btn-sm btn-outline-secondary" onclick="reportCategory('문장수집','${inspiredVO.memNickname}','${inspiredVO.idx}')" data-toggle="modal" data-target="#reportModal">
																	신고
																</a>
											    		</div>
											    	</div>
											    </div>
											  </div>
											  <hr style="margin:0px"/>
								        	
								        </td>
								      </tr>
								    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
							    	</c:forEach>
							    	<tr><td></td></tr> 
						    	</c:if>
						    </tbody>
						  </table>
					  </div>
					  
					  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
					  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
					  <div class="text-center">
						  <ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=1&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
						      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${i}&memNickname=${memberVO.nickname}">${i}</a></li></c:if>
						      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${i}&memNickname=${memberVO.nickname}">${i}</a></li></c:if>
						    </c:forEach>
						    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						  </ul>
					  </div>
					  
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
  
  
  <!-- The Modal -->
  <div class="modal fade" id="inspiredEditModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">문장수집 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee;">
			  		<div class="row">
			  			<div class="col-8">
				  			<textarea rows="4" cols="10" id="insEditContent" class="form-control mt-3" placeholder="여기에 문장을 입력해주세요."></textarea>
			  			</div>
			  			<div class="col-4">
				  			<textarea rows="4" cols="10" id="editExplanation" class="form-control mt-3" placeholder="추가 설명을 적어주세요(선택)."></textarea>
			  			</div>
			  		</div>
		  			<input type="text" id="editPage" class="form-control mt-3" placeholder="페이지 및 기타 정보  예) p.29"/>
		  			<hr style="border:0px; height:2px; width:200px; background:#41644A; margin:10px 0px"/>
		  			
		  			<div class="row ml-4 mr-3 mt-2 mb-4">
		  				<div class="col">
				  			<div>
				  				<a href="${ctp}/community/bookPage?idx=${vo.bookIdx}">
					  				<h3><b><input type="text" id="editBookTitle" style="width:1000px; background-color:transparent; border:0px" readonly/></b><br/></h3>
				  				</a>
				  				<span>출판사 : <input type="text" id="editPublisher" style="width:500px; background-color:transparent; border:0px" readonly/></span><br/>
				  				<span>저자 : <input type="text" id="editAuthors" style="width:500px; background-color:transparent; border:0px" readonly/></span>
				  				<input type="hidden" id="insEditIdx"/>
				  			</div>
		  				</div>
		  			
		  			</div>
				  </div>
				  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="inspiredEdit()">수정</button>
        </div>
        
      </div>
    </div>
  </div>
	
  
			
	<!-- 문장삽입용 책 자료 검색 -->	
 	<!-- The Modal -->
  <div class="modal fade" id="bookInsertSelectModal">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="margin:10px 100px 10px 100px">
	          <form name="inspiredSearchForm">
	          	<div class="input-group">
					      <input type="text" name="inspiredSearchString" id="inspiredSearchString" value="${inspiredSearchString}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요" />
					      <div class="input-group-append">
					     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="inspiredSearchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#0cc621;"></i></a>
					     	</div>
				     	</div>
				    </form>
			    </div>
			    <div id="insDemo" style="display:none;">
			  	  <hr/>
			  	  <c:if test="${empty insBookVOS}">
			  	  	<div class="container text-center"><br/>관련 도서가 없습니다 😲</div>
			  	  </c:if>
			  	  <c:if test="${!empty insBookVOS}">
				  	  <c:forEach var="insBookVO" items="${insBookVOS}">
			  	  		<div class="row">
			  	  			<div class="col-3 text-center"><a href="${insBookVO.url}" target="_blank"><img src="${insBookVO.thumbnail}"/></a></div>
			  	  			<div class="col-7 text-center">
			  	  				<div class="row"><div class="col"><a href="${insBookVO.url}" target="_blank"><b>${insBookVO.title}</b></a></div></div>
			  	  				<div class="row"><div class="col">${insBookVO.authors}&nbsp;&nbsp; | &nbsp;&nbsp;${insBookVO.publisher}</div></div>
			  	  				<div class="row m-3"><div class="col">${insBookVO.contents}...</div></div>
			  	  			</div>
			  	  			<div class="col-2 text-center">
			  	  				<button class="btn btn-outline-primary" onclick="insBookSelection('${insBookVO.title}', '${insBookVO.publisher}', '${insBookVO.authors}')" data-dismiss="modal">선택</button>
			  	  			</div>
			  	  		</div>
								<hr/>				
				  	  </c:forEach>
			  	  </c:if>
					</div>
        </div>
        
      </div>
    </div>
  </div>
  
  
  
	<!-- The Modal -->
  <div class="modal fade" id="reportModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">신고창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee;">
		  			<textarea rows="4" cols="10" id="message" class="form-control mt-3" placeholder="신고 내용을 상세히 입력해주세요."></textarea>
	  				<input type="hidden" id="reportCategory"/>
	  				<input type="hidden" id="originIdx"/>
	  				<input type="hidden" id="reportHostIp" value="${pageContext.request.remoteAddr}"/>
		  			
		  			<div class="row ml-4 mr-3 mt-2 mb-4">
		  				<div class="col">
				  			<div>
				  				<span style="color:red"><i class="fa-solid fa-triangle-exclamation" style="font-size:17px; margin-bottom:15px"></i>&nbsp;&nbsp;신고 철회는 불가능합니다.</span><br/>
				  				<span>
				  					신고자 : <b>
				  					<c:if test="${empty sNickname}">비회원은 신고하실 수 없습니다.</c:if>
				  					<c:if test="${!empty sNickname}">${sNickname}</c:if>
			  						</b>
				  				</span><br/>
				  				<span>원본 작성자 : <b><input type="text" id="originWriter" style="background-color:transparent; border:0px" readonly/></b></span>
				  			</div>
		  				</div>
		  			</div>
				  </div>
				  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="reportInsert()">신고</button>
        </div>
        
      </div>
    </div>
  </div>
	
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>