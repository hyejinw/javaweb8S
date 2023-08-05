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
		
		// 기록 상세창으로!
		function reflectionDetail(idx, bookIdx) {
			localStorage.setItem('bookPageReflectionSW', 'ON');
			localStorage.setItem('bookPageReflectionIdxSW', idx);
			localStorage.setItem('bookPageReflectionBookIdxSW', bookIdx);
			
			window.opener.location.reload();
			window.close();
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
						      <a class="dropdown-item" href="javascript:bookSelection('인생책','${bookVO.title}','${bookVO.publisher}')">인생책</a>
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
			<a href="${ctp}/community/bookPage?idx=${bookVO.idx}"><span class="nowPart mr-5">서재 / 기록</span></a>
			<a href="${ctp}/community/bookPage/inspired?idx=${bookVO.idx}"><span class="mr-5">문장수집</span></a>
			<hr style="border:0px; height:1.0px; background:#41644A; margin:15px 0px"/>
		</div>
	</div>
	
	<!-- 서재 -->
	<div style="padding:30px">
		<div>
			<span style="font-size:18px">이 책이 인생책인 회원&nbsp;&nbsp;&nbsp;</span><span style="color:grey; font-size:20px">${bookSave1VOSNum}</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>내 인생에 영향을 준 책 30권</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<c:if test="${!empty bookSave1VOS}">
				<div class="infoBox" style="margin:30px 0px">
		  		<div>
				  	<c:forEach var="bookSave1VO" items="${bookSave1VOS}" varStatus="st">
				  		<a href="javascript:memPage('${bookSave1VO.memNickname}')"><span><img src="${ctp}/resources/data/admin/member/${bookSave1VO.memPhoto}"title="${bookSave1VO.memNickname}" class="rounded-circle" style="width:80px"/></span></a>
				  	</c:forEach>
		  		</div>
			  </div>
			</c:if>
		</div>
		<div>
			<span style="font-size:18px">이 책이 추천책인 회원&nbsp;&nbsp;&nbsp;</span><span style="color:grey; font-size:20px">${bookSave2VOSNum}</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>알리고 싶은 좋은 책 99권</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<c:if test="${!empty bookSave2VOS}">
				<div class="infoBox" style="margin:30px 0px">
		  		<div>
				  	<c:forEach var="bookSave2VO" items="${bookSave2VOS}" varStatus="st">
				  		<a href="javascript:memPage('${bookSave2VO.memNickname}')"><span><img src="${ctp}/resources/data/admin/member/${bookSave2VO.memPhoto}" title="${bookSave2VO.memNickname}" class="rounded-circle" style="width:80px"/></span></a>
				  	</c:forEach>
		  		</div>
			  </div>
			</c:if>
		</div>
		<div>
			<span style="font-size:18px">이 책이 읽은책인 회원&nbsp;&nbsp;&nbsp;</span><span style="color:grey; font-size:20px">${bookSave3VOSNum}</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>읽었어요. 같이 이야기해요.</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<c:if test="${!empty bookSave3VOS}">
				<div class="infoBox" style="margin:30px 0px">
		  		<div>
				  	<c:forEach var="bookSave3VO" items="${bookSave3VOS}" varStatus="st">
				  		<a href="javascript:memPage('${bookSave3VO.memNickname}')"><span><img src="${ctp}/resources/data/admin/member/${bookSave3VO.memPhoto}" title="${bookSave3VO.memNickname}" class="rounded-circle" style="width:80px"/></span></a>
				  	</c:forEach>
		  		</div>
			  </div>
			</c:if>
		</div>
		<div>
			<span style="font-size:18px">이 책이 관심책인 회원&nbsp;&nbsp;&nbsp;</span><span style="color:grey; font-size:20px">${bookSave4VOSNum}</span>&nbsp;&nbsp;&nbsp;	
			<span class="w3-tooltip"><i class="fa-regular fa-circle-question" style="font-size:16px"></i>&nbsp;&nbsp;&nbsp;
				<span class="w3-text w3-tag" style="font-style:italic;"><b>아직 읽지 않았지만 관심있어요.</b></span>
			</span>	
			<hr style="border:0px; height:1.0px; background:grey; margin:15px 0px"/>	
			
			<c:if test="${!empty bookSave4VOS}">
				<div class="infoBox" style="margin:30px 0px">
		  		<div>
				  	<c:forEach var="bookSave4VO" items="${bookSave4VOS}" varStatus="st">
				  		<a href="javascript:memPage('${bookSave4VO.memNickname}')"><span><img src="${ctp}/resources/data/admin/member/${bookSave4VO.memPhoto}" title="${bookSave4VO.memNickname}" class="rounded-circle" style="width:80px"/></span></a>
				  	</c:forEach>
		  		</div>
			  </div>
			</c:if>
		</div>
	</div>
	
	<!-- 문장수집 -->
	<div class="text-center mb-2" style="margin-top:50px"><span style="font-size:25px"><i class="fa-solid fa-file-pen" style="font-size:20px;"></i>&nbsp;&nbsp;&nbsp;이 책으로 작성된 기록</span></div>
<!-- 	<div class="text-center mb-2"><span style="font-size:25px"><i class="fa-solid fa-highlighter" style="font-size:20px;"></i>&nbsp;&nbsp;&nbsp;최신 문장수집</span></div> -->
	<c:if test="${empty vos}">
		<hr/>
		<div class="text-center" style="margin-bottom:80px"><b>아직 관련 기록이 없습니다.</b></div> 
	</c:if>
	
	<c:if test="${!empty vos}">
		<div style="padding:30px">
			<table class="table">
				<thead class="text-center">
		      <tr>
		        <th>번호</th>
		        <th colspan="3">제목</th>
		        <th>작성자</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:if test="${empty vos}">
		    		<tr><td colspan="5" class="text-center" style="padding:30px"><b>기록이 없습니다.</b></td></tr> 
		    		<tr><td colspan="5"></td></tr>
		    	</c:if>
		    	
		    	<c:if test="${!empty vos}">
			    	<c:forEach var="vo" items="${vos}" varStatus="st">
				      <tr>
				      	<td class="text-center">${st.count}</td>
				        <td colspan="3">
		        			<div class="text-center" style="font-size:18px; font-weight:bold;">
				        		<a href="javascript:reflectionDetail('${vo.idx}','${vo.bookIdx}')">${vo.title}</a><!-- 상세페이지 -->
									</div>
								</td>
								<td class="text-center">
			        		<a href="javascript:memPage('${vo.memNickname}')">  <!-- 회원 페이지 -->
				        		<img src="${ctp}/resources/data/admin/member/${vo.memPhoto}" class="rounded-circle" style="width:35px"/>&nbsp;&nbsp;&nbsp;
				        		${vo.memNickname}
			        		</a>
								</td>	        	
				      </tr>
			    	</c:forEach>
			    	<tr><td colspan="5"></td></tr> 
		    	</c:if>
		    </tbody>
		  </table>
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