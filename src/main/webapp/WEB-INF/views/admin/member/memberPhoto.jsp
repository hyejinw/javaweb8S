<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>기본 프로필 사진 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
	  .head {
	 		font-size: 20px;
	  }
	  .must {
  		color: red;
		}
	</style>	
	<script>
		'use strict';
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}

		 
		// 기본 이미지 업로드
		function photoCheck() {
 			let memo = document.getElementById('memo').value;
			let photoName = document.getElementById('photoName').value; 
			let ext = photoName.substring(photoName.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 20; // 업로드 가능 파일은 20MByte까지
			
			if(photoName.trim() == "") {
				alert("사진을 업로드해주세요.");
				return false;
			}
			
			let fileSize = photoInsert.photoName.files[0].size;
			if(ext != "JPG" && ext != "PNG") {
				alert("업로드 가능한 사진 파일은 'jpg 또는 png' 입니다.");
			}
			else if(fileSize > maxSize) {
				alert("업로드 파일의 최대용량은 20MByte 입니다.");
			}
			else {
				photoInsert.submit();
			}
		}
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function (){
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 기본 이미지를 삭제 하시겠습니까?")) {
		      
 		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/member/memberDefaultPhotoDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 기본 이미지가 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
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
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:80px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">기본 프로필 사진 관리</span></div>
				<div style="text-align:center"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">삭제 시, 해당 이미지를 선택한 회원의 프로필이 'defaultImage.jpg'로 변경됩니다.</span></div>
			</div>
			<div class="row">
				<div class="col text-left">
					<a class="btn btn-danger mb-4" href="#" style="margin-left:100px" data-toggle="modal" data-target="#myModal">기본 이미지 등록</a>
				</div>
				<div class="col text-right">
					<a class="btn btn-dark mb-4" href="javascript:deleteAction()" style="margin-right:100px;">선택 삭제</a>
				</div>
			</div>
			
			<table class="table text-center">
		    <thead class="thead-dark">
		      <tr>
		        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
		        <th>파일</th>
		        <th>설명</th>
		        <th>업로드 일자</th>
		      </tr>
		    </thead>
		    <tbody>
 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
			      <tr>
			      	<c:if test="${vo.photoName == 'defaultImage.jpg'}">
				        <td><label for="chk${vo.idx}"><input type="checkbox" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.photoName}" disabled/>&nbsp;&nbsp;&nbsp;&nbsp;${st.count}</label></td>
			      	</c:if>
			      	<c:if test="${vo.photoName != 'defaultImage.jpg'}">
				        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.photoName}" />&nbsp;&nbsp;&nbsp;&nbsp;${st.count}</label></td>
			      	</c:if>
  			        <td><a href="${ctp}/admin/member/${vo.photoName}" download>${vo.photoName}</a><br/><img src="${ctp}/admin/member/${vo.photoName}" style="width:100px" class="w3-hover-opacity"></td>
			        <td>${vo.memo}</td>
			        <td>${vo.photoDate}</td>
			      </tr>
		    	</c:forEach>
		    	<tr><td colspan="5"></td></tr>
		    </tbody>
		  </table>

		
		</div>
	</div>
	
	
	 <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
					<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">기본 이미지 등록</span></div>
					<div style="text-align:center; margin-bottom:40px"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">등록 후, 자동으로 업데이트 됩니다.</span></div>
			    
			    <form name="photoInsert" method="post" action="${ctp}/admin/member/memberDefaultPhotoInsert" enctype="multipart/form-data" style="width:90%; margin:0px auto; padding:20px 50px; background-color:#FFF4D2;" class="border">
						<div class="row mb-3">
							<div class="col-sm-4 head">설명</div>
							<div class="col-sm-8"><input type="text" name="memo" id="memo" class="form-control"/></div>
						</div>
						<div class="row mb-3">
							<div class="col-sm-4 head">기본 사진 <span class="must">*</span></div>
							<div class="col-sm-8"><input type="file" name="file" id="photoName" onchange="imgCheck(this)" class="form-control-file border form-control"/></div>
						</div>
						<div class="row mb-4">
							<div class="col"><img id="photoDemo" width="200px"/></div>
						</div>
				  	<span style="color:red; margin-top:15px" class="text-right">별(*) 표시는 필수 입력사항입니다.</span><br/><br/>
						
						<div class="row mb-3 text-center">
							<div class="col-sm">
								<input type="reset" value="다시 입력" class="btn btn-dark mr-5" style="width:200px; height:50px; border-radius:30px;"/>
								<input type="button" value="등록" onclick="photoCheck()" class="btn btn-success" style="width:200px; height:50px; border-radius:30px;" />
							</div>
						</div>
			    </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	
</body>
</html>