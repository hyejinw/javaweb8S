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
    	max-height: 300px;
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
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">회원정보 수정</h2>
			
			<div style="margin:10px 0px 50px 0px">
				<div class="infoBox">
					<c:if test="${empty booksletterVO}">
						
					</c:if>
					<c:if test="${!empty booksletterVO}">
						
					</c:if>
					-  &nbsp;배송완료 후, 구매자 직접 구매확정 하실 수 있으며, 그렇지 않을 경우 배송완료 7일 이후 자동 구매확정 됩니다.<br/>
					-  &nbsp;구매확정 후, 결제액의 5%가 포인트로 지급됩니다.
				</div>
			</div>
			
			<p class="text-right" style="color:red; font-size:15px; margin-top:15px">별(*) 표시는 필수 입력사항입니다.</p>
	    <div class="form-group mt-2">
	      <label for="mid">아이디 <span class="must">(수정 불가)</span></label>
	      <input type="text" class="form-control radiusForm" name="mid" id="mid" value="${vo.mid}" placeholder="아이디를 입력하세요." readonly/>
	    	<div id="midError" class="text-primary"></div>
	    </div>
	    <div class="form-group mt-4">
	      <label for="pwd">비밀번호 <span class="must">*</span></label>
	      <input type="password" class="form-control radiusForm" maxlength=20 name="pwd" id="pwd" onchange="pwdCheck()" placeholder="비밀번호를 입력하세요." required />
	      <div id="pwdError" class="text-primary"></div>
	    </div>
	    <div class="form-group">
	      <label for="pwd2">비밀번호 확인 <span class="must">*</span></label>
	      <input type="password" class="form-control radiusForm" maxlength=20 name="pwd2" id="pwd2" onchange="pwd2Check()" placeholder="비밀번호를 입력하세요." required />
	      <div id="pwdError2" class="text-primary"></div>
	    </div>
	    <div class="form-group mt-4">
	      <label for="nickname">별명 <span class="must">*</span> &nbsp; &nbsp;<input type="button" id="nicknameBtn" value="별명 중복체크" class="btn btn-outline-dark btn-sm" onclick="nickCheck()"/></label>
	      <input type="text" class="form-control radiusForm" name="nickname" id="nickname" onchange="nicknameCheck()" value="${vo.nickname}" placeholder="별명을 입력하세요." required />
	    	<div id="nicknameError" class="text-primary"></div>
	    </div>
	    <div class="form-group mt-4">
	      <label for="name">성명 <span class="must">(수정 불가)</span></label>
	      <input type="text" class="form-control radiusForm" name="name" id="name" onchange="nameCheck()" value="${vo.name}" placeholder="성명을 입력하세요." readonly />
	    	<div id="nameError" class="text-primary"></div>
	    </div>
	    <div class="form-group mt-4">
	      <label for="email1" >이메일 <span class="must">*</span></label>
	        <div class="input-group">
	          <input type="text" class="form-control radiusForm" id="email1" name="email1" onblur="emailCheck()" value="${fn:split(vo.email,'@')[0]}" placeholder="Email을 입력하세요." required />
	          <div class="input-group-append">
	            <select name="email2" id="email2" class="custom-select">
	              <option value="naver.com" <c:if test="${fn:split(vo.email,'@')[1] == 'naver.com'}">selected</c:if>>naver.com</option>
	              <option value="hanmail.net" <c:if test="${fn:split(vo.email,'@')[1] == 'hanmail.net'}">selected</c:if>>hanmail.net</option>
	              <option value="hotmail.com" <c:if test="${fn:split(vo.email,'@')[1] == 'hotmail.com'}">selected</c:if>>hotmail.com</option>
	              <option value="gmail.com" <c:if test="${fn:split(vo.email,'@')[1] == 'gmail.com'}">selected</c:if>>gmail.com</option>
	              <option value="nate.com" <c:if test="${fn:split(vo.email,'@')[1] == 'nate.com'}">selected</c:if>>nate.com</option>
	              <option value="yahoo.com" <c:if test="${fn:split(vo.email,'@')[1] == 'yahoo.com'}">selected</c:if>>yahoo.com</option>
	            </select>
	          </div>
	        </div>
	    	<div id="emailError" class="text-primary"></div>
	    </div>
	    <div class="form-group">
	      <div class="input-group mt-5 mb-3">
	        <div class="input-group-prepend">
	          <span class="input-group-text">전화번호 <span class="must">*</span></span> &nbsp;&nbsp;
	            <select name="tel1" id="tel1" class="custom-select">
	              <option value="010" <c:if test="${fn:split(vo.tel,'-')[0] == '010'}">selected</c:if>>010</option>
	              <option value="02" <c:if test="${fn:split(vo.tel,'-')[0] == '02'}">selected</c:if>>02</option>
	              <option value="031" <c:if test="${fn:split(vo.tel,'-')[0] == '031'}">selected</c:if>>031</option>
	              <option value="032" <c:if test="${fn:split(vo.tel,'-')[0] == '032'}">selected</c:if>>032</option>
	              <option value="041" <c:if test="${fn:split(vo.tel,'-')[0] == '041'}">selected</c:if>>041</option>
	              <option value="042" <c:if test="${fn:split(vo.tel,'-')[0] == '042'}">selected</c:if>>042</option>
	              <option value="043" <c:if test="${fn:split(vo.tel,'-')[0] == '043'}">selected</c:if>>043</option>
	              <option value="051" <c:if test="${fn:split(vo.tel,'-')[0] == '051'}">selected</c:if>>051</option>
	              <option value="052" <c:if test="${fn:split(vo.tel,'-')[0] == '052'}">selected</c:if>>052</option>
	              <option value="061" <c:if test="${fn:split(vo.tel,'-')[0] == '061'}">selected</c:if>>061</option>
	              <option value="062" <c:if test="${fn:split(vo.tel,'-')[0] == '062'}">selected</c:if>>062</option>
	            </select>  -
	        </div>
	        <input type="number" name="tel2" id="tel2" size=4 maxlength=4 oninput='handleOnInput(this, 4)' value="${fn:split(vo.tel,'-')[1]}" class="form-control inputs"/>  -
	        <input type="number" name="tel3" id="tel3" size=4 maxlength=4 oninput='handleOnInput(this, 4)' value="${fn:split(vo.tel,'-')[1]}" onchange="telCheck()" class="form-control inputs"/>
	    	  <input type="hidden" name="tel" id="tel"/>
	      </div>
	      <div id="telError" class="text-primary"></div>
	    </div> 
			
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
	
  
</body>
</html>