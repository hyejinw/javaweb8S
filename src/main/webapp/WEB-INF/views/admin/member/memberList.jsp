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
    	location.href = "${ctp}/admin/member/memberList?pag=${pageVO.pag}&pageSize="+pageSize+"&sort=${sort}&search=${search}&searchString=${searchString}";
    }
		
		// 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let sort = $("#sort").val();
	    	
    	if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm.search.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/member/memberList?search="+search+"&searchString="+searchString+"&sort="+sort;
		}
		
		// 회원정보 상세창
		function memInfo(nickname) {
			let url = "${ctp}/admin/member/memInfo?nickname="+nickname;

			let popupWidth = 1000;
			let popupHeight = 800;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'memInfo', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
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
						<a class="btn btn-dark mb-4" href="${ctp}/admin/member/memberList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">회원 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	<br/>탈퇴 1개월 후, 자동 삭제 처리됩니다.
					 	<br/>상세 정보창을 통해 회원 관련 정보를 확인할 수 있습니다.
				  </span>
			  </div>
	 		</div>
			<div class="row" style="margin-top:50px">
				<div class="col-7 text-left">
					<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
		        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
		        <option <c:if test="${sort == '미탈퇴'}">selected</c:if> value="미탈퇴">활동</option>
		        <option <c:if test="${sort == '탈퇴'}">selected</c:if> value="탈퇴">탈퇴</option>
		      </select>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'nickname'}">selected</c:if> value="nickname">별명</option>
				          <option <c:if test="${search == 'mid'}">selected</c:if> value="mid">아이디</option>
				          <option <c:if test="${search == 'email'}">selected</c:if> value="email">이메일</option>
				          <option <c:if test="${search == 'tel'}">selected</c:if> value="tel">전화번호</option>
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
			      <tr>
			        <th>No.</th>
			        <th>아이디</th>
			        <th>별명</th>
			        <th>성명</th>
			        <th>이메일</th>
			        <th>전화번호</th>
			        <th>총 방문 수</th>
			        <th>가입일</th>
			        <th>마지막 방문일</th>
			        <th>탈퇴 신청 유무</th>
			        <th>상세</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${empty vos}">
			    		<tr><td colspan="11" style="padding:30px"><b>해당 회원이 없습니다.</b></td></tr> 
			    	</c:if>
			    	<c:if test="${!empty vos}">
				    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
		 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
					      <tr>
					        <td>${curScrStartNo}</td>
					        <td>${vo.mid}</td>
					        <td>${vo.nickname}</td>
					        <td>${vo.name}</td>
					        <td>${vo.email}</td>
					        <td>${vo.tel}</td>
					        <td>${vo.totCnt}</td>
					        <td>${fn:substring(vo.firstVisit,0,10)}</td>
					        <td>${fn:substring(vo.lastVisit,0,10)}</td>
					        <td>
					        	<c:if test="${vo.memberDel == '탈퇴'}">
						       	 	<span style="color:red">${vo.memberDel}</span>
					       	 	</c:if>
					        	<c:if test="${vo.memberDel != '탈퇴'}">
						       	 	${vo.memberDel}
					       	 	</c:if>
					        </td>
					        <td>
					        	<button id="memInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="memInfo('${vo.nickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:22px"></i></button>
					        </td>
					      </tr>
					    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				    	</c:forEach>
			    	</c:if>
			    	<tr><td colspan="11"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pageSize=${pageVO.pageSize}&pag=1&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/member/memberList?pageSize=${pageVO.pageSize}&pag=${i}&sort=${sort}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pageSize=${pageVO.pageSize}&pag=${i}&sort=${sort}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>
	


</body>
</html>