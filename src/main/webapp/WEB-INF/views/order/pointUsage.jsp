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
		let sw = 0;
		
		// 포인트 작성 시
		function pointCheck(idx) {
			let point = document.getElementById('point'+idx).value;
			let tempTotalPrice = document.getElementById('tempTotalPrice'+idx).value;
			let totalPoint = 0;
			if(parseInt(point) > parseInt(tempTotalPrice)) {
				alert("사용 포인트는 적용 상품의 합계를 초과할 수 없습니다.");
				sw = 1;
				return false;
			}
			else sw = 0;
			 
			$("input[name=point]").each(function(index, item){
				
				if($(item).val() != "") {
					totalPoint = totalPoint + parseInt($(item).val());
				}
		  });
			
			if(totalPoint > ${memberVO.point}) {
				alert('보유 포인트를 초과했습니다.');
				return false;
			}
	 	}
		
		// 포인트 적용
		function pointUsage() {
			let totalPoint = 0;
			$("input[name=point]").each(function(index, item){
				
				if($(item).val() != "") {
					totalPoint = totalPoint + parseInt($(item).val());
				}
		  });
			
			if(totalPoint > ${memberVO.point}) {
				alert('보유 포인트를 초과했습니다.');
				return false;
			}
			if(sw == 0) {
				let cartIdx = '${checkRow}'.split(',');
				
				for(let i=0; i<cartIdx.length; i++) {
					if(document.getElementById('point'+cartIdx[i]).value == "") document.getElementById('point'+cartIdx[i]).value = 0;
					opener.window.document.getElementById('usedPoint'+cartIdx[i]).value = document.getElementById('point'+cartIdx[i]).value;
				}
				// 총 포인트
				opener.window.document.getElementById('totalUsedPoint').value = totalPoint;
				window.opener.usedPointChange();
				
				window.close();
			}
		}
	</script>
</head>
<body>
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
			<div style="font-size:20px; background-color:#eee; font-weight:bold; padding:10px">포인트 사용 유의사항</div>
			<div style="padding:20px">
				- 사용 포인트는 적용 상품의 합계를 초과할 수 없습니다.<br/>
	      - 반품 시, 해당 상품에 적용된 포인트는 반품 처리 완료 후에 재적립 됩니다.<br/>
	      - 보유 포인트 (<b>${memberVO.point}</b>)<br/>
			</div>
			</div>
		</div>
	</div>
	
	<div class="row" style="margin:10px 0px 30px 0px">
		<div class="col">
			<div class="infoBox">
				<table class="table text-center" style="margin-bottom:0px">
					<thead>
						<tr>
							<th colspan="2">적용 상품</th>
							<th>상품 가격</th>
							<th>합계</th>
							<th>사용 포인트</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${memberVO.point != 0}">
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<tr>
									<td>${st.count}</td>
									<!-- 컬렉션 상품 -->
					        <c:if test="${vo.type == '컬렉션 상품'}">
						        <td>
						        	<span style="font-size:15px; font-weight:bold;">${vo.prodName}</span><br/><hr style="margin:10px;"/>
						        	<span>[옵션]  ${vo.opName}&nbsp;&nbsp;&nbsp;(${vo.num} 개)</span>
						        </td>
						        <td>
						     		  <fmt:formatNumber value="${vo.opPrice}" pattern="#,###"/>원
						     	   	<input type="hidden" id="price${vo.idx}" name="totalPrice" value="${vo.opPrice}"/>
						        </td>
					        </c:if>
									<!-- 매거진, 매거진 정기구독 -->
					        <c:if test="${vo.type != '컬렉션 상품'}">
						        <td>
						        	<span style="font-size:15px; font-weight:bold;">${vo.prodName}&nbsp;&nbsp;&nbsp;</span>(${vo.num} 개)
						        </td>
						        <td>
						     		  <fmt:formatNumber value="${vo.prodPrice}" pattern="#,###"/>원
						     	   	<input type="hidden" id="price${vo.idx}" name="totalPrice" value="${vo.prodPrice}"/>
						        </td>
					        </c:if>
					        <!-- 공통 -->
					        <td>
					        	<input type=text id="totalPrice${vo.idx}" class="text-center" value='<fmt:formatNumber value="${vo.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
					        	<input type=hidden id="tempTotalPrice${vo.idx}" name="tempTotalPrice" value="${vo.totalPrice}"/>
					        </td>
					        <td>
					        	<input type="number" id="point${vo.idx}" name="point" class="form-control" onchange="pointCheck(${vo.idx})"/>
					        </td>
								</tr>
							</c:forEach>
						</c:if>
						
						<!-- 포인트가 없으면 -->
						<c:if test="${memberVO.point == 0}">
							<tr><td colspan="7"><b><br/>보유 포인트가 없습니다.</b></td></tr> 
						</c:if>
					</tbody>
				</table>			
			</div>
		</div>
	</div>
	
	<div class="row text-center" style="margin-bottom:50px">
		<div class="col">
			<button class="btn btn-dark" onclick="pointUsage()">적용</button>
		</div>
	</div>
</body>
</html>