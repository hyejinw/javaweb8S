<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    }
    .must {
  		color: red;
		}
	</style>
	<script>
		'use strict'
		
		// 책 자료 검색 내용이 있다면 띄워주기
		$(document).ready(function() {
			if(${bookVOS != null}) {
				document.getElementById('bookBtn').click();
				$('#demo').css("display","block");
			}
		});
		
		
		// 책 자료 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	let title = document.getElementById('title').value; 
    	
    	location.href = "${ctp}/community/bookSelect?searchString="+searchString+"&title="+title;
		}
		
		// 책 선택
		function bookSelection(bookTitle, thumbnail, contents, publisher) {
    	document.getElementById('bookTitle').value = bookTitle;
    	document.getElementById('publisher').value = publisher;
    	document.getElementById('title').value = '${title}';
			
			$("#myModal").hide();
			
			let str = "";
			str += '<div class="row">';
			str += '<div class="col-3 text-right">';
			str += '<img src="'+thumbnail+'" style="width:100%; max-width:100px" />';
			str += '</div>';
			str += '<div class="col-9">';
			str += '<br/><b>'+bookTitle+'</b><br/><br/>';
			str += contents+'...';
			str += '</div>';
			str += '</div>';

			document.getElementById("bookDemo").innerHTML = str;
		}
		
		// 기록 등록
		function reflectionInsert() {
			let title = insertForm.title.value;
			
			let regex1 = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,100}$/g; 
			// (제목)1자 이상 100자 이하,한글,영문,숫자,특수문자 허용
			
			if(!regex1.test(title)){
				alert('제목 형식에 맞춰주세요.(한글/영문/숫자/특수문자 허용, 1~100자)');
				insertForm.title.focus();
		    return false;
		  }
			insertForm.submit();
		}
		
		// 등록 취소
		function insertCancel() {
			opener.location.reload();
			window.close();
		}
	</script>
</head>
<body>
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">기록 남기기</div>
				<form name="insertForm" method="post" action="${ctp}/community/reflectionInsert">
					<table class="table table-bordered" style="margin-bottom:0px">
						<tr>
							<th>도서</th>
							<td>
								<div class="row">
									<div class="col-1">
										<a class="btn btn-primary btn-sm" href="#" id="bookBtn" data-toggle="modal" data-target="#myModal">검색</a>
									</div>
									<div class="col-11">
										<div id="bookDemo"></div>
									</div>
								</div>
								<input type="hidden" name="bookTitle" id="bookTitle" value="없음"/>
								<input type="hidden" name="publisher" id="publisher"/>
								<input type="hidden" name="refHostIp" value="${pageContext.request.remoteAddr}"/>
							</td>
						<tr>
						<tr>
							<th>작성자</th>
							<td><input type="text" name="memNickname" id="memNickname" value="${sNickname}" class="form-control" readonly/></td>
						<tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="title" id="title" class="form-control" /></td>
						<tr>
						<tr>
							<th>내용</th>
							 <td><textarea rows="8" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
				        <script>
					        CKEDITOR.replace("content",{
					        	height:200,
					        	filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지) 업로드시 매핑경로 */
					        	uploadUrl : "${ctp}/imageUpload"		/* 여러개의 그림파일을 드래그&드롭해서 올리기 */
					        });
				        </script>
						</tr>
						<tr>
							<td colspan="2" class="text-right">
								<label for="replyOpen"><input type="checkbox" name="replyOpen" id="replyOpen" class="form-check-input" checked/>&nbsp;댓글 허용&nbsp;&nbsp;&nbsp;</label>
							</td>
						</tr>
					</table>			
				</form>
			</div>
		</div>
	</div>
	
	<div class="row text-center" style="margin-bottom:40px">
		<div class="col">
			<br/>
			<button class="btn btn-dark" onclick="reflectionInsert()">등록</button>&nbsp;&nbsp;&nbsp;
			<button class="btn btn-outline-dark" onclick="insertCancel()">취소</button>
		</div>
	</div>
	
	
	<!-- 책 자료 검색 -->	
 	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal body -->
        <div class="modal-body">
        	<div style="margin:10px 100px 10px 100px">
	          <form name="searchForm">
	          	<div class="input-group">
					      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" autofocus placeholder="검색어를 입력해주세요" />
					      <div class="input-group-append">
					     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#0cc621;"></i></a>
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
			  	  			<div class="col-3 text-center"><a href="${bookVO.url}" target="_blank"><img src="${bookVO.thumbnail}"/></a></div>
			  	  			<div class="col-7 text-center">
			  	  				<div class="row"><div class="col"><a href="${bookVO.url}" target="_blank"><b>${bookVO.title}</b></a></div></div>
			  	  				<div class="row"><div class="col">${bookVO.authors}&nbsp;&nbsp; | &nbsp;&nbsp;${bookVO.publisher}</div></div>
			  	  				<div class="row m-3"><div class="col">${bookVO.contents}...</div></div>
			  	  			</div>
			  	  			<div class="col-2 text-center">
			  	  				<button class="btn btn-outline-primary" onclick="bookSelection('${bookVO.title}','${bookVO.thumbnail}','${bookVO.contents}', '${bookVO.publisher}')" data-dismiss="modal">선택</button>
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