<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
		<style>
		.updown {
    	border: 1px solid #282828;
      width: 0.1px;
      height: 500px;
      margin-left: 75px;
    }
		.settingBtn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		let coupon = '';
		
		function pointUsageCheck(totalPrice) {
			coupon = conponForm.coupon.value;
			let pointUsage = document.getElementById("pointUsage");
			let point = document.getElementById("point").value;
			let totPriceInput = document.getElementById("totPriceInput");
			let resPrice = '';
			
		  resPrice = totalPrice - 4800;
		  totPriceInput.innerHTML = resPrice+"원";
		}
		
		function pointCheck(memPoint,totalPrice) {
			let point = document.getElementById("point").value;
			
			if(point < 0) {
				alert('최소 사용 금액은 1원 입니다.');
				point = 0;
			}
			else if(point >= memPoint) {
				alert('보유 포인트를 초과할 수 없습니다.');
				point = memPoint;
			}
			else if(point >= totalPrice) {
				alert('구매 금액을 초과할 수 없습니다.');
				point = totalPrice;
			}
			document.getElementById("point").value = point;
		}
	
		function orderCheck(storeIdx, pickupDate, menuIdx) {
			
			Swal.fire({
				  title: '결제하시겠습니까?',
				  icon: 'info',
				  showCancelButton: true,
				  confirmButtonColor: '#ffa0c5',
				  cancelButtonColor: '#FFDB7E',
				  confirmButtonText: '결제',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.value) {
	          //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
	          $.ajax({
	        	  type : "post",
	        	  url : "${ctp}/OrderCheck.kn_re",
	        		data : {coupon : coupon, storeIdx : storeIdx, pickupDate : pickupDate, menuIdx : menuIdx},
	        	  success : function(res) {
	        		  if(res == 1) {
	        			  Swal.fire('결제가 완료되었습니다.\n오늘도 맛있는 하루되세요.').then(function(){
	        				  location.href = '${ctp}/'; 
	        			  });
	        		  }
	        		  else {
	        			  Swal.fire('결제 실패\n재시도해주세요.').then(function(){
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
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">결제</h2>
		<div class="container" style="padding-top:100px; width:100%"> 
			<div class="row">
				<div class="col-sm-5">
					<div style="border-radius: 100px; background-color:#ebebeb; padding:10px" class="mb-3 ml-3">주문매장 : ${vos[0].storeName}</div>
					<div style="border-radius: 100px; background-color:#ebebeb; padding:10px" class="ml-3">주문일자 : ${vos[0].pickupDate}</div>
					<div>
						<div style="border-radius: 100px; background-color:#FFD36B; padding:10px"  class="mb-1 mt-5 ml-3">
							<div class="ml-3"><i class="fa-solid fa-book-open"></i>&nbsp;&nbsp;&nbsp;&nbsp;주문 내역</div>
						</div><br/>
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<div class="row">
								<div class="col-sm-6"><span class="ml-4">${vo.menuName}</span></div>
								<div class="col-sm-3">${vo.menuCnt}개</div>
								<div class="col-sm-3"><fmt:formatNumber value="${vo.menuPrice}" pattern="#,###" />원</div>
							</div>
							<br/>
						</c:forEach>
					</div>
				
				</div>
				<div class="col-sm-2"><div class="updown text-center"></div></div>
				<div class="col-sm-5">
				
					<div>
						<span style="font-size:20px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;주문자 정보</span><br/>
						<div class="row" style="margin-top:15px">
							<div class="col-4">아이디</div>
							<div class="col-8 text-left">${memberVO.mid}</div>
						</div>
						<div class="row">
							<div class="col-4">성명</div>
							<div class="col-8 text-left">${memberVO.name}</div>
						</div>
						<div class="row">
							<div class="col-4">연락처</div>
							<div class="col-8 text-left">${memberVO.tel}</div>
						</div>
						<div class="row">
							<div class="col-4">이메일</div>
							<div class="col-8 text-left">${memberVO.email}</div>
						</div>
						<div class="row">
							<div class="col-4">보유 포인트</div>
							<div class="col-8 text-left">${memberVO.point}</div>
						</div>
					</div>
					<hr style="border: solid 1px #282828; margin:40px 0px"/>
					<span style="margin:0px 270px 40px 0px; font-size:20px;"><i class="fa-solid fa-circle-dollar-to-slot" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;포인트</span>
					<div class="row" style="margin-top:15px">
						<div class="col-9 text-center"><input type="number" value="0" min="0" max="${memberVO.point}" id="point" onchange="pointCheck(${memberVO.point},${magazineCartVO.totalPrice})" class="form-control"/></div>
						<div class="col-3 text-center"><button class="btn btn-success" onclick="pointUsageCheck(${magazineCartVO.totalPrice})">적용</button></div>
					</div>
					<hr style="border: solid 1px #282828; margin:40px 0px"/>

					<span style="margin-right:250px">주문금액</span><fmt:formatNumber value="${magazineCartVO.totalPrice}" pattern="#,###" />원<br/>
					<span style="margin-right:250px">포인트 사용</span><span id="pointUsage"></span><br/>
					<span style="margin-right:250px">결제금액</span><span id="totPriceInput"><fmt:formatNumber value="${magazineCartVO.totalPrice}" pattern="#,###" />원</span><br/>
					<button class="settingBtn mt-5" onclick="javascript:orderCheck('${vos[0].storeIdx}', '${vos[0].pickupDate}', '${vos[0].menuIdx}')" style="background-color:#FFDB7E; font-size:1em;">결제하기</button>
				</div>
			</div>
		
		  <!-- The Modal -->
		  <div class="modal fade" id="couponClick">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title text-center">쿠폰 적용창</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		        	<form name="conponForm">
				      	<div class="row mb-4">
				      		<c:if test="${vos2[0].idx != null}"><div class="col-sm text-primary">사용할 쿠폰을 선택해주세요.</div></c:if>
				      		<c:if test="${vos2[0].idx == null}">
				      			<div class="col-sm text-primary"><i class="fa-regular fa-face-grin-squint-tears"></i>&nbsp;&nbsp;&nbsp;쿠폰함이 비었습니다.</div>
			      			</c:if>
				      	</div>
				      	<c:if test="${vos2[0].idx != null}">
					      	<div class="row mb-2">
					      		<div class="col-sm">쿠폰 
					      			<select name="coupon" id="coupon" class="form-control">
					      				<c:forEach var="vo2" items="${vos2}" varStatus="st">
						      				<c:if test="${vo2.coupon == 1}"><option value="1">도넛 무료쿠폰 (1장, 4800원)</option></c:if>
						      				<c:if test="${vo2.coupon == 2}"><option value="2">생일축하도넛 무료쿠폰 (1장, 4800원)</option></c:if>
						      				<c:if test="${vo2.coupon == 3}"><option value="3">베이커리 무료쿠폰 (1장, 6500원)</option></c:if>
						      				<c:if test="${vo2.coupon == 4}"><option value="4">케이크 무료쿠폰 (1장, 23000원)</option></c:if>
					      				</c:forEach>
				      				</select>
				      			</div>
					      		<input type="hidden" name="idx" id="idx"/>  <!-- 안 필요할 듯 -->
					      	</div>
				      	</c:if>
			        </form>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-warning" onclick="javascript:couponCheck(${getCartTotPrice})">쿠폰적용하기</button>
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        </div>
		        
		      </div>
		    </div>
		  </div>
			
		
		
		</div>
	</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>