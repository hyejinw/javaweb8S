<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
	</style>
	<script>
		'use strict'
		
		
	</script>
</head>
<body style="overflow-X:hidden"> 
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">기록 남기기</div>
			
				<!-- 여기에 내용이 들어가면 됩니당아아아아아 힘내자구용 -->
			</div>
		</div>
	</div>
	
	<div class="row text-center" style="margin-bottom:40px">
		<div class="col">
			<br/>
			<button class="btn btn-dark" onclick="reflectionInsert()">등록</button>&nbsp;&nbsp;&nbsp;
			<button class="btn btn-outline-dark" onclick="insertCancel()">취소</button>
		</div>
	</div>
	
	
  
</body>
</html>