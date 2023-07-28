<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script> 
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
	</style>
	<script>
		'use strict';
		
		// 답글 등록
		function replyInsert() {
			let reply = document.getElementById('reply').value;
			
			if(reply == '') {
				alert('답변을 입력해주세요.');
				document.getElementById('reply').focus();
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/community/reportReplyInsert",
				data : {
					idx : ${vo.idx},
					reply : reply
				},
			 	success : function() {
			 		alert('답변이 등록되었습니다.');
			 		opener.document.location.reload();
			 		location.reload();
			 	},
			 	error : function() {
			 		alert('전송 요류가 발생했습니다. 재시도 부탁드립니다.');
			 	}
			});
		}
	</script>
</head>
<body>
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">신고 처리 유의사항</div>
			<div style="padding:20px">
				- 답변은 수정이 불가능합니다. 신중히 입력해주세요. <br/>
	      - 각 신고 출처는 상세정보 링크를 통해 추가 확인 부탁드립니다.<br/>
			</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin:10px 0px 10px 0px">
		<div class="col">
			<div class="infoBox">
				<form name="addressForm">
					<table class="table table-bordered" style="margin-bottom:0px">
						<thead>
				      <tr>
				        <th colspan="2" class="text-center">신고 정보<br/></th>
				      </tr>
				    </thead>
				    <tbody>
							<tr>
								<th>신고자 (회원 별명)</th>
								<td>${vo.memNickname}</td>
							<tr>
							<tr>
								<th>분류</th>
								<td>${vo.reportCategory}</td>
							<tr>
							<tr>
								<th>신고 내용</th>
								<td>${vo.message}</td>
							<tr>
							<tr>
								<th>관리자 답글</th>
								<td>
									<c:if test="${vo.reportDone == '처리 전'}">
										<textarea rows="4" id="reply" name="reply" class="form-control"></textarea>
										<div class="text-right mt-3 mr-3">
											<button class="btn btn-sm btn-dark" onclick="replyInsert()">등록</button>
										</div>
									</c:if>
									<c:if test="${vo.reportDone != '처리 전'}">
										${vo.reply}
									</c:if>
								</td>
							<tr>
							<tr>
								<th>신고일</th>
								<td>${fn:substring(vo.reportDate,0,10)}</td>
							<tr>
							<tr>
								<th>IP주소</th>
								<td>${vo.reportHostIp}</td>
							<tr>
				    </tbody>
					</table>			
				</form>
			</div>
		</div>
	</div>
	
	<c:if test="${vo.reportCategory == '기록'}">
		<div class="row" style="margin:50px 0px 10px 0px">
			<div class="col">
				<div class="infoBox">
					<form name="addressForm">
						<table class="table table-bordered" style="margin-bottom:0px">
							<thead>
					      <tr>
					        <th colspan="2" class="text-center">신고 출처&nbsp;&nbsp;&nbsp;(${vo.reportCategory})<br/></th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:if test="${empty originVO}">
					    		<tr><td colspan="2" class="text-center"><b style="color:red">삭제된 기록입니다.</b></td></tr>
					    	</c:if>
					    	<c:if test="${!empty originVO}">
									<tr>
										<th>작성자(회원 별명)</th>
										<td>${originVO.memNickname}</td>
									</tr>
									<tr>
										<th>제목</th>
										<td>
											${originVO.title}
											<c:if test="${originVO.replyOpen == 1}">
						    				&nbsp;&nbsp;<span class="badge badge-pill badge-light">댓글 허용</span>
					    				</c:if>
					    				<c:if test="${originVO.replyOpen != 1}">
						    				&nbsp;&nbsp;<span class="badge badge-pill badge-light">댓글 비허용</span>
					    				</c:if>
										</td>
									</tr>
									<tr>
										<td colspan="2">${originVO.content}</td>
									</tr>
									<tr>
										<th>저장 등록 수 / 조회 수</th>
										<td>${originVO.refSave} / ${originVO.refView}</td>
									</tr>
									<tr>
										<th>작성 날짜</th>
										<td>${fn:substring(originVO.refDate,0,19)}</td>
									</tr>
									<tr>
										<th>IP주소</th>
										<td>${originVO.refHostIp}</td>
									</tr>
									<tr>
										<th>삭제 신청 여부</th>
										<td>${originVO.refDel}</td>
									</tr>
					    	</c:if>
					    </tbody>
						</table>			
					</form>
				</div>
			</div>
		</div>
	</c:if>
	
	<c:if test="${vo.reportCategory == '댓글'}">
		<div class="row" style="margin:50px 0px 10px 0px">
			<div class="col">
				<div class="infoBox">
					<form name="addressForm">
						<table class="table table-bordered" style="margin-bottom:0px">
							<thead>
					      <tr>
					        <th colspan="2" class="text-center">신고 출처&nbsp;&nbsp;&nbsp;(${vo.reportCategory})<br/></th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:if test="${empty originVO}">
					    		<tr><td colspan="2" class="text-center"><b style="color:red">삭제된 댓글입니다.</b></td></tr>
					    	</c:if>
					    	<c:if test="${!empty originVO}">
									<tr>
										<th>작성자(회원 별명)</th>
										<td>${originVO.memNickname}</td>
									</tr>
									<tr>
										<th>내용</th>
										<td>
											${originVO.content}
											<c:if test="${originVO.edit == 1}">
						    				&nbsp;&nbsp;<span class="badge badge-pill badge-light">수정됨</span>
					    				</c:if>
										</td>
									</tr>
									<tr>
										<th>작성 날짜</th>
										<td>${fn:substring(originVO.replyDate,0,19)}</td>
									</tr>
									<tr>
										<th>IP주소</th>
										<td>${originVO.replyHostIp}</td>
									</tr>
									<tr>
										<th>삭제 신청 여부</th>
										<td>${originVO.replyDel}</td>
									</tr>
								</c:if>
					    </tbody>
						</table>			
					</form>
				</div>
			</div>
		</div>
	</c:if>
	
	<c:if test="${vo.reportCategory == '문장수집'}">
		<div class="row" style="margin:50px 0px 10px 0px">
			<div class="col">
				<div class="infoBox">
					<form name="addressForm">
						<table class="table table-bordered" style="margin-bottom:0px">
							<thead>
					      <tr>
					        <th colspan="2" class="text-center">신고 출처&nbsp;&nbsp;&nbsp;(${vo.reportCategory})<br/></th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:if test="${empty originVO}">
					    		<tr><td colspan="2" class="text-center"><b style="color:red">삭제된 문장수집입니다.</b></td></tr>
					    	</c:if>
					    	<c:if test="${!empty originVO}">
									<tr>
										<th>작성자(회원 별명)</th>
										<td>${originVO.memNickname}</td>
									</tr>
									<tr>
										<th>내용&nbsp;(페이지)</th>
										<td>${originVO.insContent}&nbsp;(${originVO.page})</td>
									</tr>
									<c:if test="${!empty originVO.explanation}">
										<tr>
											<th>설명</th>
											<td>${originVO.explanation}</td>
										</tr>
			    				</c:if>
									<tr>
										<th>저장 등록 수</th>
										<td>${originVO.insSave}</td>
									</tr>
									<tr>
										<th>작성 날짜</th>
										<td>${fn:substring(originVO.insDate,0,19)}</td>
									</tr>
									<tr>
										<th>IP주소</th>
										<td>${originVO.insHostIp}</td>
									</tr>
									<tr>
										<th>삭제 신청 여부</th>
										<td>${originVO.insDel}</td>
									</tr>
								</c:if>
					    </tbody>
						</table>			
					</form>
				</div>
			</div>
		</div>
	</c:if>
	
	<c:if test="${vo.reportCategory == '회원'}">
		<div class="row" style="margin:50px 0px 10px 0px">
			<div class="col">
				<div class="infoBox">
					<form name="addressForm">
						<table class="table table-bordered" style="margin-bottom:0px">
							<thead>
					      <tr>
					        <th colspan="2" class="text-center">신고 출처&nbsp;&nbsp;&nbsp;(${vo.reportCategory})<br/></th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:if test="${empty originVO}">
					    		<tr><td colspan="2" class="text-center"><b style="color:red">탈퇴한 회원입니다.</b></td></tr>
					    	</c:if>
					    	<c:if test="${!empty originVO}">
									<tr>
										<th>회원 별명</th>
										<td>${originVO.nickname}</td>
									</tr>
									<tr>
										<td colspan="2"><b>회원관련 신고 출처는 커뮤니티 회원창으로 통해 확인 부탁드립니다.</b></td>
									</tr>
								</c:if>
					    </tbody>
						</table>			
					</form>
				</div>
			</div>
		</div>
	</c:if>
	<div style="margin-bottom:50px"></div>
</body>
</html>