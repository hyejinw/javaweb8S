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
		
		function idFinderCheck() {
			let name = myform.name.value.trim();
			let email = myform.email.value.trim();
			
			let regex3 = /^[가-힣a-zA-Z]{2,10}$/;  // (성명)한글,영문 2~10자
			let regex4 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; // 이메일
			
		  // 성명 확인
 			if(!regex3.test(name)){
		    alert("성명 형식이 올바르지 않습니다.(한글/영문만 2~10자)");
		    myform.name.focus();
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
				url : "${ctp}/member/idFinder",
				data : {name : name, email : email},
				success : function(res) {
					
					if(res == '입력하신 정보와 일치하는 회원이 없습니다.') {
						alert(res);
						myform.name.focus();
					}
					else {
						alert('성공적으로 검색되었습니다.');
						
						// 문자열의 절반만 *표시 (홀수일 경우, 강제 반올림)
						let starLength = Math.ceil(res.length / 2);

						// 홀수, 짝수 문자열에 따라 *의 개수 구분
						let starter = 0;
						if((res.length / 2) % 2 != 0) {
							console.log('here');
							starter = 1;
						}
						
						// 아이디 절반 별(*) 처리
						res = res.substring(0, starLength);
						for(let i = starter; i < Math.floor(starLength); i++) {
							res += '*';
							console.log("1");
						} 
						
						document.getElementById('demo').style.display = 'block';
						document.getElementById('search').style.display = 'none';
						document.getElementById('login').style.display = 'block';
						document.getElementById('midRes').value = res;
					}
				}
			});
	    
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin-top:100px">
		<div class="container-xl p-5 my-5">
			<h2 class="text-center" style="margin:0px auto;">아이디 찾기</h2>
			<div class="text-center mt-2" style="font-size:0.8em"><i class="fa-solid fa-triangle-exclamation"></i>&nbsp;회원가입 정보와 동일하게 입력해주세요.</div>
			<form name="myform" method="post" style="margin-top:50px">
				<div class="form-group" style="margin:0px auto; padding-top:30px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
					<div class="row" style="margin-bottom:30px">
						<div class="col-md-3 text-center">성명</div>
						<div class="col-md-9"><input type="text" class="form-control" name="name" id="name" placeholder="성명을 입력해주세요" autofocus required/></div>
					</div>
					<div class="row" style="margin-bottom:30px">
						<div class="col-md-3 text-center">이메일</div>
						<div class="col-md-9"><input type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력해주세요" required /></div>
					</div>
					<br/>
					<div class="text-right" style="font-size:0.8em; margin:0px auto;"><a href="${ctp}/member/pwdFinder"><i class="fa-solid fa-circle-question"></i>&nbsp;비밀번호를 잃어버리셨나요?</a></div>
					<hr/>
					<div class="row text-center" id="search" style="margin-top:30px">
						<div class="col"><button type="button" onclick="idFinderCheck()" class="btn" style="background-color:#FFDB7E; font-size: 0.8em;">검색</button></div>
					</div>
					<div id="login" style="display:none;">
						<div class="row text-center" style="margin-top:30px">
							<div class="col text-right"><button type="button" onclick="location.reload();" class="btn" style="background-color:#FFDB7E; font-size: 0.8em;">재검색</button></div>
							<div class="col text-left"><button type="button" onclick="location.href='${ctp}/member/memberLogin';" class="btn" style="background-color:#F5EBE0; font-size: 0.8em;">로그인 창</button></div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="container-xl pr-5 pl-5 pb-5 my-5" id="demo" style="display:none">
			<hr/>
			<br/>
			<div class="row" style="margin:0px auto; width:60%">
				<div class="col-md-3 text-center">검색 결과</div>
				<div class="col-md-9"><input type="text" class="form-control text-primary" name="midRes" id="midRes" readonly/></div>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>