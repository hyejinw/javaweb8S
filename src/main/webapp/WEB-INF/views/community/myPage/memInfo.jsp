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
		
		// 로그아웃
		function logout() {
			let ans = confirm('책(의)세계에서 로그아웃하시겠습니까?');
			if(!ans) return false;
			
			location.href = "${ctp}/member/memberLogout";
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
		
		// 회원 프로필 변경
		function memPhotoEdit() {
			let memPhoto = document.getElementById('memPhoto').value; 
			let ext = memPhoto.substring(memPhoto.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			
		 	let defaultPhoto = $("input[type=radio][name=defaultPhoto]:checked").val();
			
			if((memPhoto.trim() == "") && (defaultPhoto == "defaultPhotoNone")) {
				alert("사진을 업로드해주세요.");
				return false;
			}
			
			if(defaultPhoto == "defaultPhotoNone") {
				let fileSize = memPhotoUpdate.file.files[0].size;
				if(ext != "JPG" && ext != "PNG" && ext != "JPEG") {
					alert("업로드 가능한 사진 파일은 'jpg/jpeg 또는 png' 입니다.");
					return false;
				}
				if(fileSize > maxSize) {
					alert("업로드 파일의 최대용량은 20MByte 입니다.");
					return false;
				}
			}
			
			memPhotoUpdate.submit();
		}
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('photoDemo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  
			}
			else {
				document.getElementById('photoDemo').src = "";
			}
		}
		
		// 파일 업로드 활성화/비활성화
		$(document).ready(function(){
 
	    // 라디오버튼 클릭시 이벤트 발생
	    $("input:radio[name=defaultPhoto]").click(function(){
	 
	        if($("input[name=defaultPhoto]:checked").val() == "defaultPhotoNone"){
	          $("input:file[name=file]").attr("disabled",false);
	          // radio 버튼의 value 값이 defaultPhotoNone이라면 활성화
	 
	        } else if($("input[name=defaultPhoto]:checked").val() != "defaultPhotoNone"){
	            $("input:file[name=file]").attr("disabled",true);
	            
	            document.getElementById('memPhoto').value = "";
	            document.getElementById('photoDemo').src = "";
	          // radio 버튼의 value 값이 defaultPhotoNone이라면 비활성화
	        }
	    });
		});

		// 소개글 수정창
		function introductionEditOpen() {
			$("#introduction").attr("disabled", false);
			$("#introductionEditBtn").css('display', 'inline-block');
			$("#introductionCancelBtn").css('display', 'inline-block');
		}
		
		// 소개글 수정
		function introductionUpdate() {
			let introduction = document.getElementById('introduction').value;
			
			$.ajax({
				type : "post",
				data : { 
					introduction : introduction,
					nickname : '${sNickname}'
				},
				url : "${ctp}/community/introductionUpdate",
				success : function() {
					alert('소개글이 수정되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			})
		}
		
		// 회원 차단 해제
		function blockDelete(blockedNickname) {
			let ans = confirm('차단 해제하시겠습니까?');
			if(!ans) return false;
			
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/community/blockDelete",
    		data  : {
    			memNickname  : '${sNickname}',
				  blockedNickname : blockedNickname
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
		
		// 신고 모달창에 값 주기
		function reportCategory(reportCategory, originWriter, originIdx) {
			document.getElementById('reportCategory').value = reportCategory;
			document.getElementById('originWriter').value = originWriter;
			document.getElementById('originIdx').value = originIdx;
		}
		
		// 신고
		function reportInsert() {
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
		
		// 차단할 회원 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
				document.getElementById('searchString').focus();
    		return false;
    	}
    	
    	$.ajax({
				type : "post",
				url : "${ctp}/community/blockMemSearch",
				data : { 
					searchString : searchString,
					memNickname : '${sNickname}'
				},
				success : function(searchVOS) {
					document.getElementById('searchString').focus();
					
					let str = '';
					
					/* 이거 왜 선이 생기지? */
					
					if(searchVOS.length == 0) {
						str += '<table class="table" style="width:80%; margin:0px auto">';
						str += '<tr>';
						str += '<td class="text-center">';
						str += '<b>찾으시는 회원이 없습니다.</b>';
						str += '</td>';
						str += '</tr>';
						str += '<tr><td></td></tr>';
						str += '</table>';
					}
					else {
						str += '<table class="table" style="width:80%; margin:0px auto">';
						for(var i=0; i< searchVOS.length; i++) {
							str += '<tr>';
							str += '<td colspan="2">';
							str += searchVOS[i].nickname;
							str += '</td>';
							str += '<td class="text-right mr-5">';
							str += '<button type="button" onclick="block(\''+searchVOS[i].nickname+'\')" class="btn btn-sm btn-danger">차단</button>';
							str += '</td>';
							str += '</tr>';
						}
						str += '<tr><td colspan="3"></td></tr>';
						str += '</table>';
					}
					
					document.getElementById('demo').innerHTML = str;
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			}); 
		}
		
		// 회원 차단
		function block(nickname) {
			
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/community/blockInsert",
    		data  : {
				  memNickname  : '${sNickname}',
				  blockedNickname : nickname
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
						<img src="${ctp}/resources/data/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="text-center" style="font-size:20px; text-align:center; font-weight:bold">${memberVO.nickname}</span>
						&nbsp;&nbsp;&nbsp;
					</div>
					<div class="col text-right mr-5">
						<button class="btn btn-secondary" onclick="logout()">로그아웃</button>
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
					<a href="${ctp}/community/myPage/reply?memNickname=${memberVO.nickname}"><span class="mr-5">작성 댓글</span></a>
					<c:if test="${memberVO.nickname == sNickname}">
						<a href="${ctp}/community/myPage/memInfo?memNickname=${memberVO.nickname}"><span class="nowPart mr-5">회원 정보</span></a>
						<a href="${ctp}/community/myPage/ask?memNickname=${memberVO.nickname}"><span>문의 / 신고</span></a>
					</c:if>
					<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
				</div>
	 		</div>
	 		
	 		<div style="padding:20px 50px 50px 50px;">
				<i class="fa-solid fa-circle-user" style="font-size:48px;"></i>
				<span style="font-size:30px; margin-left:20px">회원 정보</span>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<span> ※ 기본 회원정보 변경은 &nbsp;<b>책(의)세계</b>&nbsp; 마이페이지에서 가능합니다. ※</span>
			</div> 	
			
			<div style="margin:0px 50px 0px 50px">
				<table class="table table-bordered">
		      <tr>
		        <th class="text-center">
		        	소개글&nbsp;&nbsp;&nbsp;
		        	<a href="javascript:introductionEditOpen()">
								<i class="fa-regular fa-pen-to-square" style="font-size:16px"></i>
							</a>
		        </th>
		        <td>
		        	<textarea rows="4" id="introduction" class="form-control" disabled>${memberVO.introduction}</textarea>
		        	<button type="button" id="introductionEditBtn" onclick="introductionUpdate()" class="btn btn-outline-success btn-sm mt-3 mr-3" style="display:none">수정</button>
		        	<button type="button" id="introductionCancelBtn" onclick="javascript:location.reload();" class="btn btn-outline-dark btn-sm mt-3" style="display:none">취소</button>
		        </td>
		      </tr>
		      <tr>
		        <th class="text-center">프로필 사진<br/>
							<span style="font-size:12px">(클릭 시, 변경가능)</span>
						</th>
		        <td>
			        <a href="#" data-toggle="modal" data-target="#memPhotoEditModal">
			        	<img src="${ctp}/resources/data/admin/member/${memberVO.memPhoto}" class="rounded-circle" style="width:100%; max-width:80px"/>
			        </a>
		       </td>
		      </tr>
		      <tr>
		        <th class="text-center">아이디</th>
		        <td>${memberVO.mid}</td>
		      </tr>
		      <tr>
		        <th class="text-center">성명</th>
		        <td>${memberVO.name}</td>
		      </tr>
		      <tr>
		        <th class="text-center">별명</th>
		        <td>${memberVO.nickname}</td>
		      </tr>
		      <tr>
		        <th class="text-center">이메일</th>
		        <td>${memberVO.email}</td>
		      </tr>
		      <tr>
		        <th class="text-center">전화번호</th>
		        <td>${memberVO.tel}</td>
		      </tr>
			  </table>
			</div>

			<div style="padding:100px 50px 50px 50px;">
				<i class="fa-solid fa-user-slash" style="font-size:46px;"></i>
				<span style="font-size:30px; margin-left:20px">차단 회원</span>
				&nbsp;&nbsp;&nbsp;&nbsp;<!-- 여기에 링크 달면 좋겠다! -->
				<span> ※ 차단 회원과는 &nbsp;<b>쪽지</b>&nbsp; 이용이 불가능합니다. ※</span>
			</div> 	
			
			<div style="margin:0px 50px 150px 50px">
				<div class="row">
					<div class="col-7">
						<table class="table">
							<thead class="">
					      <tr class="text-center">
					        <th>No.</th>
					        <th>회원 별명</th>
					        <th>선택</th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:if test="${empty blockVOS}">
					    		<tr><td colspan="3" class="text-center" style="padding:30px"><b>차단한 회원이 없습니다.</b></td></tr> 
					    	</c:if>
					    	
					    	<c:if test="${!empty blockVOS}">
						    	<c:forEach var="blockVO" items="${blockVOS}" varStatus="st"> 
						    		<tr>
						    			<td class="text-center">${st.count}</td>
						    			<td class="text-center">
										  	${blockVO.blockedNickname}
						    			</td>
						    			<td class="text-center">
						    				<button type="button" class="btn btn-sm btn-outline-success" onclick="blockDelete('${blockVO.blockedNickname}')">차단 해제</button>
						    				<a href="#" class="btn btn-sm btn-outline-secondary ml-4" onclick="reportCategory('회원','${blockVO.blockedNickname}','${blockVO.blockedMemIdx}')" data-toggle="modal" data-target="#reportModal">
													신고
												</a>
						    			</td>
						    		</tr>
									</c:forEach>
					    	</c:if>
					    	<tr><td colspan="3"></td></tr> 
					    </tbody>
					  </table>
					</div>
					
					<div class="col-5">
						<form name="searchForm" onsubmit="return false;">
	          	<div class="input-group" style="margin:0px auto; width:80%">
					      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control" placeholder="회원 별명을 입력해주세요" />
					      <div class="input-group-append">
					     		<a href="#" class="btn btn-outline-success my-2 my-sm-0" onclick="searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#0cc621;"></i></a>
					     	</div>
				     	</div>
				    </form>
						
						<div id="demo" class="mt-5" style="background-color:#eee; margin:0px 30px 0px 30px"></div>
					</div>
					
				</div>
			</div>

  </div>
  
    <!-- The Modal -->
  <div class="modal fade" id="memPhotoEditModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">프로필 사진 변경</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee; padding:30px">
          	<form name="memPhotoUpdate" method="post" action="${ctp}/community/myPage/memPhotoUpdate" enctype="multipart/form-data">
				  		<div class="row">
				  			<div class="col-8">
					  			<input type="file" name="file" id="memPhoto" onchange="imgCheck(this)" class="form-control-file border form-control"/>
				  				<input type="hidden" name="memPhoto" value="${memberVO.memPhoto}"/>
				  				<input type="hidden" name="nickname" value="${memberVO.nickname}"/>
				  				<br/><br/>
  								<label for="defaultPhotoNone"><span style="padding:20px; border-radius:50%; background-color:#ddd">직접 선택</span></label>
				  				<input type="radio" id="defaultPhotoNone" name="defaultPhoto" value="defaultPhotoNone" checked/>
				  				&nbsp;&nbsp;&nbsp;&nbsp;
  								<label for="defaultImage"><img src="${ctp}/resources/data/admin/member/defaultImage.jpg" style="width:80px"/></label>
				  				<input type="radio" id="defaultImage" name="defaultPhoto" value="defaultImage.jpg"/>
				  				&nbsp;&nbsp;&nbsp;&nbsp;
				  				<c:forEach var="i" begin="1" end="6">
	  								<label for="defaultPhoto${i}"><img src="${ctp}/resources/data/admin/member/defaultPhoto${i}.png" style="width:80px"/></label>
					  				<input type="radio" id="defaultPhoto${i}" name="defaultPhoto" value="defaultPhoto${i}.png" />
					  				&nbsp;&nbsp;&nbsp;&nbsp;
				  				</c:forEach>
				  			</div>
				  			<div class="col-4">
					  			<img id="photoDemo" width="200px"/>
				  			</div>
				  		</div>
          	</form>
          	
				  </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="memPhotoEdit()">변경</button>
        </div>
        
      </div>
    </div>
  </div>
  
  	<!-- The Modal -->
  <div class="modal fade" id="reportModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
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
				  					신고자 : <b>${sNickname}</b>
				  				</span><br/>
				  				<span>해당 회원 : <b><input type="text" id="originWriter" style="background-color:transparent; border:0px" readonly/></b></span>
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
	
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
  </div>
</body>
</html>