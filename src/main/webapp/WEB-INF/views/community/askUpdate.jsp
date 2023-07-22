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
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
  <style>
 		html {scroll-behavior:smooth;}
		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
		.table a:hover {color:#41644A !important;}
		
  	.w3-row-padding img {margin-bottom: 12px}
		/* Set the width of the sidebar to 120px */
		.w3-sidebar {width: 120px;background: #222;}
		/* Add a left margin to the "page content" that matches the width of the sidebar (120px) */
		#main {margin-left: 120px}
		/* Remove margins from "page content" on small screens */
		@media only screen and (max-width: 600px) {#main {margin-left: 0}}
		
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
		.save:hover {
			cursor: pointer;
		}
		.contentBox{
		  display:table;
		  table-layout:fixed;
		  width:100%;
		  max-width:600px;
		  height:200px;
		  background:#eee;
		  text-align:center;
		  margin-left: auto; 
		  margin-right: auto;
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
		
		// 경고
		function updateWarning() {
			let ans = confirm('수정을 취소하시겠습니까?');
			if(!ans) return false;
			
			location.href = "${ctp}/community/askDetail?idx=${vo.idx}";
		}
		
		// 기록 작성
		function askUpdate() {
			let askTitle = updateForm.askTitle.value;
			let email = updateForm.email.value;
			
			let regex1 = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\s]{1,100}$/g; 
			// (제목)1자 이상 100자 이하,한글,영문,숫자,특수문자 허용
			let regex2 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; // 이메일
			let regex3 = /^[0-9]{4}$/; //(비회원 비밀번호)숫자 4자리
			
			if(!regex1.test(askTitle)){
				alert('제목 형식에 맞춰주세요.(한글/영문/숫자/특수문자 허용, 1~100자)');
				updateForm.askTitle.focus();
		    return false;
		  }
			
			if('${sNickname}' == "") {
				if(email == "") {
					alert('비회원 이메일은 필수 작성요소입니다.');
					updateForm.email.focus();
					return false;
				}
				if(!regex2.test(email)){
					alert('이메일 형식에 맞춰주세요.');
					updateForm.email.focus();
			    return false;
			  }
				let pwd = updateForm.pwd.value;
				if(!regex3.test(pwd)){
					alert('비밀번호 형식에 맞춰주세요.(숫자 4자리)');
					updateForm.pwd.focus();
			    return false;
			  }
				
			}
			updateForm.submit();
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
	  	<form name="updateForm" method="post" action="${ctp}/community/askUpdate">
		 		<div style="background-color:white; padding:20px; margin-bottom:30px">
		 			<div class="row mb-4">
		 				<div class="col-3 text-left">
							<a class="btn btn-dark mb-4" href="javascript:updateWarning()" style="margin-left:20px;"><i class="fa-solid fa-chevron-left"></i></a>
		 				</div>
		 				<div class="col-6 text-center">
		 					<span class="text-center" style="font-size:25px; text-align:center; font-weight:bold">문의 수정</span>
		 				</div>
		 				<div class="col-3 text-right">
							<a class="btn btn-dark mb-4" href="${ctp}/community/askUpdate?idx=${vo.idx}" style="margin-right:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
		 				</div>
		 			</div>
					<div style="text-align:center">
						<span class="text-center" style="font-size:30px; text-align:center; font-weight:500">
							<input id="askTitle" class="text-center" name="askTitle" style="width:500px" placeholder="제목을 입력해주세요." value="${vo.askTitle}"/>
						</span><br/>
						<c:if test="${!empty sNickname}">
							<span class="text-center" style="font-size:20px; text-align:center; color:grey">by. ${sNickname}</span><br/>
							<input type="hidden" name="memNickname" id="memNickname" value="${sNickname}"/>
							<input type="hidden" id="email" class="text-center" name="email"/>
						</c:if>
						<c:if test="${empty sNickname}">
							<br/>
							<span class="text-center" style="font-size:20px; text-align:center; color:grey">
								<input id="email" class="text-center" name="email" value="${vo.email}" style="width:300px" placeholder="비회원 이메일을 입력해주세요."/>
							</span><br/>
						</c:if>
						<input type="hidden" name="idx" value="${vo.idx}"/>
					</div>
					<div class="row">
						<div class="col ml-5">
						</div>
						<div class="col text-right mr-5">
							<span style="font-size:18px">
								<label for="secret"><input type="checkbox" name="secret" id="secret" class="form-check-input" <c:if test="${vo.secret == '공개'}">checked</c:if>/>
								&nbsp;공개 허용&nbsp;&nbsp;&nbsp;</label>
							</span>&nbsp;&nbsp;&nbsp;&nbsp;
							
							<button class="btn btn-secondary" type="button" onclick="askUpdate()">수정</button>
						</div>
					
					</div>
					<hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
		 		</div>
				<div style="padding:0px 0px 50px 50px">
					<span><i class="fa-solid fa-circle-info" style="font-size:20px"></i>&nbsp;&nbsp;&nbsp;<b>커뮤니티 관련 문의만 남겨주세요:) 그외 문의는 책(의)세계 문의를 이용해주세요.</b></span>
				</div>
				
				<c:if test="${empty sNickname}">
					<div class="text-right mr-5">
						<span style="font-size:18px; text-align:center; color:grey">
							<input id="pwd" class="text-center" name="pwd" style="width:400px" placeholder="비회원 확인용 비밀번호 입력해주세요.(숫자 4자리)"/>
						</span><br/>
					</div>
				</c:if>
				
				<div style="padding:20px 20px 50px 20px;">
					<textarea rows="100" name="askContent" id="CKEDITOR" class="form-control">${vo.askContent}</textarea>
		        <script>
			        CKEDITOR.replace("askContent",{
			        	height:500,
			        	filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지) 업로드시 매핑경로 */
			        	uploadUrl : "${ctp}/imageUpload"		/* 여러개의 그림파일을 드래그&드롭해서 올리기 */
			        });
		        </script>
		        
				  <hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
				</div>
			</form>
		</div>
	  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>