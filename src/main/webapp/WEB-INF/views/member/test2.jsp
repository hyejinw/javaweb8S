<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>이메일 인증 회원가입</title>
  <style>
    .timer {
      font-size: 24px;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <h1>이메일 인증 회원가입</h1>
  <form id="signupForm">
    <label for="email">이메일:</label>
    <input type="email" id="email" name="email" required>
    <button type="button" onclick="startTimer()">인증 메일 전송</button>
    <br>
    <label for="verificationCode">인증 코드:</label>
    <input type="text" id="verificationCode" name="verificationCode" required>
    <button type="button" onclick="verifyCode()">인증 코드 확인</button>
    <br>
    <input type="submit" value="가입">
  </form>

  <div id="timerContainer">
    <p>남은 시간: <span id="timer" class="timer">60</span>초</p>
  </div>

  <script>
    var countdown;
    var secondsRemaining = 60;

    function startTimer() {
      countdown = setInterval(updateTimer, 1000);
      // 여기에서 이메일 전송 로직을 추가하면 됩니다.
      // 이 예시에서는 단순히 타이머만 보여주도록 하였습니다.
    }

    function updateTimer() {
      var timerElement = document.getElementById("timer");
      secondsRemaining--;

      if (secondsRemaining >= 0) {
        timerElement.innerText = secondsRemaining;
      } else {
        clearInterval(countdown);
        timerElement.innerText = "시간 초과";
      }
    }

    function verifyCode() {
      var verificationCode = document.getElementById("verificationCode").value;
      // 여기에서 인증 코드 확인 로직을 추가하면 됩니다.
      // 이 예시에서는 단순히 콘솔에 출력하도록 하였습니다.
      console.log("인증 코드 확인:", verificationCode);
    }

    document.getElementById("signupForm").addEventListener("submit", function(event) {
      event.preventDefault();
      // 여기에서 회원가입 로직을 추가하면 됩니다.
      // 이 예시에서는 폼 제출을 막고 콘솔에 출력하도록 하였습니다.
      console.log("회원가입 폼 제출");
    });
  </script>
</body>
</html>