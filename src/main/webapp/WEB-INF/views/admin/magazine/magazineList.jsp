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
    	location.href = "${ctp}/admin/magazine/magazineList?pag=${pageVO.pag}&pageSize="+pageSize;
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
		 
		  if(confirm("선택한 매거진을 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/magazine/magazineDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 매거진이 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 매거진 검색(날짜 기간으로도 가능)
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let startDate = $("#startDate").val();
			let endDate = $("#endDate").val();
	    	
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
    		alert("발행일은 오늘보다 빠를 수 없습니다.");
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
    	location.href = "${ctp}/admin/magazine/magazineListSearch?search="+search+"&searchString="+searchString+"&startDate="+startDate+"&endDate="+endDate;
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
		
		// 매거진 문의창으로 이동
		function move() {
			if(confirm('매거진 문의창으로 이동하시겠습니까?')) {
				location.href = '${ctp}/admin/manage/askList?sort=매거진';
			}
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
						<a class="btn btn-dark mb-4" href="${ctp}/admin/magazine/magazineList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
					  <a class="btn btn-warning" href="${ctp}/admin/magazine/magazineInsert" style="margin-right:20px;">매거진 등록</a>
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">매거진 정보 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	<br/>판매 수량 / 저장 등록 수 클릭 시, 상세 정보 확인 가능합니다.
				  </span>
			  </div>
	 		</div>
			<div class="row">
				<div class="col-7 text-left">
					<a class="btn btn-dark mb-4" href="javascript:deleteAction()" style="margin-right:20px;">선택 삭제</a>
					<a class="btn btn-info mb-4" href="${ctp}/admin/magazine/magazineListSearch?maType=정기 구독" style="margin-right:20px;">정기구독 상품만</a>
					<a class="btn btn-secondary mb-4" href="javascript:move()" style="margin-right:100px;">매거진 문의</a>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
						<div class="row mb-3">
							<div class="col">
				    		<input type="date" class="mr-2" name="startDate" id="startDate"/>
				    		<input type="date" class="mr-2" name="endDate" id="endDate"/>
							
							</div>
						</div>
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'maTitle'}">selected</c:if> value="maTitle">제목</option>
				          <option <c:if test="${search == 'maCode'}">selected</c:if> value="maCode">상품 코드</option>
				        </select>
				    	</div>
				      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
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
		          <a href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead class="thead-dark">
			      <tr>
			        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
			        <th>상품 코드</th>
			        <th>제목</th>
			        <th>가격</th>
			        <th>발행일</th>
			        <th>재고 수량</th>
			        <th>판매 수량</th>
			        <th>저장 등록 수</th>
			        <th>공개 유무</th>
			        <th>비고</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
	 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
				      <tr>
				        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
				        <td>${vo.maCode}</td>
				        <td><a href="${ctp}/magazine/maProduct?idx=${vo.idx}">${vo.maTitle}</a></td>
				        <td>${vo.maPrice}</td>
				        <td>${fn:substring(vo.maDate,0,10)}</td>
				        <td>${vo.maStock}</td>
				        <td>${vo.maSaleQuantity}</td>
				        <td>${vo.maSave}</td>
								<td>
				        	<div class="wrapper">
									  <input type="checkbox" class="switch" id="switch${vo.idx}" onchange="javascript:openChange('${vo.idx}', '${vo.maOpen}');" <c:if test="${vo.maOpen=='공개'}">checked</c:if>>
									  <label for="switch${vo.idx}" class="switch_label">
									    <span class="onf_btn"></span>
									  </label>
									</div>
				        </td>
				        <td>
				        	<button class="btn btn-warning btn-sm" id="update${vo.idx}" onclick="location.href='${ctp}/admin/magazine/magazineUpdate?idx=${vo.idx}';">수정</button>
				        </td>
				      </tr>
				    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			    	</c:forEach>
			    	<tr><td colspan="9"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/magazine/magazineList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>
	


</body>
</html>