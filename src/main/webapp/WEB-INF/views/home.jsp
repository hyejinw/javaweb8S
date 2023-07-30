<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>책(의)세계</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
	<script src="${ctp}/js/owl.carousel.js"></script> 
	<script src="${ctp}/js/owl.carousel.min.js"></script>
	<style>
		body,h1,h2,h3,h4,h5,h6 {font-family: 'Noto Sans KR', sans-serif;}
		
		body, html {
		  height: 100%;
		  line-height: 1.8;
		}
		
		.mySlides {display:none;}
		.w3-left, .w3-right, .w3-badge {cursor:pointer}
		.w3-badge {height:13px;width:13px;padding:0}

		/* Full height image header */
		.bgimg-1 {
		  background-position: center;
		  background-size: cover;
		  background-image: url("/w3images/mac.jpg");
		  min-height: 100%;
		}
		
		.w3-bar .w3-button {
		  padding: 16px;
		}
		
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
		.item {
			width: 500px;
			margin: 5px;
		}
		.item:hover {
			transform: scale(1.05);
			transition: transform 0.15s ease 0s;
		}
		.owl-carousel {
			z-index: 0;
		}
		.updown {
    	border: 1px solid white;
      width: 0.1px;
      height: 600px;
		  margin-left : auto;
		  margin-right : auto;
		  padding: 0px;
    }
    #OLRBookTitle a {
    	text-decoration-line: none;
    }
    #OLRBookTitle b:hover {
    	color: gray;
    }
    #OLRBox {
    	border: 2px solid white;
    	border-radius: 20px;
    	width: 100%;
    	max-width: 600px;
    	height: 100%;
    	max-height: 200px;
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
    #indexBox {
	    margin-bottom:-50px; 
	    border: 2px solid rgba(254, 251, 232);
/* 	    border: 2px solid #E3F4F4; */
/* 	    background-color: #FFF4D2; */
	    background-color: white;
	    z-index: 1;
		  position: relative;
		  top: 2px;
		  border-radius: 30px
    }
	</style>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

	<div class="w3-content w3-display-container" style="max-width:5000px;">
	 	<div class="w3-display-container mySlides">
		  <img src="${ctp}/resources/images/main_banner1.jpg" style="width:100%">
		  <div class="w3-display-bottomright w3-container">
		    <p style="margin:0px 50px 100px 0px; font-size:17px"><b>
		    	책(의)세계에서 발행하는 책Chaeg은<br/>
		    	책을 좋아하는 사람들이 만든 책과 문화에 관한 월간지입니다.<br/><br/></b>
		    	책을 많이 읽는 사람만을 위한 잡지는 아닙니다.<br/>
		    	굳이 많이 읽지 않아도 책을 좋아하거나, 즐겨 사거나,<br/>
		    	힐끗 책의 세계에 다가가보기 원하는 사람 모두를 위한 잡지입니다.<br/>
		    </p>
		  </div>
		</div>
	 	<div class="w3-display-container mySlides">
		  <img src="${ctp}/resources/images/main_banner2.jpg" style="width:100%">
		  <div class="w3-display-bottomright w3-container">
		    <p style="margin:0px 50px 100px 0px; font-size:17px"><b>
		    	'3개의 책'은 책(의)세계에서 운영하는 책 커뮤니티 입니다.<br/><br/></b>
				  세상은 나와 너, 우리로 만들어진 '3개의 책' 이란 테마 안에서,<br/> 
		    	매일 새로운 이야기와 물음으로 책의 안팎과 주변의 세계를 살피고 있습니다.<br/>
					다양한 목적의 의미있는 일에 기여하기를, 마침내 책에 대한 호기심으로<br/>
					이어지기를 소원합니다.<br/>
		    </p>
		  </div>
		</div>
	 	<div class="w3-display-container mySlides">
		  <img src="${ctp}/resources/images/main_banner3.jpg" style="width:100%">
		  <div class="w3-display-bottomright w3-container">
		    <p style="margin:0px 50px 100px 0px; font-size:17px"><b>
		    	책의 세계는 가볍고 즐거워야 합니다.<br/><br/></b>
		    	책(의)세계는 ‘책을 읽자’ ‘더 똑똑해지자’식의 계몽을 위한 공간이 아닙니다.<br/>
		    	다만 맛있는 음식이 넘쳐나는 잔치에 더 많은 사람들을<br/>
		    	초대하고 싶은 마음으로 가꾼 열린 공간입니다.<br/>
		    </p>
		  </div>
		</div>
	 <button class="w3-button w3-display-left" onclick="plusDivs(-1)"><font color="#282828" size="6px">&#10094;</font></button>
	 <button class="w3-button w3-display-right" onclick="plusDivs(1)"><font color="#282828" size="6px">&#10095;</font></button>

	  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
	  </div>
	</div>
	
	<!-- 최신 매거진 20개 -->
	<div class="container-fluid" style="margin: 150px 0px">
		<div class="text-center" style="margin-bottom:50px">
			<div class="text-center"><span style="font-size:18px;">오직 당신만을 위한 매거진</span><hr style="background-color:#9BA4B5; width:50%; height: 1px; margin:20px auto;"/></div>
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding:20px 0px">책 Chaeg</h2>
			<span style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책 세계 함께 다다르기(differeach)&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
				<span class="w3-text w3-tag"  style="margin:0px auto; font-size:14px; font-style:italic;"><b>우리는 다 다르고, 그래서 서로에게 다다를 수 있어요.</b></span>
			</span>
		</div>
		<div class="owl-carousel owl-theme">
			<c:forEach var="magazineVO" items="${magazineVOS}">
		    <div class="item"><a href="${ctp}/magazine/maProduct?idx=${magazineVO.idx}"><img src="${ctp}/magazine/${magazineVO.maThumbnail}" /></a></div>
	    </c:forEach>
		</div>
	</div>
	
