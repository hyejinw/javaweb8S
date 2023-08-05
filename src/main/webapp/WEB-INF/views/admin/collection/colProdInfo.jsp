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
</head>
<body class="w3-light-grey">
<a id="back-to-top"></a>
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
		 			<div class="col text-left">
					  <a class="btn btn-dark addBtn" href="${ctp}/admin/collection/colProdInfo?idx=${vo.idx}" style="margin-left:20px;">수정 취소</a>
		 			</div>
		 			<div class="col text-right">
					  <a class="btn btn-dark" href="${ctp}/admin/collection/colProdList" style="margin-right:20px;">상품 목록</a>
		 			</div>
	 			</div>
				<div style="text-align:center"><span class="text-center hideBtn" style="font-size:30px; text-align:center; font-weight:500">상품 정보</span></div>
				<div style="text-align:center"><span class="text-center addBlockBtn" style="font-size:30px; text-align:center; font-weight:500">상품 수정</span></div>
			  <div style="text-align:center;" class="addBlockBtn">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	별(*) 표시는 필수 입력입니다.<br/>상품 관련 파일 미 업로드 시, 기존 파일이 유지됩니다.
				  </span><hr/>
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue;">
					 	※관련 도서는 변경할 수 없습니다.※
				  </span>
			  </div>
			  <div style="text-align:center;" class="hideBtn">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue;">
					 	※수정 버튼을 누르면, 수정이 가능합니다.※
				  </span>
			  </div>
	 		</div>
			
		  <div style="background-color:white; padding:20px">
		  	<form name="colProdUpdateForm" method="post" action="${ctp}/admin/collection/colProdUpdate" enctype="multipart/form-data">
					<div class="table-responsive">
						<table class="table text-left">
				      <tr>
				        <th>컬렉션 카테고리 <span class="must">*</span></th>
				        <td>
				        	<select id="colIdx" name="colIdx" class="form-control">
			        		 <option value="" disabled>카테고리를 선택하세요</option>	
				        		<c:forEach var="colCategoryVO" items="${colCategoryVOS}">  
					        		<option value="${colCategoryVO.idx}" <c:if test="${colIdx == colCategoryVO.idx}">selected</c:if>>${colCategoryVO.colName}</option>
				        		</c:forEach>
				        	</select>
				        </td>
				      </tr>
				      <tr>
				        <td><b>관련 도서 <span class="must">*</span></b>
				       		&nbsp;&nbsp;&nbsp;<span class="text-danger">변경 불가</span>
				        </td>
				        <td>
									<input type="text" name="bookTitle" id="bookTitle" class="form-control" value="${vo.bookTitle}"/>
								</td>
				      </tr>
				      <tr>
				        <th>상품 코드 <span class="must">*</span></th>
				        <td><input type="text" name="prodCode" id="prodCode" value="${vo.prodCode}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품명 <span class="must">*</span></th>
				        <td><input type="text" name="prodName" id="prodName" value="${vo.prodName}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>가격 <span class="must">*</span></th>
				        <td><input type="number" name="prodPrice" id="prodPrice" value="${vo.prodPrice}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 선정 이유</th>
				        <td><input type="text" name="prodReason" id="prodReason" value="${vo.prodReason}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 썸네일 <span class="must">*</span></th>
				        <td><input type="file" name="thumbnailFile" id="prodThumbnail" onchange="thumbnailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 상세설명 <span class="must">*</span></th>
				        <td><input type="file" name="detailFile" id="prodDetail" onchange="detailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>등록일 <span class="must">*</span></th>
				        <td><input type="text" name="prodDate" id="prodDate" value="${vo.prodDate}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>판매 수량 <span class="must">*</span></th>
				        <td><input type="number" name="prodSaleQuantity" id="prodSaleQuantity" value="${vo.prodSaleQuantity}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>저장 등록 수 <span class="must">*</span></th>
				        <td><input type="number" name="prodSave" id="prodSave" value="${vo.prodSave}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>공개 유무 <span class="must">*</span></th>
				        <td>
				        	<div class="row">
				        		<div class="col-2"><input type="text" name="prodOpen" id="prodOpen" value="${vo.prodOpen}" style="border:none"/></div>
				        		<div class="col-10 text-left">
						        	<div class="wrapper addBtn">
											  <input type="checkbox" class="switch" id="switch" onchange="javascript:openChange('${vo.idx}', '${vo.prodOpen}');" <c:if test="${vo.prodOpen=='공개'}">checked</c:if>>
											  <label for="switch" class="switch_label">
											    <span class="onf_btn"></span>
											  </label>
											</div>
				        		</div>
				        	</div>
				        	
				        </td>
				      </tr>
				      <!-- 옵션 -->
				      <tr><td colspan="2" class="text-center"><br/><br/><span style="font-size:25px">옵션</span>
				      &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success btn-sm addBtn" onclick="addOption()">추가</button></td></tr>
					  </table>
					  
			     	<c:forEach var="optionVO" items="${optionVOS}" varStatus="st">
			     		<div id="t${st.count}">
			     			<div class="row">
			     				<div class="col-4" class="text-left">
			     					<b>옵션명 ${st.count}  <span class="must">*</span></b>
					        	<c:if test="${st.count != 1}">
						        	&nbsp;&nbsp;&nbsp;<input type="button" value="삭제" class="btn btn-danger btn-sm addBtn" onclick="removeOriginOption('t${st.count}','${optionVO.idx}')" />
					        	</c:if>
			     				</div>
			     				<div class="col-8" class="text-right">
			     					<input type="text" name="opName" id="opName${st.count}" value="${optionVO.opName}" class="form-control"/>
			     				</div>
			     			</div>
			     			<div class="row">
			     				<div class="col-4">
			     					<b>옵션 가격  <span class="must">*</span></b>
			     				</div>
			     				<div class="col-8">
			     					<input type="number" name="opPrice" id="opPrice${st.count}" value="${optionVO.opPrice}" class="form-control"/>
			     				</div>
			     			</div>
			     			<div class="row">
			     				<div class="col-4">
			     					<b>재고 수량  <span class="must">*</span></b>
			     				</div>
			     				<div class="col-8">
			     					<input type="number" name="opStock" id="opStock${st.count}" value="${optionVO.opStock}" class="form-control"/>
			     				</div>
			     			</div>
					      <hr/>
				      </div>
				      <input type="hidden" name="opIdx" value="${optionVO.idx}"/>
			     	</c:forEach>
			     	<!-- 옵션추가 -->
		      	<div id="optionType"></div>
		      	
		        <div style="margin-top:20px" class="text-center">
							<button type="button" onclick="hideBtn()" id="updateBtn" class="btn2 hideBtn" style="background-color:#F5EBE0; font-size: 1.1em; border-color:#282828; color:black">수정</button>
							<button type="button" onclick="colProdUpdate()" class="btn2 addBtn" style="background-color:#F5EBE0; font-size: 1.1em; border-color:#282828; color:black">수정 완료</button>
		        </div>
					</div>
					<input type="hidden" name="idx" value="${vo.idx}"/>
		  	</form>
		  	
			  <div class="row text-center">
					<div class="col-4"><img id="thumbnailDemo" width="300px"/></div>			  
					<div class="col-8"><img id="detailDemo" width="600px"/></div>			  
			  </div>
			  <hr/>
			  <div class="row text-center"><div class="col">기존 이미지</div></div>
			  <div class="row text-center">
					<div class="col-4"><img src="${ctp}/collection/${vo.prodThumbnail}" width="300px"/></div>			  
 					<div class="col-8"><img src="${ctp}/collection/${vo.prodDetail}" width="600px"/></div>	
			  </div>
		  </div>
		  
		  
		</div>
	</div>

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
		
		$(document).ready(function(){
			$('input').prop('readonly', true);
			$('select').prop('disabled', true);
			$('.addBtn').css('display', 'none');
			$('.addBlockBtn').css('display', 'none');
		});
		
		// 수정 허용
		function hideBtn() {
			$('input').prop('readonly', false);
			$('select').prop('disabled', false);
			
			$('.addBtn').css('display', 'inline-block');
			$('.addBlockBtn').css('display', 'block');
			$('.hideBtn').css('display', 'none');
			
			$('#prodCode').prop('readonly', true);
			$('#bookTitle').prop('readonly', true);
			$('#prodDate').prop('readonly', true);
			$('#prodSaleQuantity').prop('readonly', true);
			$('#prodSave').prop('readonly', true);
			
		}
	
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
		
		// 상품 + 옵션 수정
		function colProdUpdate() {

			let colIdx = document.getElementById('colIdx').value;
			let bookTitle = document.getElementById('bookTitle').value;
			let prodName = document.getElementById('prodName').value;
			let prodPrice = document.getElementById('prodPrice').value;
			let prodReason = document.getElementById('prodReason').value;
			let prodThumbnail = document.getElementById('prodThumbnail').value;
			let prodDetail = document.getElementById('prodDetail').value;
			
			let thumbnailExt = prodThumbnail.substring(prodThumbnail.lastIndexOf(".")+1).toUpperCase();
			let detailExt = prodDetail.substring(prodDetail.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			
			if(colIdx == "" || bookTitle == "" || prodName == "" || prodPrice == "") {
				alert('필수 입력을 완성해주세요.');
				return false;
			}
			
			if((prodThumbnail == "" && prodDetail != "") || (prodThumbnail != "" && prodDetail == "")) {
				alert('썸네일과 상세설명 파일은 단독 수정이 불가능합니다.\n모두 변경해주세요.');
				return false;
			} 
			
			if(prodThumbnail != "") {
				if(thumbnailExt != "JPG" && thumbnailExt != "PNG" && thumbnailExt != "JPEG") {
					alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
					return false;
				}
				
				let thumbnailFileSize = document.getElementById('prodThumbnail').files[0].size;
				if(thumbnailFileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
			}
			
			if(prodDetail != "") {
				if(detailExt != "JPG" && detailExt != "PNG" && detailExt != "JPEG") {
					alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
					return false;
				}
				let detailFileSize = document.getElementById('prodDetail').files[0].size;
				if(detailFileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
			}
			
			// 옵션 확인
			for(let i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("opName"+i).value=="") {
    			alert("빈칸 없이 상품 옵션 명을 모두 등록해주세요.");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("opPrice"+i).value=="") {
    			alert("빈칸 없이 상품 옵션 가격을 모두 등록해주세요.");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("opStock"+i).value=="") {
    			alert("재고를 모두 등록해주세요.");
    			return false;
    		}
    	}
    	
    	colProdUpdateForm.submit();
		}
		
		
		
		let cnt = ${optionTotNum} + 1;
    // 옵션항목 추가
    function addOption() {
    	let strOption = "";
    	let test = "t" + cnt; 
			
    	strOption += '<div id="'+test+'">';
    	strOption += '<div class="row">';
    	strOption += '<div class="col-4" class="text-left">';
    	strOption += '<b>옵션명 '+cnt+'  <span class="must">*</span></b>';
    	strOption += '&nbsp;&nbsp;&nbsp;<input type="button" value="삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')" />';
    	strOption += '</div>';
    	strOption += '<div class="col-8" class="text-right">';
    	strOption += '<input type="text" name="newOpName" id="opName'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	
    	strOption += '<div class="row">';
    	strOption += '<div class="col-4">';
    	strOption += '<b>옵션 가격  <span class="must">*</span></b>';
    	strOption += '</div>';
    	strOption += '<div class="col-8">';
    	strOption += '<input type="number" name="newOpPrice" id="opPrice'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';

    	strOption += '<div class="row">';
    	strOption += '<div class="col-4">';
    	strOption += '<b>재고 수량  <span class="must">*</span></b>';
    	strOption += '</div>';
    	strOption += '<div class="col-8">';
    	strOption += '<input type="number" name="newOpStock" id="opStock'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	
    	strOption += '<hr/>';
    	strOption += '</div>';
    	
     	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
  		$("#"+test.id).remove();
    }
		// 기존 옵션 삭제
		function removeOriginOption(test, idx) {
			
			let ans = confirm('해당 옵션을 삭제하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/collection/prodOptionDelete",
				data : {idx : idx},
				success : function() {
					alert('선택한 옵션이 삭제되었습니다.')
				},
				error : function() {
					alert("전송 오류! 재시도 부탁드립니다.");
				}
			}); 
			
			document.getElementById(test).remove();
		}
		
		// 상품 공개/비공개 변경
		function openChange(idx, prodOpen) {
			if(prodOpen == '비공개') alert('컬렉션이 비공개일 경우, 상품 공개 전환 후의 전시 상태는 동일합니다.');
			
			$.ajax({
	  	  type : "post",
	  	  url : "${ctp}/admin/collection/colProdOpenUpdate",
	  	  data : {idx : idx, prodOpen : prodOpen},
	  	  success : function(res) {
	  			if(res == "1") {
	  				alert("변경되었습니다.");
	  				//alert("res : " + res);
	  				
	  				//document.getElementById('prodOpen').value = res;
	  				
	  				$(document).ready(function () {
	  					alert('오냐');
		  				location.reload();
	  					document.getElementById('updateBtn').click();
				    });
	  			}
	  		},
	  		error : function() {
	  			alert("전송 오류! 재시도 부탁드립니다.");
	  		}
	  	});
		}
		
	</script>
</body>
</html>