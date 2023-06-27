<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>기본 프로필 사진 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
	  .head {
	 		background-color:#FFF4D2;
	 		font-size: 20px;
	  }
	</style>	
	<script>
		'use strict';
		
		function menuCheck() {
			let menuPhoto = document.getElementById('menuPhoto').value;
			let ext = menuPhoto.substring(menuPhoto.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 10; // 업로드 가능 파일은 10MByte까지
			
			if(menuPhoto.trim() == "") {
				alert("메뉴 사진을 업로드해주세요.");
				return false;
			}
			
			let fileSize = document.getElementById("menuPhoto").files[0].size;
			if(ext != "JPG" && ext != "GIF" && ext != "PNG") {
				alert("업로드 가능한 사진 파일은 'jpg/gif/png' 입니다.");
			}
			else if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 10MByte 입니다.");
			}
			else {
				menuInsert.submit();
			}
		}
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('demo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  // 이렇게하면 stream 단위 input/output 그거 안 써도 된다.
			}
			else {
				document.getElementById('demo').src = "";
			}
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:80px">
	
		<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">메뉴 등록</span></div>
		<div style="text-align:center"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red">메뉴 등록 후, 공개 유무를 설정해주세요.</span></div>
		<button class="btn btn-danger text-left mb-4" onclick="location.href='${ctp}/AdminMenuList.kn_ad';" style="margin-left: 100px">메뉴 조회창</button>
    
    <form name="menuInsert" method="post" action="${ctp}/AdminMenuInsertOk.kn_ad" enctype="multipart/form-data" style="width:90%; margin:0px auto; padding:20px 50px" class="border">
			<div class="row mb-3">
				<div class="col-sm-4 head">카테고리</div>
				<div class="col-sm-8">
					<input type="radio" name="category" value="도넛" checked/>&nbsp; <span style="font-size:18px">도넛</span>&nbsp;&nbsp;&nbsp;
					<input type="radio" name="category" value="케이크"/>&nbsp;<span style="font-size:18px">케이크</span>&nbsp;&nbsp;&nbsp;
					<input type="radio" name="category" value="베이커리"/>&nbsp; <span style="font-size:18px">베이커리</span>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-4 head">메뉴명</div>
				<div class="col-sm-8"><input type="text" name="menuName" id="menuName" class="form-control"/></div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-4 head">영문 메뉴명</div>
				<div class="col-sm-8"><input type="text" name="menuEngName" id="menuEngName" class="form-control"/></div>
			</div>
			
			
			<div class="row mb-3 text-center">
				<div class="col-sm">
					<input type="reset" value="다시 입력" class="btn btn-dark mr-5" style="width:200px; height:50px; border-radius:30px;"/>
					<input type="button" value="등록" onclick="menuCheck()" class="btn btn-success" style="width:200px; height:50px; border-radius:30px;" />
				</div>
			</div>
    </form>
	</div>
	
</body>
</html>