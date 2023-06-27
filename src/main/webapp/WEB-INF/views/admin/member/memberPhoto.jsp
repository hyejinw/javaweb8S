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
	 		font-size: 20px;
	  }
	  .must {
  		color: red;
		}
	</style>	
	<script>
		'use strict';
		 
		function open() {
			$('#demo').css("display","block");
			$('#close').css("display","inline-block");
			$('#open').css("display","none");
		}
		
		 
		function close() {
			$('#demo').css("display","none");
			$('#close').css("display","none");
			$('#open').css("display","inline-block");
		}
		
		// 기본 이미지 업로드
		function photoCheck() {
/* 			let memo = document.getElementById('memo').value;
			let fName = document.getElementById('fName').value; */
			let memo = photoInsert.memo.value;
			let fName = photoInsert.fName.value;
			let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			
			if(fName.trim() == "") {
				alert("사진을 업로드해주세요.");
				return false;
			}
			
			let fileSize = photoInsert.fName.files[0].size;
			if(ext != "JPG" && ext != "PNG") {
				alert("업로드 가능한 사진 파일은 'jpg 또는 png' 입니다.");
			}
			else if(fileSize > maxSize) {
				alert("업로드 파일의 최대용량은 20MByte 입니다.");
			}
			else {
				photoInsert.submit();
			}
		}
		
/* 		// 기본 이미지 삭제
		function photoDelete(fName) {
    	let ans = confirm("선택한 기본 이미지를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/member/memberdefaultPhotoDelete",
    		data : {fName : fName},
    		success:function(res) {
    			if(res == "1") {
    				alert("기본 이미지가 삭제되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
		} */
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('photoDemo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('photoDemo').src = "";
			}
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:80px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:80px 50px 20px 50px" class="border">
			<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">기본 프로필 사진 관리</span></div>
			<a id="open" class="btn btn-danger text-left mb-4" href="javascript:open()" style="margin-left:100px">기본 이미지 등록</a>
			<a id="close" class="btn btn-dark text-left mb-4" href="javascript:close()" style="margin-left:100px; display:none;">등록 종료</a>
			<table class="table text-center">
		    <thead class="thead-dark">
		      <tr>
		        <th>번호</th>
		        <th>파일</th>
		        <th>설명</th>
		        <th>업로드 일자</th>
		        <th>비고</th>
		      </tr>
		    </thead>
		    <tbody>
 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
			      <tr>
			        <td>${st.count}</td>
			        <td><a href="${ctp}/admin/member/${vo.fName}" download>${vo.fName}</a> &nbsp;&nbsp;&nbsp;<img src="${ctp}/admin/member/${vo.fName}" style="width:100px" class="w3-hover-opacity"></td>
			        <td>${vo.memo}</td>
			        <td>${vo.photoDate}</td>
			        <td><button class="btn btn-danger btn-sm" onclick="photoDelete('${vo.fName}')">삭제</button></td>
			      </tr>
		    	</c:forEach> 
		    </tbody>
		  </table>

		
		</div>

	
		<div id="demo" style="display:none; margin-top:150px">
			<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">기본 이미지 등록</span></div>
			<div style="text-align:center; margin-bottom:40px"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">등록 후, 자동으로 업데이트 됩니다.</span></div>
	    
	    <form name="photoInsert" method="post" action="${ctp}/admin/member/memberDefaultPhotoInsert" enctype="multipart/form-data" style="width:90%; margin:0px auto; padding:20px 50px; background-color:#FFF4D2;" class="border">
				<div class="row mb-3">
					<div class="col-sm-4 head">설명</div>
					<div class="col-sm-8"><input type="text" name="memo" id="memo" class="form-control"/></div>
				</div>
				<div class="row mb-3">
					<div class="col-sm-4 head">메뉴 사진 <span class="must">*</span></div>
					<div class="col-sm-8"><input type="file" name="fName" id="fName" onchange="imgCheck(this)" class="form-control-file border form-control"/></div>
				</div>
				<div class="row mb-4">
					<div class="col"><img id="photoDemo" width="200px"/></div>
				</div>
		  	<span style="color:red; margin-top:15px" class="text-right">별(*) 표시는 필수 입력사항입니다.</span><br/><br/>
				
				<div class="row mb-3 text-center">
					<div class="col-sm">
						<input type="reset" value="다시 입력" class="btn btn-dark mr-5" style="width:200px; height:50px; border-radius:30px;"/>
						<input type="button" value="등록" onclick="photoCheck()" class="btn btn-success" style="width:200px; height:50px; border-radius:30px;" />
					</div>
				</div>
	    </form>
		</div>
	</div>
</body>
</html>