<!-- 	<div class="container-fluid" style="background-color:#E1ECC8; margin:150px 0px; color:#282828; padding:30px"> -->
	<div class="" style="margin-top:150px; ">
		<div class="text-center"><span style="font-size:18px;">우리를 위한 책 커뮤니티</span><hr style="background-color:#9BA4B5; width:50%; height: 1px; margin:20px auto;"/></div>
	</div>
	<div class="container text-center" id="indexBox">
		<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding:20px 0px">3개의 책</h2>
	</div>
	
<!-- 	<div class="container-fluid" style="background-color:white; margin-bottom:150px; color:#282828; padding:30px; z-index: 2; border: 1px solid #282828;"> -->
	<div class="container-fluid" style="background-color:rgba(254, 251, 232); margin-bottom:150px; color:#282828; padding:30px; z-index: 2;">
		<div class="row" style="padding-top:50px">
			<div class="col-5" style="padding-left:50px">
  	  	<br/><div class="container text-center">
					<div class="text-center" style="border-radius:10px; margin:0px auto; font-size:30px; font-weight:bold; padding:20px 0px; background-color:white; color:#282828;">
						<div class="row">
							<div class="col-3"></div>
							<div class="col-6">랜덤 도서 추출기</div>
							<div class="col-3 text-left"><button type="button" class="btn btn-warning" onclick="randomBook()">랜덤 추출</button></div>
						</div>
						<hr style="background-color:#9BA4B5; width:50%; height: 1px; margin:5px auto;"/>
						<p class="w3-text w3-tag" style="margin:0px auto; font-size:15px; font-style:italic;">랜덤 도서 찾기로 인생책을 만나볼까요?</p>
					</div>
  	  	</div>
  	  	<div id="bookDemo"></div>
			</div>
			
			<div class="col-2"><div class="updown"></div></div>
			
			<div class="col-5"  style="padding-right:50px">
		    <br/>
		    <div class="container text-center">
					<div class="text-center" style="border-radius:10px; margin:0px auto; font-size:30px; font-weight:bold; padding:20px 0px; background-color:white; color:#282828;">
						<div class="row">
							<div class="col-3"></div>
							<div class="col-6">최근 수집된 문장</div>                                      
							<div class="col-3 text-left"></div>
						</div>
		  	  	
						<hr style="background-color:#9BA4B5; width:50%; height: 1px; margin:5px auto;"/>
						<p class="w3-text w3-tag" style="margin:0px auto; font-size:15px; font-style:italic;">회원이 직접 선정한 구절을 소개합니다.</p>
					</div>
		  	</div>
		  	<div style="overflow:scroll; width:100%; max-width:1000px; height:400px; padding:20px; background-color:#eee; margin-top:20px">
					
					<c:forEach var="inspiredVO" items="${inspiredVOS}" varStatus="st">
						<div class="row" style="padding:5px">
							<div class="w3-panel w3-sand" style="margin:10px; width:100%; max-width:800px">
			        	<div class="row">
						    	<div class="col">
								    <span style="font-size:80px; line-height:0.6em; opacity:0.2">❝</span>
								    <p class="w3-xlarge" style="margin:-40px 0px 0px 0px; padding:10px">
								    	<i style="font-size:15px;">${inspiredVO.insContent}</i>
								    </p>
						    	</div>
						    </div>
			
					    	<p class="ml-4" style="color:grey;">
				    			『 ${inspiredVO.bookTitle} 』(${inspiredVO.authors})&nbsp;&nbsp;${inspiredVO.page}
				    		</p>
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
											    </div>
											  </span>
								    	</c:if>
								    </div>
						    	</div>
						    </div>
						  </div>
						</div>
					</c:forEach>
				</div>
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
	
	<!-- 책 상세내용 -->
 	<!-- The Modal -->
  <div class="modal fade" id="bookModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
					<div style="text-align:center">
						<a id="bookDetailUrl1" href="#" target="_blank">
							<span id="bookDetailTitle" class="text-center" style="font-size:20px; text-align:center; font-weight:bolder"></span>
						</a>
					</div>
					<div style="text-align:center; margin-bottom:40px"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
						<span id="bookDetailAuthors"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailPublisher"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailTranslators"></span>
						<br/><span id="bookDetailIsbn"></span>
						<br/><span id="bookDetailDatetime"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailPrice"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailStatus"></span>
					</span></div>
			    
			    <div class="row">
		  			<div class="col-3 text-center">
		  				<a id="bookDetailUrl2" href="#" target="_blank"><img src="#" id="bookDetailThumbnail"/></a>
		  			</div>
		  			<div class="col-9 text-center">
		  				<div class="row"><div class="col"><span id="bookDetailBookRate"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailSave"></span></div></div>
		  				<div class="row"><div class="col" id="bookDetailBookUpdate"></div></div>
		  				<div class="row m-3"><div class="col" id="bookDetailContents"></div></div>
		  			</div>
		  		</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>	
  
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
<script>
	var slideIndex = 1;
	showDivs(slideIndex);

	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}

	function currentDiv(n) {
	  showDivs(slideIndex = n);
	}

	function showDivs(n) {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("demo");
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" w3-white", "");
	  }
	  x[slideIndex-1].style.display = "block";  
	  dots[slideIndex-1].className += " w3-white";
	}
	
	
	var myIndex = 0;
	carousel();
	
	function carousel() {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  myIndex++;
	  if (myIndex > x.length) {myIndex = 1}    
	  x[myIndex-1].style.display = "block";  
	  setTimeout(carousel, 15000); // Change image every 15 seconds
	}

	// Modal Image Gallery
	function onClick(element) {
	  document.getElementById("img01").src = element.src;
	  document.getElementById("modal01").style.display = "block";
	  var captionText = document.getElementById("caption");
	  captionText.innerHTML = element.alt;
	}
	
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
	
	// 최신 매거진 캐러셀
	$('.owl-carousel').owlCarousel({
	    stagePadding: 50,
	    loop:true,
	    margin:0,
	    nav:true,
	    autoplay:true,
	    autoplayTimeout:5000,
	    autoplayHoverPause:true,
	    responsive:{
        0:{ items:1 },
        600:{ items:1 },
        800:{ items:2 },
        900:{ items:2 },
        1000:{ items:2 },
        1300:{ items:3 }
	    }
	})

	// 랜덤 책 추출기
	function randomBook() {
		
		$.ajax({
		  type : "post",
		  url : "${ctp}/home/randomBook",
		  dataType: "json",
		  success : function(bookVO) {
			  
				let str = "";
				str += '<br/><br/><div class="row" style="padding:20px">';
				str += '<div class="col-3 text-center"><a href="'+bookVO.url+'" target="_blank"><img src="'+bookVO.thumbnail+'" style="width:100%; max-width:500px" /></a></div>';
				str += '<div class="col-9 text-center">';
				str += '<div class="row"><div class="col"><a href="'+bookVO.url+'" target="_blank"><b>'+bookVO.title+'</b></a></div></div>';
				str += '<div class="row"><div class="col">'+bookVO.authors+'&nbsp;&nbsp; | &nbsp;&nbsp;'+bookVO.publisher+'</div></div>';
				str += '<div class="row m-3"><div class="col">'+bookVO.contents+'...</div></div>';
				str += '</div>';
				str += '<hr/>	';

				document.getElementById("bookDemo").innerHTML = str;
			},
			error : function() {
				alert("전송 오류! 재시도 부탁드립니다.");
			}
		}); 
	}
	
	function randomOLR() {
		
	}
	/* // 책 저장(좋아요)
	function bookSave() {
		
		if('${sNickname}' == "") {
			alert('로그인 후 사용해주세요.');
			location.href = "${ctp}/member/memberLogin";
			return false;
		}
		
		if('${bookSaveVO}' == "") {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/community/bookSave",
    		data  : {
    			bookIdx : ${OLRVO.bookIdx},
				  memNickname  : '${sNickname}'
				},
    		success:function() {
    			alert("관심 책에 추가되었습니다.");
    			//location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	}); 
		}
		else {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}community/bookSaveDelete",
    		data  : {
    			bookIdx : ${OLRVO.bookIdx},
				  memNickname  : '${sNickname}'
				},
    		success:function() {
    			alert("관심 책에서 삭제되었습니다.");
    			//location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	}); 
		}
	} */
	
	function bookDetail(idx,title,contents,url,isbn,datetime,authors,publisher,translators,price,sale_price,thumbnail,status,bookRate,save,bookUpdate) {
		$("#bookDetailIdx").text(idx);
		$("#bookDetailTitle").text(title);
		$("#bookDetailContents").text(contents);
		
		if(contents != "") {
			$("#bookDetailContents").text(contents + "...");
		}
		else {
			$("#bookDetailContents").text("책 상세내용이 없습니다");
		}

		document.getElementById('bookDetailUrl1').setAttribute('href', url);
		document.getElementById('bookDetailUrl2').setAttribute('href', url);
		document.getElementById('bookDetailThumbnail').setAttribute('src', thumbnail);
		
		$("#bookDetailIsbn").text("isbn : " + isbn);
		
		$("#bookDetailDatetime").text('출판일 : ' + datetime.substring(0,9));
		
		$("#bookDetailAuthors").text('저자 : ' + authors);
		$("#bookDetailPublisher").text(publisher);
		
		if(translators != "") {
			$("#bookDetailTranslators").text('번역 : ' + translators);
		}
	
		$("#bookDetailPrice").text(price + "원");
		$("#bookDetailSale_price").text(sale_price);
		
		$("#bookDetailStatus").text(status);
		$("#bookDetailBookRate").text("평점 : " + bookRate);
		$("#bookDetailSave").text("저장 수 : " + save);
		$("#bookDetailBookUpdate").text("저장일 : " + bookUpdate.substring(0,19));
	} 
	
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
</html>
