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
    	overflow: auto;
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
		/* .infoBox {
			width:1000px;
	  	height:100px;
	    white-space:nowrap; 
			overflow-x:scroll; 
		} */
		
		div.infoBox {
		  overflow-x:scroll;
		  white-space: nowrap;
		}
		
		div.infoBox span {
		  display: inline-block;
		  color: rgb(0, 0, 0);
		  text-align: center;
		  text-decoration: none;
		  padding: 14px;
		}
	</style>
	<script>
		'use strict'
		
		// 팝업 닫기
		function cancel() {
			window.close();
		}
		
		// 회원 상세페이지에서 기록 상세페이지로 가는 길목에 있는 경우
		$(document).ready(function(){
			if(localStorage.getItem('memPageReflectionSW') == 'ON') {
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
		
		// 회원 페이지 열기
  	function memPage(memNickname) {
			let url = "${ctp}/community/memPage?memNickname="+memNickname;
	
			let popupWidth = 800;
			let popupHeight = 1200;
	
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'memPage', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}

		// 책 저장
		function bookSelection(categoryName, title, publisher) {
			if('${sNickname}' == "") {
				alert('로그인 후 이용해주세요.');
				return false;
			}
			
			let ans = confirm('책을 저장하시겠습니까?');
			if(!ans) return false;
				
			$.ajax({
				type : "post",
				url : "${ctp}/community/bookSaveInsert",
				data : {
					memNickname : '${sNickname}',
					title : title,
					publisher : publisher,
					categoryName : categoryName
				},
				success : function() {
					alert('책이 저장되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
	</script>
</head>
<body style="overflow-X:hidden"> 
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="introBox">
				<div style="background-color:#eee; padding:10px">
					<div class="row" style="margin-top:10px">
						<div class="col text-right mr-3">
							<a href="javascript:cancel()"><i class="fa-solid fa-x" style="font-size:25px; font-weight:bold"></i></a>
						</div>
					</div>
					<div class="row">
						<div class="col-3 text-center">
							<img src="${bookVO.thumbnail}"/><br/><br/>
							<a href="${bookVO.url}" target="_blank"><u>Daum다음에서 보기</u></a>
							<div class="dropdown bookEditBtn1" style="margin-top:10px">
						    <button type="button" class="btn btn-dark btn-sm dropdown-toggle" data-toggle="dropdown">
						      저장&nbsp;&nbsp;<i class="fa-regular fa-folder-closed"></i>
						    </button>
						    <div class="dropdown-menu">
						      <a class="dropdown-item" href="javascript:bookSelection('인생책','${bookVO.title}','${bookVO.publisher}')">추천책</a>
						      <a class="dropdown-item" href="javascript:bookSelection('추천책','${bookVO.title}','${bookVO.publisher}')">추천책</a>
						      <a class="dropdown-item" href="javascript:bookSelection('읽은책','${bookVO.title}','${bookVO.publisher}')">읽은책</a>
						      <a class="dropdown-item" href="javascript:bookSelection('관심책','${bookVO.title}','${bookVO.publisher}')">관심책</a>
						    </div>
						  </div>
						</div>
						<div class="col-9 text-left">
							<span class="text-center" style="font-size:20px; text-align:center; font-weight:bold">${bookVO.title}</span><br/>
							<span class="text-center" style="font-size:18px; text-align:center;">${bookVO.authors}   |    ${bookVO.publisher}</span>
							<div class="alert alert-success mr-5 mt-3">
						    소개글)&nbsp;&nbsp;&nbsp;&nbsp;
						    <c:if test="${(bookVO.contents == '') || (empty bookVO.contents)}">소개글이 없습니다</c:if>
						    <c:if test="${bookVO.contents != ''}"><strong>${bookVO.contents}...</strong></c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row text-center" style="margin:50px 10px 40px 10px">
		<div class="col">
			<a href="${ctp}/community/bookPage?idx=${bookVO.idx}"><span class="mr-5">서재 / 기록</span></a>
			<a href="${ctp}/community/bookPage/inspired?idx=${bookVO.idx}"><span class="nowPart mr-5">문장수집</span></a>
			<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
		</div>
	</div>
	
		<!-- 문장수집 -->
	<div style="padding:30px">
		<div class="text-center mb-2"><span style="font-size:25px"><i class="fa-solid fa-highlighter" style="font-size:20px;"></i>&nbsp;&nbsp;&nbsp;이 책으로 수집된 문장</span></div>
		<c:if test="${empty inspiredVOS}">
			<hr/>
			<div class="text-center" style=""><b>아직 수집된 문장이 없습니다.</b></div> 
		</c:if>
		
		<c:if test="${!empty inspiredVOS}">
			<div style="overflow:scroll; width:100%; height:600px; padding:30px; margin-bottom:40px; background-color:#fff">
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
							    	<a href="javascript:memPage('${inspiredVO.memNickname}')"><span>by. ${inspiredVO.memNickname}</span></a>
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
	</div>
		
	
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