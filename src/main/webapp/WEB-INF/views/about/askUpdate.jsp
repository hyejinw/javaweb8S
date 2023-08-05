<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 200px;
    	max-width: 1500px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px;
    	margin-bottom: 30px;
    }
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
    
    .pill-nav a {
		  display: inline-block;
		  color: black;
		  text-align: center;
		  padding: 8px 20px;
		  text-decoration: none;
		  font-size: 17px;
		  border-radius: 5px;
		}
		.pill-nav a:hover {
		  background-color: #ddd;
		  color: black;
		}
		.pill-nav a.active {
		  background-color: #F5EBE0;
		  color: #282828;
		}
		.nowPart {
     color : #282828;
     font-weight: bold;
     border-bottom: 5px solid #282828;
     padding-bottom:14px;
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
			location.href = "${ctp}/about/askDetail?idx=${vo.idx}";
		}
		
		// 문의 수정
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
		
		// 3개의 책 문의창으로 이동
		function move() {
			if(confirm('3개의 책 문의창으로 이동하시겠습니까?')) location.href = "${ctp}/community/ask";
		}
		
		// 새 문의 남기기
		function newInsert() {
			if(confirm('새 문의를 작성하시겠습니까?')) location.href = "${ctp}/about/askInsert";
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<div class="row mb-4">
 				<div class="col-3 text-left">
					<a class="btn btn-dark mb-4" href="javascript:updateWarning()" style="margin-left:20px;"><i class="fa-solid fa-chevron-left"></i></a>
 				</div>
 				<div class="col-6 text-center">
 					<span class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">문의 수정</span>
 				</div>
 				<div class="col-3 text-right">
					<a class="btn btn-dark mb-4" href="${ctp}/community/askUpdate=idx${vo.idx}" style="margin-right:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
 				</div>
 			</div>
			
 			<div style="margin:0px auto;">
		  	<form name="updateForm" method="post" action="${ctp}/about/askUpdate">
			 		<div style="background-color:white; padding:20px;">
						<div style="text-align:center">
							<span class="text-center" style="font-size:30px; text-align:center; font-weight:500">
								<input id="askTitle" name="askTitle"  class="form-control" style="font-size:30px; text-align:center; font-weight:500" value="${vo.askTitle}" placeholder="제목을 입력해주세요."/>
							</span><br/>
							<c:if test="${!empty sNickname}">
								<span class="text-center" style="font-size:20px; text-align:center; color:grey">by. ${sNickname}</span><br/>
								<input type="hidden" name="memNickname" id="memNickname" value="${sNickname}"/>
								<input type="hidden" id="email" class="text-center" name="email"/>
							</c:if>
							<c:if test="${empty sNickname}">
								<br/>
								<span class="text-center" style="font-size:20px; text-align:center; color:grey">
									<input id="email" class="text-center" name="email" style="width:300px" value="${vo.email}" placeholder="비회원 이메일을 입력해주세요."/>
								</span><br/>
							</c:if>
							
						</div>
						<div class="row">
							<div class="col ml-5">
							</div>
							<div class="col text-right mr-5">
								<span style="font-size:18px">
									<label for="secret"><input type="checkbox" name="secret" id="secret" class="form-check-input" <c:if test="${vo.secret == '공개'}">checked</c:if>/>
									&nbsp;공개 허용&nbsp;&nbsp;&nbsp;</label>
								</span>&nbsp;&nbsp;&nbsp;&nbsp;
								
								<input type="hidden" name="idx" value="${vo.idx}"/>
								<button class="btn btn-secondary" type="button" onclick="askUpdate()">수정</button>
							</div>
						</div>
						<hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
			 		</div>
					<div class="infoBox">
						<div class="row">
							<div class="col">
								<span style="font-size:16px">문의 종류)</span>&nbsp;&nbsp;<b>${vo.category}</b>			
							</div>
							<div class="col text-right">
								<c:if test="${vo.category == '컬렉션상품'}"><a href="${ctp}/collection/colProduct?idx=${vo.originIdx}"><u><i class="fa-solid fa-magnifying-glass"></i>${vo.originName}</u></a></c:if>		
								<c:if test="${(vo.category == '매거진') || (vo.category == '정기구독')}"><a href="${ctp}/magazine/maProduct?idx=${vo.originIdx}"><u><i class="fa-solid fa-magnifying-glass"></i>${vo.originName}</u></a></c:if>		
							</div>
						</div>
					</div>
					
					<div style="padding:0px 0px 50px 50px">
						<span><i class="fa-solid fa-circle-info" style="font-size:20px"></i>&nbsp;&nbsp;&nbsp;<b>커뮤니티 관련 문의는 <a href="javascript:move()"><u>3개의 책 문의</u></a>에 남겨주세요.</b></span><br/>
						<span><i class="fa-solid fa-circle-info" style="font-size:20px"></i>&nbsp;&nbsp;&nbsp;<b>문의 카테고리 변경은 불가능합니다. <a href="javascript:newInsert()"><u>새 문의</u></a>를 남겨주세요:)</b></span>
					</div>
					
					
					<c:if test="${empty sNickname}">
						<div class="text-right mr-5">
							<span style="font-size:18px; text-align:center; color:grey">
								<input type="password" id="pwd" class="text-center" name="pwd" style="width:400px" placeholder="비회원 확인용 비밀번호 입력해주세요.(숫자 4자리)"/>
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
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>