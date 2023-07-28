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
    	location.href = "${ctp}/admin/manage/askList?pag=${pageVO.pag}&pageSize="+pageSize+"&sort=${sort}&search=${search}&searchString=${searchString}";
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
    	location.href = "${ctp}/admin/manage/askList?search="+search+"&searchString="+searchString+"&sort="+sort;
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
		
		// 문의 상세창에서 돌아왔다면, 해당 session을 없애준다.
		$(document).ready(function(){
			if(localStorage.getItem('adminAskSW') == 'ON') {
				localStorage.removeItem('adminAskSW');
			}
		});
		
		// 문의 상세창
		function move(idx, category) {
			localStorage.setItem('adminAskSW', 'ON');
			
			if(category != "커뮤니티") location.href = "${ctp}/about/askDetail?idx="+idx;
			else location.href = "${ctp}/community/askDetail?idx="+idx;
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
						<a class="btn btn-dark mb-4" href="${ctp}/admin/manage/askList" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">문의 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;답변 수정은 지양해주시길 바랍니다.
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;답변 등록 후, 작성자에게 답변 등록 이메일이 전송됩니다. 작성 후, 화면 전환까지 잠시 기다려주시길 바랍니다.
				  </span>
			  </div>
	 		</div>
			<div class="row" style="margin-top:50px">
				<div class="col-7 text-left">
					<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
		        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
		        <option <c:if test="${sort == '커뮤니티'}">selected</c:if> value="커뮤니티">커뮤니티</option>
		        <option <c:if test="${sort == '컬렉션상품'}">selected</c:if> value="컬렉션상품">컬렉션상품</option>
		        <option <c:if test="${sort == '매거진'}">selected</c:if> value="매거진">매거진</option>
		        <option <c:if test="${sort == '정기구독'}">selected</c:if> value="정기구독">정기구독</option>
		        <option <c:if test="${sort == '뉴스레터'}">selected</c:if> value="뉴스레터">뉴스레터</option>
		        <option <c:if test="${sort == '포인트'}">selected</c:if> value="포인트">포인트</option>
		        <option <c:if test="${sort == '게임'}">selected</c:if> value="게임">게임</option>
		        <option <c:if test="${sort == '기타'}">selected</c:if> value="기타">기타</option>
		      </select>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
								<select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'askTitle'}">selected</c:if> value="askTitle">제목</option>
				          <option <c:if test="${search == 'memNickname'}">selected</c:if> value="memNickname">작성자(회원)</option>
				          <option <c:if test="${search == 'email'}">selected</c:if> value="email">작성자(비회원)</option>
				          <option <c:if test="${search == 'askContent'}">selected</c:if> value="askContent">내용</option>
				          <option <c:if test="${search == 'answer'}">selected</c:if> value="answer">답변 내용</option>
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
			        <th>문의 종류</th>
			        <th>작성자</th>
			        <th>제목</th>
			        <th>답변 유무</th>
			        <th>작성일</th>
			      </tr>
			    </thead>
			    <tbody>
						<c:if test="${empty vos}">
			    		<tr><td colspan="6" class="text-center" style="padding:30px"><b>작성 문의가 없습니다.</b></td></tr> 
			    		<tr><td colspan="6"></td></tr>
			    	</c:if>
			    	
			    	<c:if test="${!empty vos}">
				    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
					    	<c:forEach var="vo" items="${vos}"> 
					    		<tr>
					    			<td>${curScrStartNo}</td>
					    			<td>
					    				<c:if test="${vo.category == '커뮤니티'}"><b>${vo.category}</b></c:if>
					    				<c:if test="${vo.category != '커뮤니티'}">${vo.category}</c:if>
				    				</td>
					    			<td>
					    				<span style="color:grey; font-weight:bold">
						    				<c:if test="${empty vo.memNickname}">
							    				${vo.email}&nbsp;&nbsp;<span class="badge badge-pill badge-light">비회원</span>
						    				</c:if>
						    				<c:if test="${!empty vo.memNickname}">
							    				${vo.memNickname}&nbsp;
							    				<button id="memInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="memInfo('${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:15px; color:#557A46"></i></button>
						    				</c:if>
					    				</span>
					    			</td>
					    			<td>
					    				<a href="javascript:move('${vo.idx}', '${vo.category}')">
									  		${vo.askTitle}
									  		<c:if test="${vo.secret == '비공개'}">
									  			<i class="fa-solid fa-lock"></i>
									  		</c:if>
									  	</a>
					    			</td>
					    			<td class="text-center">
					    				<c:if test="${vo.answeredAsk == '답변완료'}">${vo.answeredAsk}&nbsp;&nbsp;<span style="font-size:10px">${fn:substring(vo.answerDate,0,10)}</span></c:if>	
					    				<c:if test="${vo.answeredAsk == '답변전'}">답변 전</c:if>
				    				</td>
				    				<td class="text-center">
				    					${fn:substring(vo.askDate,0,10)}
				    				</td>
					    		</tr>
					    		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
							</c:forEach>
				    	<tr><td colspan="6"></td></tr> 
			    	</c:if>
			    </tbody>
			  </table>
		  </div>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/askList?pageSize=${pageVO.pageSize}&pag=1&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/askList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/manage/askList?pageSize=${pageVO.pageSize}&pag=${i}&sort=${sort}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/askList?pageSize=${pageVO.pageSize}&pag=${i}&sort=${sort}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/askList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/manage/askList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&sort=${sort}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>


</body>
</html>