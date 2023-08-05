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
		
		$(document).ready(function() {
			if(${bookVOS != null}) {
				document.getElementById('bookBtn').click();
				$('#demo').css("display","block");
			}
		});
		
		
 		$(document).mouseup(function (e){
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal")) {
	    	$("#myModal").hide();
	    	
	    	let colIdx = document.getElementById('colIdx').value; 
	    	let prodName = document.getElementById('prodName').value;
	    	let prodPrice = document.getElementById('prodPrice').value;
	    	
				location.href="${ctp}/admin/collection/colProdInsert?colIdx="+colIdx+"&prodName="+prodName+"&prodPrice="+prodPrice;
	    }
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
		
		// 상품 + 옵션 등록
		function colProdInsert() {

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
			
			if(colIdx == "" || prodName == "" || prodPrice == "" || prodThumbnail == "" || prodDetail == "") {
				alert('필수 입력을 완성해주세요.');
				return false;
			}
			if((thumbnailExt != "JPG" && thumbnailExt != "PNG" && thumbnailExt != "JPEG") || (detailExt != "JPG" && detailExt != "PNG" && detailExt != "JPEG")) {
				alert("업로드 가능한 사진 파일은 'jpg, png 또는 jpeg' 입니다.");
				return false;
			}
			
			let thumbnailFileSize = document.getElementById('prodThumbnail').files[0].size;
			let detailFileSize = document.getElementById('prodDetail').files[0].size;
			
			if((thumbnailFileSize > maxSize) || (detailFileSize > maxSize)) {
				alert("업로드 파일의 최대용량은 20MByte 입니다.");
				return false;
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
    	if(document.getElementById("opName").value=="") {
    		alert("상품 옵션 명을 등록해주세요.");
    		document.getElementById("opName").focus();
    		return false;
    	}
    	else if(document.getElementById("opPrice").value=="") {
    		alert("상품 옵션 가격을 등록해주세요.");
    		document.getElementById("opPrice").focus();
    		return false;
    	}
    	colProdInsertForm.submit();
		}
		
		
		// 관련 도서 등록 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	let colIdx = document.getElementById('colIdx').value; 
    	let prodName = document.getElementById('prodName').value;
    	let prodPrice = document.getElementById('prodPrice').value;
    	
    	location.href = "${ctp}/admin/collection/bookSelect?searchString="+searchString+"&colIdx="+colIdx+"&prodName="+prodName+"&prodPrice="+prodPrice;
		}
		
		function bookSelection(idx, title) {
			document.getElementById('bookTitle').value = title;
			
			$("#myModal").hide();
	    	
    	document.getElementById('colIdx').value = '${colIdx}';
    	document.getElementById('prodName').value = '${prodName}';
    	document.getElementById('prodPrice').value = '${prodPrice}';
		}
		
		let cnt = 1;
    // 옵션항목 추가
    function addOption() {
    	let strOption = "";
    	let test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'">';
    	strOption += '<div class="row">';
    	strOption += '<div class="col-4" class="text-left">';
    	strOption += '<b>옵션명 <span class="must">*</span>&nbsp;&nbsp;&nbsp;</b>';
    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')">';
    	strOption += '</div>';
    	strOption += '<div class="col-8" class="text-right">';
    	strOption += '<input type="text" name="opName" id="opName'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	
    	strOption += '<div class="row">';
    	strOption += '<div class="col-4">';
    	strOption += '<b>옵션 가격 <span class="must">*</span></b>';
    	strOption += '</div>';
    	strOption += '<div class="col-8">';
    	strOption += '<input type="number" name="opPrice" id="opPrice'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';

    	strOption += '<div class="row">';
    	strOption += '<div class="col-4">';
    	strOption += '<b>재고 수량 <span class="must">*</span></b>';
    	strOption += '</div>';
    	strOption += '<div class="col-8">';
    	strOption += '<input type="number" name="opStock" id="opStock'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	
    	strOption += '<hr/>';
    	strOption += '</div>';
    	
    	
     	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
    	/* $("#"+test).remove(); */
    	$("#"+test.id).remove();
    }
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
		 			<div class="col text-left">
					  <a class="btn btn-dark" href="${ctp}/admin/collection/colProdInsert" style="margin-left:20px;">재입력</a>
		 			</div>
		 			<div class="col text-right">
					  <a class="btn btn-dark" href="${ctp}/admin/collection/colProdList" style="margin-right:20px;">상품 목록</a>
		 			</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">상품 등록</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	등록과 동시에, 상품이 공개됩니다.<br/>별(*) 표시는 필수 입력입니다.
				  </span><hr/>
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue;">
					 	※관련 도서를 먼저 선택해주세요.※<br/>관련 도서는 등록 후, 변경이 불가합니다.
				  </span>
			  </div>
	 		</div>
			
		  <div style="background-color:white; padding:20px">
		  	<form name="colProdInsertForm" method="post" action="${ctp}/admin/collection/colProdInsert" enctype="multipart/form-data">
					<div class="table-responsive">
						<table class="table text-left">
				      <tr>
				        <th>컬렉션 카테고리 <span class="must">*</span></th>
				        <td>
				        	<select id="colIdx" name="colIdx" class="form-control">
			        		 <option value="" selected disabled>카테고리를 선택하세요</option>	
				        		<c:forEach var="colCategoryVO" items="${colCategoryVOS}">  
					        		<option value="${colCategoryVO.idx}" <c:if test="${colIdx == colCategoryVO.idx}">selected</c:if>>${colCategoryVO.colName}</option>
				        		</c:forEach>
				        	</select>
				        </td>
				      </tr>
				      <tr>
				        <th>관련 도서
				       		&nbsp;&nbsp;&nbsp;<a class="btn btn-danger btn-sm" href="#" id="bookBtn" data-toggle="modal" data-target="#myModal">자료 검색</a>
				        </th>
				        <td>
									<input type="text" name="bookTitle" id="bookTitle" class="form-control" placeholder="검색으로 도서를 찾아주세요" readonly/>
								</td>
				      </tr>
				      <tr>
				        <th>상품명 <span class="must">*</span></th>
				        <td><input type="text" name="prodName" id="prodName" value="${prodName}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>가격 <span class="must">*</span></th>
				        <td><input type="number" name="prodPrice" id="prodPrice" value="${prodPrice}" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 선정 이유</th>
				        <td><input type="text" name="prodReason" id="prodReason" class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 썸네일 <span class="must">*</span></th>
				        <td><input type="file" name="thumbnailFile" id="prodThumbnail" onchange="thumbnailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <tr>
				        <th>상품 상세설명 <span class="must">*</span></th>
				        <td><input type="file" name="detailFile" id="prodDetail" onchange="detailCheck(this)" class="form-control-file border form-control"/></td>
				      </tr>
				      <!-- 옵션 -->
				      <tr><td colspan="2" class="text-center"><br/><br/><span style="font-size:25px">옵션</span>
				      &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success btn-sm addBtn" onclick="addOption()">추가</button></td></tr>
					  </table>
				      
			      <!-- 옵션 등록 -->
	     			<div class="row">
	     				<div class="col-4" class="text-left">
	     					<b>옵션명 <span class="must">*</span></b>
	     				</div>
	     				<div class="col-8" class="text-right">
	     					<input type="text" name="opName" id="opName" class="form-control"/>
	     				</div>
	     			</div>
	     			<div class="row">
	     				<div class="col-4">
	     					<b>옵션 가격 <span class="must">*</span></b>
	     				</div>
	     				<div class="col-8">
	     					<input type="number" name="opPrice" id="opPrice" class="form-control"/>
	     				</div>
	     			</div>
	     			<div class="row">
	     				<div class="col-4">
	     					<b>재고 수량 <span class="must">*</span></b>
	     				</div>
	     				<div class="col-8">
	     					<input type="number" name="opStock" id="opStock" class="form-control"/>
	     				</div>
	     			</div>
			      <hr/>
			     	<!-- 옵션추가 -->
		      	<div id="optionType"></div>
		      </div>
	      	
	        <div style="margin-top:20px" class="text-center">
	      	 <button type="button" onclick="colProdInsert()" class="btn2" style="background-color:#F5EBE0; font-size: 0.9em; border-color:#282828; color:black">등록</button>
	        </div>
		  	</form>
			  
			  <div class="row text-center">
					<div class="col-4"><img id="thumbnailDemo" width="300px"/></div>			  
					<div class="col-8"><img id="detailDemo" width="600px"/></div>			  
			  </div>
		  </div>
		  
		  
		</div>
	</div>
	
	
	<!-- 책 자료 검색 -->	
 	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="margin:10px 100px 10px 100px">
	          <form name="searchForm">
	          	<div class="input-group">
					      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요" />
					      <div class="input-group-append">
					     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#0cc621;"></i></a>
					     	</div>
				     	</div>
				    </form>
			    </div>
			    <div id="demo" style="display:none;">
			  	  <hr/>
			  	  <c:if test="${empty bookVOS}">
			  	  	<div class="container text-center"><br/>관련 도서가 없습니다 😲</div>
			  	  </c:if>
			  	  <c:if test="${!empty bookVOS}">
				  	  <c:forEach var="bookVO" items="${bookVOS}">
			  	  		<div class="row">
			  	  			<div class="col-3 text-center"><a href="${bookVO.url}" target="_blank"><img src="${bookVO.thumbnail}"/></a></div>
			  	  			<div class="col-7 text-center">
			  	  				<div class="row"><div class="col"><a href="${bookVO.url}" target="_blank"><b>${bookVO.title}</b></a></div></div>
			  	  				<div class="row"><div class="col">${bookVO.authors}&nbsp;&nbsp; | &nbsp;&nbsp;${bookVO.publisher}</div></div>
			  	  				<div class="row m-3"><div class="col">${bookVO.contents}...</div></div>
			  	  			</div>
			  	  			<div class="col-2 text-center">
			  	  				<button class="btn btn-outline-primary" onclick="bookSelection('${bookVO.idx}','${bookVO.title}')" data-dismiss="modal">선택</button>
			  	  			</div>
			  	  		</div>
								<hr/>				
				  	  </c:forEach>
			  	  </c:if>
					</div>
        </div>
        
      </div>
    </div>
  </div>


</body>
</html>