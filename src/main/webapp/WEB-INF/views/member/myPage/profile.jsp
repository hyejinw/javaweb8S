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
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
    }
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 400px;
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
    .jClick {
			width:100%;
		  max-width: 300px;
	    padding: 15px;
	    border-radius:500px; 
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
		
		// 정규식 검사용
		let check = true;
		
		// 별명 중복버튼을 클릭했는지의 여부를 확인하기 위한 변수(버튼 클릭 후엔 내용 수정처리 불가)
		let nicknameCheckSw = 0;
		
		// 별명 중복 검사 
		function nickCheck() {
			let nickname = myform.nickname.value.trim();
			let regex6 = /^[가-힣0-9]+$/; //(별명)한글,영문,숫자만 적어도 1자이상 
			
			if(nickname == "") {
				alert("별명을 입력하세요");
				myform.nickname.focus();
				return false;
			}
			else if(!regex6.test(nickname)) {
				document.getElementById("nicknameError").innerHTML="별명 형식에 맞춰주세요.(한글/숫자만 1자 이상)";
				myform.nickname.focus();
				return false;
			}

			if(nickname == '${sNickname}') {
				alert('회원님의 현재 별명입니다. 사용가능합니다.');
				nicknameCheckSw = 1;
				return false;
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/member/memberNicknameCheck",
				data : {nickname : nickname},
				success:function(res) {
					if(res == "1") {
						alert("이미 사용 중인 별명입니다. 다시 입력해 주세요");
						$("#nickname").focus();
					}
					else  {
						alert("사용 가능한 별명입니다.");
							myform.nickname.readOnly = true;
						nicknameCheckSw = 1;
						$("#nickname").focus();
					}
				}
			});
		}
		
		// 별명 검사
		function nicknameCheck() {
			let regex6 = /^[가-힣0-9]{2,10}$/; //(별명)한글,숫자 2~10자
			let nickname = document.getElementById("nickname").value.trim();
			document.getElementById("nicknameError").innerHTML="";
			
		  // 별명 확인
		  if(!regex6.test(nickname)){
		    document.getElementById("nicknameError").innerHTML="별명이 올바르지 않습니다.(한글/숫자만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nicknameError").innerHTML="";
			  check = true;
		  }			
		}
		
		// 비밀번호 검사
		function pwdCheck() {
			let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영문/숫자 1개 이상 필수, 특수문자 허용
			let pwd = document.getElementById("pwd").value.trim();
			document.getElementById("pwdError").innerHTML="";
			
		  // 비밀번호 확인
		  if(!regex2.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영문/숫자 필수, 특수문자 가능 4~20자)";
		    check = false;
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
	  	  check = true;
	  	}	
		}
		function pwd2Check() {
			let pwd = document.getElementById("pwd").value.trim();
			let pwd2 = document.getElementById("pwd2").value.trim();
			document.getElementById("pwdError").innerHTML="";
			document.getElementById("pwdError2").innerHTML="";
			
		  // 비밀번호 확인2
		  if(pwd !== pwd2) {
			    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
			    check = false;
		  }
		  else {
	  	  document.getElementById("pwdError").innerHTML="";
	  	  document.getElementById("pwdError2").innerHTML="";
	  	  check = true;
		  }
		} 
		
		// 이메일 검사
		function emailCheck() {
			let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일
			let email1 = document.getElementById("email1").value.trim();
		  document.getElementById("emailError").innerHTML="";
	
		  // 이메일확인
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }			
		}
		
		// 전화번호 검사
		function telCheck() {
			let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
		  let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  // 전화번호 확인
		  if(tel2==="" || tel3===""){
		    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		    check = true;
		  }
		}
		
		// 회원정보 수정
		function memberUpdate() {
			let pwd = document.getElementById("pwd").value.trim();
			let pwd2 = document.getElementById("pwd2").value.trim();
		  let nickname = document.getElementById("nickname").value.trim();
		  
		  let email1 = myform.email1.value.trim();
			let email2 = myform.email2.value;
			let email = email1 + "@" + email2;
			
			let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; 
		  //(비밀번호)4자 이상 20자 이하, 영문/숫자 1개 이상 필수, 특수문자 허용
	 		let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일 
	 		let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
	 		let regex6 = /^[가-힣0-9]{2,10}$/; //(별명)한글,숫자 2~10자
	 		
	 		
	 		// 비밀번호 확인
	 		if(pwd != "") {
			  if(!regex2.test(pwd)) {
			    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영문/숫자 필수, 특수문자 가능 4~20자)";
			    check = false;
			  }
			  else {
			    document.getElementById("pwdError").innerHTML="";
				    
				  if(pwd2=== "") {
				    document.getElementById("pwdError2").innerHTML="비밀번호를 다시 입력해주세요.";
				    check = false;
				  }
				  else if(pwd !== pwd2) {
				    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
				    check = false;
				  }
				  else {
			  	  document.getElementById("pwdError").innerHTML="";
			  	  document.getElementById("pwdError2").innerHTML="";
			  	  check = true;
				  }
			  } 
	 		}
	 		
	 		// 별명 확인
		  if(!regex6.test(nickname)){
		    document.getElementById("nicknameError").innerHTML="별명이 올바르지 않습니다.(한글/숫자만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nicknameError").innerHTML="";
			  check = true;
		  }	
	 		
			// 이메일확인
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }	
	 		
			// 전화번호 확인
		  if(tel2==="" || tel3===""){
		    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		    check = true;
		  }
			
			
		  if(!check){
			  alert('입력된 값을 다시 확인해주세요.');
			  check = true;
				return false;
		  }
		  if(nickname != '${sNickname}') {
		    if(nicknameCheckSw == 0) {
					alert("별명 중복확인을 해주세요.");
					document.getElementById("nicknameBtn").focus();
					return false;
				} 
		  }
	   	$.ajax({
	   		type : "post",
	   		url : "${ctp}/member/myPage/memberUpdate",
	   		data : {
	   			idx : ${vo.idx},
	   			pwd : pwd,
	   			nickname : nickname,
	   			email : email,
	   			tel : tel
	   		},
	   		success : function() {
	   			alert('회원 정보가 수정되었습니다.')
	   			location.reload();
	   		},
	   		error : function() {
	   			alert('재시도 부탁드립니다. 오류가 계속될 경우, 문의를 남겨주세요.')
	   		}
	   	}); 
		}
		
		// 회원 탈퇴 비밀번호 검사
		function memberDeleteCheck() {
			let memberDelPwd = document.getElementById('memberDelPwd').value;
			
			$.ajax({
	   		type : "post",
	   		url : "${ctp}/member/myPage/memberPwdCheck",
	   		data : {
	   			memberDelPwd : memberDelPwd,
	   			pwd : '${vo.pwd}'
	   		},
	   		success : function(res) {
	   			if(res == "1") memberDelete();
	   			else {
		   			alert('비밀번호가 다릅니다.');
						document.getElementById('memberDelPwd').focus();
						return false;
	   			}
	   		},
	   		error : function() {
	   			alert('재시도 부탁드립니다. 오류가 계속될 경우, 문의를 남겨주세요.')
	   		}
	   	}); 
		}
		
		// 회원 탈퇴
		function memberDelete() {
			let ans = confirm('[현재 포인트] '+${vo.point}+'\n탈퇴하면 포인트가 삭제됩니다.\n정말로 탈퇴 하시겠습니까?');
			if(!ans) return false;

			memberDelForm.submit();
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">회원정보 수정</h2>
			
			<hr/>
			<p class="text-right" style="color:red; font-size:15px; margin-top:15px">별(*) 표시는 필수 입력사항입니다.</p>
			<form name="myform">
				<div class="form-group mt-2">
	      <label for="mid">아이디 <span class="must">(수정 불가)</span></label>
	      <input type="text" class="form-control radiusForm" name="mid" id="mid" value="${vo.mid}" placeholder="아이디를 입력하세요." readonly/>
		    </div>
		    <div class="form-group mt-4">
		      <label for="pwd">비밀번호</label>
		      <input type="password" class="form-control radiusForm" maxlength=20 name="pwd" id="pwd" onchange="pwdCheck()" placeholder="비밀번호를 입력하세요." required />
		      <div id="pwdError" class="text-primary"></div>
		    </div>
		    <div class="form-group">
		      <label for="pwd2">비밀번호 확인</label>
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
		    	<input type="hidden" name="email" id="email"/>
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
				
				<div class="text-center" style="margin:70px 0px">
					<div class="text-right">
						<button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#memDeleteModal">회원탈퇴</button>
					</div>
		    	<button type="button" onclick="memberUpdate()" class="jClick" style="background-color:#GREY; font-size: 1.1em; border-color:#282828; color:black">수정</button>
		  	</div>
			</form>
	    
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
	
	<!-- The Modal -->
  <div class="modal fade" id="memDeleteModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">탈퇴 신청</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee;">
          	<form name="memberDelForm" method="post" action="${ctp}/member/myPage/memberDelete">
			  			<textarea rows="4" cols="10" name="memberDelReason" id="memberDelReason" class="form-control mt-3" placeholder="(선택)탈퇴 사유를 적어주세요. 더욱 발전하는 책(의)세계가 되겠습니다."></textarea>
							<input type="password" id="memberDelPwd" class="form-control mt-3" placeholder="(필수)비밀번호를 입력해주세요."/> 		  			
			  			<div class="ml-4 mr-3 mt-4 mb-3">
			  				<span style="color:red"><i class="fa-solid fa-triangle-exclamation" style="font-size:17px; margin-bottom:15px"></i>&nbsp;&nbsp;탈퇴 철회는 불가능합니다.&nbsp;기존 아이디로 1개월간 재가입이 불가능합니다.</span>
			  				<span>&nbsp;&nbsp;3개의 책에서도 함께 탈퇴됩니다.</span><br/>
			  				<span>
			  					회원 아이디 : <b>${vo.mid}</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  					회원 별명 : <b>${vo.nickname}</b>
			  					<input type="hidden" name="idx" value="${vo.idx}"/>
			  				</span>
			  			</div>
          	</form>
				  </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        	<button type="button" class="btn btn-dark" onclick="memberDeleteCheck()">탈퇴</button>
        </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>