<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>책(의)세계</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
	<script src="${ctp}/js/owl.carousel.js"></script> 
	<script src="${ctp}/js/owl.carousel.min.js"></script>
  <style>
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
		.updown {
    	border: 1px solid grey;
      width: 0.1px;
      height: 400px;
		  margin-left : auto;
		  margin-right : auto;
		  margin-top: 100px;
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
					if(reportCategory == '문장수집') sessionStorage.setItem('inspiredSW', 'ON'); 
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
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
	    		url   : "${ctp}/community/insSaveDelete",
	    		data  : {
	    			memNickname  : '${sNickname}',
	    			insIdx : insIdx,
	    			idx : insSaveIdx
					},
	    		success:function() {
	    			alert("문장수집 저장이 취소되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
		}

		// 회원 페이지 열기
  	function memPage(memNickname) {
			let url = "${ctp}/community/memPage?memNickname="+memNickname;
	
			let popupWidth = 1000;
			let popupHeight = 1200;
	
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
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
	
		<div class="row" style="margin: 60px 0px 0px 30px">
			<div class="col-5" style="padding-left:30px">
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
			<div class="col-1"><div class="updown"></div></div>
			
			<div class="col-6"  style="padding-right:30px">
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
		  	<div style="overflow:scroll; width:100%; max-width:1000px; height:400px; padding:20px; background-color:#eee">
				
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
		
				    	<p class="ml-4" style="color:grey;">『 ${inspiredVO.bookTitle} 』(${inspiredVO.authors})&nbsp;&nbsp;${inspiredVO.page}</p>
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
					    	<div class="col text-right">
					    		<div style="padding:10px">
						    		<c:if test="${inspiredVO.insSaveIdx == 0}"><i class="fa-regular fa-bookmark save" style="font-size:25px" onclick="insSave('${inspiredVO.idx}', '${inspiredVO.insSaveIdx}')" title="관심등록되지 않은 문장수집 입니다"></i></c:if>
										<c:if test="${inspiredVO.insSaveIdx != 0}"><i class="fa-solid fa-bookmark save" style="font-size:25px" onclick="insSave('${inspiredVO.idx}', '${inspiredVO.insSaveIdx}')" title="관심등록된 문장수집"></i></c:if>
					  				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a href="#" class="btn btn-outline-secondary" onclick="reportCategory('문장수집','${inspiredVO.memNickname}','${inspiredVO.idx}')" data-toggle="modal" data-target="#reportModal">
											신고
										</a>
					    		</div>
					    	</div>
					    </div>
					  </div>
					</div>
				</c:forEach>
			</div>
		</div>	
	</div>	
	
	<div style="margin:100px 0px 0px 0px; background-color:red">
	 ddfs
		<div class="owl-carousel owl-theme">
			<c:forEach var="bookVO" items="${bookVOS}">
		    <div class="item"><a href="javascript:bookPage(${bookVO.idx})"><img src="${bookVO.thumbnail}" /></a></div>
	    </c:forEach>
		</div>
	</div>
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
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
  
	
</body>
<script>

	// 가장 많이 저장된 책 캐러셀
	$(document).ready(function () {
    (function ($) {
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
		        1000:{ items:3 },
		        1200:{ items:4 }
			    }
        });
    })(jQuery);
	});
	

</script>
</html>