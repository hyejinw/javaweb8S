<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	  <style>
	  .head {
	 		font-size: 20px;
	  }
	  .must {
  		color: red;
		}
		.wrapper {
		  /* width: 50px;
		  height: 50px; */
		  text-align: center;
		  /* margin: 50px auto; */
		}
		.switch {
		  position: absolute;
		  /* hidden */
		  appearance: none;
		  -webkit-appearance: none;
		  -moz-appearance: none;
		}
		
		.switch_label {
		  position: relative;
		  cursor: pointer;
		  display: inline-block;
		  width: 53px;
		  height: 23px;
		  background: #fff;
		  border: 2px solid #daa;
		  border-radius: 20px;
		  transition: 0.2s;
		}
		.switch_label:hover {
		  background: #efefef;
		}
		.onf_btn {
		  position: absolute;
		  top: 2px;
		  left: 3px;
		  display: inline-block;
		  width: 15px;
		  height: 15px;
		  border-radius: 20px;
		  background: #daa;
		  transition: 0.2s;
		}
		
		/* checking style */
		.switch:checked+.switch_label {
		  background: #c44;
		  border: 2px solid #c44;
		}
		
		.switch:checked+.switch_label:hover {
		  background: #e55;
		}
		
		/* move */
		.switch:checked+.switch_label .onf_btn {
		  left: 34px;
		  background: #fff;
		  box-shadow: 1px 2px 3px #00000020;
		}
		.btn2 {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		
		// 썸네일 이미지 1장 미리보기
		function thumbnailCheck(input) {
			if(input.files && input.files[0]) { 
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('thumbnailDemo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('thumbnailDemo').src = "";
			}
		}
		
		// 상세설명 이미지 1장 미리보기
		function detailCheck(input) {
			if(input.files && input.files[0]) { 
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('detailDemo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('detailDemo').src = "";
			}
		}
		
		// 매거진 등록
		function magazineInsert() {
			let regex1 = /^[0-9a-zA-Zㄱ-ㅎ가-힣\s]+$/;  // (제목)한글,영문,숫자,공백 1자 이상
			let regex2 = /^[0-9]+$/;  // (가격, 재고 수량)숫자 1자 이상
			
			let maType = document.querySelector('input[name="maType"]:checked').value;
			let maTitle = document.getElementById('maTitle').value;
			let maPrice = document.getElementById('maPrice').value;
			let maThumbnail = document.getElementById('maThumbnail').value;
			let maDetail = document.getElementById('maDetail').value;
			let maDate = document.getElementById('maDate').value;
			let maStock = document.getElementById('maStock').value;
			
			let thumbnailExt = maThumbnail.substring(maThumbnail.lastIndexOf(".")+1).toUpperCase();
			let detailExt = maDetail.substring(maDetail.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			alert("maType : " +maType);
			
			if(maType == "" || maTitle == "" || maPrice == "" || maThumbnail == "" || maDetail == "") {
				alert('필수 입력을 완성해주세요.');
				return false;
			}
			if(maType == "매거진" && (maDate == "" || maStock == "")) {
				alert('매거진은 발행일과 재고 수량을 필수로 입력해야 합니다.');
				return false;
			}
			if((thumbnailExt != "JPG" && thumbnailExt != "PNG" && thumbnailExt != "JPEG") || (detailExt != "JPG" && detailExt != "PNG" && detailExt != "JPEG")) {
				alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
				return false;
			}
			
			let thumbnailFileSize = magazineInsertForm.maThumbnail.files[0].size;
			let detailFileSize = magazineInsertForm.maDetail.files[0].size;
			
			if((thumbnailFileSize > maxSize) || (detailFileSize > maxSize)) {
				alert("업로드 파일의 최대용량은 20MByte 입니다.");
				return false;
			}
			magazineInsertForm.submit();
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="text-right">
				  <a class="btn btn-dark" href="${ctp}/admin/collection/colCategoryList" style="margin-right:20px;">컬렉션 목록</a>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">컬렉션 카테고리 등록</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	컬렉션 저장 후, 상품을 등록해주세요.<br/>별(*) 표시는 필수 입력입니다.
				  </span>
			  </div>
	 		</div>
			
		  <div style="background-color:white; padding:20px">
		  	<form name="magazineInsertForm" method="post" enctype="multipart/form-data">
					<div class="table-responsive">
						<table class="table text-left">
				      <tr>
				        <th>제목 <span class="must">*</span></th>
				        <td><input type="text" name="maTitle" id="maTitle" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>가격 <span class="must">*</span></th>
				        <td><input type="number" name="maPrice" id="maPrice" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 썸네일 <span class="must">*</span></th>
				        <td><input type="file" name="thumbnailFile" id="maThumbnail" onchange="thumbnailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 상세설명 <span class="must">*</span></th>
				        <td><input type="file" name="detailFile" id="maDetail" onchange="detailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>발행일  <span class="must">* (정기구독 제외)</span></th>
				        <td><input type="date" name="maDate" id="maDate" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>재고 수량  <span class="must">* (정기구독 제외)</span></th>
				        <td><input type="number" name="maStock" id="maStock" class="form-control"/></td>
				      </tr>
				      <tr>
				        <td colspan="2" class="text-center">
					        <div style="margin-top:20px">
										<button type="button" onclick="magazineInsert()" class="btn2" style="background-color:#F5EBE0; font-size: 0.9em; border-color:#282828; color:black">등록</button>
					        </div>
				        </td>
				      </tr>
					  </table>
					</div>
		  	</form>
			  
			  <div class="row text-center">
					<div class="col-4"><img id="thumbnailDemo" width="300px"/></div>			  
					<div class="col-8"><img id="detailDemo" width="600px"/></div>			  
			  </div>
		  </div>
		  
		  
		</div>
	</div>
	


</body>
</html>