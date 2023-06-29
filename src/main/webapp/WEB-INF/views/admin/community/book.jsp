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
	<title>등록 책 관리</title>
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
				$('#demo').css("display","block");
			}
		});
		
		
		$(document).mouseup(function (e){
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal")) {
	    	$("#myModal").hide();
				location.href="${ctp}/admin/community/book?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}";
	    	
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
		
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function() {
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 책을 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/community/bookDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 책이 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
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
		
		// 책 등록 검색(DB)
		function searchCheck2() {
			let searchString = $("#searchString2").val();
			let search = $("#search2").val();
	    	
    	if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm2.search2.focus();
    		return false;
    	}
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm2.searchString2.focus();
    		return false;
    	}
    	
    	location.href = "${ctp}/admin/community/bookDB?search="+search+"&searchString="+searchString;
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
		
 		function bookDetail(idx,title,contents,url,isbn,datetime,authors,publisher,translators,price,sale_price,thumbnail,status,bookRate,save,bookUpdate) {
			
			$("#bookDetailIdx").text(idx);
			$("#bookDetailTitle").text(title);
			$("#bookDetailContents").text(contents);
			
			if(contents != "") {
				$("#bookDetailContents").text(contents + "...");
			}
			else {
				$("#bookDetailContents").text("책 상세내용이 없습니다");
			}
			
			//document.getElementById("bookDetailUrl").innerHTML = '<a href='+url+'></a>';
			
			//$(".bookDetailUrl").append('<a href='+url+'></a>');
			
		/* 	let bookDetailUrl = document.createElement("a");
			bookDetailUrl.setAttribute("href",url);
			bookDetailUrl.setAttribute("id","bookDetailUrl");
			bookDetailUrl.setAttribute("class","btn btn-primary");		
			bookDetailUrl.setAttribute("value","상세보기");		
			
			document.querySelector(".bookDetailUrlDemo").appendChild(bookDetailUrl); */
			document.getElementById('bookDetailUrl1').setAttribute('href', url);
			document.getElementById('bookDetailUrl2').setAttribute('href', url);
			document.getElementById('bookDetailThumbnail').setAttribute('src', thumbnail);
			
			$("#bookDetailIsbn").text("isbn : " + isbn);
			
			$("#bookDetailDatetime").text('출판일 : ' + datetime.substring(0,9));
			
			$("#bookDetailAuthors").text('저자 : ' + authors);
			$("#bookDetailPublisher").text(publisher);
			
			if(translators != "") {
				$("#bookDetailTranslators").text('번역 : ' + translators);
			}
		
			$("#bookDetailPrice").text(price + "원");
			$("#bookDetailSale_price").text(sale_price);
			
			$("#bookDetailStatus").text(status);
			$("#bookDetailBookRate").text("평점 : " + bookRate);
			$("#bookDetailSave").text("저장 수 : " + save);
			$("#bookDetailBookUpdate").text("저장일 : " + bookUpdate.substring(0,19));
			
			
		} 
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div class="text-right">
					<a class="btn btn-danger" href="#" id="bookBtn" style="margin-left:100px" data-toggle="modal" data-target="#myModal">자료 검색</a>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">등록 책 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">
					 	자료 검색과 동시에, 책이 저장됩니다.<br/>제목 클릭 시, 상세 정보 확인 가능합니다.
				  </span>
			  </div>
	 		</div>
			<div class="row">
				<div class="col text-left">
					<a class="btn btn-dark mb-4" href="javascript:deleteAction()" style="margin-right:20px;">선택 삭제</a>
					<a class="btn btn-secondary mb-4" href="${ctp}/admin/community/book" style="margin-right:100px;">새로고침</a>
				</div>
				<div class="col text-right">
					<form name="searchForm2" class="form-inline" style="flex-direction: row-reverse">
			    	<div class="input-group">
				      <input type="text" name="searchString" id="searchString2" value="${searchString2}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요" style="width:300px;"/>
				      <div class="input-group-append">
				     		<a href="#" class="btn btn-success my-2 my-sm-0" onclick="javascript:searchCheck2()"><i class="fa-solid fa-magnifying-glass" style="color:#282828;"></i></a>
				     	</div>
			     	</div>
			    	<div>
			        <select name="search" id="search2" class="form-control mr-sm-2">
			          <option <c:if test="${search2 == 'title'}">selected</c:if> value="title">제목</option>
			          <option <c:if test="${search2 == 'authors'}">selected</c:if> value="authors">저자</option>
			        </select>
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
			        <td>
			        	<a href="#" id="bookDetail" data-toggle="modal" data-target="#bookModal" 
			        		onclick="javascript:bookDetail('${vo.idx}','${vo.title}','${vo.contents}','${vo.url}','${vo.isbn}','${vo.datetime}','${vo.authors}','${vo.publisher}','${vo.translators}','${vo.price}','${vo.sale_price}','${vo.thumbnail}','${vo.status}','${vo.bookRate}','${vo.save}','${vo.bookUpdate}')">
			        	${vo.title}</a>
			        </td>
			        <td>${fn:substring(vo.datetime,0,9)}</td>
			        <td>${vo.authors}</td>
			        <td>${vo.bookRate}</td>
			        <td>${vo.save}</td>
			        <td>${fn:substring(vo.bookUpdate,0,19)}</td>
			      </tr>
			    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    	</c:forEach>
		    	<tr><td colspan="7"></td></tr> 
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
	
	<!-- 책 상세내용 -->
 	<!-- The Modal -->
  <div class="modal fade" id="bookModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
					<div style="text-align:center">
						<a id="bookDetailUrl1" href="#" target="_blank">
							<span id="bookDetailTitle" class="text-center" style="font-size:20px; text-align:center; font-weight:bolder"></span>
						</a>
					</div>
					<div style="text-align:center; margin-bottom:40px"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
						<span id="bookDetailAuthors"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailPublisher"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailTranslators"></span>
						<br/><span id="bookDetailIsbn"></span>
						<br/><span id="bookDetailDatetime"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailPrice"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailStatus"></span>
					</span></div>
			    
			    <div class="row">
		  			<div class="col-3 text-center">
		  				<a id="bookDetailUrl2" href="#" target="_blank"><img src="#" id="bookDetailThumbnail"/></a>
		  			</div>
		  			<div class="col-9 text-center">
		  				<div class="row"><div class="col"><span id="bookDetailBookRate"></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span id="bookDetailSave"></span></div></div>
		  				<div class="row"><div class="col" id="bookDetailBookUpdate"></div></div>
		  				<div class="row m-3"><div class="col" id="bookDetailContents"></div></div>
		  			</div>
		  		</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>	

	<!-- 책 자료 검색 -->	
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
				    </form>
			    </div>
			    <div id="demo" style="display:none;">
			  	  <hr/>
			  	  <c:if test="${empty bookVOS}">
			  	  	<div class="container text-center"><br/>관련 도서가 없습니다 😲</div>
			  	  </c:if>
			  	  <c:if test="${!empty bookVOS}">
				  	  <c:forEach var="bookVO" items="${bookVOS}">
			  	  		<div class="row">
			  	  			<div class="col-3 text-center"><a href="${bookVO.url}"><img src="${bookVO.thumbnail}"/></a></div>
			  	  			<div class="col-9 text-center">
			  	  				<div class="row"><div class="col"><a href="${bookVO.url}"><b>${bookVO.title}</b></a></div></div>
			  	  				<div class="row"><div class="col">${bookVO.publisher}</div></div>
			  	  				<div class="row m-3"><div class="col">${bookVO.contents}...</div></div>
			  	  			</div>
			  	  		</div>
								<hr/>				
				  	  </c:forEach>
			  	  </c:if>
					</div>
        </div>
        
      </div>
    </div>
  </div>
		

</body>
</html>