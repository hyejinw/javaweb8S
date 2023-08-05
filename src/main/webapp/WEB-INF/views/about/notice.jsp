<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<style>
		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
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
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 200px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
    }
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
    
    .pill-nav a {
		  display: inline-block;
		  color: black;
		  text-align: center;
		  padding: 8px 20px;
		  text-decoration: none;
		  font-size: 17px;
		  border-radius: 5px;
		}
		.pill-nav a:hover {
		  background-color: #ddd;
		  color: black;
		}
		.pill-nav a.active {
		  background-color: #F5EBE0;
		  color: #282828;
		}
		.nowPart {
     color : #282828;
     font-weight: bold;
     border-bottom: 5px solid #282828;
     padding-bottom:14px;
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
		
		// 공지사항 검색 + 분류 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let sort = $("#sort").val();
	    	
    	location.href = "${ctp}/about/ask?search="+search+"&searchString="+searchString+"&sort="+sort;
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
		
			<div class="text-center mb-4">
				<span class="text-center" style="margin:0px auto; font-size:30px; font-weight:bold; padding-bottom:20px">공지사항</span>
			</div>
	 		
			<form name="searchForm">
				<div class="row mb-5">
					<div class="col-7 text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/about/notice" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
					</div>
					<div class="col-5 text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'noticeTitle'}">selected</c:if> value="noticeTitle">제목</option>
				          <option <c:if test="${search == 'noticeContent'}">selected</c:if> value="noticeContent">내용</option>
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
		        <th>공지 종류</th>
		        <th colspan="2">제목</th>
		        <th>조회수</th>
		        <th>등록일</th>
		      </tr>
		    </thead>
		    <tbody>
					<c:if test="${empty vos}">
		    		<tr><td colspan="6" class="text-center" style="padding:30px"><b>공지사항이 없습니다.</b></td></tr> 
		    		<tr><td colspan="6"></td></tr>
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
				    	<c:forEach var="vo" items="${vos}"> 
				    		<tr <c:if test="${vo.important == 1}">style="background-color: #EEE;"</c:if>>
				    			<td>${curScrStartNo}</td>
				    			<td>${vo.category}</td>
				    			<td colspan="2">
				    				<a href="${ctp}/about/noticeDetail?idx=${vo.idx}">
					    				<c:if test="${vo.important == 1}">
						    				<b>${vo.noticeTitle}</b>
					    				</c:if>
					    				<c:if test="${vo.important != 1}">
						    				${vo.noticeTitle}
					    				</c:if>
				    				</a>
			    				</td>
				    			<td>${vo.noticeView}</td>
				    			<td>${fn:substring(vo.noticeDate,0,10)}</td>
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
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/about/notice?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/about/notice?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/about/notice?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/about/notice?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/about/notice?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/about/notice?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		</div>
	</div>
	
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>