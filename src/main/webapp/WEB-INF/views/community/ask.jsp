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
		
		function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
  		location.href = "${ctp}/community/reflection?pag=${pageVO.pag}&pageSize="+pageSize+"&search=${search}&searchString=${searchString}";
    }
		
		// 문의 검색 + 분류 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let sort = $("#sort").val();
	    	
    	location.href = "${ctp}/community/ask?search="+search+"&searchString="+searchString+"&sort="+sort;
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
						<a class="btn btn-dark mb-4" href="${ctp}/community/ask" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
					  <a class="btn btn-warning" href="${ctp}/community/askInsert" style="margin-right:20px;">문의 남기기</a>
	 				</div>
	 			</div>
				<div style="text-align:center">
					<i class="fa-solid fa-clipboard-question" style="font-size:30px"></i>					
					<span class="text-center" style="font-size:30px; text-align:center; font-weight:500">문의</span>
				</div>
				<hr style="border:0px; height:5px; width:120px; background:#282828; margin:0px auto"/>
	 		</div>
	 		
	 		
			<form name="searchForm">
				<div class="row mb-5">
					<div class="col-7 text-left">
						<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
			        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
			        <option <c:if test="${sort == '답변완료'}">selected</c:if> value="답변완료">답변완료</option>
			        <option <c:if test="${sort == '답변전'}">selected</c:if> value="답변전">답변 전</option>
			        <option <c:if test="${sort == '공개'}">selected</c:if> value="공개">공개</option>
			        <option <c:if test="${sort == '비공개'}">selected</c:if> value="비공개">비공개</option>
			      </select>
					</div>
					<div class="col-5 text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'askTitle'}">selected</c:if> value="askTitle">제목</option>
				          <option <c:if test="${search == 'askContent'}">selected</c:if> value="askContent">내용</option>
				          <option <c:if test="${search == 'answer'}">selected</c:if> value="answer">답변 내용</option>
				        </select>
				    	</div>
				      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
				      <div class="input-group-append">
				     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="javascript:searchCheck()"><i class="fa-solid fa-magnifying-glass"></i></a>
				     	</div>
			     	</div>
					</div>
				</div>
	    </form>
			
			
			<table class="table text-center">
				<thead>
		      <tr class="text-center">
		        <th>No.</th>
		        <th>작성자</th>
		        <th>제목</th>
		        <th>답변 유무</th>
		        <th>작성일</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty vos}">
		    		<tr><td colspan="5" class="text-center" style="padding:30px"><b>작성 문의가 없습니다.</b></td></tr> 
		    		<tr><td colspan="5"></td></tr>
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
				    	<c:forEach var="vo" items="${vos}"> 
				    		<tr>
				    			<td>${curScrStartNo}</td>
				    			<td>
				    				<span style="color:grey; font-weight:bold">
					    				<c:if test="${empty vo.memNickname}">
						    				${vo.email}&nbsp;&nbsp;<span class="badge badge-pill badge-light">비회원</span>
					    				</c:if>
					    				<c:if test="${!empty vo.memNickname}">
						    				${vo.memNickname}
					    				</c:if>
				    				</span>
				    			</td>
				    			<td>
								  	<a href="javascript:askDetail('${vo.idx}')">
								  		${vo.askTitle}
								  		<c:if test="${vo.secret == '비공개'}">
								  			<i class="fa-solid fa-lock"></i>
								  		</c:if>
								  	</a>
				    			</td>
				    			<td class="text-center">
				    				<c:if test="${vo.answeredAsk == '답변완료'}">${vo.answeredAsk}&nbsp;&nbsp;${fn:substring(vo.answerDate,0,10)}</c:if>	
				    				<c:if test="${vo.answeredAsk == '답변전'}">답변 전</c:if>
			    				</td>
			    				<td class="text-center">
			    					${fn:substring(vo.askDate,0,10)}
			    				</td>
				    		</tr>
				    		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
						</c:forEach>
			    	<tr><td colspan="5"></td></tr> 
		    	</c:if>
		    </tbody>
		  </table>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/ask?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}&sort=${sort}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/ask?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&sort=${sort}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/community/ask?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&sort=${sort}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/ask?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&sort=${sort}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/ask?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&sort=${sort}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/ask?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}&sort=${sort}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		</div>
		  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>