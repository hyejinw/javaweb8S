<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>책(의)세계</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
 		html {scroll-behavior:smooth;}
 		
 		a {
		  color: gray;
		  text-decoration: none;
		}
		a:hover {
		  color: #41644A;
		}
		a.active {
		  color: #282828;
		  font-weight: bold
		}
		@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
		}
  	.title {
  		font-size:25px;
  		font-weight:bold;
  		font-family: 'TheJamsil5Bold', 'SUIT-Regular', sans-serif;
  	}
  
	  .navTitle {
	  	font-size:20px;
  		font-weight:bold;
  		padding:10px;
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
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    }
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 500px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
		.infoBox3 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	box-sizing: border-box;
    	background-color: white;
    }
    
		/* * { padding: 0px; margin: 0px; }
		html, body { max-width: 100%; height:100%; background-color: skyblue; } */
		
		#wrap { display: flex; width: 100%; height: 100%; justify-content: center; align-items: center; }
		#diceBox { max-width: 600px; width: 90vw; height: auto; background-color: #fff; padding: 30px; box-sizing: border-box; }
		#diceBox > .dice_wrap { width: 100%; height: auto; display: flex; margin-bottom: 20px;}
		#diceBox > .dice_wrap > [class^=dice]:last-of-type {margin-right: 0px;}
		/* 주사위 만들기 */
		#diceBox > .dice_wrap > [class^=dice] { width: 49%; margin-right: 2%; padding-top: 49%; position: relative; }
		.dice_inner { position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; perspective: 300px; padding: 20%; box-sizing: border-box; }
		#diceBox > .dice_wrap > [class^=dice] .dice { width: 100%; height: 100%; transform-style: preserve-3d; transition: 1s; }
		#diceBox > .dice_wrap > [class^=dice] .dice > div { position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; justify-content: center; align-items: center; opacity: 0.8; color: #fff; font-size: 60px; }
		#diceBox > .dice_wrap > [class^=dice] .dice .face1 { transform: rotateY(0deg) translateZ(60px); background: red; }
		#diceBox > .dice_wrap > [class^=dice] .dice .face2 { transform: rotateY(90deg) translateZ(60px); background: blue; }
		#diceBox > .dice_wrap > [class^=dice] .dice .face3 { transform: rotateX(90deg) translateZ(60px); background: green; }
		#diceBox > .dice_wrap > [class^=dice] .dice .face4 { transform: rotateX(270deg) translateZ(60px); background: pink; }
		#diceBox > .dice_wrap > [class^=dice] .dice .face5 { transform: rotateY(270deg) translateZ(60px); background: royalblue; }
		#diceBox > .dice_wrap > [class^=dice] .dice .face6 { transform: rotateY(180deg) translateZ(60px); background: purple; }
		/* 주사위 눈 */
		#diceBox > .dice_wrap > [class^=dice] .dice.face1 { transform: rotateX(0deg) rotateY(0deg); }
		#diceBox > .dice_wrap > [class^=dice] .dice.face2 { transform: rotateX(0deg) rotateY(-90deg); }
		#diceBox > .dice_wrap > [class^=dice] .dice.face3 { transform: rotateX(-90deg) rotateY(0deg); }
		#diceBox > .dice_wrap > [class^=dice] .dice.face4 { transform: rotateX(-270deg) rotateY(0deg); }
		#diceBox > .dice_wrap > [class^=dice] .dice.face5 { transform: rotateX(0deg) rotateY(-270deg); }
		#diceBox > .dice_wrap > [class^=dice] .dice.face6 { transform: rotateX(0deg) rotateY(-180deg); }
		#btnRolling { display: block; width: 160px; height: 40px; margin: 0 auto; background-color: royalblue; border: none; border-radius: 4px; color: #fff; cursor: pointer; position: relative; overflow: hidden; }
		#btnRolling::before{ display: block; content: ''; width: 60px; height: 100%; background-color: #fff; position: absolute; top:0; left: -60px; transition: all 0.5s; transform: skewX(-45deg); transform-origin: top left; opacity: 0.3; }
		#btnRolling:hover::before { transform: skewX(-45deg) translateX(280px); }
		
		/* 반응형 */
		@media screen and (max-width : 429px){
		  #diceBox { box-shadow:none;}
		  #diceBox > .dice_wrap { display: block;}
		  #diceBox > .dice_wrap > [class^=dice] { width: 100%; margin-right: 0%; padding-top: 100%; }
		}
  </style>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 700px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding-bottom:20px">게임</h2>
			<div class="text-center">
				<span style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책 세계 함께 다다르기(differeach)&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span class="w3-text w3-tag"  style="margin:0px auto; font-size:14px; font-style:italic;"><b>우리는 다 다르고, 그래서 서로에게 다다를 수 있어요.</b></span>
				</span>
			</div>
		</div>
		
		<div class="row" style="margin: 100px 50px 200px 100px">
			<div class="col-2" style="padding:20px;">
				<hr/>
				<a href="${ctp}/game/dice">
					<div class="navTitle" style="color:#41644A;">주사위 게임</div>
				</a>
				<hr/>
				<a href="${ctp}/game/roulette">
					<div class="navTitle">룰렛 게임</div>
				</a>
				<hr/>
			</div>
			<div class="col-10" style="padding:30px 70px 0px 30px;">
				<div class="text-center" style="font-size:25px; background-color:#eee; font-weight:bold; padding:20px; border: 4px solid #e8e8e8;">오늘의 번호&nbsp;:&nbsp;${luckyNum}</div>
				<div class="infoBox">
					<div id="wrap">
					  <section id="diceBox">
					    <div class="dice_wrap">
					      <div class="dice01">
					        <div class="dice_inner">
					          <div class="dice">
					            <div class="face1">1</div>
					            <div class="face2">2</div>
					            <div class="face3">3</div>
					            <div class="face4">4</div>
					            <div class="face5">5</div>
					            <div class="face6">6</div>
					          </div>
					        </div>
					      </div>
					      <div class="dice02">
					        <div class="dice_inner">
					          <div class="dice">
					            <div class="face1">1</div>
					            <div class="face2">2</div>
					            <div class="face3">3</div>
					            <div class="face4">4</div>
					            <div class="face5">5</div>
					            <div class="face6">6</div>
					          </div>
					        </div>
					      </div>
					    </div>
					    <c:if test="${empty sNickname}"><button id="btnRolling" disabled>주사위 굴리기</button></c:if>
					    <c:if test="${!empty sNickname}"><button id="btnRolling">주사위 굴리기</button></c:if>
					  </section>
					</div>
				</div>
				<c:if test="${empty sNickname}">
					<div class="infoBox3" style=" margin-top:50px">
						<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">주사위 게임 유의사항</div>
						<div style="padding:20px">
							- 일 최대 3번 시도 가능<br/>
				      - 오늘의 번호와 일치 성공 시, 즉시 포인트 지급됩니다.<br/>
				      - <b>비회원은 참여가 불가능합니다.</b><br/>
						</div>
					</div>
				</c:if>
				<c:if test="${!empty sNickname}">
					<div class="row" style="margin-top:30px">
						<div class="col">
							<div class="infoBox2" style=" margin-top:50px">
								<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">주사위 게임 유의사항</div>
								<div style="padding:20px">
									- 일 최대 3번 시도 가능<br/>
						      - 오늘의 번호와 일치 성공 시, 즉시 <b><u>500 포인트</u></b>가 지급됩니다.<br/>
						      - 비회원은 참여가 불가능합니다.<br/>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top:0px">
						<div class="col">
							<div class="infoBox2">
								<table class="table text-center" style="margin-bottom:0px">
									<thead>
										<tr>
											<th>No.</th>
											<th>총 성공 횟수</th>
											<th>총 획득 적립금</th>
											<th>시도 잔여 횟수</th>
											<th>시도일</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="ymd" value="<%=new java.util.Date()%>" />
										<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" var="today"/>
										<c:forEach var="vo" items="${vos}" varStatus="st">
											<tr>
												<td>${st.count}</td>
												<td>${vo.success} 회</td>
												<td>${vo.totPoint}</td>
												<td>${vo.trial} 회</td>
												<td>
													${fn:substring(vo.diceDate,0,10)}
													<c:if test="${fn:substring(vo.diceDate,0,10) == today}">&nbsp;<span class="badge badge-success">오늘</span></c:if>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
				
			</div>
		</div>
		
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
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

		//  translateZ는  .dice의 가로값 절반이면 됨
		// 리사이징 될 떄마다 계산
		var dice = document.querySelectorAll('.dice');
		var dice_width = dice[0].clientWidth;
		var face1 = document.querySelectorAll('.face1');
		var face2 = document.querySelectorAll('.face2');
		var face3 = document.querySelectorAll('.face3');
		var face4 = document.querySelectorAll('.face4');
		var face5 = document.querySelectorAll('.face5');
		var face6 = document.querySelectorAll('.face6');
		
		function DiceResizing(){
		  Array.prototype.forEach.call(face1, function(item){
		    item.style.transform = 'rotateY(0deg) translateZ(' + dice_width/2 + 'px)';
		  });
		  Array.prototype.forEach.call(face2, function(item){
		    item.style.transform = 'rotateY(90deg) translateZ(' + dice_width/2 + 'px)';
		  });
		  Array.prototype.forEach.call(face3, function(item){
		    item.style.transform = 'rotateX(90deg) translateZ(' + dice_width/2 + 'px)';
		  });
		  Array.prototype.forEach.call(face4, function(item){
		    item.style.transform = 'rotateX(270deg) translateZ(' + dice_width/2 + 'px)';
		  });
		  Array.prototype.forEach.call(face5, function(item){
		    item.style.transform = 'rotateY(270deg) translateZ(' + dice_width/2 + 'px)';
		  });
		  Array.prototype.forEach.call(face6, function(item){
		    item.style.transform = 'rotateY(180deg) translateZ(' + dice_width/2 + 'px)';
		  });
		}

		DiceResizing();

		window.onresize = function(){
		  dice_width = dice[0].clientWidth;
		  DiceResizing();
		};

		let number1 = 0;
		let number2 = 0;
		
		// 랜덤 주사위 눈
		var RandomNumber = function(){
		  return 'face' + Math.floor(Math.random()*6);
		};
		function rolling(){
			number1 = RandomNumber();
			number2 = RandomNumber();
		  dice[0].classList.add(number1);
		  dice[1].classList.add(number2);
		  
		  number1 = number1.substring(4);
		  number2 = number2.substring(4);
		  
		  if(number1 == 0) number1 = 1;
		  if(number2 == 0) number2 = 1;
		}

		// 주사위 굴리기
		var btnRolling = document.querySelector('#btnRolling');
		btnRolling.onclick = function(){
			
			if('${diceVO.trial}' == 0) {
				alert('오늘 시도횟수를 다 사용하셨습니다:)');
				return false;
			}
			
		  dice[0].classList.value = "dice";
		  dice[1].classList.value = "dice";
		  rolling();
		  result();
		};
		
		function result() {
			setTimeout(function() {
				let res = parseInt(number1) + parseInt(number2);
				let flag = 0;
				
			  if(res == '${luckyNum}') {
				  alert('오늘의 번호와 같아요! 500p가 적립되었습니다.');
				  flag = 1;
			  }
			  else {
				 	alert('오늘의 번호와 달라요');
			  }
			  
			  $.ajax({
				  type : "post",
				  url : "${ctp}/game/diceUpdate",
				  data : {
					  memNickname : '${sNickname}',
					  flag : flag
				  },
				  success : function() {
					  location.reload();
				  },
				  error : function() {
					  alert('재시도 부탁드립니다. 오류가 계속되면 문의를 남겨주세요:)')
				  }
			  });
			  
			}, 1000);
		}
 	</script>
</html>