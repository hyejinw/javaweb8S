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
	<link type="text/css" rel="stylesheet" href="animate.css">
	<script type="text/javascript" src="jquery.aniview.js"></script>
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
		
		
		$(document).ready(function(){
    	// 해당 엘리먼트를 가져와 AniView() 실행
        $('.aniview').AniView({
            animateClass: 'animate__animated' // animate.css를 aniview에 등록
        });
    });
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
	    <div class="row animate__animated animate__fadeInUp" style="margin-top:100px">
			<!-- <div class="row aniview" data-av-animation="animate__slideInUp" style="margin-top:100px"> -->
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
			
			<div class="row" style="margin-top:100px">
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
					<button onclick="aboutCommunity()" style="border:0px; background-color:transparent;">
						<i class="fa-solid fa-circle-plus" style="color:#41644A; font-size:25px"></i>
					</button>
					<br/>
					<hr style="border:0px; height:1.5px; background:#282828; margin:10px 0px"/>
					<b>책(의)세계에서 운영하는 책 커뮤니티입니다.</b><br/><br/>
					여기 책(의)세계에는 3개의 책이 존재합니다.<br/>
					너, 나 그리고 우리라고 이름한 이 세계의 주제는 연결입니다.<br/>
					점점 소멸되어 가는 책의 세계를 연결하고,<br/>
					재미있는 지식의 연결을 통해 너와 내가 우리로 확장되는 기쁨을 향락하는 공간입니다.<br/>
				</div>
			</div>
			책을 읽는 건 특별한 누군가만 하는 대단한 행위가 아니라, 그저 신나고 재미있는 경험입니다.
		</div>
	</div>
	
	<!-- The Modal -->
  <div class="modal fade" id="aboutChaeg">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          Modal body..
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
</html>