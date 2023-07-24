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
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
  <style>
 		html {scroll-behavior:smooth;}
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
		.save:hover {
			cursor: pointer;
		}
		.contentBox{
		  display:table;
		  table-layout:fixed;
		  width:100%;
		  max-width:600px;
		  height:200px;
		  background:#eee;
		  text-align:center;
		  margin-left: auto; 
		  margin-right: auto;
		}
		.contentBox__item{
		  display:table-cell;
		  vertical-align:middle;
		}
  </style>
  <script>
		'use strict';
		
		// 책 자료 검색 내용이 있다면 띄워주기
		$(document).ready(function() {
			if(${bookVOS != null}) {
				document.getElementById('bookBtn').click();
				$('#demo').css("display","block");
			}
		});
	
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
		
		// 경고
		function insertWarning() {
			let ans = confirm('작성을 취소하시겠습니까?');
			if(!ans) return false;
			
			location.href = "${ctp}/community/reflection";
		}
		
		// 책 자료 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let title = $("#title").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}
    	
    	location.href = "${ctp}/community/bookSelect?searchString="+searchString+"&title="+title;
		}
		
		// 책 추가
		function bookSelection(title, publisher, thumbnail) {
			let ans = confirm('책을 추가하시겠습니까?');
			if(!ans) return false;
			
			$('#bookInsertSearch').css('display','none');
			
			let str = '<h4><b>『 '+title+' 』</b></h4>';
			str += '<img src="'+thumbnail+'" /><br/><br/>';
			
			document.getElementById('bookInsertDemo').innerHTML = str;
			document.getElementById('bookTitle').value = bookTitle;
    	document.getElementById('publisher').value = publisher;
		}
		
		// 기록 작성
		function reflectionInsert() {
			let title = insertForm.title.value;
			
			let regex1 = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\s]{1,100}$/g; 
			// (제목)1자 이상 100자 이하,한글,영문,숫자,특수문자 허용
			
			if(!regex1.test(title)){
				alert('제목 형식에 맞춰주세요.(한글/영문/숫자/특수문자 허용, 1~100자)');
				insertForm.title.focus();
		    return false;
		  }
			insertForm.submit();
		}
  </script>
</head>
<body>
<div id="back-to-top"></div>
<jsp:include page="/WEB-INF/views/community/communityMenu.jsp" />
	
	<!-- Page Content -->
	<div id="main">
		<a href="${ctp}/community/communityMain">
			<img src = "${ctp}/images/banner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		
	  <div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	  	<form name="insertForm" method="post" action="${ctp}/community/reflectionInsert">
		 		<div style="background-color:white; padding:20px; margin-bottom:30px">
		 			<div class="row mb-4">
		 				<div class="col-3 text-left">
							<a class="btn btn-dark mb-4" href="javascript:insertWarning()" style="margin-left:20px;"><i class="fa-solid fa-chevron-left"></i></a>
		 				</div>
		 				<div class="col-6 text-center">
		 					<span class="text-center" style="font-size:25px; text-align:center; font-weight:bold">기록 남기기</span>
		 				</div>
		 				<div class="col-3 text-right">
							<a class="btn btn-dark mb-4" href="${ctp}/community/reflectionInsert" style="margin-right:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
		 				</div>
		 			</div>
					<div style="text-align:center">
						<span class="text-center" style="font-size:30px; text-align:center; font-weight:500">
							<input id="title" class="text-center" name="title" value="${title}" style="width:500px" placeholder="제목을 입력해주세요."/>
						</span><br/>
						<span class="text-center" style="font-size:20px; text-align:center; color:grey">by. ${sNickname}</span><br/>
						<input type="hidden" name="memNickname" id="memNickname" value="${sNickname}"/>
					</div>
					<div class="row">
						<div class="col ml-5">
						</div>
						<div class="col text-right mr-5">
							<span style="font-size:18px">
								<label for="replyOpen"><input type="checkbox" name="replyOpen" id="replyOpen" class="form-check-input" checked/>
								&nbsp;댓글 허용&nbsp;&nbsp;&nbsp;</label>
							</span>&nbsp;&nbsp;&nbsp;&nbsp;
							
							<input type="hidden" name="bookTitle" id="bookTitle" value="없음"/>
							<input type="hidden" name="publisher" id="publisher"/>
							<input type="hidden" name="refHostIp" value="${pageContext.request.remoteAddr}"/>

							<button class="btn btn-secondary" type="button" onclick="reflectionInsert()">작성</button>
						</div>
					
					</div>
					<hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
		 		</div>
				
				<div style="padding:20px 20px 50px 20px;">
					<div class="text-center" id="bookInsertDemo">
					</div>
					<div class="contentBox" style="margin-bottom:80px" id="bookInsertSearch">
					  <span class="contentBox__item">
							<a href="#" id="bookBtn" class="btn btn-primary" data-toggle="modal" data-target="#myModal">도서 추가</a>
					  </span>
					</div>
					
					<textarea rows="100" name="content" id="CKEDITOR" class="form-control"></textarea>
		        <script>
			        CKEDITOR.replace("content",{
			        	height:800,
			        	filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지) 업로드시 매핑경로 */
			        	uploadUrl : "${ctp}/imageUpload"		/* 여러개의 그림파일을 드래그&드롭해서 올리기 */
			        });
		        </script>
		        
				  <hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
				</div>
			</form>
		</div>
	  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
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
			  	  				<button class="btn btn-outline-primary" onclick="bookSelection('${bookVO.title}', '${bookVO.publisher}', '${bookVO.thumbnail}')" data-dismiss="modal">선택</button>
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