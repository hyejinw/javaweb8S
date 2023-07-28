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
		// 문의 검색 + 분류 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let sort = $("#sort").val();
	    	
    	location.href = "${ctp}/member/myPage/ask?search="+search+"&searchString="+searchString+"&sort="+sort;
		}
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		/* 개별 박스 선택할 때도 똑같이 처리 */
		function tempCheckChange() {
			
			// 전체 해제한 경우 '전체 선택' 체크박스도 해제시켜주기
			if($( "input[name='checkRow']:checked" ).length == 0) {
				$("input[name=checkAll]").prop("checked", false);
			}
			
			// 전체 선택한 경우 '전체 선택' 체크박스도 선택시켜주기 (전체 상품 개수에서 품절 개수는 제외)
			if($( "input[name='checkRow']:checked" ).length == ${askNum}) {
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
		    alert("삭제할 문의를 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 문의를 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/community/askIdxesDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
    				alert("선택한 문의가 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 문의 상세창에서 돌아왔다면, 해당 session을 없애준다.
		$(document).ready(function(){
			if(localStorage.getItem('memMyPageAskSW') == 'ON') {
				localStorage.removeItem('memMyPageAskSW');
			}
			else if(localStorage.getItem('memMyPageAskInsertSW') == 'ON') {
				localStorage.removeItem('memMyPageAskInsertSW');
			}
		});
		
		// 문의 상세창
		function askDetail(idx) {
			localStorage.setItem('memMyPageAskSW', 'ON');
			location.href = "${ctp}/about/askDetail?idx="+idx;
		}
		// 문의 등록
		function insertCheck() {
			localStorage.setItem('memMyPageAskInsertSW', 'ON');
			location.href = "${ctp}/about/askInsert";
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
					<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">나의 문의 관리</h2>
 				</div>
 				<div class="col-3 text-right">
 					<a class="btn btn-dark mb-4" href="${ctp}/member/myPage/ask" style="margin-right:20px;">
 						<i class="fa-solid fa-arrows-rotate"></i>
					</a>
 				</div>
 			</div>
			
			
			<form name="searchForm">
 				<div class="text-right">
					<a class="btn btn-dark mr-3 mb-4" href="javascript:deleteAction()">선택 삭제</a>
					<a class="btn btn-outline-secondary mr-3 mb-4" href="javascript:insertCheck()">문의 등록</a>
				</div>
				<div class="row">
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
		        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;No.</label></th>
		        <th>제목</th>
		        <th>답변 유무</th>
		        <th>작성일</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty vos}">
		    		<tr><td colspan="4" class="text-center" style="padding:30px"><b>작성 문의가 없습니다.</b></td></tr> 
		    		<tr><td colspan="4"></td></tr>
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
				    	<c:forEach var="vo" items="${vos}"> 
				    		<tr>
				    			<td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" onclick="tempCheckChange()" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
				    			<td>
								  	<a href="javascript:askDetail('${vo.idx}')">
								  		${vo.askTitle}
								  		<c:if test="${vo.secret == '비공개'}">
								  			<span class="badge badge-pill badge-dark">비공개</span>
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
			    	<tr><td colspan="4"></td></tr> 
		    	</c:if>
		    </tbody>
		  </table>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/ask?pageSize=${pageVO.pageSize}&pag=1&search=${search}&searchString=${searchString}&memNickname=${memberVO.nickname}&sort=${sort}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/ask?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&memNickname=${memberVO.nickname}&sort=${sort}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/member/myPage/ask?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&memNickname=${memberVO.nickname}&sort=${sort}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/ask?pageSize=${pageVO.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&memNickname=${memberVO.nickname}&sort=${sort}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/ask?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&search=${search}&searchString=${searchString}&memNickname=${memberVO.nickname}&sort=${sort}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/myPage/ask?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&search=${search}&searchString=${searchString}&memNickname=${memberVO.nickname}&sort=${sort}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>