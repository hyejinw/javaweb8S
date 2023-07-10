<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title></title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		@import url(https://fonts.googleapis.com/css?family=Raleway:400,100,200,300);
		#container {font-size: 1.2em;}
		.btn {
			width:100%;
		  max-width: 50px;
	    padding: 5px;
	    border-radius:100px; 
		}
		.btn2 {
			width:100%;
		  max-width: 170px;
	    padding: 10px;
	    border-radius:500px; 
		}
		small {
			color:#282828;
		}
		small:hover {
			color:gray;
			text-decoration:none;
		}
	</style>
	<script>
		'use strict';
		
		function cartDelCheck(storeName) {
			if(storeName == "") {
				Swal.fire('장바구니가 비어있습니다.');
				return false;
			}
			Swal.fire({
				  title: '정말 장바구니를 삭제하시겠습니까?',
				  icon: 'info',
				  showCancelButton: true,
				  confirmButtonColor: '#ffa0c5',
				  cancelButtonColor: '#FFDB7E',
				  confirmButtonText: '삭제',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.value) {
	          //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
	          $.ajax({
	        	  url : "${ctp}/CartDel.kn_re",
	        	  success : function(res) {
	        		  if(res == 1) {
	        			  Swal.fire('삭제 완료').then(function(){
	        				  location.reload();
	        			  })   
	        		  }
	        		  else {
	        			  Swal.fire('삭제 실패');
	        		  }
	        	  }, error : function() {
	        		  Swal.fire('전송 실패');
	        	  }
	          });
			  }
			})
		}
		function order(memMid) {
			if(memMid == "") {
				Swal.fire('장바구니가 비어있습니다.');
				return false;
			}
			location.href = "${ctp}/Order.kn_re";
		}
			
		function cartMenuDel(idx) {
			Swal.fire({
				  title: '해당 메뉴를 삭제하시겠습니까?',
				  icon: 'info',
				  showCancelButton: true,
				  confirmButtonColor: '#ffa0c5',
				  cancelButtonColor: '#FFDB7E',
				  confirmButtonText: '삭제',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.value) {
	              //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
	              $.ajax({
	            	  url : "${ctp}/CartMenuDel.kn_re?idx="+idx,
	            	  success : function(res) {
	            		  if(res == 1) {
	            			  Swal.fire('삭제 완료').then(function(){
	            				  location.reload(); 
	            			  });
	            		  }
	            		  else {
	            			  Swal.fire('삭제 실패').then(function(){
	            				  location.reload(); 
	            			  });

	            		  }
	            	  }, error : function() {
	            		  Swal.fire('전송 실패');
	            	  }
	              });
			  }
			})
		}
		function cartChange() {
			Swal.fire({
				  title: '모든 예약이 재설정됩니다.\n변경하시겠습니까?',
				  icon: 'info',
				  showCancelButton: true,
				  confirmButtonColor: '#ffa0c5',
				  cancelButtonColor: '#FFDB7E',
				  confirmButtonText: '변경',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.value) {
	              location.href="${ctp}/CartChange.kn_re";
			  }
			})
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">예약 장바구니</h2>
		<div class="container" style="padding-top:100px; width:100%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
			<div style="border-radius: 100px; background-color:#FDF7C3; padding:10px">
				<c:if test="${vos[0].storeName == null}"><span style="margin-left:40px">장바구니를 채워주세요😀</span></c:if>
				<span style="margin-left:40px">${vos[0].storeName}&nbsp;&nbsp;&nbsp;${vos[0].pickupDate}&nbsp;&nbsp;&nbsp;</span>
				<c:if test="${vos[0].storeName != null}"><button class="btn btn-success" onclick="javascript:cartChange()">변경</button></c:if>
			</div>
			<c:if test="${vos[0].storeName != null}"><hr style="border: solid 1px #282828; margin:10px 0px"/></c:if>
			<br/>
			<c:if test="${vos[0].storeName != null}">
				<div class="row text-center" style="margin-bottom:7px">
					<div class="col-sm-4">메뉴명</div>
					<div class="col-sm-3">수량</div>
					<div class="col-sm-3">금액</div>
					<div class="col-sm-2"></div>
				</div>
			</c:if>
			<div class="row text-center" style="margin-bottom:10px">
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<div class="col-sm-4">${vo.menuName}</div>
					<div class="col-sm-3">${vo.menuCnt}</div>
					<div class="col-sm-3"><fmt:formatNumber value="${vo.menuPrice}" pattern="#,###" /></div>
					<div class="col-sm-2">
						<a href="javascript:cartMenuDel(${vo.idx})"><i class="fa-solid fa-xmark" style="color: #008bf5; font-size:30px"></i></a>
					</div>
					<br/>
				</c:forEach>
			<br/>
			</div>
			<c:if test="${vos[0].storeName != null}"><hr style="border: solid 1px #282828; margin:10px 0px"/></c:if>
			<c:if test="${vos[0].storeName != null}">
				<div class="text-right mb-5 mr-5">결제 금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatNumber value="${totMenuPrice}" pattern="#,###" />원</div>
			</c:if>
			<div class="row text-center" style="margin-bottom:10px">
				<div class="col pr-1 text-right"><button type="button" onclick="javascript:cartDelCheck('${vos[0].storeName}')" class="btn2" style="background-color:#ffa0c5; font-size: 1em; border-color:#ffa0c5; color:black">장바구니 비우기</button></div>
				<div class="col pl-1 text-left"><button type="button" onclick="javascript:order('${vos[0].memMid}')" class="btn2" style="background-color:#FFDB7E; font-size: 1em; color:black">결제하기</button></div>
			</div>
		</div>
	</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>