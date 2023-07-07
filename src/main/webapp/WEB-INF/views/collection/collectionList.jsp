<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		
		.collectionHover:hover { 
	    text-decoration: none;
	  	color: #ffa0c5;
		}
		
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
		
		/* img {
		  vertical-align: top;
		} */
		.banner_img {
		  display:inline-block;
		  position: relative;
		}
		.banner_img:hover:after,
		.banner_img:hover > .hover_text {
		  display:block;
		}
		.banner_img:after, .hover_text {
		  display:none;
		}
		.banner_img:after {
		  content:'';
 		  position: absolute;
		  top: 0;
		  right: 0;
		  bottom: 0;
		  left: 0;
		  background: rgba(0, 0, 0, 0.7);
		  z-index: 10;
		}
		.banner_img {
		  overflow: hidden;
		}
	/* 	.banner_img img{
		  height: 340px;
		} */
		.banner_img:hover img{
		  transform: scale(1.2);
		  transition: 1.5s;
		}
		.hover_text {
			padding: 30px;
		  position: absolute;
		  top: 150px;
		  left: 0px;
		  color: #fff;
		  z-index: 20;
		  font-weight: 600;
		  font-size: 20px;
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
		
		function sortCheck() {
    	let sort = document.getElementById("sort").value;
    	if(sort == '컬렉션') {
	    	location.href = "${ctp}/collection/collectionList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&search=${search}&sort="+sort;
    	}
    	else {
	    	location.href = "${ctp}/collection/colProductList?search=${search}&colIdx=0&sort="+sort;
    	}
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 100px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding-bottom:20px">컬렉션</h2>
			<div class="text-center">
				<span style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책 세계 함께 다다르기(differeach)&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span class="w3-text w3-tag"  style="margin:0px auto; font-size:14px; font-style:italic;"><b>우리는 다 다르고, 그래서 서로에게 다다를 수 있어요.</b></span>
				</span>
<!-- 				<span class="w3-tooltip" style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책 세계 쉽게 다다르기(differeach)&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span class="w3-text w3-tag"  style="margin:0px auto; font-size:14px; font-style:italic;"><b>우리는 다 다르고, 서로에게 다다를 수 있어요.</b></span>
				</span> -->
			</div>
		
		
			<div class="row" style="margin:50px 0px 10px 0px">
				<div class="col text-left" style="padding:0px">
					총 ${pageVO.totRecCnt}개의 상품이 존재합니다.
				</div>
			</div>
			<div class="row" style="margin-bottom:50px">
				<div class="col-2 text-left">
					<select class="form-control" id="sort" onchange="sortCheck()">
						<option <c:if test="${sort == '컬렉션'}">selected</c:if>>컬렉션</option>
						<option <c:if test="${sort == '상품'}">selected</c:if>>상품</option>
					</select>
				</div>
				<div class="col-10 text-right">
					<div class="pill-nav" style="margin-left:100px">
					  <a class="<c:if test="${search=='최신순'}">active</c:if> mr-2" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=1&search=최신순">최신순</a>
					  <a class="<c:if test="${search=='상품명'}">active</c:if> mr-2" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=1&search=상품명">상품명</a>
					  <a class="<c:if test="${search=='낮은 가격순'}">active</c:if> mr-2" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=1&search=낮은 가격순">낮은 가격순</a>
					  <a class="<c:if test="${search=='높은 가격순'}">active</c:if>" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=1&search=높은 가격순">높은 가격순</a>
					</div>
				</div>
			</div>
			
			<!-- 컬렉션 리스트 : 2개씩 끊어서 뿌려야 한다.-->
			<div class="row" style="margin-bottom:100px">
			<c:set var="cnt" 	value="${0}"/>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<div class="col" <c:if test="${cnt % 2 != 0}">style="margin-left:80px"</c:if>>
					<a href="${ctp}/collection/colProductList?idx=${vo.idx}" class="banner_img">
						<img src="${ctp}/collection/${vo.colThumbnail}" style="width:100%; max-width:1000px; margin-bottom:10px"/>
						<div class="text-center hover_text">${fn:replace(vo.colDetail, "<br/>", newLine)}</div>
					</a>
					<a href="${ctp}/collection/colProductList?colIdx=${vo.idx}" class="collectionHover">
						<div class="text-center">
							<span style="font-size:20px; font-weight:bold">${vo.colName}</span>
							<span style="font-size:17px;"><br/>${fn:substring(vo.colDate,0,10)}</span>
							<br/><span class="badge badge-pill badge-dark" style="font-size:18px; margin-top:10px; width:60px"><i class="fa-solid fa-gift"></i>&nbsp;&nbsp;&nbsp;${vo.colProdNum}</span>
						</div>
					</a>
				</div>
				<c:set var="cnt" value="${cnt + 1}"/>
				<c:if test="${cnt % 2 == 0}">
					</div>
					<div class="row" style="margin-bottom:100px">
				</c:if>
			</c:forEach>
			<c:if test="${cnt % 2 != 0}">
				<div class="col" style="margin-right:80px"></div>
			</c:if>
			</div>
			
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center" style="margin-top:-70px">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=1&search=${search}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/collection/collectionList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
			
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>