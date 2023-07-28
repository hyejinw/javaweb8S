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
		
		// 전체선택
	  $(function(){
	  	$("#checkAll").click(function(){
	  		if($("#checkAll").prop("checked")) {
		    		$(".chk").prop("checked", true);
	  		}
	  		else {
		    		$(".chk").prop("checked", false);
	  		}
	  	});
	  });
	  
	  // 선택항목 반전
	  $(function(){
	  	$("#reversekAll").click(function(){
	  		$(".chk").prop("checked", function(){
	  			return !$(this).prop("checked");
	  		});
	  	});
	  });
	  
	  // 선택항목 삭제하기(ajax처리하기)
	  function selectDelCheck() {
	  	let delItems = "";
	  	if(delItems == "") {
	  		alert("삭제할 파일을 선택해주세요.");
	  		return false;
	  	}
	  	
	  	let ans = confirm("선택된 파일을 삭제 하시겠습니까?");
	  	if(!ans) return false;
	  	
	  	for(let i=0; i<myform.chk.length; i++) {
	  		if(myform.chk[i].checked == true) delItems += myform.chk[i].value + "/";
	  	}
			
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/admin/manage/tempFileDelete",
	  		data : {delItems : delItems},
	  		success:function(res) {
	  			if(res == "1") {
	  				alert("선택한 파일이 삭제되었습니다.");
	  			  location.reload();
	  			}
	  		},
	  		error  :function() {
	  			alert("전송오류!!");
	  		}
	  	});
	  }
	</script>
</head>
<body class="w3-light-grey">
	<a id="back-to-top"></a>
  <jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
	
	<div class="w3-main" style="margin-left:300px; margin-top:43px; padding-top:50px">

	 	<div class="table-responsive" style="width:90%; margin:0px auto; padding:40px 50px 100px 50px" class="border">
	 		<div style="background-color:white; padding:20px; margin-bottom:30px">
				<div style="text-align:center"><span class="text-center" style="font-size:30px; text-align:center; font-weight:500">임시파일 관리</span></div>
			  <div style="text-align:center;">
				  <span class="text-center" style="font-size:15px; text-align:center; font-weight:300;">
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;서버에 저장된 임시파일을 관리하는 창입니다.
					 	<br/><i class="fa-solid fa-check"></i>&nbsp;삭제된 파일은 복구가 불가능합니다.
				  </span>
			  </div>
	 		</div>

		  <form name="myform">
			  <table class="table table-hover text-center">
			    <tr>
			      <td colspan="4">
			      	<div class="row">
			      		<div class="col">
					        <label for="checkAll"><input type="checkbox" id="checkAll"/>&nbsp;전체 선택 &nbsp;&nbsp;</label>
					        <label for="reversekAll"><input type="checkbox" id="reversekAll"/>&nbsp;선택 반전 &nbsp;&nbsp;</label>
			      		</div>
			      		<div class="col">
					        <input type="button" value="선택항목삭제" onclick="selectDelCheck()" class="btn btn-danger btn-sm"/>
			      		</div>
			      	</div>
			      </td>
			    </tr>
			    <tr class="thead-dark text-dark">
			      <th>선택</th><th>번호</th><th>파일명</th><th>이미지</th>
			    </tr>
				  <c:forEach var="file" items="${files}" varStatus="st">
				    <tr>
				      <td><input type="checkbox" name="chk" id="chk${st.count}" class="chk" value="${file}"/></td>
				      <td><label for="chk${st.count}">${st.count}</label></td>
				      <td><label for="chk${st.count}">${file}</label></td>
				      <td><label for="chk${st.count}"><img src="${ctp}/data/ckeditor/${file}" width="150px"/></label></td>
				    </tr>
				  </c:forEach>
				  <tr><td colspan="4" class="m-0 p-0"></td></tr>
			  </table>
		  </form>
		  
		</div>
	</div>


</body>
</html>