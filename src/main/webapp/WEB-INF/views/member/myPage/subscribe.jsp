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
    #subscribeBox {
    	border: 2px solid #282828;
    	width: 100%;
    	max-width: 600px;
    	height: 100%;
    	max-height: 1500px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	margin: 0 auto;
    	padding: 30px 50px;
    }
    .jClick {
			width:100%;
		  max-width: 300px;
	    padding: 15px;
	    border-radius:500px; 
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
		
		// 1. 뉴스레터 구독
		function booksletterCheck() {
			let email = document.getElementById('booksletterEmail').value;
			let regex1 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;  // 이메일 정규식
			
			if(email == "") {
				alert('책(의)편지를 수신할 이메일을 작성해주세요.');
				document.getElementById('booksletterEmail').focus();
				return false;
			}
			if(!regex1.test(email)) {
				alert('책(의)편지를 수신할 이메일을 올바르게 작성해주세요.');
				document.getElementById('booksletterEmail').focus();
				return false;
			}
			// 구독 중인지 확인
			booksletterSubCheckMem(email, '${sNickname}');
		}
		
		
		// 2. 뉴스레터 (회원, 이미 구독 중인지 확인)
		function booksletterSubCheckMem(email, memNickname) {
			
			$.ajax({
				type : "post",
				url : "${ctp}/about/booksletterCheck",
				data : {
					email : email,
					memNickname : memNickname
				},
				success : function(res) {
					if(res != "") {
						alert('해당 이메일로 '+res + ' 부터 책(의)편지를 구독 중입니다.');
						return false;
					}
					else {
						booksletterInsert(email);
					}
				}, error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 3. 뉴스레터 구독신청
		function booksletterInsert(email) {
			
			$.ajax({
				type : "post",
				url : "${ctp}/about/booksletterInsert",
				data : {
					email : email, 
					memNickname : '${sNickname}'
				},
				success : function(res) {
					alert('구독 신청되었습니다.\n매주 월요일 오후 3시, 메일함에서 책(의)편지를 찾아주세요.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 뉴스레터 구독 취소
		function unsubscribeBooksletter(idx) {
			let ans = confirm('구독을 취소하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/myPage/booksletterDelete",
				data : { idx : idx },
				success : function(res) {
					alert('구독 취소되었습니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		
		// 매거진 정기 구독, 주문 상세 정보
		function subOrderInfo(idx, memNickname) {
			let url ='${ctp}/member/myPage/subOrderInfo?idx='+idx;
			
			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
		
		// 매거진 정기 구독 취소신청
		function unsubscribeMagazine(idx) {
			let ans = confirm('매거진 정기구독 취소를 신청하시겠습니까?');
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/myPage/subscribeCancel",
				data : { idx : idx },
				success : function(res) {
					alert('구독 취소가 신청되었습니다.\n승인 후, 환불금과 반환포인트가 지급됩니다.');
					location.reload();
				},
				error : function() {
					alert('전송 오류! 재시도 부탁드립니다.');
				}
			});
		}
		// 주소록 리스트에서 매거진 정기배송지 변경용 주문 고유번호, 해당 session을 없애준다.
		$(document).ready(function(){
			if(localStorage.getItem('sSubAddressChange') == 'ON') {
				localStorage.removeItem('sSubAddressChange');
				localStorage.removeItem('sSubAddressChangeOrderIdx');
			}
		});
		
		// 주소록 리스트
		function addressList(orderIdx) {
			localStorage.setItem("sSubAddressChange", "ON");
			localStorage.setItem("sSubAddressChangeOrderIdx", orderIdx);
			
			let url = "${ctp}/member/myPage/addressList";

			let popupWidth = 800;
			let popupHeight = 600;

			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			window.open(url, 'player', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:25px; font-weight:bold; padding-bottom:20px">구독 관리</h2>
			
			<div style="margin:10px 0px 50px 0px">
				<div class="infoBox">
					<div style="background-color:#eee; padding:15px">
						<span style=" font-size:20px; font-weight:bold;">책(의)편지</span>&nbsp;&nbsp;<span style=" font-size:20px;">관리&nbsp;&nbsp;&nbsp;</span><span>(뉴스레터)</span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-sm btn-dark" data-toggle="modal" data-target="#booksletterModal">구독 신청</button>
					</div>
					<div style="padding:20px 20px 0px 20px">
					-  &nbsp;매주 책(의)편지가 찾아갑니다.<br/>
					-  &nbsp;월요일 오후 3시, 메일함에서 책(의)편지를 확인해보세요.<br/><br/>
						<c:if test="${!empty booksletterVOS}">
							<table class="table text-center">
								<thead>
									<tr>
										<th>No.</th>
										<th>구독 이메일</th>
										<th>구독일</th>
										<th>발송 횟수</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="booksletterVO" items="${booksletterVOS}" varStatus="st">
										<tr>
											<td>${st.count}</td>
											<td>${booksletterVO.email}</td>
											<td>${fn:substring(booksletterVO.booksletterDate,0,10)}</td>
											<td>${booksletterVO.sendNum}&nbsp;회</td>
											<td><button type="button" class="btn btn-sm btn-outline-dark" onclick="unsubscribeBooksletter('${booksletterVO.idx}')">구독 취소</button></td>
										</tr>
									</c:forEach>
									<tr><td colspan="5"></td></tr>
								</tbody>
							</table>
						</c:if>
					</div>
				</div>
			</div>
			
			<div style="margin:10px 0px 50px 0px">
				<div class="infoBox">
					<div style="background-color:#eee; padding:15px">
						<span style=" font-size:20px; font-weight:bold;">매거진 정기구독</span>&nbsp;&nbsp;<span style=" font-size:20px;">관리&nbsp;&nbsp;&nbsp;</span><span></span>
					</div>
					<div style="padding:20px 20px 0px 20px">
					-  &nbsp;매달 15일 일괄 발송되며, 구독권 기간에 따라 6/12개월 동안 지속됩니다.<br/>
					-  &nbsp;구독취소 신청 승인 후, 환불금과 반환 포인트가 지급됩니다.<br/>
					-  &nbsp;구독종료 후, 결제액의 5% 가 포인트가 적립됩니다.  (구독취소 시, 결제액과 환불금 차액의 5% 적립.)<br/><br/>
						<c:if test="${!empty subscribeVOS}">
							<table class="table text-center">
								<thead>
									<tr>
										<th>No.</th>
										<th>구독 종류</th>
										<th>구독 기간</th>
										<th>발송 잔여 횟수</th>
										<th>상태</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="subscribeVO" items="${subscribeVOS}" varStatus="st">
										<tr>
											<td>${st.count}</td>
											<td><a href="${ctp}/magazine/maProduct?idx=${subscribeVO.maIdx}">${subscribeVO.prodName}</a></td>
											<td>${fn:substring(subscribeVO.subStartDate,0,10)} ~ ${fn:substring(subscribeVO.subExpireDate,0,10)}</td>
											<td>
												${subscribeVO.subSendNum}&nbsp;회
												<button id="orderInfo${vo.idx}" style="border:0px; background-color:transparent;" onclick="subOrderInfo('${subscribeVO.orderIdx}','${subscribeVO.memNickname}')"><i class="fa-solid fa-circle-info" title="자세히" style="font-size:18px"></i></button>
											</td>
											<td>${subscribeVO.subStatus}</td>
											<td>
												<c:if test="${subscribeVO.subStatus == '구독중'}">
													<button type="button" class="btn btn-sm btn-outline-dark mr-2" onclick="unsubscribeMagazine('${subscribeVO.idx}')">구독취소 신청</button>
													<button type="button" class="btn btn-sm btn-outline-primary" onclick="addressList(${subscribeVO.orderIdx})">배송지 변경</button>
												</c:if>
											</td>
										</tr>
									</c:forEach>
									<tr><td colspan="6"></td></tr>
								</tbody>
							</table>
						</c:if>
					</div>
				</div>
			</div>
	    
			
		</div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
	
	
	<!-- The Modal -->
  <div class="modal fade" id="booksletterModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">책(의)편지 뉴스레터 구독</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="padding:0px">
        	<div class="text-center">
						<div id="subscribeBox">
							<div><i class="fa-solid fa-envelope-open-text" style="font-size:30px"></i></div><br/>
							<div style="font-size:25px"><b>뉴스레터</b></div><br/>
							<form name="booksletterForm" method="post">
								<div class="input-group">
									<input type="text" name="email" id="booksletterEmail" placeholder="뉴스레터를 수신할 이메일을 적어주세요." class="form-control"/>
									<div class="input-group-append">
										<input type="button" id="booksletterBtn" onclick="booksletterCheck()" class="btn btn-outline-danger" value="구독"/>
									</div>
								</div>
							</form>
							<br/>
							<div>
								<span style="font-size:15px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51; font-size:20px;"></i>&nbsp;&nbsp;&nbsp;<b>매주 책(의)편지가 찾아갑니다.</b></span><br/>
								<span style="font-size:15px;">&nbsp;&nbsp;&nbsp;<b>월요일 오후 3시, 메일함에서 책(의)편지를 확인해보세요.</b></span><br/>
								<br/>
								이메일 : info@chaeg.co.kr<br/>	
								전화번호 : 02-6228-5589<br/>
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

</body>
</html>