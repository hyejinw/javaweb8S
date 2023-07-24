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
		
		// 문의 검색 + 분류 검색
		function searchCheck() {
			let sort = $("#sort").val();
	    	
    	location.href = "${ctp}/community/myPage/report?memNickname=${memberVO.nickname}&sort="+sort;
		}
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		/* 개별 박스 선택할 때도 똑같이 처리 */
		function tempCheckChange() {
			
			// 전체 해제한 경우 '전체 선택' 체크박스도 해제시켜주기
			if($( "input[name='checkRow']:checked" ).length == 0) {
				$("input[name=checkAll]").prop("checked", false);
			}
			
			// 전체 선택한 경우 '전체 선택' 체크박스도 선택시켜주기 (전체 상품 개수에서 품절 개수는 제외)
			if($( "input[name='checkRow']:checked" ).length == (${reportNum} - ${reportYetDoneNum})) {
				$("input[name=checkAll]").prop("checked", true);
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
		    alert("삭제할 신고를 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 신고를 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/community/reportIdxesDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
    				alert("선택한 신고가 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 신고 상세창 값 전달
		function reportDetail(idx) {
			document.getElementById('reportCategory').value = document.getElementById('reportCategory'+idx).value;
			document.getElementById('message').value = document.getElementById('message'+idx).value;
			if(document.getElementById('reply'+idx).value == '') {
				document.getElementById('reply').value = '(신고처리 진행 중입니다)';
			}
			else {
				document.getElementById('reply').value = document.getElementById('reply'+idx).value;
			}
			document.getElementById('reportDone').value = document.getElementById('reportDone'+idx).value;
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
						<a href="${ctp}/community/myPage/memInfo?memNickname=${memberVO.nickname}"><span class="mr-5">회원 정보</span></a>
						<a href="${ctp}/community/myPage/ask?memNickname=${memberVO.nickname}"><span class="nowPart">문의 / 신고</span></a>
					</c:if>
					<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
				</div>
	 		</div>
	 		
	 		<div style="padding:20px 50px 50px 50px;">
	 			<div class="row">
	 				<div class="col-9">
						<i class="fa-solid fa-triangle-exclamation" style="font-size:48px;"></i>
						<span style="font-size:30px; margin-left:20px">신고</span>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<span> ※ 신고 철회 / 수정은 <b>불가</b>합니다. 처리완료된 신고만 삭제가 가능합니다.※</span>
	 				</div>
	 				<div class="col-3 text-right">
	 					<a href="${ctp}/community/myPage/ask?memNickname=${memberVO.nickname}" class="btn btn-outline-dark">
	 						<span style="font-size:15px">문의창&nbsp;&nbsp;<i class="fa-solid fa-arrow-right"></i></span>
 						</a>
	 				</div>
	 			</div>
			</div> 	
			
			<form name="searchForm">
				<div class="row">
					<div class="col-7 text-left">
						<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
			        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
			        <option <c:if test="${sort == '기록'}">selected</c:if> value="기록">기록</option>
			        <option <c:if test="${sort == '댓글'}">selected</c:if> value="댓글">댓글</option>
			        <option <c:if test="${sort == '문장수집'}">selected</c:if> value="문장수집">문장수집</option>
			        <option <c:if test="${sort == '회원'}">selected</c:if> value="회원">회원</option>
			      </select>
					</div>
					<div class="col-5 text-right">
						<a class="btn btn-dark mr-3 mb-4" href="javascript:deleteAction()">선택 삭제</a>
					</div>
				</div>
	    </form>
			
			
			<table class="table text-center">
				<thead>
		      <tr class="text-center">
		        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;No.</label></th>
		        <th>분류</th>
		        <th>제목</th>
		        <th>신고일</th>
		        <th>상태</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty vos}">
		    		<tr><td colspan="6" class="text-center" style="padding:30px"><b>작성 신고가 없습니다.</b></td></tr> 
		    		<tr><td colspan="6"></td></tr>
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:forEach var="vo" items="${vos}" varStatus="st"> 
			    		<tr>
			    			<td><label for="chk${vo.idx}"><input type="checkbox" <c:if test="${vo.reportDone != '처리 전'}">name="checkRow" id="chk${vo.idx}"</c:if> onclick="tempCheckChange()" <c:if test="${vo.reportDone == '처리 전'}">disabled</c:if> class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${st.count}</label></td>
			    			<td>${vo.reportCategory}</td>
			    			<td>
			    				<a href="#" onclick="reportDetail(${vo.idx})" data-toggle="modal" data-target="#myModal">
			    					${fn:substring(vo.message,0,40)}
			    					<c:if test="${fn:length(vo.message) > 40}">...</c:if>
			    				</a>
			    				<input type="hidden" id="reportCategory${vo.idx}" value="${vo.reportCategory}"/>
			    				<input type="hidden" id="message${vo.idx}" value="${vo.message}"/>
			    				<input type="hidden" id="reply${vo.idx}" value="${vo.reply}"/>
			    				<input type="hidden" id="reportDone${vo.idx}" value="${vo.reportDone}"/>
			    			</td>
			    			<td>${fn:substring(vo.reportDate,0,10)}</td>
			    			<td class="text-center">
			    				<h6><span class="badge badge-dark">${vo.reportDone}</span></h6>
		    				</td>
			    		</tr>
						</c:forEach>
			    	<tr><td colspan="5"></td></tr> 
		    	</c:if>
		    </tbody>
		  </table>
		  
  </div>
  
	 <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">신고 상세정보</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
          <div class="w3-container w3-border" style="background-color:#eee;">
		  			<textarea rows="4" cols="10" id="message" style="background-color:#FFF; border:0px" readonly class="form-control mt-3"></textarea>
		  			<hr style="border:0px; height:2px; width:200px; background:#41644A; margin:10px 0px"/>
		  			
		  			<div class="row ml-4 mr-3 mt-2 mb-4">
		  				<div class="col">
				  			<div>
				  				<div class="mb-4">답변 : <textarea rows="4" cols="10" id="reply" style="background-color:#FFF; border:0px" readonly class="form-control"></textarea></div>
				  				<span>분류 : <input type="text" id="reportCategory" style="width:500px; background-color:transparent; border:0px" readonly/></span><br/>
				  				<span>상태 : <input type="text" id="reportDone" style="width:500px; background-color:transparent; border:0px" readonly/></span><br/>
				  			</div>
		  				</div>
		  			
		  			</div>
				  </div>
				  
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        </div>
        
      </div>
    </div>
  </div>
	
	<!-- END PAGE CONTENT -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>