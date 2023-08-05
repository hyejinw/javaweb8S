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
		
		// 책 상세페이지에서 기록 상세페이지로 가는 길목에 있는 경우
		$(document).ready(function(){
			if(localStorage.getItem('bookPageReflectionSW') == 'ON') {
				window.opener.location.reload();
				window.close();
			}
		});
		
		
		// 신고 모달창에 값 주기
		function reportCategory(reportCategory, originWriter, originIdx) {
			document.getElementById('reportCategory').value = reportCategory;
			document.getElementById('originWriter').value = originWriter;
			document.getElementById('originIdx').value = originIdx;
		}
		
		// 신고
		function reportInsert() {
			if('${sNickname}' == "") {
				alert('로그인 후 이용해주세요.');
				return false;
			}			
			
			let reportCategory = document.getElementById('reportCategory').value;
			let originIdx = document.getElementById('originIdx').value;
			let reportHostIp = document.getElementById('reportHostIp').value;
			let message = document.getElementById('message').value;
			
			if(message == '') {
				alert('신고 내용을 입력해주세요.');
				document.getElementById('message').focus();
		    return false;
		  }
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/reportInsert",
				data : {
					memNickname : '${sNickname}',
					reportCategory : reportCategory,
					originIdx : originIdx,
					message : message,
					reportHostIp : reportHostIp
				},
				success : function() {
					alert('소중한 의견 감사합니다. 빠르게 처리해드리겠습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 문장수집 저장
		function insSave(insIdx, insSaveIdx) {
			
			if('${sNickname}' == "") {
				alert('로그인 후 사용해주세요.');
				return false;
			}
			
			if(insSaveIdx == 0) {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/insSave",
	    		data  : {
					  memNickname  : '${sNickname}',
					  insIdx : insIdx
					},
	    		success:function() {
	    			alert("문장수집이 저장되었습니다.");
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
	    		url   : "${ctp}/community/insSaveDelete",
	    		data  : {
	    			memNickname  : '${sNickname}',
	    			insIdx : insIdx,
	    			idx : insSaveIdx
					},
	    		success:function() {
	    			alert("문장수집 저장이 취소되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
		}
		
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
							<img src="${ctp}/resources/data/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
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
			<a href="${ctp}/community/memPage?memNickname=${memberVO.nickname}"><span class="nowPart mr-5">서재 / 문장수집</span></a>
			<a href="${ctp}/community/memPage/reflection?memNickname=${memberVO.nickname}"><span class="mr-5">기록</span></a>
			<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
		</div>
	</div>
	
	<!-- 서재 -->
	<div style="padding:30px">
		<div>
			<span style="font-size:20px">최신 인생책&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>내 인생에 영향을 준 책 30권</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<div class="infoBox" style="margin:30px 0px">
		  	<c:forEach var="bookSave1VO" items="${bookSave1VOS}" varStatus="st">
		  		<div class="text-center">
	  				<a href="javascript:bookPage(${bookSave1VO.bookIdx})"><img src="${bookSave1VO.thumbnail}" style="width:100px; height:150px"/></a><br/>
	  				<a href="javascript:bookPage(${bookSave1VO.bookIdx})"><span style="color:grey"><b>${bookSave1VO.title}</b></span></a><br/>
		  		</div>
		  	</c:forEach>
		  </div>
		</div>
		<div>
			<span style="font-size:20px">최신 추천책&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>알리고 싶은 좋은 책 99권</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<div class="infoBox" style="margin:30px 0px">
		  	<c:forEach var="bookSave2VO" items="${bookSave2VOS}" varStatus="st">
		  		<div class="text-center">
	  				<a href="javascript:bookPage(${bookSave2VO.bookIdx})"><img src="${bookSave2VO.thumbnail}" style="width:100px; height:150px"/></a><br/>
	  				<a href="javascript:bookPage(${bookSave2VO.bookIdx})"><span style="color:grey"><b>${bookSave2VO.title}</b></span></a><br/>
		  		</div>
		  	</c:forEach>
		  </div>
		</div>
		<div>
			<span style="font-size:20px">최신 읽은책&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>읽었어요. 같이 이야기해요.</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<div class="infoBox" style="margin:30px 0px">
		  	<c:forEach var="bookSave3VO" items="${bookSave3VOS}" varStatus="st">
		  		<div class="text-center">
	  				<a href="javascript:bookPage(${bookSave3VO.bookIdx})"><img src="${bookSave3VO.thumbnail}" style="width:100px; height:150px"/></a><br/>
	  				<a href="javascript:bookPage(${bookSave3VO.bookIdx})"><span style="color:grey"><b>${bookSave3VO.title}</b></span></a><br/>
		  		</div>
		  	</c:forEach>
		  </div>
		</div>
		<div>
			<span style="font-size:20px">최신 관심책&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>아직 읽지 않았지만 관심있어요.</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<div class="infoBox" style="margin:30px 0px">
		  	<c:forEach var="bookSave4VO" items="${bookSave4VOS}" varStatus="st">
		  		<div class="text-center">
	  				<a href="javascript:bookPage(${bookSave4VO.bookIdx})"><img src="${bookSave4VO.thumbnail}" style="width:100px; height:150px"/></a><br/>
	  				<a href="javascript:bookPage(${bookSave4VO.bookIdx})"><span style="color:grey"><b>${bookSave4VO.title}</b></span></a><br/>
		  		</div>
		  	</c:forEach>
		  </div>
		</div>
	</div>
	
	<!-- 문장수집 -->
	<div class="text-center mb-2"><span style="font-size:25px"><i class="fa-solid fa-highlighter" style="font-size:20px;"></i>&nbsp;&nbsp;&nbsp;최신 문장수집</span></div>
	<c:if test="${empty inspiredVOS}">
		<hr/>
		<div class="text-center" style=""><b>아직 수집된 문장이 없습니다.</b></div> 
	</c:if>
	
	<c:if test="${!empty inspiredVOS}">
		<div style="overflow:scroll; width:100%; height:600px; padding:30px; margin-bottom:80px; background-color:#fff">
			<c:forEach var="inspiredVO" items="${inspiredVOS}" varStatus="st">
				<div class="row" style="padding:5px">
					<div class="w3-panel w3-sand" style="margin:10px; width:100%; max-width:800px">
		      	<div class="row">
				    	<div class="col">
						    <span style="font-size:80px; line-height:0.6em; opacity:0.2">❝</span>
						    <p class="w3-xlarge" style="margin:-40px 0px 0px 0px; padding:10px">
						    	<i style="font-size:15px;">${inspiredVO.insContent}</i>
						    </p>
				    	</div>
				    </div>
			    	<p class="ml-4" style="color:grey;">『 ${inspiredVO.bookTitle} 』(${inspiredVO.authors})&nbsp;&nbsp;${inspiredVO.page}</p>
				    <hr style="margin:0px"/>
				    <div class="row">
				    	<div class="col">
						    <div style="padding:10px">
						    	<span>by. ${inspiredVO.memNickname}</span>
						    	<c:if test="${inspiredVO.explanation!= ''}">
						    		&nbsp;&nbsp;&nbsp;
						    		<span class="dropdown dropright">
									    <button type="button" class="dropdown-toggle" data-toggle="dropdown" style="border:0px; background-color:transparent;">
									      <i class="fa-solid fa-circle-info" style="font-size:20px; padding:5px"></i>
									    </button>
									    <div class="dropdown-menu" style="padding:5px">
									      <p>${inspiredVO.explanation}</p>
									    </div>
									  </span>
						    	</c:if>
						    </div>
				    	</div>
				    	<div class="col text-right">
				    		<div style="padding:10px">
					    		<c:if test="${inspiredVO.insSaveIdx == 0}"><i class="fa-regular fa-bookmark save" style="font-size:25px" onclick="insSave('${inspiredVO.idx}', '${inspiredVO.insSaveIdx}')" title="관심등록되지 않은 문장수집 입니다"></i></c:if>
									<c:if test="${inspiredVO.insSaveIdx != 0}"><i class="fa-solid fa-bookmark save" style="font-size:25px" onclick="insSave('${inspiredVO.idx}', '${inspiredVO.insSaveIdx}')" title="관심등록된 문장수집"></i></c:if>
				  				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="#" class="btn btn-outline-secondary" onclick="reportCategory('문장수집','${inspiredVO.memNickname}','${inspiredVO.idx}')" data-toggle="modal" data-target="#reportModal">
										신고
									</a>
				    		</div>
				    	</div>
				    </div>
				  </div>
				</div>
			</c:forEach>
		</div>
	</c:if>
	
	
	
	<!-- The Modal -->
  <div class="modal fade" id="reportModal">
    <div class="modal-dialog modal-xl modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">신고창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee;">
		  			<textarea rows="4" cols="10" id="message" class="form-control mt-3" placeholder="신고 내용을 상세히 입력해주세요."></textarea>
	  				<input type="hidden" id="reportCategory"/>
	  				<input type="hidden" id="originIdx"/>
	  				<input type="hidden" id="reportHostIp" value="${pageContext.request.remoteAddr}"/>
		  			
		  			<div class="row ml-4 mr-3 mt-2 mb-4">
		  				<div class="col">
				  			<div>
				  				<span style="color:red"><i class="fa-solid fa-triangle-exclamation" style="font-size:17px; margin-bottom:15px"></i>&nbsp;&nbsp;신고 철회는 불가능합니다.</span><br/>
				  				<span>
				  					신고자 : <b>
				  					<c:if test="${empty sNickname}">비회원은 신고하실 수 없습니다.</c:if>
				  					<c:if test="${!empty sNickname}">${sNickname}</c:if>
			  						</b>
				  				</span><br/>
				  				<span>원본 작성자 : <b><input type="text" id="originWriter" style="background-color:transparent; border:0px" readonly/></b></span>
				  			</div>
		  				</div>
		  			</div>
				  </div>
				  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="reportInsert()">신고</button>
        </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>