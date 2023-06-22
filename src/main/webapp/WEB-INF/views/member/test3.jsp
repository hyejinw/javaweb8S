<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>회원가입</title>

</head>
<body>
  <h1>회원가입</h1>
  <form id="signup-form">
    <label for="email">이메일:</label>
    <input type="email" id="email" required>
    <button type="button" id="emailBtn" onclick="sendCode()">이메일 인증</button>
    <button type="button" id="changeEmail" onclick="enableEmailChange()" style="display:none">이메일 변경</button>
    <br>
    <label for="code">인증코드:</label>
    <input type="text" id="code" disabled>
    <button type="submit" id="codeCheck" disabled>인증</button>
  </form>
</body>
  <script>
  let emailInput = document.getElementById('email');
  let emailBtn = document.getElementById('emailBtn');
  let changeEmailBtn = document.getElementById('changeEmail');
  let codeInput = document.getElementById('code');
  let codeCheck = document.getElementById('codeCheck'); 
  let timerId;
  let timerElement = document.createElement('span');
  timerElement.id = 'timer';
  emailBtn.parentNode.appendChild(timerElement);
  
  
  function sendCode() {
    emailInput.readOnly = true;
    emailBtn.disabled = true;
    changeEmailBtn.style.display = 'inline-block';
    timerId = startTimer();
    enableCodeCheck(); 
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
        timerElement.textContent = ' (남은 시간: ' + timeLeft + '초)';
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

  document.getElementById('signup-form').addEventListener('submit', function (event) {
    event.preventDefault();
    let verificationCode = codeInput.value;
    // 여기에 인증 코드 확인 및 회원가입 처리를 수행하는 코드를 추가하세요.
  });

  </script>
</html>   