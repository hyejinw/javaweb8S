<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	  <style>
	  .head {
	 		font-size: 20px;
	  }
	  .must {
  		color: red;
		}
		.wrapper {
		  /* width: 50px;
		  height: 50px; */
		  text-align: center;
		  /* margin: 50px auto; */
		}
		.switch {
		  position: absolute;
		  /* hidden */
		  appearance: none;
		  -webkit-appearance: none;
		  -moz-appearance: none;
		}
		.switch_label {
		  position: relative;
		  cursor: pointer;
		  display: inline-block;
		  width: 53px;
		  height: 23px;
		  background: #fff;
		  border: 2px solid #daa;
		  border-radius: 20px;
		  transition: 0.2s;
		}
		.switch_label:hover {
		  background: #efefef;
		}
		.onf_btn {
		  position: absolute;
		  top: 2px;
		  left: 3px;
		  display: inline-block;
		  width: 15px;
		  height: 15px;
		  border-radius: 20px;
		  background: #daa;
		  transition: 0.2s;
		}
		
		/* checking style */
		.switch:checked+.switch_label {
		  background: #c44;
		  border: 2px solid #c44;
		}
		
		.switch:checked+.switch_label:hover {
		  background: #e55;
		}
		
		/* move */
		.switch:checked+.switch_label .onf_btn {
		  left: 34px;
		  background: #fff;
		  box-shadow: 1px 2px 3px #00000020;
		}
	</style>
	<script>
		'use strict';
		
		// 검색
		function searchCheck() {
			let searchString = $("#searchString").val();
			let search = $("#search").val();
			let sort = $("#sort").val();
	    	
    	if(search.trim() == "") {
    		alert("검색 분야를 선택해주세요.");
    		searchForm.search.focus();
    		return false;
    	}
    	location.href = "${ctp}/admin/community/report?search="+search+"&searchString="+searchString+"&sort="+sort;
		}
		
		// 회원정보 상세창
		function memInfo(nickname) {
			let url = "${ctp}/admin/member/memInfo?nickname="+nickname;

			let popupWidth = 1000;
			let popupHeight = 800;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'memInfo', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 신고 상세창
		function reportDetail(idx) {
			let url = "${ctp}/admin/community/reportInfo?idx="+idx;

			let popupWidth = 1000;
			let popupHeight = 800;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'reportInfo', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="row">
	 				<div class="col text-left">
						<a class="btn btn-dark mb-4" href="${ctp}/admin/community/report" style="margin-left:20px;"><i class="fa-solid fa-arrows-rotate"></i></a>
	 				</div>
	 				<div class="col text-right">
	 				</div>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">신고 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
					 	<br/>신고 관련 처리는 철회가 불가능합니다. 신중하게 처리해주세요.
					 	<br/><span style="color:red;">상세창에서 신고 관련처리가 가능합니다.</span>
				  </span>
			  </div>
	 		</div>
			<div class="row" style="margin-top:50px">
				<div class="col-7 text-left">
					<select name="sort" id="sort" class="form-control mb-3" style="width:150px;" onchange="searchCheck()">
		        <option <c:if test="${sort == '전체'}">selected</c:if> value="전체">전체</option>
		        <option <c:if test="${sort == '처리 전'}">selected</c:if> value="처리 전">처리 전</option>
		        <option <c:if test="${sort == '기록'}">selected</c:if> value="기록">기록</option>
		        <option <c:if test="${sort == '댓글'}">selected</c:if> value="댓글">댓글</option>
		        <option <c:if test="${sort == '문장수집'}">selected</c:if> value="문장수집">문장수집</option>
		        <option <c:if test="${sort == '회원'}">selected</c:if> value="회원">회원</option>
		      </select>
				</div>
				<div class="col-5 text-right">
					<form name="searchForm" class="text-right">
			    	<div class="input-group">
				    	<div class="mr-3">
				        <select name="search" id="search" class="form-control">
				          <option <c:if test="${search == 'memNickname'}">selected</c:if> value="memNickname">신고자(회원 별명)</option>
				          <option <c:if test="${search == 'message'}">selected</c:if> value="message">내용</option>
				          <option <c:if test="${search == 'reply'}">selected</c:if> value="reply">관리자 답글</option>
				        </select>
				    	</div>
				      <input type="text" name="searchString" id="searchString" value="${searchString}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요"/>
				      <div class="input-group-append">
				     		<a href="#" class="btn btn-success my-2 my-sm-0" onclick="javascript:searchCheck()"><i class="fa-solid fa-magnifying-glass" style="color:#282828;"></i></a>
				     	</div>
			     	</div>
			    </form>
				</div>
			</div>
			
		  <div class="table-responsive">
				<table class="table text-center">
			    <thead class="thead-dark">
			      <tr>
			        <th>No.</th>
			        <th>분류 (처리)</th>
			        <th>신고자(회원 별명)</th>
			        <th>내용</th>
			        <th>신고일</th>
			        <th>처리 유무</th>
			        <th>출처 상세</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${empty vos}">
			    		<tr><td colspan="7" style="padding:30px"><b>신고 정보가 없습니다.</b></td></tr> 
			    	</c:if>
			    	<c:if test="${!empty vos}">
		 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
					      <tr>
					        <td>${st.count}</td>
					        <td>
					        	${vo.reportCategory}&nbsp;
					        	<a href="javascript:reportDetail('${vo.idx}')">
					        		<i class="fa-solid fa-arrow-pointer" style="font-size:17px"></i>
					        	</a>
					        </td>
					        <td>
				    				<span style="color:grey; font-weight:bold">
					    				${vo.memNickname}&nbsp;
					    				<button id="memInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="memInfo('${vo.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:15px; color:#557A46"></i></button>
				    				</span>
				    			</td>
					        <td>
					        	${fn:substring(vo.message,0,20)}
					        	<c:if test="${fn:length(vo.message) > 20}">...</c:if>
					        </td>
					        <td>${fn:substring(vo.reportDate,0,10)}</td>
					        <td>
					        	<c:if test="${vo.reportDone == '처리 전'}"><b>${vo.reportDone}</b></c:if>
					        	<c:if test="${vo.reportDone != '처리 전'}">${vo.reportDone}</c:if>
					        </td>
					        <td>
					        	<c:if test="${vo.reportCategory == '기록'}">
						        	<button class="btn btn-sm btn-outline-primary" onclick="location.href='${ctp}/community/reflectionDetail?idx=${vo.originIdx}';">이동</button>
					        	</c:if>
					        	<c:if test="${vo.reportCategory == '댓글'}">
						        	<button class="btn btn-sm btn-outline-primary" onclick="location.href='${ctp}/community/reflectionDetail?idx=${vo.originRefIdx}';">이동</button>
					        	</c:if>
					        	<c:if test="${vo.reportCategory == '회원'}">
						        	<button class="btn btn-sm btn-outline-primary" onclick="location.href='${ctp}/community/myPage?memNickname=${vo.originNickname}';">이동</button>
					        	</c:if>
					        </td>
					      </tr>
				    	</c:forEach>
			    	</c:if>
			    	<tr><td colspan="7"></td></tr> 
			    </tbody>
			  </table>
		  </div>
		  
		  
		</div>
	</div>
	


</body>
</html>