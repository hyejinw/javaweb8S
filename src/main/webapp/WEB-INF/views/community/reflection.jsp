<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>책(의)세계</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
		/* .table a {
			text-decoration : none;
		} */
		
		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
		.table a:hover {color:#41644A !important;}
		
  	.w3-row-padding img {margin-bottom: 12px}
		/* Set the width of the sidebar to 120px */
		.w3-sidebar {width: 120px;background: #222;}
		/* Add a left margin to the "page content" that matches the width of the sidebar (120px) */
		#main {margin-left: 120px}
		/* Remove margins from "page content" on small screens */
		@media only screen and (max-width: 600px) {#main {margin-left: 0}}
		
		
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
		
		// 기록 남기기
		function insert() {
			
			if('${sNickname}' == "") {
				alert('로그인 후 이용해주세요.');
				return false;
			}
			 
			let url = "${ctp}/community/reflectionInsert";

			let popupWidth = 1200;
			let popupHeight = 800;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
			
		
		function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
  		location.href = "${ctp}/community/reflection?pag=${pageVO.pag}&pageSize="+pageSize+"&search=${search}&searchString=${searchString}";
    }
		
		// 기록 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();

			if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm.search.focus();
    		return false;
    	}
			// 검색어가 없다면 전체 리스트를 보여준다.
    	location.href = "${ctp}/community/reflection?search="+search+"&searchString="+searchString;
		}
  </script>
</head>
<body>
<div id="back-to-top"></div>
<jsp:include page="/WEB-INF/views/community/communityMenu.jsp" />
	
	<!-- Page Content -->
	<div id="main">
		<a href="${ctp}/community/communityMain">
			<img src = "${ctp}/images/communityBanner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		
	  <div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/community/reflection" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
					  <a class="btn btn-warning" href="javascript:insert()" style="margin-right:20px;">기록 남기기</a>
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">기록</span></div>
	 		</div>
			<div class="row">
				<div class="col-7 text-left">
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'title'}">selected</c:if> value="title">제목</option>
				          <option <c:if test="${search == 'memNickname'}">selected</c:if> value="memNickname">작성자</option>
				          <option <c:if test="${search == 'content'}">selected</c:if> value="content">내용</option>
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
		          <a href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
			<table class="table">
				<thead class="thead-dark text-center">
		      <tr>
		        <th>번호</th>
		        <th colspan="3">제목</th>
		        <th>비고</th>
		        <th>작성자</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty vos}">
		    		<tr><td colspan="6" class="text-center" style="padding:30px"><b>찾는 기록이 없습니다.</b></td></tr> 
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
			    	<c:forEach var="vo" items="${vos}" varStatus="st">
				      <tr <c:if test="${vo.memNickname == sNickname}">style="background-color:#F5F5F5"</c:if>>
				      	<td class="text-center">${curScrStartNo}</td>
				      	<td class="text-center"><!-- 책 상세 페이지 -->
				        	<c:if test="${!empty vo.thumbnail}"><img src="${vo.thumbnail}" style="width:50px"/></c:if>
			        	</td>
				        <td colspan="2">
		        			<div class="col-6" style="font-size:18px; font-weight:bold;">
				        		<a href="${ctp}/community/reflectionDetail?idx=${vo.idx}&bookIdx=${vo.bookIdx}">${vo.title}</a><!-- 상세페이지 -->
									</div>
								</td>
								<td class="text-center"> 
			        		<a href="${ctp}/community/reflectionDetail?idx=${vo.idx}">
				        		${fn:substring(vo.refDate,0,10)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				        		<i class="fa-solid fa-eye"></i>&nbsp;&nbsp;${vo.refView}&nbsp;&nbsp;&nbsp;&nbsp;
				        		<i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;${vo.replyNum}
				        		<c:if test="${(vo.memNickname == sNickname) || (sMemType == '관리자')}">
				        			&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-bookmark save"></i>&nbsp;&nbsp;${vo.refSave}
				        		</c:if>	
			        		</a><!-- 상세페이지 -->
								</td>		
								<td class="text-center">
			        		<a href="${ctp}/community/memPage?nickname=${vo.memNickname}">  <!-- 회원 페이지 -->
				        		<img src="${ctp}/admin/member/${vo.memPhoto}" class="rounded-circle" style="width:35px"/>&nbsp;&nbsp;&nbsp;
				        		${vo.memNickname}
			        		</a>
								</td>	        	
				      </tr>
				    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			    	</c:forEach>
			    	<tr><td colspan="6"></td></tr> 
		    	</c:if>
		    </tbody>
		  </table>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/reflection?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>