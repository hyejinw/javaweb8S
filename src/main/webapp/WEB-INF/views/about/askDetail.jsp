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
	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
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
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
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
			// 매거진 상세페이지
			if(localStorage.getItem('magazineAskDetailSW') == 'ON') {
				let idx = localStorage.getItem('magazineReturnOriginIdx2');
				location.href="${ctp}/magazine/maProduct?idx="+idx+"#q&a";
			}
			// 컬렉션상품 상세페이지
			else if(localStorage.getItem('productAskDetailSW') == 'ON') {
				let idx = localStorage.getItem('productReturnOriginIdx2');
				location.href="${ctp}/collection/colProduct?idx="+idx+"#q&a";
			}
			// 마이페이지 문의관리창
			else if(localStorage.getItem('memMyPageAskSW') == 'ON') {
				location.href="${ctp}/member/myPage/ask";
			}
			// 관리자창
			else if(localStorage.getItem('adminAskSW') == 'ON') {
				location.href="${ctp}/admin/manage/askList";
			}
			else {
				location.href="${ctp}/about/ask"
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
							location.href = "${ctp}/about/askUpdate?idx="+idx;
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
			location.href = "${ctp}/about/askUpdate?idx="+idx;
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
							location.href = "${ctp}/community/askDelete?idx="+idx+"&flag=about";
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
				// 회원 문의 삭제
				let ans = confirm('삭제 후 복구 불가능합니다. 삭제하시겠습니까?');
				if(!ans) return false;
				
				location.href = "${ctp}/community/askDelete?idx="+idx+"&flag=about";
			}
		}
		
		// 카카오톡 공유하기
		Kakao.init('2957b853b61482d92df3640d007c600f'); // 사용하려는 앱의 JavaScript 키 입력
	  
	  function shareMessage() {
		  let tempTitle = '${vo.askTitle}';
	    Kakao.Share.sendDefault({
	      objectType: 'feed',
	      content: {
	        title: tempTitle,
	        imageUrl:
	          'http://localhost:9090/javaweb8S/resources/images/logo.png',
	        link: {
	          // [내 애플리케이션] > [플랫폼] 에서 등록한 사이트 도메인과 일치해야 함
	          mobileWebUrl: 'http://49.142.157.251:9090/javaweb8S',
	          webUrl: 'http://49.142.157.251:9090/javaweb8S', //http://49.142.157.251:9090
	        },
	      },
	      buttons: [
	        {
	          title: '내용 확인',
	          link: {
	            /* mobileWebUrl: 'http://localhost:9090/javaweb8S/community/reflectionDetail?idx=${vo.idx}',
	            webUrl: 'http://localhost:9090/javaweb8S/community/reflectionDetail?idx=${vo.idx}', */
 	            mobileWebUrl: 'http://49.142.157.251:9090/javaweb8S/about/askDetail?idx=${vo.idx}',
	            webUrl: 'http://49.142.157.251:9090/javaweb8S/about/askDetail?idx=${vo.idx}', 
	          },
	        },
	      ],
	    });
	  }
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
 			<div style="margin:0px auto;">
		 		<div style="background-color:white; padding:20px; margin-bottom:30px">
		 			<div class="row">
		 				<div class="col-3 text-left">
		 					<a class="btn btn-dark mb-4" href="javascript:returnPath()" style="margin-left:20px;">
								<i class="fa-solid fa-chevron-left"></i>
							</a>
		 				</div>
		 				<div class="col-6 text-center">
							<a href="${ctp}/about/ask">
			 					<span class="text-center" style="font-size:23px; color:grey; text-align:center;">문의)</span>
							</a>
		 				</div>
		 				<div class="col-3 text-right">
						  <a class="btn btn-warning" href="javascript:shareMessage()" style="margin-right:20px;"><i class="fa-solid fa-share-from-square"></i>&nbsp;카카오톡 공유</a>
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
					<div class="infoBox">
						<div class="row">
							<div class="col">
								<span style="font-size:16px">문의 종류)</span>&nbsp;&nbsp;<b class="mr-5">${vo.category}</b>			
							</div>
							<div class="col text-right">
								<c:if test="${vo.category == '컬렉션상품'}"><a href="${ctp}/collection/colProduct?idx=${vo.originIdx}"><u><i class="fa-solid fa-magnifying-glass"></i>${vo.originName}</u></a></c:if>		
								<c:if test="${(vo.category == '매거진') || (vo.category == '정기구독')}"><a href="${ctp}/magazine/maProduct?idx=${vo.originIdx}"><u><i class="fa-solid fa-magnifying-glass"></i>${vo.originName}</u></a></c:if>		
							</div>
						</div>
					</div>
		 		</div>
				
				<div style="padding:20px 80px">
					${vo.askContent}
				</div>
				<div style="padding:20px 20px 50px 20px;">
				  <hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
				</div>
			  
			  <div id="answerSection">
		  	  <div class="w3-bar">
				    <button class="w3-bar-item w3-button tablink w3-blue" onclick="openCity(event,'answer')">
<!-- 				    <button class="w3-bar-item w3-button tablink w3-black" onclick="openCity(event,'answer')"> -->
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
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>