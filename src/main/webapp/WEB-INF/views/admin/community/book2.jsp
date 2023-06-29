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
	<title>책 명언 관리</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	  <style>
	  .head {
	 		font-size: 20px;
	  }
	  .must {
  		color: red;
		}
	</style>	
	<script>
		'use strict';
		
		$(document).ready(function() {
			if(${bookVOS != null}) {
				document.getElementById('bookBtn').click();
				$('#demo').css("display","inline-block");
			}
		});
		
		
		$(document).mouseup(function (e){
			/* if($("#myModal").has(e.target).length === 0){
				console.log('들어오니?');
				$("#myModal").hide();
				location.href="${ctp}/admin/community/book"; 
			} */
				
		    const evTarget = e.target
		    if(evTarget.classList.contains("modal")) {
		    	$("#myModal").hide();
					console.log('들어오니?');
					location.href="${ctp}/admin/community/book"; 
		    	
		    }
		});
		
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/admin/community/book?pag=${pageVO.pag}&pageSize="+pageSize;
    }
		 
/* 		function open() {
			$('#demo').css("display","block");
			$('#close').css("display","inline-block");
			$('#open').css("display","none");
		}
		
		 
		function close() {
			$('#demo').css("display","none");
			$('#close').css("display","none");
			$('#open').css("display","inline-block");
		} */
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		// 기본 이미지 업로드
		function bookCheck() {
			let content = bookInsert.content.value.trim();
			let origin = bookInsert.origin.value.trim();

			if(content == "") {
				alert("명언을 입력해주세요.");
				return false;
			}
			else if(origin == "") {
				alert("작성자를 입력해주세요.");
				return false;
			}
			else {
				$.ajax({
		    		type : "post",
		    		url  : "${ctp}/admin/community/book",
		    		data : {content : content, origin : origin},
		    		success:function(res) {
		    			if(res == "1") {
		    				alert("명언이 추가되었습니다.");
		    				location.reload();
		    			}
		    		},
		    		error : function() {
		    			alert("전송 오류! 재시도 부탁드립니다.");
		    		}
		    	});
			}
		}
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function (){
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 기본 이미지를 삭제 하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/community/bookDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 책 명언이 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 책 명언 수정 창
		function bookUpdate(idx) {
			$('#content'+idx).attr('disabled', false);
			$('#origin'+idx).attr('disabled', false);
			$('#confirm'+idx).css("display","inline-block");
			$('#update'+idx).css("display","none");
		}
		
		function bookConfirm(idx) {
			let content = document.getElementById('content'+idx).value.trim();
			let origin = document.getElementById('origin'+idx).value.trim();
			
			if(content == "" || origin == "") {
				alert('내용과 작성자는 필수 입력값입니다.');
				return false;
			}

			$.ajax({
    	  type : "post",
    	  url : "${ctp}/admin/community/bookUpdate",
    	  data : {idx : idx, content : content, origin : origin},
    	  success : function(res) {
    			if(res == "1") {
    				alert("수정되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
			
			$('#content'+idx).attr('disabled', true);
			$('#origin'+idx).attr('disabled', true);
			$('#confirm'+idx).css("display","none");
			$('#update'+idx).css("display","inline-block");
		}
		
		// 책 등록 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/community/bookInsert?searchString="+searchString;
		}
/* 		
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	
		  let values = [];
		  
			$.ajax({
    	  type : "post",
    	  url : "${ctp}/admin/community/bookInsert",
    	  datatype : "json",
    	  data : {searchString : searchString},
    	  success : function(res) {
    		  
    		  let str = JSON.stringify(res);
    		  alert(str); 
    		  
    		  $.each(res, function(index, item) { // 데이터 =item
						console.log(index + " "); // index가 끝날때까지 
						console.log(item.title + " ");
						console.log(item.contents + " ");
						console.log(item.url + " ");
						console.log(item.isbn + " ");
					});
	    		  
					$('#demo').css("display","block");
					
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
		} */
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:80px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:80px 50px 100px 50px" class="border">
			<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">등록 책 관리</span></div>
		  <div style="text-align:center; margin-bottom:40px">
			  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
				 	검색과 동시에, 책이 저장됩니다.<br/>제목 클릭 시, 상세 정보 확인 가능합니다.
			  </span>
		  </div>
			<div class="row">
				<div class="col text-left">
					<a class="btn btn-danger mb-4" href="#" id="bookBtn" style="margin-left:100px" data-toggle="modal" data-target="#myModal">검색</a>
				</div>
				<div class="col text-right">
					<a class="btn btn-dark mb-4" href="javascript:deleteAction()" style="margin-right:100px;">선택 삭제</a>
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
		          <a href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
			<table class="table text-center">
		    <thead class="thead-dark">
		      <tr>
		        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
		        <th>제목</th>
		        <th>출판날짜</th>
		        <th>저자</th>
		        <th>평점</th>
		        <th>저장 등록 수</th>
		        <th>저장 날짜</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
			      <tr>
			        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
			        <td>${vo.title}</td>
			        <td>${vo.datetime}</td>
			        <td>${vo.authors}</td>
			        <td>${vo.bookRate}</td>
			        <td>${vo.save}</td>
			        <td>${fn:substring(vo.bookUpdate,0,19)}</td>
			      </tr>
			    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    	</c:forEach>
		    	<tr><td colspan="4"></td></tr> 
		    </tbody>
		  </table>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>	

		
 	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="margin:10px 100px 10px 100px">
	          <form name="searchForm">
	          	<div class="input-group">
					      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요" />
					      <div class="input-group-append">
					     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="javascript:searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#0cc621;"></i></a>
					     	</div>
				     	</div>
				    	<input type="hidden" name="pag" value="${bookPageVO.pag}"/>   
		  				<input type="hidden" name="pageSize" value="${bookPageVO.pageSize}"/>
				    </form>
			    </div>
			    <div id="demo" style="display:none;">
			  	  <hr/>
			  	  <c:forEach var="bookVO" items="${bookVOS}">
			  	  	<table class="text-center">
			  	  		<tr>
			  	  			<td rowspan="3"><a href="${bookVO.url}"><img src="${bookVO.thumbnail}"/></a></td>
			  	  			<td>
			  	  				<div class="row">
			  	  					<div class="col"><b>${bookVO.title}</b></div>
			  	  				</div>
			  	  				<div class="row">
			  	  					<div class="col">${bookVO.publisher}</div>
			  	  				</div>
			  	  				<div class="row">
			  	  					<div class="col">${bookVO.contents}...</div>
			  	  				</div>
			  	  			</td>
			  	  			<td rowspan="3"><button class="btn btn-outline-dark my-2 my-sm-0" onclick="()">선택</button></td>
			  	  		</tr>
			  	  	</table>
							<hr/>				
			  	  </c:forEach>
			  	  
<%-- 			  	  <!-- 페이징 -->
					  <div class="text-center">
						  <ul class="pagination justify-content-center">
						    <c:if test="${bookPageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${bookPageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						    <c:if test="${bookPageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${bookPageVO.pageSize}&pag=${(bookPageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						    <c:forEach var="i" begin="${bookPageVO.curBlock*bookPageVO.blockSize + 1}" end="${bookPageVO.curBlock*pageVO.blockSize + bookPageVO.blockSize}" varStatus="st">
						      <c:if test="${i <= bookPageVO.totPage && i == bookPageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/community/book?pageSize=${bookPageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
						      <c:if test="${i <= bookPageVO.totPage && i != bookPageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${bookPageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
						    </c:forEach>
						    <c:if test="${bookPageVO.curBlock < bookPageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${bookPageVO.pageSize}&pag=${(bookPageVO.curBlock+1)*bookPageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						    <c:if test="${bookPageVO.pag < bookPageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/book?pageSize=${bookPageVO.pageSize}&pag=${bookPageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						  </ul>
					  </div> --%>
					</div>
        </div>
        
      </div>
    </div>
  </div>
		

</body>
</html>