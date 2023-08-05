<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
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
		.infoBox2 {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 300px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
    }
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 400px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
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
		
		// 주소록 등록
		function addressInsert() {
			
			if(${addressNum} >= 5) {
				alert('배송 주소록은 최대 5개까지 등록 가능합니다.');
				return false;
			}
			
			let url = "${ctp}/member/myPage/addressInsert";

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 주소록 수정
		function addressUpdate(idx) {
			
			let url = "${ctp}/member/myPage/addressUpdate?idx="+idx;

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}

		// 주소 삭제
		function addressDelete(idx) {

			if(confirm("선택한 주소를 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/member/myPage/addressDelete",
	    	  data : { idx : idx },
	    	  success : function(res) {
    				alert("선택한 주소가 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">배송 주소록 관리</h2>
 			
 			<div class="row" style="margin:10px 0px 30px 0px">
				<div class="col">
					<div class="infoBox">
					<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">배송주소록 유의사항</div>
					<div style="padding:20px">
						- 배송 주소록은 최대 5개까지 등록 가능합니다.<br/>
			      - 기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.<br/>
			      - 기본 배송지는 삭제가 불가능합니다.<br/>
					</div>
					</div>
				</div>
			</div>
			
			<div class="row" style="margin:10px 0px 30px 0px">
				<div class="col">
					<table class="table text-center" style="margin-bottom:0px">
						<thead>
							<tr>
								<th>No.</th>
								<th>배송지 명</th>
								<th>수령인</th>
								<th>전화번호</th>
								<th>주소</th>
								<th>배송메시지</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${!empty vos}">
								<c:forEach var="vo" items="${vos}" varStatus="st">
									<tr>
										<td>${st.count}</td>
										<c:if test="${vo.defaultAddress == 0}"><td>${vo.addressName}<span class="badge badge-pill badge-success">기본 주소</span></td></c:if>
										<c:if test="${vo.defaultAddress != 0}"><td>${vo.addressName}</td></c:if>
										<td>${vo.name}</td>
										<td>${vo.tel}</td>
										<td>(${vo.postcode}) ${vo.roadAddress} ${vo.detailAddress} ${vo.extraAddress}</td>
										<td>
											<c:if test="${!empty vo.addressMsg}">${vo.addressMsg}</c:if>
											<c:if test="${empty vo.addressMsg}"><i class="fa-solid fa-text-slash"></i></c:if>
										</td>
										<td>
											<button class="btn btn-sm btn-outline-secondary" onclick="addressUpdate(${vo.idx})">수정</button>
											<button class="btn btn-sm btn-outline-danger ml-2" onclick="addressDelete(${vo.idx})" <c:if test="${vo.defaultAddress == 0}">disabled</c:if>>삭제</button>
										</td>
									</tr>
								</c:forEach>
								<tr><td colspan="7"></td></tr> 
							</c:if>
							
							<!-- 주소록 미등록 시 -->
							<c:if test="${empty vos}">
								<tr><td colspan="7" style="padding:20px 20px 35px 20px"><b><br/>등록된 주소록이 없습니다.</b></td></tr> 
								<tr><td colspan="7"></td></tr> 
							</c:if>
						</tbody>
					</table>			
				</div>
			</div>
			
			<div class="row text-center" style="margin-bottom:50px">
				<div class="col">
					<button class="btn btn-dark" onclick="addressInsert()">배송지 등록</button>
				</div>
			</div>
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>