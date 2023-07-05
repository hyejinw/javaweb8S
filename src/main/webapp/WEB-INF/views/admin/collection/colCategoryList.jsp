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
		.btn2 {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
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
	</style>	
	<script>
		'use strict';
		
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/admin/collection/colCategoryList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
		 
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
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
		
		// 수정 시, 썸네일 이미지 1장 미리보기
		function thumbnailCheck2(input) {
			if(input.files && input.files[0]) { 
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('thumbnailDemo2').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('thumbnailDemo2').src = "";
			}
		}
		
		// 컬렉션 카테고리 등록
		function colCategoryInsert() {
			//let regex = /^[가-힣a-zA-Z\s\d:<>\(\)]+$/; // (컬렉션 명, 컬렉션 설명)한글,영문,숫자,:,공백 1자 이상
			
			let colName = document.getElementById('colName').value;
			let colDetail = document.getElementById('colDetail').value;
			let colThumbnail = document.getElementById('colThumbnail').value;
			
			let thumbnailExt = colThumbnail.substring(colThumbnail.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지

			if(colName == "" || colDetail == "" || colThumbnail == "") {
				alert('필수 입력을 완성해주세요.');
				return false;
			} 
			
			/* if(!regex.test(colName) || !regex.test(colDetail)) {
				alert('한글,영문,숫자,콜론,공백만 입력가능합니다.');
				document.getElementById('colName').focus();
				return false;
			} */
			if(thumbnailExt != "JPG" && thumbnailExt != "PNG" && thumbnailExt != "JPEG") {
				alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
				return false;
			}

/* 		name은 colThumbnail이 아님!!!!!!!!!    let thumbnailFileSize = colCollectionInsertForm.colThumbnail.files[0].size; */
			let thumbnailFileSize = document.getElementById('colThumbnail').files[0].size;
			
			if(thumbnailFileSize > maxSize) {
				alert("업로드 파일의 최대용량은 20MByte 입니다.");
				return false;
			}
			colCollectionInsertForm.submit();
		}
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function (){
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 컬렉션을 삭제하시겠습니까?")) {
 		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/collection/colCategoryDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 카테고리가 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 컬렉션 카테고리 수정 창
		function colCateUpdate(idx) {
			$('#colName'+idx).attr('disabled', false);
			$('#colDetail'+idx).attr('disabled', false);
			$('#colDate'+idx).attr('disabled', false);
			$('#confirm'+idx).css("display","inline-block");
			$('#update'+idx).css("display","none");
			
			// 입력값 끝에 커서 주기
			let colNameValue = $('#colName'+idx).val();
      $('#colName'+idx).focus().val('').val(colNameValue);
		}
		
		function colCateConfirm(idx) {
			let colName = document.getElementById('colName'+idx).value.trim();
			let colDetail = document.getElementById('colDetail'+idx).value.trim();
			let colDate = document.getElementById('colDate'+idx).value.trim();
			
			if(colName == "" || colDetail == "" || colDate == "") {
				alert('컬렉션 명, 컬렉션 설명과 발행일은 필수 입력값입니다.');
				return false;
			}

			$.ajax({
    	  type : "post",
    	  url : "${ctp}/admin/collection/colCategoryUpdate",
    	  data : {idx : idx, colName : colName, colDetail : colDetail, colDate : colDate},
    	  success : function(res) {
    			if(res == "1") {
    				alert("수정되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
			
			$('#colName'+idx).attr('disabled', true);
			$('#colDetail'+idx).attr('disabled', true);
			$('#colDate'+idx).attr('disabled', true);
			$('#confirm'+idx).css("display","none");
			$('#update'+idx).css("display","inline-block");
		}
		
		
		// 컬렉션 공개/비공개 변경
		function openChange(idx, colOpen) {
			$.ajax({
	  	  type : "post",
	  	  url : "${ctp}/admin/collection/colCategoryOpenUpdate",
	  	  data : {idx : idx, colOpen : colOpen},
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
		
		// 썸네일 변경 시, 값 넘겨주기
		function throwData(idx, colThumbnail) {
			document.getElementById('throwIdx').value = idx;
			document.getElementById('throwThumbnail').value = colThumbnail;
		}
		
		// 컬렉션 카테고리 썸네일 변경
		function colCategoryThumbUpdate() {
			let colThumbnail = document.getElementById('colThumbnail2').value;
			
			let thumbnailExt = colThumbnail.substring(colThumbnail.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지

			if(colThumbnail == "") {
				alert('변경할 썸네일을 선택해주세요.');
				return false;
			} 
			
			if(thumbnailExt != "JPG" && thumbnailExt != "PNG" && thumbnailExt != "JPEG") {
				alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
				return false;
			}

			let thumbnailFileSize = document.getElementById('colThumbnail2').files[0].size;
			
			if(thumbnailFileSize > maxSize) {
				alert("업로드 파일의 최대용량은 20MByte 입니다.");
				return false;
			}
			thumbnailUpdateForm.submit();
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:80px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="text-right">
					<a class="btn btn-danger mb-4" href="#" style="margin-left:100px" data-toggle="modal" data-target="#myModal">등록</a>
				</div>
				<div style="text-align:center;"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">컬렉션 카테고리 관리</span></div>
				<div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	컬렉션 삭제 시, 관련 상품도 함께 삭제됩니다.<br/>썸네일 클릭하면 썸네일 수정이 가능합니다.
				  </span>
			  </div>				
			</div>
			<div class="row">
				<div class="col text-left">
					<a class="btn btn-dark mb-4" href="javascript:deleteAction()" style="margin-right:100px;">선택 삭제</a>
				</div>
			</div>
		
		  <table class="table table-borderless mb-0 p-0">
		    <tr>
		      <td>
		        <select name="pageSize" id="pageSize" onchange="pageCheck()">
		          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
		          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
		          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
		          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
		          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
		        </select> 건
		      </td>
		      <td class="text-right">
		        <!-- 첫페이지 / 이전페이지 / (현재페이지번호/총페이지수) / 다음페이지 / 마지막페이지 -->
		        <c:if test="${pageVO.pag > 1}">
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead class="thead-dark">
			      <tr>
			        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
			        <th>컬렉션 명</th>
			        <th>컬렉션 설명</th>
			        <th>컬렉션 썸네일</th>
			        <th>발행일</th>
			        <th>공개 유무</th>
			        <th>비고</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
	 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
				      <tr>
				        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.colThumbnail}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
				        <td><input type="text" id="colName${vo.idx}" value="${vo.colName}" class="text-center" disabled style="border: none; width:200px"/></td>
				        <td><textarea id="colDetail${vo.idx}" cols="50" rows="5" disabled style="border: none">${fn:replace(vo.colDetail, "<br/>", newLine)}</textarea></td>
				        
				        <td><div><a href="#" data-toggle="modal" data-target="#thumbnailModal" onclick="throwData('${vo.idx}','${vo.colThumbnail}')"><img src="${ctp}/collection/${vo.colThumbnail}" width="100px"/></a></div></td>
				        
				        <td><input type="text" id="colDate${vo.idx}" value="${fn:substring(vo.colDate,0,19)}" class="text-center" disabled style="border: none"/></td>
				        <td>
				        	<div class="wrapper">
									  <input type="checkbox" class="switch" id="switch${vo.idx}" onchange="javascript:openChange('${vo.idx}', '${vo.colOpen}');" <c:if test="${vo.colOpen=='공개'}">checked</c:if>>
									  <label for="switch${vo.idx}" class="switch_label">
									    <span class="onf_btn"></span>
									  </label>
									</div>
				        </td>
				        
				        <td>
				        	<button class="btn btn-warning btn-sm" id="update${vo.idx}" onclick="colCateUpdate('${vo.idx}')">수정</button>
				        	<button class="btn btn-dark btn-sm" id="confirm${vo.idx}" onclick="colCateConfirm('${vo.idx}')" style="display:none;">종료</button>
				        	<hr style="background:#343a40; height:1px; border:0;"/><button class="btn btn-success btn-sm" onclick="location.href='${ctp}/admin/collection/';">상품보기</button>
			        	</td>
				      </tr>
				    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			    	</c:forEach>
			    	<tr><td colspan="7"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>	

		
		<div id="demo" style="display:none; margin:150px 0px" class="border">
			
		</div>
	
 	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="text-align:center;"><span class="text-center" style="font-size:28px; text-align:center; font-weight:500">컬렉션 카테고리 등록</span></div>
        	<div style="text-align:center;" class="mb-4">
					  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
						 	컬렉션 저장 후, 상품을 등록해주세요.<br/>별(*) 표시는 필수 입력입니다.
					  </span>
				  </div>
					<form name="colCollectionInsertForm" method="post" enctype="multipart/form-data">
						<div class="table-responsive">
							<table class="table text-left">
					      <tr>
					        <th>컬렉션 명 <span class="must">*</span></th>
					        <td><input type="text" name="colName" id="colName" class="form-control"/></td>
					      </tr>
					      <tr>
					        <th>컬렉션 설명 <span class="must">*</span></th>
					        <td><textarea rows="5" name="colDetail" id="colDetail" class="form-control"></textarea></td>
					      </tr>
					      <tr>
					        <th>컬렉션 썸네일 <span class="must">*</span></th>
					        <td><input type="file" name="thumbnailFile" id="colThumbnail" onchange="thumbnailCheck(this)" class="form-control-file border form-control"/></td>
					      </tr>
					      <tr>
					        <td colspan="2" class="text-center">
						        <div style="margin-top:20px">
											<button type="button" onclick="colCategoryInsert()" class="btn2" style="background-color:#F5EBE0; font-size: 0.9em; border-color:#282828; color:black">등록</button>
						        </div>
					        </td>
					      </tr>
						  </table>
						</div>
			  	</form>
					<div class="text-center"><img id="thumbnailDemo" width="300px"/></div>			  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
		
 	<!-- The Modal -->
  <div class="modal fade" id="thumbnailModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="text-align:center;"><span class="text-center" style="font-size:28px; text-align:center; font-weight:500">컬렉션 카테고리 썸네일 변경</span></div>
        	<div style="text-align:center;" class="mb-4">
					  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
						 	기존 썸네일은 완전히 삭제됩니다.
					  </span>
				  </div>
					<form name="thumbnailUpdateForm" method="post" action="${ctp}/admin/collection/colCategorythumbUpdate" enctype="multipart/form-data">
						<div class="table-responsive">
							<table class="table text-left">
					      <tr>
					        <th>컬렉션 썸네일 <span class="must">*</span></th>
					        <td><input type="file" name="thumbnailFile" id="colThumbnail2" onchange="thumbnailCheck2(this)" class="form-control-file border form-control"/></td>
					      </tr>
					      <tr>
					        <td colspan="2" class="text-center">
						        <div style="margin-top:20px">
											<button type="button" onclick="colCategoryThumbUpdate()" class="btn2" style="background-color:#F5EBE0; font-size: 0.9em; border-color:#282828; color:black">변경</button>
						        </div>
					        </td>
					      </tr>
						  </table>
						</div>
						<input type="hidden" name="idx" id="throwIdx"/>
						<input type="hidden" name="colThumbnail" id="throwThumbnail"/>
			  	</form>
					<div class="text-center"><img id="thumbnailDemo2" width="300px"/></div>			  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
		

</body>
</html>