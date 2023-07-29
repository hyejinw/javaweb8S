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
		
		// 커뮤니티 문의창으로 이동
		function move1() {
			if(confirm('커뮤니티 문의창으로 이동하시겠습니까?')) {
				location.href = '${ctp}/community/ask';
			}
		}
 	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 100px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding-bottom:20px">커뮤니티 가이드</h2>
			<div class="text-center">
				<span style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책 세계 함께 다다르기(differeach)&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span class="w3-text w3-tag"  style="margin:0px auto; font-size:14px; font-style:italic;"><b>우리는 다 다르고, 그래서 서로에게 다다를 수 있어요.</b></span>
				</span>
			</div>
		</div>
		
		<!-- 문의/신고 관련 부분 링크 달기! -->
		
		<div class="row" style="margin: 100px 50px 200px 100px">
			<div class="col-10" style="padding:30px 70px 0px 30px;">
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="1">3개의 책</div>
					<div class="content">
						3개의 책은 매일 새로운 이야기와 물음으로 책 읽기의 즐거움을 나누는 공간입니다. 모든 콘텐츠가 그러한 영감을 주는 것은 아니므로 3개의 책은 커뮤니티 가이드라인을 마련해두고 있습니다. 가이드라인은 3개의 책의 허용 가능 사용 정책이므로 3개의 책에 없어야 할 콘텐츠를 발견하신다면 3개의 책에 <a href="javascript:move1()"><b><u>문의</u></b></a>해주세요 . 3개의 책은 회원님의 신고를 통해 3개의 책 운영 기준을 심층적으로 분석하고 발전시키며 주제 전문가들과 협력하여 3개의 책의 가이드라인을 알리고 업데이트합니다. 
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="2">콘텐츠 안전</div>
					<div class="content">
						3개의 책은 적대적이거나, 노골적이거나, 거짓 또는 오해의 소지가 있거나, 유해하거나, 혐오감을 주거나, 폭력성을 띠는 콘텐츠나 행위를 허용하지 않습니다. 3개의 책은 유해 정도에 따라 해당 콘텐츠 및 해당 콘텐츠를 만들거나 유포하는 계정, 개인 및 그룹을 삭제하거나, 제한하거나, 유포를 차단할 수 있습니다.
						3개의 책은 사용자들이 이해하기 쉽도록 명확하고 투명한 요구사항을 제시하고자 최선을 다하고 있습니다. 이에 관해 궁금한 점 또는 문제가 있는 경우 3개의 책에 <a href="javascript:move1()"><b><u>문의</u></b></a>해주세요.
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="3">잘못된 정보</div>
					<div class="content">
						3개의 책은 잘못된 정보, 허위 정보, 악의적인 정보는 물론 해당 정보를 생성하거나 유포하는 개인 또는 그룹을 허용하지 않습니다. 3개의 책은 회원이나 대중의 복지, 안전 또는 신뢰를 해칠 수 있는 다음과 같은 허위 또는 오해의 소지가 있는 콘텐츠를 삭제하거나 유포를 제한합니다.<br/><br/>
						* 건강에 관하여 의학적으로 증명되지 않은 의견으로 공중 보건 및 안전을 위험하게 하는 경우(잘못된 치료법, 예방접종 반대, 또는 공중 보건이나 안전 응급 상황에 관한 잘못된 정보 포함)<br/>
						* 개인 또는 보호 대상 그룹에 관하여 공포감, 혐오감 또는 편견을 조장하는 거짓 또는 오해의 소지가 있는 콘텐츠<br/>
						* 개인, 그룹, 장소 또는 조직을 희롱이나 물리적 폭력의 대상이 되도록 조장하는 거짓 또는 오해의 소지가 있는 콘텐츠<br/>
						* 기후 변화 또는 시민 참여 관련 정보를 포함한 음모론<br/>
						* 기후 변화 또는 시민 참여 관련 정보 등의 허위 정보 캠페인을 바탕으로 한 콘텐츠<br/>
						* 신뢰를 흐릴 목적 또는 피해를 줄 목적으로 사실 정보를 공개하거나 맥락, 날짜 또는 시간을 변경 또는 누락하는 등 의도적으로 변형하는 경우<br/>
						* 신뢰를 흐리거나 피해를 주는 허위의 또는 의도적으로 조작된 시각적 또는 청각적 콘텐츠<br/>
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="4">희롱 및 비판</div>
					<div class="content">
					3개의 책은 개인 또는 그룹을 모욕 또는 적대시하거나 이들에게 상처를 주는 행위를 허용하지 않습니다. 3개의 책은 긍정적이고 영감적인 공간을 유지하기 위해 모욕적인 콘텐츠의 배포를 제한하거나 이를 삭제할 수 있습니다. 이러한 콘텐츠에는 다음이 포함됩니다.<br/><br/>
					* 타인을 비하하거나 수치심을 줄 목적으로 조작된 이미지<br/>
					* 신체를 이유로 또는 과거의 성적인 경험 또는 연애 경험에 대한 추측에 기반하여 타인에게 수치심을 주는 경우<br/>
					* 타인의 신체에 관한 성적인 발언과 성적인 행위를 요구하거나 제안하는 경우<br/>
					* 욕설, 신성 모독 및 그 외 모욕적인 언어나 이미지를 이용한 비판<br/>
					* 슬픔, 애도, 죽음 또는 분노로 고통받는 타인을 모욕하는 경우<br/>
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="5">사적인 정보</div>
					<div class="content">
						3개의 책은 개인 정보 또는 민감한 정보를 공개하는 콘텐츠를 허용하지 않습니다. 3개의 책은 다음과 같은 내용을 금지합니다.<br/><br/>
						* 개인 ID 및 여권 정보<br/>
						* 사적인 연락처 정보 및 주소<br/>
						* 온라인 로그인 정보(사용자 이름 및 비밀번호)<br/>
						* 온라인에 공개되길 원치 않는 사적인 사람들의 사진<br/>
						* 개인 금융 기록 또는 병력<br/>
						원치 않는 본인 사진이나 정보를 발견한 경우 3개의 책에 신고 할 수 있습니다. 미성년자나 미성년자의 권한을 위임받은 대리인도 원치 않는 사진이나 정보와 관련하여 info@chaeg.co.kr으로 문의할 수 있습니다.<br/>
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="6">댓글</div>
					<div class="content">
						3개의 책 모든 커뮤니티 가이드라인은 회원이 작성하는 댓글에 적용됩니다. 또한 댓글은 관련성이 있어야 합니다. 3개의 책은 다음 내용을 포함하여 3개의 책 가이드라인을 위반하는 댓글을 삭제할 수 있습니다.<br/><br/>
						* 관련이 없거나 무의미한 자료<br/>
						* 스팸<br/>
						* 성적으로 노골적인 콘텐츠<br/>
						* 자해 유발 콘텐츠<br/>
						* 잘못된 정보<br/>
						* 혐오적 활동<br/>
						* 인신공격 또는 사생활 침해<br/>
						* 저작권 또는 상표권 침해<br/>
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="7">메시지</div>
					<div class="content">
						3개의 책 모든 커뮤니티 가이드라인은 회원 간에 전송되는 메시지에 적용됩니다. 메시지도 관련성을 지녀야 합니다. 3개의 책은 회원차단 기능을 제공하는 것 외에도, 다음 내용이 포함된 메시지를 보내는 것을 포함하여 3개의 책 가이드라인을 위반하는 계정을 경고하거나 정지할 수 있습니다.<br/><br/>
						* 스팸<br/>
						* 성적으로 노골적인 콘텐츠 공유 또는 권유<br/>
						* 자해 또는 자살 콘텐츠<br/>
						* 잘못된 정보<br/>
						* 인종 비방 등의 혐오 활동<br/>
						* 괴롭힘 관련 콘텐츠 또는 행동<br/>
						* 개인 정보 착취<br/>
					</div>
				</div>
				
				<div style="margin-bottom:100px">
					<div class="title mb-4" id="8">지적 재산권 및 기타 권리</div>
					<div class="content">
						3개의 책 내외에서 타인의 권리를 존중하기 위해 다음 사항을 지켜 주세요.<br/><br/>
						* 타인의 지적 재산권, 사생활 및 기타 권리를 침해하지 마세요.<br/>
						* 법률 또는 규정에 위배되는 행위를 하거나 해당 콘텐츠를 게시하지 마세요.<br/>
						* 타인에게 혼란을 초래할 수 있는 방법으로 3개의 책의 이름, 로고 또는 상표를 사용하지 마세요.<br/>
					</div>
				</div>
				
				<b>마지막으로, 모든 관련 법률과 규정을 반드시 준수하세요.</b>
			</div>
			<div class="col-2" style="padding:20px;">
				<a href="#1">
					<div class="navTitle">3개의 책</div>
				</a>
				<hr/>
				<a href="#2">
					<div class="navTitle">콘텐츠 안전</div>
				</a>
				<hr/>
				<a href="#3">
					<div class="navTitle">잘못된 정보</div>
				</a>
				<hr/>
				<a href="#4">
					<div class="navTitle">희롱 및 비판</div>
				</a>
				<hr/>
				<a href="#5">
					<div class="navTitle">사적인 정보</div>
				</a>
				<hr/>
				<a href="#6">
					<div class="navTitle">댓글</div>
				</a>
				<hr/>
				<a href="#7">
					<div class="navTitle">메시지</div>
				</a>
				<hr/>
				<a href="#8">
					<div class="navTitle">지적 재산권 및 기타 권리</div>
				</a>
				<hr/>
			</div>
		
		
		</div>
		
		
		
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>