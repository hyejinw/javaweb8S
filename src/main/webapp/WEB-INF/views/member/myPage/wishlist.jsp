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
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
    }
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 600px;
    	max-width: 1500px;
    	box-sizing: border-box;
    	background-color: white;
    	padding: 20px;
    	margin-top:30px;
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
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		/* 개별 박스 선택할 때도 똑같이 처리 */
		function tempChange() {
			// 전체 해제한 경우 '전체 선택' 체크박스도 해제시켜주기
			if($( "input[name='checkRow']:checked" ).length == 0) {
				$("input[name=checkAll]").prop("checked", false);
			}
			
			// 전체 선택한 경우 '전체 선택' 체크박스도 선택시켜주기 (전체 상품 개수에서 품절 개수는 제외)
			if($( "input[name='checkRow']:checked" ).length == ${vosNum}) {
				$("input[name=checkAll]").prop("checked", true);
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
		    alert("삭제할 상품을 선택해주세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 상품을 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/member/myPage/saveIdxesDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
    				alert("선택한 상품이 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 저장 삭제 (단일)
		function saveDelete(idx) {
			if(confirm("선택한 상품을 삭제하시겠습니까?")) {
			      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/member/myPage/saveDelete",
	    	  data : { idx : idx },
	    	  success : function(res) {
    				alert("선택한 상품이 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<div class="row">
 				<div class="col-3 text-left">
					<a class="btn btn-dark mb-4" href="${ctp}/member/myPage" style="margin-left:20px;">
						<i class="fa-solid fa-chevron-left"></i>
					</a>
 				</div>
 				<div class="col-6 text-center">
					<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">관심 상품</h2>
 				</div>
 				<div class="col-3 text-right">
 					<div class="mb-2"><button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/magazine/magazineList';">매거진 계속 쇼핑</button></div>
					<div><button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/collection/collectionList';">컬렉션 계속 쇼핑</button></div>
 				</div>
 			</div>
			
			
    	<div class="infoBox" style="margin-bottom:20px">
		    <div class="row">
					<div class="col-2 text-left">
						<button class="btn btn-outline-dark ml-4" onclick="deleteAction()">선택 삭제</button>
					</div>
					<div class="col-10 text-right">
						<div class="pill-nav">
						  <a class="<c:if test="${sort=='컬렉션 상품'}">active</c:if> mr-2" href="${ctp}/member/myPage/wishlist?sort=컬렉션 상품">컬렉션 상품</a>
						  <a class="<c:if test="${sort=='매거진'}">active</c:if> mr-2" href="${ctp}/member/myPage/wishlist?sort=매거진">매거진</a>
						  <a class="<c:if test="${sort=='정기 구독'}">active</c:if> mr-2" href="${ctp}/member/myPage/wishlist?sort=정기 구독">정기 구독</a>
						</div>
					</div>
	    	</div>
			</div>
			
			<div class="table-responsive">
				<table class="table text-center">
			    <thead>
			      <tr>
			        <th><label for="th_checkAll"><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll()"/>&nbsp;&nbsp;&nbsp;&nbsp;<b>No.</b></label></th>
			        <th>이미지</th>
			        <th>상품명</th>
			        <th>판매가</th>
			        <th>선택</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${empty vos}">
			    		<tr><td colspan="5" class="text-center" style="padding:30px;">관심 상품이 없습니다.</td></tr> 
			    	</c:if>
			    	
			    	<c:if test="${!empty vos}">
		 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
					      <tr>
					        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" onclick="tempChange()" class="form-check-input" value="${vo.idx}" />&nbsp;&nbsp;${st.count}</label></td>
					        <td>
					        	<c:if test="${vo.type == '컬렉션 상품'}">
					        		<a href="${ctp}/collection/colProduct?idx=${vo.prodIdx}">
						        		<img src="${ctp}/collection/${vo.prodThumbnail}" style="width:100%; max-width:100px"/>
						        	</a>
					        	</c:if>
					        	<c:if test="${vo.type != '컬렉션 상품'}">
					        		<a href="${ctp}/magazine/maProduct?idx=${vo.maIdx}">
						        		<img src="${ctp}/magazine/${vo.prodThumbnail}" style="width:100%; max-width:100px"/>
						        	</a>
					        	</c:if>
				        	</td>
					        <td>
					        	<c:if test="${vo.type == '컬렉션 상품'}">
					        		<a href="${ctp}/collection/colProduct?idx=${vo.prodIdx}">
						        		${vo.prodName}
						        	</a>
					        	</c:if>
					        	<c:if test="${vo.type != '컬렉션 상품'}">
					        		<a href="${ctp}/magazine/maProduct?idx=${vo.maIdx}">
						        		${vo.prodName}
						        	</a>
						        	<c:if test="${vo.type == '매거진'}"><span class="badge badge-pill badge-success">M</span></c:if>
						        	<c:if test="${vo.type == '정기 구독'}"><span class="badge badge-pill badge-warning">S</span></c:if>
					        	</c:if>
				        	</td>
					        <td><fmt:formatNumber value="${vo.prodPrice}" pattern="#,###"/> 원</td>
					        <td><button class="btn btn-sm btn-outline-dark" onclick="saveDelete(${vo.idx})">삭제하기</button></td>
					      </tr>
				    	</c:forEach>
			    	</c:if>
			    	
			    	<tr><td colspan="5"></td></tr> 
			    </tbody>
			  </table>
		  </div>
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>