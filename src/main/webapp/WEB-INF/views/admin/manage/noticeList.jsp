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
	  a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
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
    	location.href = "${ctp}/admin/manage/noticeList?pag=${pageVO.pag}&pageSize="+pageSize+"&search=${search}&searchString=${searchString}";
    }
		
		// 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
	    	
    	if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm.search.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/manage/noticeList?search="+search+"&searchString="+searchString;
		}
		
		// 공지사항 삭제
		function noticeDelete(idx) {
			if(confirm('삭제 후 되돌릴 수 없습니다. 정말 삭제하시겠습니까?')) {
				$.ajax({
					type : "post",
					url : "${ctp}/admin/manage/noticeDelete",
					data : { idx : idx },
					success : function() {
						alert('공지사항이 삭제되었습니다.');
						location.reload();
					},
					error : function() {
						alert('전송 오류가 발생했습니다. 재시도 부탁드립니다.');
					}
				});
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
						<a class="btn btn-dark mb-4" href="${ctp}/admin/manage/noticeList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
						<button class="btn btn-outline-primary" onclick="location.href='${ctp}/admin/manage/noticeInsert';">공지사항 등록</button>
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">공지사항 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;공지사항 수정은 지양해주세요.
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;상단 고정 시, 홈화면 상단(최신 3건)과 공지사항 상단에 노출됩니다.
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;<span class="badge badge-pill badge-success">고정</span> 공지사항이 3개 미만일 경우, 일반 공지를 포함해 최대 3건이 홈화면 상단에 노출됩니다.
				  </span>
			  </div>
	 		</div>
			<div class="row" style="margin-top:50px">
				<div class="col-7 text-left">
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
								<select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'noticeTitle'}">selected</c:if> value="noticeTitle">제목</option>
				          <option <c:if test="${search == 'noticeContent'}">selected</c:if> value="noticeContent">내용</option>
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
		    </tr>
		  </table>
		  
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead class="thead-dark">
			      <tr class="text-center">
			        <th>No.</th>
			        <th>공지 종류</th>
			        <th>제목</th>
			        <th>조회수</th>
			        <th>공개 유무</th>
			        <th>등록일</th>
			        <th>선택</th>
			      </tr>
			    </thead>
			    <tbody>
						<c:if test="${empty vos}">
			    		<tr><td colspan="7" class="text-center" style="padding:30px"><b>공지사항이 없습니다.</b></td></tr> 
			    		<tr><td colspan="7"></td></tr>
			    	</c:if>
			    	
			    	<c:if test="${!empty vos}">
				    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
					    	<c:forEach var="vo" items="${vos}"> 
					    		<tr>
					    			<td>${curScrStartNo}</td>
					    			<td>${vo.category}</td>
					    			<td>
					    				<a href="${ctp}/about/noticeDetail?idx=${vo.idx}">
						    				<c:if test="${vo.important == 1}">
							    				${vo.noticeTitle}&nbsp;&nbsp;<span class="badge badge-pill badge-success">고정</span>
						    				</c:if>
						    				<c:if test="${vo.important != 1}">
							    				${vo.noticeTitle}
						    				</c:if>
					    				</a>
				    				</td>
					    			<td>${vo.noticeView}</td>
					    			<td>${vo.noticeOpen}</td>
					    			<td>${fn:substring(vo.noticeDate,0,10)}</td>
					    			<td>
											<button class="btn btn-sm btn-secondary" onclick="location.href='${ctp}/admin/manage/noticeUpdate?idx=${vo.idx}';">수정</button>
											<button class="btn btn-sm btn-outline-dark" onclick="noticeDelete(${vo.idx})">삭제</button>
										</td>
					    		</tr>
					    		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
							</c:forEach>
				    	<tr><td colspan="7"></td></tr> 
			    	</c:if>
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/noticeList?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/noticeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/manage/noticeList?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/noticeList?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/noticeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/noticeList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>


</body>
</html>