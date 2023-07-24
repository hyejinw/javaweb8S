<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		a:link {text-decoration: none !important;}
		a:visited {text-decoration: none !important;}
		a:hover {text-decoration: none !important;}
		a:active {text-decoration: none !important;}
		
		.introBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 1000px;
    	box-sizing: border-box;
    	background-color: white;
    }
    .nowPart {
     color : #282828;
     font-weight: bold;
     border-bottom: 5px solid #282828;
     padding-bottom:14px;
    }
    .save:hover {
			cursor: pointer;
		}
		.infoBox {
			display:grid;
			grid-template-columns:repeat(5,1fr);
			grid-gap:48px 24px;
			padding:0 2%;
		}
	</style>
	<script>
		'use strict'
		
		// 팝업 닫기
		function cancel() {
			window.close();
		}
		
		// 더 알아보기
		function more() {
			localStorage.setItem('myPageDetailSW', 'ON');
			localStorage.setItem('memNicknameSW', '${memberVO.nickname}');
			
			window.opener.location.reload();
			window.close();
		}
		// 기록 상세창으로!
		function reflectionDetail(idx, bookIdx) {
			localStorage.setItem('memPageReflectionSW', 'ON');
			localStorage.setItem('memPageReflectionIdxSW', idx);
			localStorage.setItem('memPageReflectionBookIdxSW', bookIdx);
			
			window.opener.location.reload();
			window.close();
		}
		
		// 책 상세페이지에서 기록 상세페이지로 가는 길목에 있는 경우
		$(document).ready(function(){
			if(localStorage.getItem('bookPageReflectionSW') == 'ON') {
				window.opener.location.reload();
				window.close();
			}
		});
		
		// 책 상세 페이지 열기
  	function bookPage(idx) {
			let url = "${ctp}/community/bookPage?idx="+idx;
	
			let popupWidth = 700;
			let popupHeight = 1200;
	
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'bookPage', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
	</script>
</head>
<body style="overflow-X:hidden"> 
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="introBox">
				<div style="background-color:#eee; padding:10px">
					<div class="row" style="margin-top:10px">
						<div class="col ml-5">
							<img src="${ctp}/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span class="text-center" style="font-size:20px; text-align:center; font-weight:bold">${memberVO.nickname}</span>
							&nbsp;&nbsp;&nbsp;
							<button class="btn btn-sm btn-success" onclick="more()">더 알아보기</button>
						</div>
						<div class="col text-right mr-3">
							<a href="javascript:cancel()"><i class="fa-solid fa-x" style="font-size:25px; font-weight:bold"></i></a>
						</div>
					</div>
					<div style="width:50%; margin:0px 0px 0px 150px">
						<div class="alert alert-success">
					    소개글)&nbsp;&nbsp;&nbsp;&nbsp;
					    <c:if test="${(memberVO.introduction == '') || (empty memberVO.introduction)}">소개글이 없습니다</c:if>
					    <c:if test="${memberVO.introduction != ''}"><strong>${memberVO.introduction}</strong></c:if>
						</div>
					</div>			
				</div>
			</div>
		</div>
	</div>
	
	<div class="row text-center" style="margin:50px 10px 40px 10px">
		<div class="col">
			<a href="${ctp}/community/memPage?memNickname=${memberVO.nickname}"><span class="mr-5">서재 / 문장수집</span></a>
			<a href="${ctp}/community/memPage/reflection?memNickname=${memberVO.nickname}"><span class="nowPart mr-5">기록</span></a>
			<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
		</div>
	</div>
	
	<!-- 기록 -->
	<div class="text-center mb-2"><span style="font-size:25px"><i class="fa-solid fa-file-pen" style="font-size:20px;"></i>&nbsp;&nbsp;&nbsp;최신 기록</span></div>
	<div style="padding:30px">
		<table class="table">
			<thead class="text-center">
	      <tr>
	        <th>번호</th>
	        <th colspan="3">제목</th>
	        <th>비고</th>
	        <th>작성자</th>
	      </tr>
	    </thead>
	    <tbody>
	    	<c:if test="${empty vos}">
	    		<tr><td colspan="6" class="text-center" style="padding:30px"><b>기록이 없습니다.</b></td></tr> 
	    		<tr><td colspan="6"></td></tr>
	    	</c:if>
	    	
	    	<c:if test="${!empty vos}">
		    	<c:forEach var="vo" items="${vos}" varStatus="st">
			      <tr>
			      	<td class="text-center">${st.count}</td>
			      	<td class="text-center"><!-- 책 상세 페이지 -->
			        	<c:if test="${!empty vo.thumbnail}"><img src="${vo.thumbnail}" style="width:50px"/></c:if>
		        	</td>
			        <td colspan="2">
	        			<div class="col-6" style="font-size:18px; font-weight:bold;">
			        		<a href="javascript:reflectionDetail('${vo.idx}','${vo.bookIdx}')">${vo.title}</a><!-- 상세페이지 -->
								</div>
							</td>
							<td class="text-center"> 
		        		<a href="${ctp}/community/reflectionDetail?idx=${vo.idx}">
			        		${fn:substring(vo.refDate,0,10)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        		<i class="fa-solid fa-eye"></i>&nbsp;&nbsp;${vo.refView}
			        		<c:if test="${vo.replyOpen == 1}">
				        		&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;${vo.replyNum}
			        		</c:if>
			        		<c:if test="${vo.replyOpen != 1}">
				        		&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:grey"><i class="fa-solid fa-comment-dots"></i>&nbsp;X</span>
			        		</c:if>
			        		<c:if test="${(vo.memNickname == sNickname) || (sMemType == '관리자')}">
			        			&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-bookmark save"></i>&nbsp;&nbsp;${vo.refSave}
			        		</c:if>	
		        		</a><!-- 상세페이지 -->
							</td>		
							<td class="text-center">
		        		<a href="javascript:memPage('${vo.memNickname}')">  <!-- 회원 페이지 -->
			        		<img src="${ctp}/admin/member/${vo.memPhoto}" class="rounded-circle" style="width:35px"/>&nbsp;&nbsp;&nbsp;
			        		${vo.memNickname}
		        		</a>
							</td>	        	
			      </tr>
		    	</c:forEach>
		    	<tr><td colspan="6"></td></tr> 
	    	</c:if>
	    </tbody>
	  </table>
	</div>
	
  
</body>
</html>