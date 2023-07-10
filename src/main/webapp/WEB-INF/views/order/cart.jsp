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
		
		.magazineHover:hover { 
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
		#infoBox {
    	border: 2px solid white;
    	border-radius: 20px;
    	width: 100%;
    	max-width: 600px;
    	height: 100%;
    	max-height: 200px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
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
		
		function maDateCheck() {
    	let maDate = document.getElementById("maDate").value;
    	location.href = "${ctp}/magazine/magazineList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&search=${search}&maDate="+maDate;
    }
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 100px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding-bottom:20px">장바구니</h2>
			<div class="text-center">
				<span style="margin:0px auto; font-size:18px; font-style:italic;"><i class="fa-solid fa-quote-left"></i>&nbsp;&nbsp;&nbsp;책 세계 함께 다다르기(differeach)&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-quote-right"></i><br/>
					<span class="w3-text w3-tag"  style="margin:0px auto; font-size:14px; font-style:italic;"><b>우리는 다 다르고, 그래서 서로에게 다다를 수 있어요.</b></span>
				</span>
			</div>
		
			<div class="row" style="margin:10px 0px 50px 0px">
				<div class="col">
					<div id="infoBox">
						정보&nbsp;&nbsp;&nbsp;&nbsp;<span>보유 포인트</span><span>${memberVO.point}</span>
						책의 세계는 모두 무료배송<hr/>
						구매 완료 시, 포인트 5%가 적립됩니다.
					</div>
				</div>
			</div>
			
			<c:if test="${(empty productVOS) && (empty magazineVOS) && (empty subscribeVOS)}">
				<div class="row" style="margin-bottom:100px">
					<div class="col">
						<div>장바구니를 채워주세요</div>
					</div>
				</div>
			</c:if>
			
			<!-- 상품 장바구니 -->
			<c:if test="${(!empty productVOS)}">
				<div class="table-responsive">
					<table class="table text-center">
				    <thead class="thead-dark">
				      <tr>
				        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
				        <th>이미지</th>
				        <th>상품정보</th>
				        <th>판매가</th>
				        <th>수량</th>
				        <th>합계</th>
				        <th>선택</th>
				      </tr>
				    </thead>
				    <tbody>
		 		    	<c:forEach var="productVO" items="${productVOS}" varStatus="st">
					      <tr>
					        <td><label for="chk${productVO.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
					        <td>
					        
					        
					        
					        <!-- 여기부터 하면 됩니다!!!!!!!!!!!!!1 -->



					        	<a href="#" id="bookDetail" data-toggle="modal" data-target="#bookModal" 
					        		onclick="javascript:bookDetail('${vo.idx}','${vo.title}','${fn:replace(vo.contents,'\'', '\\\'')}','${vo.url}','${vo.isbn}','${vo.datetime}','${vo.authors}','${vo.publisher}','${vo.translators}','${vo.price}','${vo.sale_price}','${vo.thumbnail}','${vo.status}','${vo.bookRate}','${vo.save}','${vo.bookUpdate}')">
					        	${vo.title}</a>
					        </td>
					        <td>${fn:substring(vo.datetime,0,9)}</td>
					        <td>${vo.authors}</td>
					        <td>${vo.bookRate}</td>
					        <td>${vo.save}</td>
					        <td>${fn:substring(vo.bookUpdate,0,19)}</td>
					      </tr>
				    	</c:forEach>
				    	<tr><td colspan="7"></td></tr> 
				    </tbody>
				  </table>
			  </div>
			</c:if>
			
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>