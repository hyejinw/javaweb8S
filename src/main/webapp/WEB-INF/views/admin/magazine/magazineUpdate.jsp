<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<title>책(의)세계</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
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
		  text-align: left;
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
		#back-to-top {
		  display: inline-block;
		  background-color: #282828;
		  width: 50px;
		  height: 50px;
		  text-align: center;
		  border-radius: 4px;
		  position: fixed;
		  bottom: 30px;
		  right: 30px;
		  transition: background-color .3s, opacity .5s, visibility .5s;
		  opacity: 0;
		  visibility: hidden;
		  z-index: 1000;
		}
		#back-to-top::after {
		  content: "\f077";
		  font-family: FontAwesome;
		  font-weight: normal;
		  font-style: normal;
		  font-size: 2em;
		  line-height: 50px;
		  color: #fff;
		}
		#back-to-top:hover {
		  cursor: pointer;
		  text-decoration: none;
		  background-color: #333;
		}
		#back-to-top:active {
		  background-color: #555;
		}
		#back-to-top.show {
		  opacity: 1;
		  visibility: visible;
		}
	</style>
	<script>
		'use strict';
		
		// 맨 위로 스크롤
		$(function(){
		  $('#back-to-top').on('click',function(e){
		      e.preventDefault();
		      $('html,body').animate({scrollTop:0},600);
		  });
		  
		  $(window).scroll(function() {
		    if ($(document).scrollTop() > 100) {
		      $('#back-to-top').addClass('show');
		    } else {
		      $('#back-to-top').removeClass('show');
		    }
		  });
		});
		
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
			
			console.log("maType: " + maType);
			console.log("maDate: " + maDate);
			console.log("maStock: " + maStock);
			
			if(maType == "" || maTitle == "" || maPrice == "") {
				alert('필수 입력을 완성해주세요.');
				return false;
			}
 			if((maThumbnail == "" && maDetail != "") || (maThumbnail != "" && maDetail == "")) {
				alert('썸네일과 상세설명 파일은 단독 수정이 불가능합니다.\n모두 변경해주세요.');
				return false;
			} 
		  if(maType == "매거진" && (maDate == "" || maStock == "")) {
				alert('매거진은 발행일과 재고 수량을 필수로 입력해야 합니다.');
				return false;
			} 
			if(maThumbnail != "") {
				if(thumbnailExt != "JPG" && thumbnailExt != "PNG" && thumbnailExt != "JPEG") {
					alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
					return false;
				}
				
				let thumbnailFileSize = magazineUpdateForm.maThumbnail.files[0].size;
				if(thumbnailFileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
				
			}
			
			if(maDetail != "") {
				if(detailExt != "JPG" && detailExt != "PNG" && detailExt != "JPEG") {
					alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
					return false;
				}
				let detailFileSize = magazineUpdateForm.maDetail.files[0].size;
				if(detailFileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
			}
			magazineUpdateForm.submit();
		}
		
		// 매거진 공개/비공개 변경
		function openChange(idx, maOpen) {
			$.ajax({
	  	  type : "post",
	  	  url : "${ctp}/admin/magazine/magazineOpenUpdate",
	  	  data : {idx : idx, maOpen : maOpen},
	  	  success : function(res) {
	  			if(res == "1") {
	  				alert("변경되었습니다.");
	  				location.reload();
	  			}
	  		},
	  		error : function() {
	  			alert("전송 오류! 재시도 부탁드립니다.");
	  		}
	  	});
		}
	</script>
</head>
<body class="w3-light-grey">
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="text-right">
				  <a class="btn btn-dark" href="${ctp}/admin/magazine/magazineList" style="margin-right:20px;">매거진 목록</a>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">매거진 정보 수정</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
					 	『 ${vo.maTitle} (${fn:substring(vo.maDate,0,10).replace("-"," ")}) 』 <span style="color:red;">매거진 수정창<br/>별(*) 표시는 필수 입력입니다.<br/>상품 관련 파일 미 업로드 시, 기존 파일이 유지됩니다.</span>
				  </span>
			  </div>
	 		</div>
			
		  <div style="background-color:white; padding:20px">
		  	<form name="magazineUpdateForm" method="post" enctype="multipart/form-data">
					<div class="table-responsive">
						<table class="table text-left">
				      <tr>
				        <th>상품 코드</th>
				        <td><input type="text" name="maCode" id="maCode" value="${vo.maCode}" readonly class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 타입 <span class="must">*</span></th>
				        <td>
									<label for="type1"><input type="radio" name="maType" id="type1" value="매거진" <c:if test="${vo.maType == '매거진'}">checked</c:if>>&nbsp;&nbsp;매거진</label>
									<label for="type2"><input type="radio" name="maType" id="type2" value="정기 구독" class="ml-4" <c:if test="${vo.maType == '정기 구독'}">checked</c:if>>&nbsp;&nbsp;정기 구독</label>
				        </td>
				      </tr>
				      <tr>
				        <th>제목 <span class="must">*</span></th>
				        <td><input type="text" name="maTitle" id="maTitle" value="${vo.maTitle}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>가격 <span class="must">*</span></th>
				        <td><input type="number" name="maPrice" id="maPrice" value="${vo.maPrice}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 썸네일</th>
				        <td><input type="file" name="thumbnailFile" id="maThumbnail" onchange="thumbnailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 상세설명</th>
				        <td><input type="file" name="detailFile" id="maDetail" onchange="detailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>발행일  <span class="must">* (정기구독 제외)</span></th>
				        <td><input type="date" name="maDate" id="maDate" value="${fn:substring(vo.maDate,0,10)}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>재고 수량  <span class="must">* (정기구독 제외)</span></th>
				        <td><input type="number" name="maStock" id="maStock" value="${vo.maStock}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>판매 수량</th>
				        <td><input type="number" name="maSaleQuantity" id="maSaleQuantity" value="${vo.maSaleQuantity}" readonly class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>저장 등록 수</th>
				        <td><input type="number" name="maSave" id="maSave" value="${vo.maSave}" readonly class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>공개 유무</th>
				        <td>
				        	<div class="wrapper">
									  <input type="checkbox" class="switch" id="switch${vo.idx}" onchange="javascript:openChange('${vo.idx}', '${vo.maOpen}');" <c:if test="${vo.maOpen=='공개'}">checked</c:if>>
									  <label for="switch${vo.idx}" class="switch_label">
									    <span class="onf_btn"></span>
									  </label>
									</div>
				        </td>
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
				  <input type="hidden" name="idx" value="${vo.idx}"/>
		  	</form>
			  
			  <div class="row text-center">
					<div class="col-4"><img id="thumbnailDemo" width="300px"/></div>			  
					<div class="col-8"><img id="detailDemo" width="600px"/></div>			  
			  </div>
			  <hr/>
			  <div class="row text-center"><div class="col">기존 이미지</div></div>
			  <div class="row text-center">  <!-- 이미지가 안 나온당ㅜㅜ -->
					<div class="col-4"><img src="${ctp}/magazine/${vo.maThumbnail}" width="300px"/></div>			  
 					<div class="col-8"><img src="${ctp}/magazine/${vo.maDetail}" width="600px"/></div>	
			  </div>
		  </div>
		  
		  
		</div>
	</div>
	

</body>
</html>