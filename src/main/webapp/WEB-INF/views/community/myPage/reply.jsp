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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  	.w3-row-padding img {margin-bottom: 12px}
		/* Set the width of the sidebar to 120px */
		.w3-sidebar {width: 120px;background: #222;}
		/* Add a left margin to the "page content" that matches the width of the sidebar (120px) */
		#main {margin-left: 120px}
		/* Remove margins from "page content" on small screens */
		@media only screen and (max-width: 600px) {#main {margin-left: 0}}

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
		.nowPart {
     color : #282828;
     font-weight: bold;
     border-bottom: 5px solid #282828;
     padding-bottom:14px;
    }
    .infoBox {
			display:grid;
			grid-template-columns:repeat(7,1fr);
			grid-gap:48px 24px;
			padding:0 2%;
		}
		@media screen and (max-width: 1770px) {
			.infoBox{
				display:grid;
				grid-template-columns:repeat(6,1fr);
				grid-gap:48px 24px;
			}
		}
		@media screen and (max-width: 1440px) {
			.infoBox{
				display:grid;
				grid-template-columns:repeat(4,1fr);
				grid-gap:48px 24px;
			}
		}
		@media screen and (max-width: 1200px) { 
			.infoBox{
				display:grid;
				grid-template-columns:repeat(2,1fr);
				grid-gap:48px 24px;
			}
		}
		.save:hover {
			cursor: pointer;
		}
		.contentBox{
		  display:table;
		  table-layout:fixed;
		  width:100%;
		  max-width:600px;
		  height:100px;
		  background:#ddd;
		  text-align:center;
		  margin-left: auto; 
		  margin-right: auto;
		  margin-top: 10px;
		}
		.contentBox__item{
		  display:table-cell;
		  vertical-align:middle;
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
		
		// 기록 상세창에서 돌아왔다면, 해당 session을 없애준다.
		$(document).ready(function(){
			if(sessionStorage.getItem('myPageReplySW') == 'ON') {
				sessionStorage.removeItem('myPageReplySW');
			}
		});
		
		// 로그아웃
		function logout() {
			let ans = confirm('책(의)세계에서 로그아웃하시겠습니까?');
			if(!ans) return false;
			
			location.href = "${ctp}/member/memberLogout";
		}
		
		// 해당 댓글이 있는 기록 상세창으로!
		function reflectionDetail(refIdx, bookIdx) {
			sessionStorage.setItem('myPageReplySW', 'ON');
			location.href = "${ctp}/community/reflectionDetail?idx="+refIdx+"&bookIdx="+bookIdx;
		}
		
		
		// 댓글 삭제
		function replyDelete(idx) {
			let ans = confirm('삭제 후 복구 불가능합니다. 삭제하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/replyDelete",
				data : { idx : idx },
				success : function() {
					alert('댓글이 삭제되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 회원 차단
		function block() {
			if('${sNickname}' == "") {
				alert('로그인 후 사용해주세요.');
				return false;
			}
			
			if('${blockVO}' == '') {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/blockInsert",
	    		data  : {
					  memNickname  : '${sNickname}',
					  blockedNickname : '${memberVO.nickname}'
					},
	    		success:function() {
	    			alert("해당 회원이 차단되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
			else {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/blockDelete",
	    		data  : {
	    			memNickname  : '${sNickname}',
					  blockedNickname : '${memberVO.nickname}'
					},
	    		success:function() {
	    			alert("차단이 해제되었습니다.");
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
<div id="back-to-top"></div>
<jsp:include page="/WEB-INF/views/community/communityMenu.jsp" />
	
	<!-- Page Content -->
	<div id="main">
		<a href="${ctp}/community/communityMain">
			<img src = "${ctp}/images/banner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div class="row">
					<div class="col ml-5">
						<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="text-center" style="font-size:20px; text-align:center; font-weight:bold">${memberVO.nickname}</span>
						&nbsp;&nbsp;&nbsp;
					</div>
					<div class="col text-right mr-5">
						<c:if test="${memberVO.nickname == sNickname}">
							<button class="btn btn-secondary" onclick="logout()">로그아웃</button>
						</c:if>
						<c:if test="${memberVO.nickname != sNickname}">
							<c:if test="${!empty blockVO}">
								<button class="btn btn-outline-success" onclick="block()">차단 해제</button>
							</c:if>
							<c:if test="${empty blockVO}">
								<button class="btn btn-outline-danger" onclick="block()">차단</button>
							</c:if>
						</c:if>
					</div>
				</div>
					<div style="width:50%; margin:0px 0px 0px 150px">
						<div class="alert alert-success">
					    소개글)&nbsp;&nbsp;&nbsp;&nbsp;
					   	<c:if test="${(memberVO.introduction == '') || (empty memberVO.introduction)}">소개글이 없습니다</c:if>
					    <c:if test="${memberVO.introduction != ''}"><strong>${memberVO.introduction}</strong></c:if>
					</div>
				</div>
				
				<div style="margin-top:100px">
					<a href="${ctp}/community/myPage?memNickname=${memberVO.nickname}"><span class="mr-5">서재 / 문장수집</span></a>
					<a href="${ctp}/community/myPage/reflection?memNickname=${memberVO.nickname}"><span class="mr-5">기록</span></a>
					<a href="${ctp}/community/myPage/reply?memNickname=${memberVO.nickname}"><span class="nowPart mr-5">작성 댓글</span></a>
					<c:if test="${memberVO.nickname == sNickname}">
						<a href="${ctp}/community/myPage/memInfo?memNickname=${memberVO.nickname}"><span class="mr-5">회원 정보</span></a>
						<a href="${ctp}/community/myPage/ask?memNickname=${memberVO.nickname}"><span>문의 / 신고</span></a>
					</c:if>
					<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
				</div>
	 		</div>
	 		
	 		<div style="padding:20px 50px 50px 50px;">
				<i class="fa-solid fa-keyboard" style="font-size:48px;"></i>
				<span style="font-size:30px; margin-left:20px">작성 댓글</span>
			</div> 	
			
			<table class="table">
				<thead class="">
		      <tr class="text-center">
		        <th>No.</th>
		        <th>내용</th>
		        <th>원본글</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty vos}">
		    		<tr><td colspan="3" class="text-center" style="padding:30px"><b>작성 댓글이 없습니다.</b></td></tr> 
		    		<tr><td colspan="3"></td></tr>
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
				    	<c:forEach var="vo" items="${vos}"> 
				    		<tr>
				    			<td class="text-center">${curScrStartNo}</td>
				    			<td style="width:90%">
								  	<div class="row mt-4"> 
								  		<div class="col-2 text-right">
								  			<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:30px"/>
								  		</div>
								  		<div class="col-10">
							  				<span style="color:grey; font-size:17px"><b>${vo.memNickname}</b></span>
								  			<c:if test="${(vo.memNickname == sNickname) || (sMemType == '관리자')}">
								  				<a href="javascript:replyDelete('${vo.idx}')">
								  				  &nbsp;&nbsp;
								  					<i class="fa-solid fa-xmark" style="font-size:20px"></i>
								  				</a>
								  			</c:if><br/>
								  			<p>
								  				<c:if test="${vo.edit == 1}"><span style="color:grey">(수정됨)</span></c:if>
								  				${vo.content}
								  				<input type="hidden" id="content${vo.idx}" value="${vo.content}"/>
								  			</p>
								  		</div>
								  	</div>
				    			</td>
				    			<td class="text-center">
				    				<button type="button" class="btn btn-sm btn-outline-primary" onclick="reflectionDetail('${vo.refIdx}','${vo.bookIdx}')">이동</button>
				    			</td>
				    		</tr>
				    		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
						</c:forEach>
			    	<tr><td colspan="3"></td></tr> 
		    	</c:if>
		    </tbody>
		  </table>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage/reply?pageSize=${pageVO.pageSize}&pag=1&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage/reply?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/community/myPage/reply?pageSize=${pageVO.pageSize}&pag=${i}&memNickname=${memberVO.nickname}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage/reply?pageSize=${pageVO.pageSize}&pag=${i}&memNickname=${memberVO.nickname}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage/reply?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/community/myPage/reply?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&memNickname=${memberVO.nickname}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>

  </div>
  
	
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>