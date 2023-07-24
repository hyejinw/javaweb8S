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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
		
		function openCity(evt, cityName) {
		  var i, x, tablinks;
		  x = document.getElementsByClassName("city");
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablink");
		  for (i = 0; i < x.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" w3-blue", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.className += " w3-blue";
		}
		
		// 답변 작성
		function answerInsert() {
			let answer = document.getElementById('answerContent').value; 
			
			if(answer == '') {
				alert('답변을 작성해주세요.');
				document.getElementById('answerContent').focus();
		    return false;
		  }

			$.ajax({
				type : "post",
				url : "${ctp}/community/answerInsert",
				data : {
					idx : ${vo.idx},
					answer : answer
				},
				success : function() {
					alert('답변이 등록되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 답변 수정 창
		function answerEditOpen() {
			$('#answerEditOpen').css('display', 'none');
			$('#answerEdit').css('display', 'inline-block');
			$('#answerContent').prop('readOnly', false);
		} 
		
		// 답변 수정
		function answerEdit() {
			let answer = document.getElementById('answerContent').value; 
			
			if(answer == '') {
				alert('답변을 작성해주세요.');
				document.getElementById('answerContent').focus();
		    return false;
		  }

			$.ajax({
				type : "post",
				url : "${ctp}/community/answerUpdate",
				data : {
					idx : ${vo.idx},
					answer : answer
				},
				success : function() {
					alert('답변이 수정되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 되돌아가기 경로
		function returnPath() {
			if(sessionStorage.getItem('myPageAskSW') == 'ON') {
				location.href="${ctp}/community/myPage/ask?memNickname=${vo.memNickname}"
			}
			else {
				location.href="${ctp}/community/ask"
			}
		}
		
		// 문의 수정창 
		function askUpdateCheck(idx, memNickname, pwd, answeredAsk) {
			
			if(answeredAsk != "답변전") {
				alert('답변완료 후에는 문의를 수정하실 수 없습니다.');
				return false;
			}
			
			// 비회원 문의
			if(memNickname == "") {
				let ans = prompt('비회원 문의 비밀번호를 입력해주세요(숫자 4자리).');
				if(ans == null) return false;
				
				$.ajax({
					type : "post",
					url : "${ctp}/community/askPwdCheck",
					data : {
						ans : ans,
						pwd : pwd
					},
					success : function(res) {
						if(res == "1") {
							location.href = "${ctp}/community/askUpdate?idx="+idx;
							return false;
						}
						else {
							alert('잘못된 비밀번호입니다.');
							return false;
						}
					},
					error : function() {
						alert('전송 오류 발생, 재시도 부탁드립니다.');
						return false;
					}						
				});
			}
			// 회원 문의
			location.href = "${ctp}/community/askUpdate?idx="+idx;
		}
		
		// 문의 삭제
		function askDelete(idx, memNickname, pwd) {
			// 비회원 문의
			if(memNickname == "") {
				let ans = prompt('비회원 문의 비밀번호를 입력해주세요(숫자 4자리).');
				if(ans == null) return false;
				
				$.ajax({
					type : "post",
					url : "${ctp}/community/askPwdCheck",
					data : {
						ans : ans,
						pwd : pwd
					},
					success : function(res) {
						if(res == "1") {
							location.href = "${ctp}/community/askDelete?idx="+idx;
							return false;
						}
						else {
							alert('잘못된 비밀번호입니다.');
							return false;
						}
					},
					error : function() {
						alert('전송 오류 발생, 재시도 부탁드립니다.');
						return false;
					}						
				});
			}
			else {
				// 회원 문의
				let ans = confirm('삭제 후 복구 불가능합니다. 삭제하시겠습니까?');
				if(!ans) return false;
				
				location.href = "${ctp}/community/askDelete?idx="+idx;
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
			<img src = "${ctp}/images/banner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		
	  <div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col-3 text-left">
						<a class="btn btn-dark mb-4" href="javascript:returnPath()" style="margin-left:20px;">
							<i class="fa-solid fa-chevron-left"></i>
						</a>
	 				</div>
	 				<div class="col-6 text-center">
						<a href="javascript:returnPath()">
		 					<span class="text-center" style="font-size:23px; color:grey; text-align:center;">문의)</span>
						</a>
	 				</div>
	 				<div class="col-3 text-right">
					  <a class="btn btn-warning" href="javascript:insert()" style="margin-right:20px;"><i class="fa-solid fa-share-from-square"></i>카카오톡 공유</a>
	 				</div>
	 			</div>
				<div style="text-align:center">
					<span class="text-center" style="font-size:30px; text-align:center; font-weight:500">${vo.askTitle}</span>
				
					<c:if test="${(vo.memNickname == sNickname)}">&nbsp;&nbsp;
	  				<a href="javascript:askUpdateCheck('${vo.idx}','${vo.memNickname}','${vo.pwd}','${vo.answeredAsk}')">
							<i class="fa-regular fa-pen-to-square" style="font-size:20px"></i>
						</a>			
					</c:if>	
				
					<br/>
					<c:if test="${!empty vo.memNickname}">
						<a href="${ctp}/"><span class="text-center" style="font-size:20px; text-align:center; color:grey">by. ${vo.memNickname}</span></a><br/>
					</c:if>
					<c:if test="${empty vo.memNickname}">
						<span class="text-center" style="font-size:20px; text-align:center; color:grey">by. ${vo.email}</span>&nbsp;&nbsp;<span class="badge badge-pill badge-light">비회원</span><br/>
					</c:if>
					<span class="text-center" style="font-size:14px; text-align:center;">${fn:substring(vo.answerDate,0,19)}</span>
				</div>
				<div class="row">
					<div class="col ml-5">
						<a href="#answerSection" class="btn btn-outline-primary">답변</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="${ctp}/community/askInsert" class="btn btn-outline-secondary">추가문의</a>
					</div>
					<div class="col text-right mr-5">
						<c:if test="${vo.memNickname == sNickname}">
	  					<a href="javascript:askDelete('${vo.idx}','${vo.memNickname}','${vo.pwd}')">
		  					<i class="fa-solid fa-xmark" style="font-size:32px"></i>
		  				</a>
		  				&nbsp;&nbsp;&nbsp;&nbsp;
		  			</c:if>
					</div>
				
				</div>
				<hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
	 		</div>
			
			<div style="padding:20px 20px 50px 20px;">
				${vo.askContent}
			  <hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
			</div>
		  
		  <div id="answerSection">
	  	  <div class="w3-bar">
			    <button class="w3-bar-item w3-button tablink w3-blue" onclick="openCity(event,'answer')">
			    	<c:if test="${vo.answeredAsk == '답변전'}">
			    		답변 전
			    	</c:if>
			    	<c:if test="${vo.answeredAsk != '답변전'}">
			    		${vo.answeredAsk}
			    	</c:if>
			    </button>
			  </div>
			  
			  <div id="answer" class="w3-border city">
			  	
			  	<div class="w3-container w3-border" style="background-color:#eee">
			  		<c:if test="${(sMemType == '관리자') && (vo.answeredAsk == '답변전')}">
			  			<textarea rows="4" cols="10" id="answerContent" class="form-control mt-3" placeholder="[관리자]    1) 수정은 지양해주시길 바랍니다.   2) 작성 완료 후, 작성자에게 답변 등록 이메일이 전송됩니다. 화면 전환까지 잠시 기다려주시길 바랍니다."></textarea>
			  			<div class="text-right mr-3 mt-2 mb-3"><button class="btn btn-dark" onclick="answerInsert()">작성</button></div>
			  		</c:if>
			  		<c:if test="${(sMemType == '관리자') && (vo.answeredAsk != '답변전')}">
			  			<textarea rows="4" cols="10" id="answerContent" class="form-control mt-3" readonly>${vo.answer}</textarea>
			  			<div class="text-right mr-3 mt-2 mb-3"><button class="btn btn-dark" id="answerEditOpen" onclick="answerEditOpen()">수정</button></div>
			  			<div class="text-right mr-3 mt-2 mb-3"><button class="btn btn-warning" id="answerEdit" onclick="answerEdit()" style="display:none">완료</button></div>
			  		</c:if>
			  		<c:if test="${sMemType != '관리자'}">
			  			<div style="padding:30px">
			  				<c:if test="${vo.answeredAsk == '답변전'}">문의 답변 처리 중입니다.</c:if>
			  				<c:if test="${vo.answeredAsk != '답변전'}">${vo.answer}</c:if>
			  			</div>
			  		</c:if>
				  </div>
				  
				  
			  </div>
			
			</div>
			
					  
		</div>
	  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	
</body>
</html>