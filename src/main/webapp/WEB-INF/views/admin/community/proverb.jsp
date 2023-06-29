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
	<title>책 명언 관리</title>
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
		
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/admin/community/proverb?pag=${pageVO.pag}&pageSize="+pageSize;
    }
		 
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
		}
		
		// 기본 이미지 업로드
		function proverbCheck() {
			let content = proverbInsert.content.value.trim();
			let origin = proverbInsert.origin.value.trim();

			if(content == "") {
				alert("명언을 입력해주세요.");
				return false;
			}
			else if(origin == "") {
				alert("작성자를 입력해주세요.");
				return false;
			}
			else {
				$.ajax({
		    		type : "post",
		    		url  : "${ctp}/admin/community/proverb",
		    		data : {content : content, origin : origin},
		    		success:function(res) {
		    			if(res == "1") {
		    				alert("명언이 추가되었습니다.");
		    				location.reload();
		    			}
		    		},
		    		error : function() {
		    			alert("전송 오류! 재시도 부탁드립니다.");
		    		}
		    	});
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
		  console.log("checkRow : "+checkRow);
		 
		  if(confirm("선택한 기본 이미지를 삭제 하시겠습니까?")) {
		      
 		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/admin/community/proverbDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
	    			if(res == "1") {
	    				alert("선택한 책 명언이 삭제되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 책 명언 수정 창
		function proverbUpdate(idx) {
			$('#content'+idx).attr('disabled', false);
			$('#origin'+idx).attr('disabled', false);
			$('#confirm'+idx).css("display","inline-block");
			$('#update'+idx).css("display","none");
			
			// 입력값 끝에 커서 주기
			let contentValue = $('#content'+idx).val();
      $('#content'+idx).focus().val('').val(contentValue);
		}
		
		function proverbConfirm(idx) {
			let content = document.getElementById('content'+idx).value.trim();
			let origin = document.getElementById('origin'+idx).value.trim();
			
			if(content == "" || origin == "") {
				alert('내용과 작성자는 필수 입력값입니다.');
				return false;
			}

			$.ajax({
    	  type : "post",
    	  url : "${ctp}/admin/community/proverbUpdate",
    	  data : {idx : idx, content : content, origin : origin},
    	  success : function(res) {
    			if(res == "1") {
    				alert("수정되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});
			
			$('#content'+idx).attr('disabled', true);
			$('#origin'+idx).attr('disabled', true);
			$('#confirm'+idx).css("display","none");
			$('#update'+idx).css("display","inline-block");
		}
		
	</script>
</head>
<body class="w3-light-grey">
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:80px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">책 명언 관리</span></div>
			</div>
			<div class="row">
				<div class="col text-left">
					<a class="btn btn-dark mb-4" href="javascript:deleteAction()" style="margin-right:100px;">선택 삭제</a>
				</div>
				<div class="col text-right">
					<a class="btn btn-danger mb-4" href="#" style="margin-left:100px" data-toggle="modal" data-target="#myModal">등록</a>
				</div>
			</div>
		
		  <table class="table table-borderless mb-0 p-0">
		    <tr>
		      <td>
		        <select name="pageSize" id="pageSize" onchange="pageCheck()">
		          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
		          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
		          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
		          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
		          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
		        </select> 건
		      </td>
		      <td class="text-right">
		        <!-- 첫페이지 / 이전페이지 / (현재페이지번호/총페이지수) / 다음페이지 / 마지막페이지 -->
		        <c:if test="${pageVO.pag > 1}">
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=1" title="첫페이지로">◁◁</a>
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.pag-1}" title="이전페이지로">◀</a>
		        </c:if>
		        ${pageVO.pag}/${pageVO.totPage}
		        <c:if test="${pageVO.pag < pageVO.totPage}">
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.pag+1}" title="다음페이지로">▶</a>
		          <a href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}" title="마지막페이지로">▷▷</a>
		        </c:if>
		      </td>
		    </tr>
		  </table>
		  
			<table class="table text-center">
		    <thead class="thead-dark">
		      <tr>
		        <th><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;번호</label></th>
		        <th>내용</th>
		        <th>작성자</th>
		        <th>비고</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
 		    	<c:forEach var="vo" items="${vos}" varStatus="st">
			      <tr>
			        <td><label for="chk${vo.idx}"><input type="checkbox" name="checkRow" id="chk${vo.idx}" class="form-check-input chkGrp" value="${vo.idx}" />&nbsp;&nbsp;&nbsp;&nbsp;${curScrStartNo}</label></td>
			        <td><textarea id="content${vo.idx}" cols="60" rows="3" disabled style="border: none">${fn:replace(vo.content, newLine, "<br/>")}</textarea></td>
			        <td><input type="text" id="origin${vo.idx}" value="${vo.origin}" class="text-center" disabled style="border: none"/></td>
			        <td>
			        	<button class="btn btn-warning btn-sm" id="update${vo.idx}" onclick="proverbUpdate('${vo.idx}')">수정</button>
			        	<button class="btn btn-dark btn-sm" id="confirm${vo.idx}" onclick="proverbConfirm('${vo.idx}')" style="display:none;">종료</button>
		        	</td>
			      </tr>
			    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    	</c:forEach>
		    	<tr><td colspan="4"></td></tr> 
		    </tbody>
		  </table>
		  
		  <!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
		  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
		  <div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=1"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
			      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/community/proverb?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			  </ul>
		  </div>
		  
		</div>
	</div>	

		
		<div id="demo" style="display:none; margin:150px 0px" class="border">
			
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
					<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">명언 등록</span></div>
					<div style="text-align:center; margin-bottom:40px"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red;">등록 후, 자동으로 업데이트 됩니다.</span></div>
			    
			    <form name="proverbInsert" method="post" style="width:90%; margin:0px auto; padding:20px 50px; background-color:#FFF4D2;" class="border">
						<div class="row mb-3">
							<div class="col-sm-4 head">내용 <span class="must">*</span></div>
							<div class="col-sm-8"><textarea rows="7" name="content" id="content" class="form-control"></textarea></div>
						</div>
						<div class="row mb-3">
							<div class="col-sm-4 head">작성자 <span class="must">*</span></div>
							<div class="col-sm-8"><input type="text" name="origin" id="origin" class="form-control"/></div>
						</div>
				  	<span style="color:red; margin-top:15px" class="text-right">별(*) 표시는 필수 입력사항입니다.</span><br/><br/>
						
						<div class="row mb-3 text-center">
							<div class="col-sm">
								<input type="reset" value="다시 입력" class="btn btn-dark mr-5" style="width:200px; height:50px; border-radius:30px;"/>
								<input type="button" value="등록" onclick="proverbCheck()" class="btn btn-success" style="width:200px; height:50px; border-radius:30px;" />
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