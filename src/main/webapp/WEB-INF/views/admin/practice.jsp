<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title></title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<body>
    <h1>사이트</h1>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        $.ajax({
            method: "GET",
            url: "https://dapi.kakao.com/v3/search/book?target=title",
            data: {query : "미움받을 용기" },
            headers: { Authorization: "KakaoAK 7687511cd3463867077e445e82c52e7a" }
        })
        .done(function (msg) {
            console.log(msg);
        });
    </script>
</body>
</body>
</html>