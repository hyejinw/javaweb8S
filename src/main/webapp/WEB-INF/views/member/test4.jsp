<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>Email Verification</title>
    <style>
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <h1>Email Verification</h1>
    <label for="email">Email:</label>
    <input type="email" id="email" required>
    <button id="verificationButton" onclick="startVerification()">Email Verification</button>
    <button id="changeEmailButton" class="hidden" onclick="changeEmail()">Change Email</button>
    <br><br>
    <label for="verificationCode">Verification Code:</label>
    <input type="text" id="verificationCode" disabled>
    <button id="submitButton" class="hidden" onclick="submitVerification()">Submit</button>
    <p id="timer"></p>

    <script>
        var timer;
        var timeLeft = 60;

        function startVerification() {
            var emailInput = document.getElementById("email");
            emailInput.readOnly = true;
            var verificationButton = document.getElementById("verificationButton");
            verificationButton.disabled = true;

            var changeEmailButton = document.getElementById("changeEmailButton");
            changeEmailButton.classList.remove("hidden");

            var verificationCodeInput = document.getElementById("verificationCode");
            verificationCodeInput.disabled = false;

            var submitButton = document.getElementById("submitButton");
            submitButton.classList.remove("hidden");

            startTimer();
        }

        function changeEmail() {
            var emailInput = document.getElementById("email");
            emailInput.readOnly = false;
            emailInput.value = "";

            var changeEmailButton = document.getElementById("changeEmailButton");
            changeEmailButton.classList.add("hidden");

            var verificationCodeInput = document.getElementById("verificationCode");
            verificationCodeInput.value = "";
            verificationCodeInput.disabled = true;

            var submitButton = document.getElementById("submitButton");
            submitButton.classList.add("hidden");

            clearTimeout(timer);
            document.getElementById("timer").innerHTML = "";
            timeLeft = 60;
        }

        function startTimer() {
            timer = setInterval(function () {
                timeLeft--;
                document.getElementById("timer").innerHTML = "Time remaining: " + timeLeft + " seconds";

                if (timeLeft === 0) {
                    clearTimeout(timer);
                    document.getElementById("verificationButton").disabled = true;
                }
            }, 1000);
        }

        function submitVerification() {
            var verificationCodeInput = document.getElementById("verificationCode");
            var verificationCode = verificationCodeInput.value;

            // Perform verification with the backend
            // You can send an AJAX request to the server with the verification code and the email address

            // If the verification is successful, you can redirect the user to another page
            // For example:
            // window.location.href = "success.html";
        }
    </script>
</body>
</html>

