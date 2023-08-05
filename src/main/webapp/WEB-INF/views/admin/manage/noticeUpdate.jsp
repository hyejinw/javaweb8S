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
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
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
		.btn2 {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';

		// 공지사항 등록
		function noticeUpdate() {
			let noticeTitle = noticeUpdateForm.noticeTitle.value;
			let regex1 = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\s]{1,100}$/g; 
			// (제목)1자 이상 100자 이하,한글,영문,숫자,특수문자 허용
			
			if(!regex1.test(noticeTitle)){
				alert('제목 형식에 맞춰주세요.(한글/영문/숫자/특수문자 허용, 1~100자)');
				noticeUpdateForm.noticeTitle.focus();
		    return false;
		  }
			noticeUpdateForm.submit();
		}
		
		// 공지사항 목록(경고)
		function warning() {
			if(confirm('수정을 취소하시겠습니까?')) {
				location.href = "${ctp}/admin/manage/noticeList";
			}
		}
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
	 			<div class="text-right">
				  <a class="btn btn-dark" href="javascript:warning()" style="margin-right:20px;">공지사항 목록</a>
	 			</div>
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">공지사항 수정</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
					 	<br/>공개 선택 시, 등록과 동시에 공지사항이 공개됩니다.<br/><span style="color:red;">별(*) 표시는 필수 입력입니다.</span><br/>상단 고정 시, <span style="color:red;">홈화면 상단과 공지사항 상단</span>에 노출됩니다.
				  </span>
			  </div>
	 		</div>
			
		  <div style="background-color:white; padding:20px">
		  	<form name="noticeUpdateForm" method="post">
					<div class="table-responsive">
						<table class="table text-left">
				      <tr>
				        <th>공개 유무 <span class="must">*</span></th>
				        <td>
									<label for="type1"><input type="radio" name="noticeOpen" id="type1" value="공개" <c:if test="${vo.noticeOpen == '공개'}">checked</c:if>>&nbsp;&nbsp;공개</label>
									<label for="type2"><input type="radio" name="noticeOpen" id="type2" value="비공개" <c:if test="${vo.noticeOpen == '비공개'}">checked</c:if> class="ml-4">&nbsp;&nbsp;비공개</label>
				        </td>
				      </tr>
				      <tr>
				        <th>상단 고정</th>
				        <td>
									<label for="important"><input type="checkbox" name="important" id="important" <c:if test="${vo.important == '1'}">checked</c:if>/>&nbsp;&nbsp;고정</label>
				        </td>
				      </tr>
				      <tr>
				        <th>제목 <span class="must">*</span></th>
				        <td><input type="text" name="noticeTitle" id="noticeTitle" class="form-control" value="${vo.noticeTitle}"/></td>
				      </tr>
				      <tr>
				        <th>공지 종류 <span class="must">*</span></th>
				        <td>
				        	<select name="category" id="category" class="form-control">
										<option value="책(의)세계" <c:if test="${vo.category == '책(의)세계'}">selected</c:if>>책(의)세계</option>							
										<option value="3개의책" <c:if test="${vo.category == '3개의책'}">selected</c:if>>3개의책</option>							
									</select>
				        </td>
				      </tr>
				      <tr>
				        <td colspan="2">
				        	<textarea rows="100" name="noticeContent" id="CKEDITOR" class="form-control">${vo.noticeContent}</textarea>
					        <script>
						        CKEDITOR.replace("noticeContent",{
						        	height:600,
						        	filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지) 업로드시 매핑경로 */
						        	uploadUrl : "${ctp}/imageUpload"		/* 여러개의 그림파일을 드래그&드롭해서 올리기 */
						        });
					        </script>
				        </td>
				      </tr>
				      <tr>
				        <td colspan="2" class="text-center">
					        <div style="margin-top:20px">
										<button type="button" onclick="noticeUpdate()" class="btn2" style="background-color:#F5EBE0; font-size: 0.9em; border-color:#282828; color:black">수정</button>
					        </div>
				        </td>
				      </tr>
					  </table>
					</div>
		  	</form>
		  </div>
		  
		  
		</div>
	</div>
	


</body>
</html>