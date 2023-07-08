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
	</style>
	<script>
		'use strict';

		function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/admin/collection/colProdList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function() {
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 상품을 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/collection/colProdDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 상품이 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 상품 검색(날짜 기간으로도 가능)
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let startDate = $("#startDate").val();
			let endDate = $("#endDate").val();
			let sort = $("#sort").val();
	    	
    	if((startDate.trim() != "" && endDate.trim() == "") || (startDate.trim() == "" && endDate.trim() != "") || (startDate.trim() > endDate.trim())) {
    		alert("시작날짜와 종료날짜를 알맞게 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	// 오늘 날짜
    	let today = new Date();

    	let year = today.getFullYear();
    	let month = ('0' + (today.getMonth() + 1)).slice(-2);
    	let day = ('0' + today.getDate()).slice(-2);
    	let todayString = year + '-' + month  + '-' + day;
    	
    	if(endDate.trim() > todayString) {
    		alert("등록일은 오늘보다 빠를 수 없습니다.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm.search.focus();
    		return false;
    	}
    	if(search.trim() != "" && searchString.trim() == "" && startDate.trim() == "" && endDate.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/collection/colProdListSearch?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
		}
		
		// 분류 검색
		function sortCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let startDate = $("#startDate").val();
			let endDate = $("#endDate").val();
			let sort = $("#sort").val();
	    	
    	if((startDate.trim() != "" && endDate.trim() == "") || (startDate.trim() == "" && endDate.trim() != "") || (startDate.trim() > endDate.trim())) {
    		alert("시작날짜와 종료날짜를 알맞게 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	// 오늘 날짜
    	let today = new Date();

    	let year = today.getFullYear();
    	let month = ('0' + (today.getMonth() + 1)).slice(-2);
    	let day = ('0' + today.getDate()).slice(-2);
    	let todayString = year + '-' + month  + '-' + day;
    	
    	if(endDate.trim() > todayString) {
    		alert("등록일은 오늘보다 빠를 수 없습니다.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/collection/colProdListSearch?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate+"&sort="+sort;
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
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/admin/collection/colProdList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
					  <a class="btn btn-warning" href="${ctp}/admin/collection/colProdInsert" style="margin-right:20px;">상품 등록</a>
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">컬렉션 상품 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	<br/>판매 수량 / 저장 등록 수 클릭 시, 상세 정보 확인 가능합니다.
				  </span>
			  </div>
	 		</div>
			<div class="row">
				<div class="col-7 text-left">
					<!-- 여기 해야 한다!!!!!!!!!!!!!!!!! -->
					<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="sortCheck()">
		        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
		        <option <c:if test="${sort == '판매'}">selected</c:if> value="판매">판매</option>
		        <option <c:if test="${sort == '품절'}">selected</c:if> value="품절">품절</option>
		        <option <c:if test="${sort == '공개'}">selected</c:if> value="공개">공개</option>
		        <option <c:if test="${sort == '비공개'}">selected</c:if> value="비공개">비공개</option>
		      </select>
					<a class="btn btn-dark mr-3 mb-4" href="javascript:deleteAction()">선택 삭제</a>
					<a class="btn btn-secondary mr-3 mb-4" href="${ctp}/">상품 문의</a>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
						<div class="row mb-3">
							<div class="col">
								<div class="row">
									<div class="col"></div>
					        <div class="col">
						    		<input type="date" class="mr-2 form-control" name="startDate" id="startDate"/>
					        </div>
					        <div class="col">
						    		<input type="date" class="mr-2 form-control" name="endDate" id="endDate"/>
					        </div>
								</div>
							</div>
						</div>
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'prodName'}">selected</c:if> value="prodName">상품명</option>
				          <option <c:if test="${search == 'prodCode'}">selected</c:if> value="prodCode">상품 코드</option>
				          <option <c:if test="${search == 'colName'}">selected</c:if> value="colName">컬렉션</option>
				        </select>
				    	</div>
				      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요"/>
				      <div class="input-group-append">
				     		<a href="#" class="btn btn-success my-2 my-sm-0" onclick="javascript:searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#282828;"></i></a>
				     	</div>
			     	</div>
			    </form>
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
		          <a href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead class="thead-dark">
			      <tr>
			        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
			        <th>컬렉션</th>
			        <th>상품 코드</th>
			        <th>상품명</th>
			        <th>가격</th>
			        <th>등록일</th>
			        <th>판매 수량</th>
			        <th>저장 등록 수</th>
			        <th>공개 유무</th>
			        <th>조회</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
	 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
				      <tr>
				        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
				        <td>${vo.colName}</td>
				        <td>${vo.prodCode}</td>
				        <td>
				        	${vo.prodName}
				        	<c:if test="${vo.prodStatus == '품절'}"><span class="badge badge-pill badge-dark">품절</span></c:if>
			        	</td>
				        <td>${vo.prodPrice}</td>
				        <td>${fn:substring(vo.prodDate,0,10)}</td>
				        <td>${vo.prodSaleQuantity}</td>
				        <td>${vo.prodSave}</td>
								<td>
				        	<div class="wrapper">
									  <input type="checkbox" class="switch" id="switch${vo.idx}" onchange="javascript:openChange('${vo.idx}', '${vo.prodOpen}');" <c:if test="${vo.prodOpen=='공개'}">checked</c:if>>
									  <label for="switch${vo.idx}" class="switch_label">
									    <span class="onf_btn"></span>
									  </label>
									</div>
				        </td>
				        <td>
				        	<button id="update${vo.idx}" style="border:0px; background-color:transparent;" onclick="location.href='${ctp}/admin/collection/colProdInfo?idx=${vo.idx}';"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:22px"></i></button>
				        </td>
				      </tr>
				    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			    	</c:forEach>
			    	<tr><td colspan="10"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/collection/colProdList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>
	


</body>
</html>