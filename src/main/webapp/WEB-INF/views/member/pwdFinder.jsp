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
		#container {font-size: 1.2em;}
		
		.form-control {
			border-radius:100px; 
			margin-top: -5px;
		}
		.btn {
			width:100%;
		  max-width: 200px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		
		function pwdFinderCheck() {
			let mid = myform.mid.value.trim();
			let email = myform.email.value.trim();
			
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
			let regex4 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; // 이메일
			
			// 이메일 스피너 생성
			let emailSpinner = document.getElementById('emailSpinner'); 
			emailSpinner.style.display = 'inline-block';
			
		  // 아이디 확인
 			if(!regex1.test(mid)){
		    alert("성명 형식이 올바르지 않습니다.(영문/숫자만 4~20자)");
		    myform.mid.focus();
		    return false;
		  }
		  // 이메일확인
		  if(!regex4.test(email)){
		    alert("이메일 형식이 올바르지 않습니다.");
		    myform.email.focus();
		    return false;
		  }
					  
			$.ajax({
				type : "post",
				url : "${ctp}/member/pwdFinder",
				data : {mid : mid, email : email},
				success : function(res) {
					
					if(res == '입력하신 정보와 일치하는 회원이 없습니다.') {
						alert(res);
						myform.mid.focus();
					}
					else {
						alert('이메일로 임시 비밀번호가 전송되었습니다.\n로그인 후, 마이페이지에서 비밀번호를 변경해주세요.');
						
						document.getElementById('search').style.display = 'none';
						document.getElementById('login').style.display = 'block';
					}
					// 이메일 스피너 가리기
					emailSpinner.style.display = 'none';
				}
			});
	    
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin-top:100px">
		<div class="container-xl p-5 my-5">
			<h2 class="text-center" style="margin:0px auto;">비밀번호 찾기  <font size="3px" color="#FFDB7E"><span id="emailSpinner" class="spinner-border" style="display:none"></span></font></h2>
			<div class="text-center mt-2" style="font-size:0.8em"><i class="fa-solid fa-triangle-exclamation"></i>&nbsp;회원가입 정보와 동일하게 입력해주세요.<br/><font color="red">이메일로 임시비밀번호를 보내드립니다.</font></div>
			<form name="myform" method="post" style="margin-top:50px">
				<div class="form-group" style="margin:0px auto; padding-top:30px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
					<div class="row" style="margin-bottom:30px">
						<div class="col-md-3 text-center">아이디</div>
						<div class="col-md-9"><input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력해주세요" autofocus required/></div>
					</div>
					<div class="row" style="margin-bottom:30px">
						<div class="col-md-3 text-center">이메일</div>
						<div class="col-md-9"><input type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력해주세요" required /></div>
					</div>
					<br/>
					<div class="text-right" style="font-size:0.8em; margin:0px auto;"><a href="${ctp}/member/idFinder"><i class="fa-solid fa-circle-question"></i>&nbsp;아이디를 잃어버리셨나요?</a></div>
					<hr/>
					<div class="row text-center" id="search" style="margin-top:30px">
						<div class="col"><button type="button" onclick="pwdFinderCheck()" class="btn" style="background-color:#FFDB7E; font-size: 0.8em;">검색</button></div>
					</div>
					<div id="login" style="display:none;">
						<div class="row text-center" style="margin-top:30px">
							<div class="col text-right"><button type="button" onclick="pwdFinderCheck()" class="btn" style="background-color:#FFDB7E; font-size: 0.8em;">재검색</button></div>
							<div class="col text-left"><button type="button" onclick="location.href='${ctp}/member/memberLogin';" class="btn" style="background-color:#F5EBE0; font-size: 0.8em;">로그인 창</button></div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>