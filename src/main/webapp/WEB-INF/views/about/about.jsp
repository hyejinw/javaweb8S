<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
	<script src="https://unpkg.com/jquery-aniview/dist/jquery.aniview.js"></script>
	<style>
		@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
		}
		.titles {font-family: 'TheJamsil5Bold', 'SUIT-Regular', sans-serif;}
		
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
    	border: 0px;
    	width: 100%;
    	height: 100%;
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
    #subscribeBox {
    	border: 2px solid #282828;
    	width: 100%;
    	max-width: 600px;
    	height: 100%;
    	max-height: 500px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	margin: 0 auto;
    	padding: 30px 50px;
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
		
		// 스크롤 시, 자동 위로 애니메이션
		$(document).ready(function(){
      $('.aniview-v4').AniView({
          animateClass: 'animate__animated'
      });
    });
		
		// 회원일 경우 해당 이메일에 달린 별명 배열
		let memNicknameArray = new Array();
		
		// 1. 뉴스레터 (비회원 + 회원)
		function booksletterCheck() {
			let email = document.getElementById('email').value;
			let regex1 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;  // 이메일 정규식
			
			if(email == "") {
				alert('책(의)편지를 수신할 이메일을 작성해주세요.');
				document.getElementById('email').focus();
				return false;
			}
			if(!regex1.test(email)) {
				alert('책(의)편지를 수신할 이메일을 올바르게 작성해주세요.');
				document.getElementById('email').focus();
				return false;
			}
			
			if('${sNickname}' == "") {
				
				$.ajax({
					type : "post",
					url : "${ctp}/about/booksletterEmailCheck",
					data : {email : email},
					success : function(res) {
						
						// 회원
						if(res != "") {
							
							for(let i=0; i<res.length; i++) memNicknameArray.push(res[i]);
							
							alert('회원이시군요! 회원 별명을 추가로 입력해주세요.');
							let str = '<input type="text" name="memNickname" id="memNickname" placeholder="회원 별명을 입력해주세요." class="form-control"/>';
							document.getElementById('demo').innerHTML = str;
							document.getElementById('memNickname').focus();
							
							$("#email").prop("readonly",true);
							$('#booksletterBtnMem').css('display','inline-block');
							$('#booksletterBtn').css('display','none');
						}
						// 비회원
						else{
							// 이미 구독 중인 이메일인지 확인
							booksletterSubCheckNoneMem(email);
						}
					},error : function() {
						alert('전송 오류! 재시도 부탁드립니다.');
					}
				});
			}
			// 로그인한 회원
			else {
				booksletterSubCheckMem(email, '${sNickname}');
			}
			
		}
		
		// 2-1. 뉴스레터 (회원)
		function booksletterCheckMem() {
			let email = document.getElementById('email').value;
			let memNickname = document.getElementById('memNickname').value;
			
			let regex1 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;  // 이메일 정규식
			let regex2 = /^[가-힣0-9]+$/; //(별명)한글,영문,숫자만 적어도 1자이상 

			
			if(email == "") {
				alert('책(의)편지를 수신할 이메일을 작성해주세요.');
				document.getElementById('email').focus();
				return false;
			}
			if(!regex1.test(email)) {
				alert('책(의)편지를 수신할 이메일을 올바르게 작성해주세요.');
				document.getElementById('email').focus();
				return false;
			}
			if(memNickname == "") {
				alert('회원 별명을 이메일을 작성해주세요.');
				document.getElementById('memNickname').focus();
				return false;
			}
			if(!regex2.test(memNickname)) {
				alert('회원 별명을 올바르게 작성해주세요.');
				document.getElementById('memNickname').focus();
				return false;
			}
			
			// 해당 이메일에 맞는 별명인지 확인
			if(!memNicknameArray.includes(memNickname)) {
				alert('해당 별명은 이메일과 일치하지 않습니다.');
				document.getElementById('memNickname').focus();
				return false;
			}
			booksletterSubCheckMem(email, memNickname);
		}
		
		// 2-2. 뉴스레터 (비회원, 이미 구독 중인지 확인)
		function booksletterSubCheckNoneMem(email) {
			
			$.ajax({
				type : "post",
				url : "${ctp}/about/booksletterCheck",
				data : {email : email},
				success : function(res) {
					if(res != "") {
						alert('해당 이메일로 '+res + ' 부터 책(의)편지를 구독 중입니다.');
						return false;
					}
					else {
						booksletterInsert('none');
					}
				}, error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
				
			});
		}
		
		// 2-3. 뉴스레터 (회원, 이미 구독 중인지 확인)
		function booksletterSubCheckMem(email, memNickname) {
			
			$.ajax({
				type : "post",
				url : "${ctp}/about/booksletterCheck",
				data : {
					email : email,
					memNickname : memNickname
					},
				success : function(res) {
					if(res != "") {
						alert('해당 이메일로 '+res + ' 부터 책(의)편지를 구독 중입니다.');
						return false;
					}
					else {
						if('${sNickname}' != "") booksletterInsert('none');
						else booksletterInsert('check');
					}
				}, error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 3. 뉴스레터 수신에 추가
		function booksletterInsert(flag) {
			let email = document.getElementById('email').value;
			let memNickname = "";
			
			// 로그인하지 않고 사용하는 회원
			if(flag == 'check') {
				memNickname = document.getElementById('memNickname').value;
			}
			
			// 로그인 후 사용하는 회원
			if('${sNickname}' != "") {
				memNickname = '${sNickname}';
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/about/booksletterInsert",
				data : {
					email : email, 
					memNickname : memNickname
				},
				success : function(res) {
					alert('매주 월요일 오후 3시, 메일함에서 책(의)편지를 찾아주세요.');
					location.reload();
					
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
 <div class="text-center animate__animated animate__fadeInDown" style="margin:150px 0px 50px 0px">
		<img src="${ctp}/images/aboutPhoto.png" style="width:70%; max-width:2500px"/>
	</div>
	
	<div id="container" style="margin:100px 0px 100px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding-bottom:20px">책(의)세계란?</h2>
			<div class="text-center">
				<span style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책의 세계를 지키며 맘껏 누리기 위한 공간&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span class="w3-text w3-tag" style="margin:0px auto; font-size:14px; font-style:italic;"><b>책의 세계는 원래 우리의 것이었다.</b></span>
				</span>
			</div>
			<br/><br/>
			<!-- <div class="row">
				<div class="col-4"></div>
				<div class="col-4 text-center">
					<hr style="border:0.5px solid gray; margin-left:175px; width:0.05px; height:180px;"/>
				</div>
				<div class="col-4"></div>
			</div>
			<br/><br/> -->
			<div class="aniview-v4" data-av-animation="animate__fadeInUp">
		    <div class="row" style="margin-top:100px">
					<div class="col-5" style="font-size:16px;">
						<span style="font-size:22px" class="titles">인류 문명은</span><br/>
						<hr style="border:0px; height:1.5px; background:#282828; margin:10px 0px"/>
						<b>인류 문명은 읽고 쓰는 삶 위에 존재합니다.</b><br/><br/>
						기록은 아주 오래 전부터 우리의 곁에서 함께 했죠.<br/>
						지금 우리가 누리는 모든 것은 책이란 터 위에서 가능했습니다.<br/>
						고도로 발달한 현대 사회에서 책을 읽는다는 것은,<br/>
						마치 대단한 일로 여겨져 점점 짐처럼 느껴집니다.<br/>
						사실 그렇지 않은데도 말이죠.<br/>
					</div>
					<div class="col-2"></div>
					<div class="col-5" style="font-size:16px;">
						<span style="font-size:21px" class="titles">책(의)세계는</span><br/>
						<hr style="border:0px; height:1.5px; background:#282828; margin:10px 0px"/>
						<b>책(의)세계는 가볍고 즐거운 책의 세계로 여러분을 초대합니다.</b><br/><br/>
						누가 더 많은 지식을 가졌는지,<br/>
						많은 좋아요를 받았는지,<br/>
						많은 친구를 가졌는지 상관없습니다.<br/>
						우린 그저 책을 가볍고 즐겁게 누릴 경험을 시작하고 공유하면 됩니다.<br/>
					</div>
				</div>
			</div>
			
			<div class="aniview-v4" data-av-animation="animate__fadeInUp">
				<div class="row" style="margin:200px 0px 150px 0px;">
					<div class="col-5" style="font-size:16px;">
						<span style="font-size:22px" class="titles">매거진 책 Chaeg은</span>&nbsp;&nbsp;
						<button type="button" data-toggle="modal" data-target="#aboutChaeg" style="border:0px; background-color:transparent;">
							<i class="fa-solid fa-circle-plus" style="color:#41644A; font-size:25px"></i>
						</button>
						<br/>
						<hr style="border:0px; height:1.5px; background:#282828; margin:10px 0px"/>
						<b>책을 많이 읽는 사람만을 위한 잡지는 아닙니다.</b><br/><br/>
						굳이 많이 읽지 않아도 책을 좋아하거나, 즐겨 사거나, 좋아하지만 어쩐지 책이 어렵게 느껴지는 사람들, 그리고 책이 재미없는 사람들 모두를 위한 잡지입니다.<br/>
						‘책을 읽자’ ‘더 똑똑해지자’식의 계몽을 위한 잡지는 아닙니다. 더 나은 사람들이 만드는 잡지도 아닙니다.다만 맛있는 음식이 넘쳐나는 잔치에 더 많은 사람들을 초대하고 싶은 마음으로 만듭니다.
					</div>
					<div class="col-2"></div>
					<div class="col-5" style="font-size:16px;">
						<span style="font-size:21px" class="titles">3개의 책은</span>&nbsp;&nbsp;
						<button type="button" data-toggle="modal" data-target="#aboutCommunity" style="border:0px; background-color:transparent;">
							<i class="fa-solid fa-circle-plus" style="color:#41644A; font-size:25px"></i>
						</button>
						<br/>
						<hr style="border:0px; height:1.5px; background-color:#282828; margin:10px 0px"/>
						<b>책(의)세계에서 운영하는 책 커뮤니티입니다.</b><br/><br/>
						여기 책(의)세계에는 3개의 책이 존재합니다.<br/>
						너, 나 그리고 우리라고 이름한 이 세계의 주제는 연결입니다.<br/>
						점점 소멸되어 가는 책의 세계를 연결하고,<br/>
						재미있는 지식의 연결을 통해 너와 내가 우리로 확장되는 기쁨을 향락하는 공간입니다.<br/>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<!-- 	<div class="container-xl aniview-v4" data-av-animation="animate__bounceInUp" style="margin-bottom:150px"> -->
	<div class="container-xl aniview-v4" data-av-animation="animate__fadeInDown" style="margin-bottom:150px">
		<div class="infoBox" style="padding:50px;">
			<div class="text-center">
			<hr style="border:0px; height:0.5px; background-color:gray"/>
				<span style="margin:0px auto; font-size:25px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;<font class="titles">내가 세계를 알게 된 것은 책에 의해서였다</font>&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span style="margin:0px auto; font-size:20px; font-style:italic;">사르트르</span><br/>
					<a href="${ctp}/member/memberJoin"><span class="w3-text w3-tag" style="margin:0px auto; font-size:14px; font-style:italic;"><b>여기서 시작하기</b></span></a>
				</span>
			</div>
		</div>
	</div>
	
	<!-- 뉴스레터 -->
	<div class="container text-center" style="margin-bottom:180px">
		<div id="subscribeBox">
			<div><i class="fa-solid fa-envelope-open-text" style="font-size:30px"></i></div><br/>
			<div style="font-size:25px"><b>뉴스레터</b></div><br/>
			<form name="booksletterForm" method="post">
				<div class="input-group">
					<input type="text" name="email" id="email" placeholder="뉴스레터를 수신할 이메일을 적어주세요." class="form-control"/>
					<div class="input-group-append">
						<input type="button" id="booksletterBtn" onclick="booksletterCheck()" class="btn btn-outline-danger" value="구독"/>
						<input type="button" id="booksletterBtnMem" onclick="booksletterCheckMem()" class="btn btn-outline-warning" value="구독" style="display:none"/>
					</div>
				</div>
				<div id="demo" class="mt-3"></div>
			</form>
			<br/>
			<div>
				<span style="font-size:15px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51; font-size:20px;"></i>&nbsp;&nbsp;&nbsp;<b>매주 책(의)편지가 찾아갑니다.</b></span><br/>
				<span style="font-size:15px;">&nbsp;&nbsp;&nbsp;<b>월요일 오후 3시, 메일함에서 책(의)편지를 확인해보세요.</b></span><br/>
				<br/>
				이메일 : info@chaeg.co.kr<br/>	
				전화번호 : 02-6228-5589<br/>
			</div>
		</div>
	</div>
		
	<!-- The Modal -->
  <div class="modal fade" id="aboutChaeg">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div class="infoBox">
						<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">매거진 책 Chaeg</div>
						<div style="padding:20px">
							<b>비치 배포처</b><br/><br/>
							그랜드하얏트서울호텔(서울시 용산구 소월로 322) / 미스지콜렉션 본점 (서울시 강남구 청담동 83-14) / 앤트러사이트(서울시 마포구 토정로 5길 10) / rave espresso bar(서울시 마포구 성산동 260-1) / 느티나무 도서관(경기도 용인시 수지구 수풍로 116번길 22) / 경기도립과천도서관 / 경기도립평택도서관 / 김천시립도서관 / 달서구립본리도서관 / 도솔도서관 / 샛별도서관 / 부산광역시시립서동도서관 / 아우내도서관 / 역삼푸른솔 도서관 / 전주책마루어린이도서관 / 선문대학교 도서관 / 천일어린이도서관 웃는책 / 초당대학교 도서관 / 파주 적성도서관 / 파주문산도서관 / 파주법원도서관 / 파주시중앙도서관 / 한빛도서관 / 해솔도서관 / 교하도서관 / 탄현도서관 / 강남구립못골도서관 / 도란도란 작은도서관 / 레인보우영동도서관
						</div>
					</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        </div>
        
      </div>
    </div>
  </div>
		
	<!-- The Modal -->
  <div class="modal fade" id="aboutCommunity">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div class="infoBox">
						<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">3개의 책</div>
						<div style="padding:20px">
							<b>너, 나 그리고 우리라고 이름한 이 세계</b><br/><br/>
							어떻게 하면 책의 세계를 좀 더 매력적으로 보이게 할까라는 고민에서 출발합니다. 책의 위대함보다 삶과 맞닿아 있는 실용적 가치에 매력의 초점을 맞춥니다. 실용적 가치에는 여러 종류가 있습니다. 계란말이를 맛있게 마는 방법을 알려주는 책도 실용적이지만 이유 없이 찾아온 상실감의 정체를 알아보고 싶을 때 도움을 주는 책도 실용적입니다. 이런 매력에는 국적, 문화, 장르의 상하도 구분도 없습니다. 다양한 목적, 의견, 사람, 문화, 시선을 통해 책의 매력을 함께 제시해나갑니다.
						</div>
					</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        </div>
        
      </div>
    </div>
  </div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>