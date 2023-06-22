		'use strict';
		
		// 아이디 중복버튼을 클릭했는지의 여부를 확인하기 위한 변수(버튼 클릭 후엔 내용 수정처리 불가)
		let idCheckSw = 0;
		
		// 아이디 중복 검사 
		function idCheck() {
			let mid = myform.mid.value.trim();
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자
			
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
				return false;
			}
			else if(!regex1.test(mid)) {
				document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    myform.mid.focus();
				return false;
			}
			
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/member/memberIdCheck",
    		data : {mid : mid},
    		success:function(res) {
    			if(res == "1") {
    				alert("이미 사용 중인 아이디 입니다. 다시 입력해 주세요");
    				$("#mid").focus();
    			}
    			else  {
    				alert("사용 가능한 아이디 입니다.");
    				idCheckSw = 1;
    				myform.mid.readOnly = true;
    				$("#pwd").focus();
    			}
    		}
    	});
		}
		
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
		
		// 전화번호 길이 제한(4자리 이상부터 입력 불가)
		function handleOnInput(el, maxlength) {
		  if(el.value.length > maxlength)  {
		    el.value 
		      = el.value.substr(0, maxlength);
		  }
		}
		
		// 첫 번째 전화번호 내용 입력 후 자동으로 커서 옮기기
		$(document).ready(function() {
	    $(".inputs").keyup(function () {
        if (this.value.length == this.maxLength) {
          $(this).next('.inputs').focus();
        }
	    });
		});	
		
		
		let check = true;

		// 가입부분 체크
		function joinCheck(){
		  let mid = document.getElementById("mid").value.trim();
		  let pwd = document.getElementById("pwd").value.trim();
		  let pwd2 = document.getElementById("pwd2").value.trim();
		  let nickname = document.getElementById("nickname").value.trim();
		  let name = document.getElementById("name").value.trim();
	  
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
		  let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  let agreement1 = document.getElementById("agreement1").checked;
		  let agreement2 = document.getElementById("agreement2").checked;
		  
		  let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
		  let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; 
		  //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
		  
		  let regex3 = /^[가-힣a-zA-Z]{2,10}$/;  // (성명)한글,영문 2~10자
	 		let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일 
	 		let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
	 		let regex6 = /^[가-힣0-9]{2,10}$/; //(별명)한글,숫자 2~10자
			
		  	
		  // 아이디 확인
		  if(!regex1.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    check = false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
			   check = true;
		  }
		  
 		  // 비밀번호 확인
		  if(!regex2.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
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
		  
		  // 별명 확인
		  if(!regex6.test(nickname)){
		    document.getElementById("nicknameError").innerHTML="별명이 올바르지 않습니다.(한글/숫자만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nicknameError").innerHTML="";
			  check = true;
		  }	
				  
		  // 성명 확인
		  if(!regex3.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
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
/* 			  alert('입력된 값을 다시 확인해주세요.'); */
			  alert('책(의)세계로 갈 준비를 완료해주세요!');
			  window.scrollTo(0,130); // (그냥 위치만 바뀌는)스크롤 위로 올리기 
			  check = true;
		  }
		  else if(agreement1 == false || agreement2 == false) {
			  alert('필수 약관 동의가 필요합니다.');
		  }
		  else {
		    if(idCheckSw == 0) {
					alert("아이디 중복확인을 해주세요.");
					document.getElementById("midBtn").focus();
				} 
		    else if(nicknameCheckSw == 0) {
					alert("별명 중복확인을 해주세요.");
					document.getElementById("nicknameBtn").focus();
				} 
				else {
			    myform.tel.value = tel;
			    myform.email.value = email;
			   	myform.submit();
				}
		  }
		}
		
		function midCheck() {
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
			let mid = document.getElementById("mid").value.trim();
			document.getElementById("midError").innerHTML="";
			
		  // 아이디 확인
		  if(!regex1.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    check = false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
			   check = true;
		  }			
		}
 		function pwdCheck() {
			let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
			let pwd = document.getElementById("pwd").value.trim();
			document.getElementById("pwdError").innerHTML="";
			
		  // 비밀번호 확인
		  if(!regex2.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
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
		
		function nameCheck() {
			let regex3 = /^[가-힣a-zA-Z]{2,10}$/;  // (성명)한글,영문 2~10자
			let name = document.getElementById("name").value.trim();
			document.getElementById("nameError").innerHTML="";
			
		  // 성명 확인
		  if(!regex3.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
			  check = true;
		  }			
		}
		
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
	      
    let emailInput = document.getElementById('email');
	  let emailBtn = document.getElementById('emailBtn');
	  let changeEmailBtn = document.getElementById('changeEmail');
	  let codeInput = document.getElementById('code');
	  let codeCheck = document.getElementById('codeCheck'); 
	  let timerId;
	  let timerElement = document.createElement('span');
	  timerElement.id = 'timer';
	  emailBtn.parentNode.appendChild(timerElement);
	  let emailAuth = "";
	  
	  
	  function sendCode() {
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

				let email1 = myform.email1.value.trim();
	    	let email2 = myform.email2.value;
	    	let email = email1 + "@" + email2;
			
	      // 인증코드 이메일 발송 처리
	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/member/memberEmailAuth",
	    	  data : {email : email},
	    	  success : function(res) {
	    		  emailAuth = res;
	    		  /*emailAuthProcess(emailAuth);*/
	    		  
				    emailInput.readOnly = true;
				    emailBtn.disabled = true;
				    changeEmailBtn.style.display = 'inline-block';
				    timerId = startTimer();
				    enableCodeCheck(); 
				    
	    	  },
	    	  error : function() {
	    		  alert('이메일 인증 오류가 발생했습니다. 재시도 부탁드립니다.')
	    	  }
	      });
			
		  }
		
	  }
	
	  function enableEmailChange() {
	    emailInput.readOnly = false;
	    changeEmailBtn.style.display = 'none';
	    codeInput.value = '';
	    timerElement.textContent = '';
	    codeInput.disabled = true;
	    clearInterval(timerId);
	    emailBtn.disabled = false;
	    disableCodeCheck();
	  }
	
	  function startTimer() {
		  let timeLeft = 60;
	
	
	    function countDown() {
	      if (timeLeft === 0) {
	        clearInterval(timerId);
	        disableVerification();
	      } else {
	        timerElement.textContent = '      (남은 시간: ' + timeLeft + '초)';
	        timeLeft--;
	      }
	    }
	
	    countDown();
	    return setInterval(countDown, 1000);
	  }
	
	  function enableCodeCheck() {
	    codeCheck.disabled = false;
	    codeInput.disabled = false;
	  } 
	
	  function disableCodeCheck() {
	    codeCheck.disabled = true;
	    codeInput.disabled = true;
	  }
	
	  function disableVerification() {
	    emailBtn.disabled = true;
	    emailInput.readOnly = true;
	    changeEmailBtn.style.display = 'none';
	    clearInterval(timerId);
	  }
	
/*	  document.getElementById('signup-form').addEventListener('submit', function (event) {
	    event.preventDefault();
	    let verificationCode = codeInput.value;
	    // 여기에 인증 코드 확인 및 회원가입 처리를 수행하는 코드를 추가하세요.
	  });    
*/
 
 
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
		
		$(document).ready(function(){
			$('#recoMid').focusout(function(){
				let recoMid =document.getElementById("recoMid").value.trim();
				let str = '';
				
				if(recoMid != '') {
					$.ajax({
						type : "post",
						url : "${ctp}/member/recoMid",
						data : {recoMid : recoMid},
						success : function(res) {
							if(res == '1') {
							  /* check = true; 이걸 이렇게 주는 게 맞나? */
								str += '<span>존재하는 회원입니다.</span>';
							}
							else {
								str += '<span>존재하지 않는 회원입니다. 적립이 불가능합니다 :)</span>';
							}
							$('#recoMidCheck').html(str);
						},
						error : function() {
							alert('추천인 아이디 검색 오류\n재시도 부탁드립니다.');
						}
					});
				}
				else {
					$('#recoMidCheck').html(str);
				}
			});
			
			
			$('.check-all').click(function(){
				$('.agree').prop('checked',this.checked);
			});
		});
		
