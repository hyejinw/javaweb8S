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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
		
		// 문장 삽입 관련해, location.reload() 되었다면 그 상태 유지
		$(document).ready(function(){
			if(sessionStorage.getItem('inspiredSW') == 'ON') {
				sessionStorage.removeItem('inspiredSW');
				document.getElementById('inspiredBtn').click();
			}
		});
		
		function openCity(evt, cityName) {
		  var i, x, tablinks;
		  x = document.getElementsByClassName("city");
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablink");
		  for (i = 0; i < x.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" w3-blue", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.className += " w3-blue";
		}
		
		// 댓글 작성
		function replyInsert() {
		
			if('${sNickname}' == "") {
				alert('로그인 후 이용해주세요.');
				return false;
			}

			let replyHostIp = document.getElementById('replyHostIp').value; 
			let replyContent = document.getElementById('replyContent').value; 
			//let regex1 = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\'\"\s\-_+<>@\#$%&\\\=\(]$/g; 
			// (댓글)한글,영문,숫자,특수문자 허용
			
			if(replyContent == ''){
				alert('댓글을 작성해주세요.');
				document.getElementById('replyContent').focus();
		    return false;
		  }
			
/* 			if(!regex1.test(replyContent)){
				alert('댓글을 알맞게 입력해주세요.(한글/영문/숫자/특수문자 허용)');
				document.getElementById('replyContent').focus();
		    return false;
		  }
			 */
			$.ajax({
				type : "post",
				url : "${ctp}/community/replyInsert",
				data : {
					memNickname : '${sNickname}',
					refIdx : ${vo.idx},
					content : replyContent,
					replyHostIp : replyHostIp
				},
				success : function() {
					alert('댓글이 등록되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 대댓글 작성
		function reReplyInsert() {
		
			if('${sNickname}' == "") {
				alert('로그인 후 이용해주세요.');
				return false;
			}

			let replyHostIp = document.getElementById('replyHostIp').value; 
			let replyContent = document.getElementById('replyContent').value; 

			if(replyContent == ''){
				alert('댓글을 작성해주세요.');
				document.getElementById('replyContent').focus();
		    return false;
		  }
			
			let mentionedNickname = document.getElementById('mentionedNickname').value;
			let groupId = document.getElementById('groupId').value;
			let level = document.getElementById('level').value;
		
			alert(mentionedNickname);
			alert(groupId);
			alert(level);
			
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/reReplyInsert",
				data : {
					memNickname : '${sNickname}',
					refIdx : ${vo.idx},
					content : replyContent,
					replyHostIp : replyHostIp,
					mentionedNickname : mentionedNickname,
					groupId : groupId,
					level : level
				},
				success : function() {
					alert('댓글이 등록되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 대댓글 창 열기
		function reReply(mentionedNickname, content, groupId, level) {
			let subStringContent = content.substring(0,20);
			
			let str = '';
			
			str += '<div style="padding:0px 16px 0px 16px;">';
			str += '<div class="row mt-3" style="background-color:rgba(254, 251, 232); border-radius:10px; padding:10px;">';

			str += '<div class="col-10">';
			str += '<a href="${ctp}/community/memPage?nickname='+mentionedNickname+'">';
			str += '<span style="color:grey">@'+mentionedNickname+'</span>';
			str += '</a>';
			str += '&nbsp;&nbsp;&nbsp;';
			str += '<span>'+subStringContent+'';
			str += '</span>';
			str += '</div>';
			
			str += '<div class="col-2 text-right">';
			str += '<a href="javascript:reReplySectionDel()">';
			str += '<i class="fa-regular fa-circle-xmark" style="font-size:25px"></i>';
			str += '</a>';
			str += '</div>';

			str += '<input type="hidden" id="mentionedNickname" value="'+mentionedNickname+'"/>';
			str += '<input type="hidden" id="groupId" value="'+groupId+'"/>';
			str += '<input type="hidden" id="level" value="'+level+'"/>';
			str += '</div>';
			str += '</div>';
			
			document.getElementById('reReplySection').innerHTML = str;
			
			// 버튼 변경
			$('#replyBtn').css('display','none');
			$('#reReplyBtn').css('display','inline-block');
		}
		
		// 대댓글 창 삭제
		function reReplySectionDel() {
			location.reload();
		}
		
		// 기록 저장
		function save() {
			if('${sNickname}' == "") {
				alert('로그인 후 사용해주세요.');
				return false;
			}
			
			if('${saveVO}' == "") {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/community/refSave",
	    		data  : {
					  memNickname  : '${sNickname}',
					  refIdx : ${vo.idx},
					},
	    		success:function() {
	    			alert("기록이 저장되었습니다.");
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
	    		url   : "${ctp}/community/refSaveDelete",
	    		data  : {
	    			memNickname  : '${sNickname}',
					  refIdx : ${vo.idx},
					},
	    		success:function() {
	    			alert("기록 저장이 취소되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
		}
		
		// 문장 수집 작성
		function inspiredInsert() {
			let insContent = document.getElementById('insContent').value; 
			let page = document.getElementById('page').value; 
			let explanation = document.getElementById('explanation').value; 
			let insHostIp = document.getElementById('insHostIp').value; 

			if(insContent == '') {
				alert('문장 수집란을 완성해주세요.');
				document.getElementById('insContent').focus();
		    return false;
		  }
			if(page == '') {
				alert('페이지 및 기타 정보를 작성해주세요.');
				document.getElementById('page').focus();
		    return false;
		  }
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/inspiredInsert",
				data : {
					memNickname : '${sNickname}',
					bookIdx : ${vo.bookIdx},
					insContent : insContent,
					page : page,
					explanation : explanation,
					insHostIp : insHostIp
				},
				success : function() {
					alert('문장 수집이 등록되었습니다.');
					sessionStorage.setItem('inspiredSW', 'ON'); 
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
	    			sessionStorage.setItem('inspiredSW', 'ON'); 
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
	    			sessionStorage.setItem('inspiredSW', 'ON'); 
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
		}
		
		
		// 문장 수집 삭제
		function inspiredDelete(inspiredIdx) {
			let ans = confirm('삭제 후 복구 불가능합니다. 삭제하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
    		type  : "post",
    		url   : "${ctp}/community/inspiredDelete",
    		data  : { idx : inspiredIdx },
    		success:function() {
    			alert("문장수집이 삭제되었습니다.");
    			sessionStorage.setItem('inspiredSW', 'ON'); 
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
		}
		
		// 댓글 수정창
		function replyEditOpen(content) {
			document.getElementById('replyEditContent').value = content;
			
			// 입력값 끝에 커서 주기 == 안 된다ㅜ
			let contentValue = $('#replyEditContent').val();
      $('#replyEditContent').focus().val('').val(contentValue);
		}
		
		// 문장 수집 수정창
		function inspiredEditOpen(idx, insContent, page, explanation) {
			document.getElementById('insEditIdx').value = idx;
			document.getElementById('insEditContent').value = insContent;
			document.getElementById('editPage').value = page;
			document.getElementById('editExplanation').value = explanation;
		}
		
		// 문장 수집 수정
		function inspiredEdit() {
			let idx = document.getElementById('insEditIdx').value;
			let insContent = document.getElementById('insEditContent').value;
			let page = document.getElementById('editPage').value;
			let explanation = document.getElementById('editExplanation').value;
			
			if(insContent == '') {
				alert('문장 수집란을 완성해주세요.');
				document.getElementById('insEditContent').focus();
		    return false;
		  }
			if(page == '') {
				alert('페이지 및 기타 정보를 작성해주세요.');
				document.getElementById('editPage').focus();
		    return false;
		  }
			
			$.ajax({
				type : "post",
				url : "${ctp}/community/inspiredUpdate",
				data : {
					idx : idx,
					insContent : insContent,
					page : page,
					explanation : explanation
				},
				success : function() {
					alert('문장 수집이 수정되었습니다.');
					sessionStorage.setItem('inspiredSW', 'ON'); 
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
			
  </script>
</head>
<body>
<div id="back-to-top"></div>
<jsp:include page="/WEB-INF/views/community/communityMenu.jsp" />
	
	<!-- Page Content -->
	<div id="main">
		<a href="${ctp}/community/communityMain">
			<img src = "${ctp}/images/communityBanner.png" style="width: 100%; max-width:2000px"/>
		</a>
		
		
	  <div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/community/reflection" style="margin-left:20px;"><i class="fa-solid fa-chevron-left"></i></a>
	 				</div>
	 				<div class="col text-right">
					  <a class="btn btn-warning" href="javascript:insert()" style="margin-right:20px;"><i class="fa-solid fa-share-from-square"></i>카카오톡공유</a>
	 				</div>
	 			</div>
				<div style="text-align:center">
					<span class="text-center" style="font-size:30px; text-align:center; font-weight:500">${vo.title}</span>
				
					<c:if test="${(vo.memNickname == sNickname)}">&nbsp;&nbsp;
	  				<a href="${ctp}/community/reflectionUpdate?idx=${vo.idx}">
							<i class="fa-regular fa-pen-to-square" style="font-size:20px"></i>
						</a>			
					</c:if>	
				
					<br/>
					<a href="${ctp}/"><span class="text-center" style="font-size:20px; text-align:center; color:grey">by. ${vo.memNickname}</span></a><br/>
					<span class="text-center" style="font-size:14px; text-align:center;">${fn:substring(vo.refDate,0,19)}</span>
				</div>
				<div class="row">
					<div class="col ml-5">
						<a href="#replySection" class="btn btn-outline-primary">댓글(${replyNum})</a>
					</div>
					<div class="col text-right mr-5">
						<span style="font-size:28px">
							<c:if test="${empty saveVO}"><i class="fa-regular fa-bookmark save" onclick="save()" title="관심등록되지 않은 기록입니다"></i></c:if>
							<c:if test="${!empty saveVO}"><i class="fa-solid fa-bookmark save" onclick="save()" title="관심등록된 기록"></i></c:if>
						</span>
					</div>
				
				</div>
				<hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
	 		</div>
			
			<div style="padding:20px 20px 50px 20px;">
				<c:if test="${vo.bookIdx != ''}">
					<div class="text-center">
						<a href="${ctp}/community/bookPage?idx=${vo.bookIdx}"><h4><b>『 ${vo.bookTitle} 』</b></a></h4>
						<a href="${ctp}/community/bookPage?idx=${vo.bookIdx}"><img src="${vo.thumbnail}" /></a><br/><br/>
					</div>
				</c:if>
				${vo.content}
			  <hr style="border:0px; height:1.0px; background:#41644A; margin:10px 0px"/>
			</div>
		  
		  <div id="replySection">
	  	  <div class="w3-bar">
			    <button class="w3-bar-item w3-button tablink w3-blue" <c:if test="${vo.bookIdx != ''}">onclick="openCity(event,'reply')"</c:if>>댓글(${replyNum})</button>
			    <c:if test="${vo.bookIdx != ''}"><button id="inspiredBtn" class="w3-bar-item w3-button tablink" onclick="openCity(event,'inspired')">문장 수집(${inspiredNum})</button></c:if>
			  </div>
			  
			  <div id="reply" class="w3-border city">
			  	
			  	<div class="w3-container w3-border" style="background-color:#eee">
			  		<div id="reReplySection"></div>
		  			<textarea rows="4" cols="10" id="replyContent" class="form-control mt-3" placeholder="댓글을 남겨주세요."></textarea>
		  			<input type="hidden" id="replyHostIp" value="${pageContext.request.remoteAddr}"/>
		  			<div class="text-right mr-3 mt-2 mb-3"><button class="btn btn-dark" id="replyBtn" onclick="replyInsert()">작성</button></div>
		  			<div class="text-right mr-3 mt-2 mb-3"><button class="btn btn-dark" id="reReplyBtn" onclick="reReplyInsert()" style="display:none">작성</button></div>
				  </div>
				  
					<c:forEach var="replyVO" items="${replyVOS}"> 
				  	<div class="row mt-4">
				  		<div class="col-2 text-right">
					  		<a href="${ctp}/community/memPage?nickname=${replyVO.memNickname}">
					  			<img src="${ctp}/admin/member/${replyVO.memPhoto}" class="rounded-circle" style="width:30px"/>
				  			</a>
				  		</div>
				  		<div class="col-8">
				  			<a href="${ctp}/community/memPage?nickname=${replyVO.memNickname}">
				  				<span style="color:grey">${replyVO.memNickname}</span><br/>
				  			</a>
				  			<p>
				  				${replyVO.content}
									<c:if test="${(replyVO.memNickname == sNickname)}">&nbsp;&nbsp;
					  				<a href="#" onclick="replyEditOpen('${replyVO.content}')" data-toggle="modal" data-target="#replyEditModal">
											<i class="fa-regular fa-pen-to-square"></i>
										</a>			
									</c:if>				  			
				  			</p>
				  		</div>
				  		<div class="col-2">
				  			<c:if test="${(replyVO.memNickname == sNickname) || (sMemType == '관리자')}">
				  				<a href="javascript:replyDelete('${replyVO.idx}')">
				  					<i class="fa-solid fa-xmark" style="font-size:23px"></i>
				  					&nbsp;&nbsp;&nbsp;
				  				</a>
				  			</c:if>
				  			<a href="javascript:reReply('${replyVO.memNickname}','${replyVO.content}','${replyVO.groupId}','${replyVO.level}')">
				  				<i class="fa-solid fa-comments" style="font-size:18px"></i>
			  				</a>&nbsp;&nbsp;&nbsp;
				  			<button class="btn btn-sm btn-outline-secondary">신고</button>
				  		</div>
				  	</div>
				  		
		  			<hr style="margin:0px"/>
					</c:forEach>
			  </div>
			
			  <div id="inspired" class="w3-border city" style="display:none">
			  
			  	<div class="w3-container w3-border" style="background-color:#eee;">
			  		<div class="row">
			  			<div class="col-8">
				  			<textarea rows="4" cols="10" id="insContent" class="form-control mt-3" placeholder="여기에 문장을 입력해주세요."></textarea>
			  			</div>
			  			<div class="col-4">
				  			<textarea rows="4" cols="10" id="explanation" class="form-control mt-3" placeholder="추가 설명을 적어주세요(선택)."></textarea>
			  			</div>
			  		</div>
		  			<input type="hidden" id="insHostIp" value="${pageContext.request.remoteAddr}"/>
		  			<input type="text" id="page" class="form-control mt-3" placeholder="페이지 및 기타 정보  예) p.29"/>
		  			<hr style="border:0px; height:2px; width:200px; background:#41644A; margin:10px 0px"/>
		  			
		  			<div class="row ml-4 mr-3 mt-2 mb-4">
		  				<div class="col">
				  			<div>
				  				<a href="${ctp}/community/bookPage?idx=${vo.bookIdx}">
					  				<h3><b>${vo.bookTitle}</b><br/></h3>
				  				</a>
				  				<span>출판사 : ${vo.publisher}</span><br/>
				  				<span>저자 : ${vo.authors}</span>
				  				<input type="hidden" id="bookIdx" value="${vo.bookIdx}"/>
				  			</div>
		  				</div>
		  			
		  				<div class="col">
				  			<div class="text-right"><button class="btn btn-dark" onclick="inspiredInsert()">작성</button></div>
		  				</div>
		  			
		  			</div>
				  </div>
				  
				  <c:forEach var="inspiredVO" items="${inspiredVOS}"> 
				    <div class="w3-panel w3-sand" style="margin:15px">
					    
					    <div class="row">
					    	<div class="col-11">
					    	
							    <span style="font-size:80px; line-height:0.6em; opacity:0.2">❝</span>
							    <p class="w3-xlarge" style="margin:-40px 0px 0px 0px; padding:10px"><i style="font-size:19px;">${inspiredVO.insContent}</i>
							    	<c:if test="${(inspiredVO.memNickname == sNickname)}">&nbsp;
						  				<a href="#" onclick="inspiredEditOpen('${inspiredVO.idx}','${inspiredVO.insContent}','${inspiredVO.page}','${inspiredVO.explanation}')" data-toggle="modal" data-target="#inspiredEditModal">
												<i class="fa-regular fa-pen-to-square" style="font-size:16px"></i>
											</a>			
									</c:if>	
							    </p>
					    	
					    	</div>
					    	<div class="col-1 mt-4 text-right">
					    		<c:if test="${(replyVO.memNickname == sNickname) || (sMemType == '관리자')}">
					  				<a href="javascript:inspiredDelete('${inspiredVO.idx}')">
					  					<i class="fa-solid fa-xmark" style="font-size:30px"></i>
					  					&nbsp;&nbsp;&nbsp;
					  				</a>
					  			</c:if>
					    	</div>
					    </div>
					    
				    	<p class="ml-4" style="color:grey;">『 ${vo.bookTitle} 』(${vo.authors})&nbsp;&nbsp;${inspiredVO.page}</p>
					    <hr style="margin:0px"/>
					    <div class="row">
					    	<div class="col">
							    <div style="padding:10px">
							    	<a href="${ctp}/community/memPage?nickname=${inspiredVO.memNickname}"><span>by. ${inspiredVO.memNickname}</span></a>
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
					  				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-sm btn-outline-secondary">신고</button>
					    		</div>
					    	</div>
					    </div>
					  </div>
					  <hr style="margin:0px"/>
				  </c:forEach>
				  
				  
			  </div>
			  
			  
			</div>
			
					  
		</div>
	  
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	
	
	<!-- The Modal -->
  <div class="modal fade" id="replyEditModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">댓글 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee">
		  			<textarea rows="4" cols="10" id="replyEditContent" style="margin:15px 0px" class="form-control mt-3" placeholder="댓글을 남겨주세요." autofocus></textarea>
				  </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">수정</button>
        </div>
        
      </div>
    </div>
  </div>
	
	
	<!-- The Modal -->
  <div class="modal fade" id="inspiredEditModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">문장수집 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee;">
			  		<div class="row">
			  			<div class="col-8">
				  			<textarea rows="4" cols="10" id="insEditContent" class="form-control mt-3" placeholder="여기에 문장을 입력해주세요."></textarea>
			  			</div>
			  			<div class="col-4">
				  			<textarea rows="4" cols="10" id="editExplanation" class="form-control mt-3" placeholder="추가 설명을 적어주세요(선택)."></textarea>
			  			</div>
			  		</div>
		  			<input type="text" id="editPage" class="form-control mt-3" placeholder="페이지 및 기타 정보  예) p.29"/>
		  			<hr style="border:0px; height:2px; width:200px; background:#41644A; margin:10px 0px"/>
		  			
		  			<div class="row ml-4 mr-3 mt-2 mb-4">
		  				<div class="col">
				  			<div>
				  				<a href="${ctp}/community/bookPage?idx=${vo.bookIdx}">
					  				<h3><b>${vo.bookTitle}</b><br/></h3>
				  				</a>
				  				<span>출판사 : ${vo.publisher}</span><br/>
				  				<span>저자 : ${vo.authors}</span>
				  				<input type="hidden" id="insEditIdx"/>
				  			</div>
		  				</div>
		  			
		  			</div>
				  </div>
				  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="inspiredEdit()">수정</button>
        </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>