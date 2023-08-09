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
    	max-height: 800px;
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
    
    @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css");
		canvas {
		  transition: 2s;
		}
		
		button {
		  background: #febf00;
		  margin-top: 1rem;
		  padding: .8rem 1.8rem;
		  border: none;
		  font-size: 1.5rem;
		  font-weight: bold;
		  border-radius: 5px;
		  transition: .2s;
		  cursor: pointer;
		}
		
		button:active {
		  background: #444;
		  color: #f9f9f9;
		}
		 
		#roulette {
		  width: 380px;
		  overflow: hidden;
		  display: flex;
		  align-items: center;
		  flex-direction: column;
		  position: relative;
		}
		
		#roulette::before {
		  content: "";
		  position: absolute;
		  width: 10px;
		  height: 50px;
		  border-radius: 5px;
		  background: #000;
		  top: -20px;
		  left: 50%;
		  transform: translateX(-50%);
		  z-index: 22;
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
					<div class="navTitle">주사위 게임</div>
				</a>
				<hr/>
				<a href="${ctp}/game/roulette">
					<div class="navTitle" style="color:#41644A;">룰렛 게임</div>
				</a>
				<hr/>
			</div>
			<div class="col-10" style="padding:30px 70px 0px 30px;">
				<div class="infoBox text-center">
					<div id="roulette" style="margin:0px auto; margin-top:150px">
					  <canvas width="380" height="380"></canvas>  
					  <c:if test="${empty sNickname}"><button disabled>룰렛 돌리기</button></c:if>
					  <c:if test="${!empty sNickname}"><button onclick="rotate()">룰렛 돌리기</button></c:if>
					</div>

				</div>
				<c:if test="${empty sNickname}">
					<div class="infoBox3" style=" margin-top:50px">
						<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">룰렛 게임 유의사항</div>
						<div style="padding:20px">
							- 일 최대 2번 시도 가능<br/>
				      - 룰렛 포인트 획득 시, 즉시 포인트 지급됩니다.<br/>
				      - <b>비회원은 참여가 불가능합니다.</b><br/>
						</div>
					</div>
				</c:if>
				<c:if test="${!empty sNickname}">
					<div class="row" style="margin-top:30px">
						<div class="col">
							<div class="infoBox2" style=" margin-top:50px">
								<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">룰렛 게임 유의사항</div>
								<div style="padding:20px">
									- 일 최대 2번 시도 가능<br/>
						      - 룰렛 포인트 획득 시, 즉시 포인트 지급됩니다.<br/>
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
													${fn:substring(vo.rouletteDate,0,10)}
													<c:if test="${fn:substring(vo.rouletteDate,0,10) == today}">&nbsp;<span class="badge badge-success">오늘</span></c:if>
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

		const $c = document.querySelector("canvas");
		const ctx = $c.getContext(`2d`);


		const product = [
		  "500p", "꽝", "10p", "꽝", "200p", "꽝", "50p", "꽝", "30p",
		];

		const colors = ["#dc0936", "#e6471d", "#f7a416", "#efe61f ", "#60b236", "#209b6c", "#169ed8", "#3f297e", "#87207b", "#be107f", "#e7167b"];

		const newMake = () => {
		    const [cw, ch] = [$c.width / 2, $c.height / 2];
		    const arc = Math.PI / (product.length / 2);
		  
		    for (let i = 0; i < product.length; i++) {
		      ctx.beginPath();
		      ctx.fillStyle = colors[i % (colors.length -1)];
		      ctx.moveTo(cw, ch);
		      ctx.arc(cw, ch, cw, arc * (i - 1), arc * i);
		      ctx.fill();
		      ctx.closePath();
		    }

		    ctx.fillStyle = "#fff";
		    ctx.font = "18px Pretendard";
		    ctx.textAlign = "center";

		    for (let i = 0; i < product.length; i++) {
		      const angle = (arc * i) + (arc / 2);

		      ctx.save();

		      ctx.translate(
		        cw + Math.cos(angle) * (cw - 50),
		        ch + Math.sin(angle) * (ch - 50),
		      );

		      ctx.rotate(angle + Math.PI / 2);

		      product[i].split(" ").forEach((text, j) => {
		        ctx.fillText(text, 0, 30 * j);
		      });

		      ctx.restore();
		    }
		}

		const rotate = () => {
			
			if('${rouletteVO.trial}' == 0) {
				alert('오늘 시도횟수를 다 사용하셨습니다:)');
				return false;
			}
			
		  $c.style.transform = `initial`;
		  $c.style.transition = `initial`;
		  
		  setTimeout(() => {
		    
		    const ran = Math.floor(Math.random() * product.length);
				
		    const arc = 360 / product.length;
		    const rotate = (ran * arc) + 3600 + (arc * 3) - (arc/4);
		    
		    $c.style.transform = 'rotate(-'+rotate+'deg)';
		    $c.style.transition = '2s';
		    
		    result(ran);
		  }, 1);
		};
		
		function result(ran) {
			setTimeout(function() {
				let totPoint = '';
				if(product[ran] != '꽝') {
				  alert(product[ran]+'가 적립되었습니다.');
				  totPoint = product[ran].split('p')[0];
			  }
			  else {
				 	alert('다음을 기약해볼까요');
			  } 
			   $.ajax({
				  type : "post",
				  url : "${ctp}/game/rouletteUpdate",
				  data : {
					  memNickname : '${sNickname}',
					  totPoint : totPoint
				  },
				  success : function() {
					  location.reload();
				  },
				  error : function() {
					  alert('재시도 부탁드립니다. 오류가 계속되면 문의를 남겨주세요:)')
				  }
			  });
			  
			}, 2300);
		}

		newMake();
 	</script>
</html>