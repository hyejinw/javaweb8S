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
		html {scroll-behavior:smooth;}
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
		
		.pill-nav a {
		  display: inline-block;
		  color: gray;
		  text-align: center;
		  text-decoration: none;
		  font-size: 17.5px;
		}
		.pill-nav a:hover {
		  color: #ffa0c5;
		}
		.pill-nav a.active {
		  color: #282828;
		  font-weight: bold
		}
		.price  {
      text-align:right;
      font-size:1em;
      border:0px;
      outline: none;
    }
    .btn2 {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    background-color:white; 
	    font-size: 1em; 
	    border-color:#282828; 
	    color:#444444
		}
		.btn2:hover {
			background-color:#ECF2FF;
			color:#282828;
		}
    .btn3 {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    background-color:#444444; 
	    font-size: 1em; 
	    border-color:#282828; 
	    color:white
		}
		.btn3:hover {
			background-color:#282828;
			color:white;
		}
		.save:hover {
			cursor: pointer;
		}
		.removeBtn:hover {
			color: #AAC8A7;
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
  	let idxArray = new Array();		/* 배열의 개수 지정없이 동적배열로 설정 */
		
  	// 옵션 선택
		function optionSelect() {
			let option = $('#option').val();
			let opIdx = option.split(',')[0];
			let opName = option.split(',')[1];
			let opPrice = option.split(',')[2];
			let commaOpPrice = numberWithCommas(opPrice);			// 콤마 붙인 옵션 가격
			
			
			// 옵션박스의 내용을 한 개라도 선택한다면 선택된 옵션의 '옵션명/콤마붙인가격'을 화면에 출력
			if($("#layer"+opIdx).length == 0 && option != "") {   // 옵션이 하나라도 있으면 처리
				idxArray[opIdx] = opIdx;
				
				let str = '<div class="layer" id="layer'+opIdx+'">';
				str += '<div class="row">';
				str += '<div class="col-6" style="padding-right:0px">';
				str += '<span style="font-size:18px">'+opName+'&nbsp;&nbsp;&nbsp;('+commaOpPrice+'원)</span>';
				str += '</div>';
				
				str += '<div class="col-6 text-center _count" style="padding:0px">';
				str += '<div class="row">';
				str += '<div class="col text-right">';
				str += '<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numMinusChange('+opPrice+','+opIdx+')"><i class="fa-solid fa-minus"></i></button>';
				str += '<input type="text" class="text-center opNum num" name="num" id="num'+opIdx+'" value="1" readonly style="width:50px;"/>';
				str += '<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numPlusChange('+opPrice+','+opIdx+')"><i class="fa-solid fa-plus"></i></button>';
				str += '</div>';
				
				str += '<div class="col">';
				str += '<button onclick="remove('+opIdx+')" style="border:0px; background-color:transparent;"><i class="fa-solid fa-circle-xmark removeBtn" style="font-size:30px;"></i></button>';
				str += '</div>';
				str += '</div>';
				
				str += '</div>';
				str += '<input type="hidden" id="price'+opIdx+'" value="'+opPrice+'"/>';  /* 변동되는 가격을 재계산하기위해 price+idx 아이디를 사용하고 있다. */
    		str += '<input type="hidden" name="statePrice" id="statePrice'+opIdx+'" value="'+opPrice+'"/>';		/* 현재상태에서의 변경된 상품(옵션)의 가격이다. */
    		str += '<input type="hidden" name="opIdx" class="opIdx" value="'+opIdx+'"/>';
    		str += '<input type="hidden" name="opName" class="opName" value="'+opName+'"/>';
    		str += '<input type="hidden" name="opPrice" class="opPrice" value="'+opPrice+'"/>';
				str += '</div>';
				str += '<hr/>';
				str += '</div>';
				
				$("#optionSelect").append(str);
				onTotal();
			}
			else {
  		  alert("이미 선택한 옵션입니다.");
  	  }
		}
	 // 수량 변경 시 처리하는 함수(minus)
    function numMinusChange(opPrice, opIdx) {
			let num = document.getElementById("num"+opIdx).value;
			if(num <= 1) {
				alert('최소 주문수량은 1개 입니다.');
				num = 1;
			}
			else num--;
			
			document.getElementById("num"+opIdx).value = num;
    	let price = opPrice * num;
    	document.getElementById("price"+opIdx).value = price;
    	onTotal();
    }
	 // 수량 변경 시 처리하는 함수(plus)
    function numPlusChange(opPrice, opIdx) {
			let num = document.getElementById("num"+opIdx).value;
			if(num >= 999) {
				alert('최대 주문수량은 999개 입니다.');
				num = 999;
			}
			else num++;
			
			document.getElementById("num"+opIdx).value = num;
    	let price = opPrice * num;
    	document.getElementById("price"+opIdx).value = price;
    	onTotal();
    }
  	
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  let total = 0;
  	  for(let i=0; i<idxArray.length; i++) {
  		  if($("#layer"+idxArray[i]).length != 0) {
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
  		  	document.getElementById("totalPriceResult").value = total;
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total);
    }
    
    // 등록한 옵션 상품 삭제하기
    function remove(opIdx) {
  	  $("div").remove("#layer"+opIdx);
  	  
  	  // 옵션내역이 1개라도 있으면 가격을 재계산하고, 없으면 reload한다.
  	  if($(".opNum").length) onTotal();
  	  else location.reload();
    }
		
		// 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
		
		// 상품저장(좋아요)
		function save() {
			
			if('${sNickname}' == "") {
				alert('로그인 후 사용해주세요.');
				location.href = "${ctp}/member/memberLogin";
				return false;
			}
			
			if('${saveVO}' == "") {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/collection/productSave",
	    		data  : {
					  memNickname  : '${sNickname}',
					  type : '컬렉션 상품',
	    			prodIdx : ${vo.idx},
	    			prodName : '${vo.prodName}',
	    			prodPrice : ${vo.prodPrice},
	    			prodThumbnail : '${vo.prodThumbnail}'
					},
	    		success:function() {
	    			alert("관심상품에 추가되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
			else {
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/collection/productSaveDelete",
	    		data  : {
					  memNickname  : '${sNickname}',
					  prodIdx : ${vo.idx},
					},
	    		success:function() {
	    			alert("관심상품이 취소되었습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
			}
    }
		
		// 장바구니 담기
		function cart() {
			/* let opIdxes = document.getElementsByClassName('opIdx');
			let opNames = document.getElementsByClassName('opName');
			let opPrices = document.getElementsByClassName('opPrice');
			let nums = document.getElementsByClassName('num');

			for (let i = 0; i < opIdxes.length; i++) {
			  // 각 box 요소 출력
			  console.log(opIdxes[i]);
			} */
			
			/* let opIdxes = $('input[name = opIdx]').eq('0').val();
			console.log("opIdxes : " + opIdxes); */
			
			let totalPrice = document.getElementById("totalPrice").value;
    	if('${sNickname}' == "") {
    		alert('로그인 후 사용해주세요 😀');
    		location.href = "${ctp}/member/memberLogin";
    	}
    	else if(totalPrice == "" || totalPrice == 0) {
    		alert("옵션을 선택해주세요.");
    		return false;
    	}
			
			if('${cartVO}' != "") {
				let ans = confirm('이미 장바구니에 담겨있습니다.\n옵션을 추가하시겠습니까?');
				if(!ans) return false;
			}
			// 옵션 내용 Array에 담아서 보내기
			let opIdx = new Array();
			$("input[name=opIdx]").each(function(index, item){
				opIdx.push($(item).val());
		  });
			let opName = new Array();
			$("input[name=opName]").each(function(index, item){
				opName.push($(item).val());
		  });
			let opPrice = new Array();
			$("input[name=opPrice]").each(function(index, item){
				opPrice.push($(item).val());
		  });
			let num = new Array();
			$("input[name=num]").each(function(index, item){
				num.push($(item).val());
		  });
			
		 	$.ajax({
    		type  : "post",
    		url   : "${ctp}/collection/productCartInsert",
    		traditional: true,
     		data  : {
				  memNickname  : '${sNickname}',
				  type : '컬렉션 상품',
					prodIdx : '${vo.idx}',
					prodName : '${vo.prodName}',
					prodPrice : '${vo.prodPrice}',
					prodThumbnail : '${vo.prodThumbnail}',
					
					// 옵션 내용
					opIdx : opIdx,
					opName : opName,
					opPrice : opPrice,
					num : num 
    		}, 
    		success:function() {
    			let ans2 = confirm('장바구니에 담겼습니다.\n확인하시겠습니까?');
    			if(ans2) location.href = "${ctp}/order/cart";
    			else location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	});   
		}

    // 바로 주문하기
    function order() {
    	let totalPrice = document.getElementById("totalPrice").value;
    	if('${sNickname}' == "") {
    		alert('로그인 후 사용해주세요 😀');
    		location.href = "${ctp}/member/memberLogin";
    	}
    	else if(totalPrice == "" || totalPrice == 0) {
    		alert("옵션을 선택해주세요.");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:150px 0px 100px 0px">
		<div class="container-xl">
			<div class="row">
				<div class="col" style="margin-right:80px">
					<img src="${ctp}/collection/${vo.prodThumbnail}" style="width:100%; max-width:1000px; margin-bottom:10px"/>
				</div>
				<div class="col">
					<c:if test="${vo.prodStatus == '품절'}">
						<span class="badge badge-pill badge-dark" style="font-size:18px; margin:10px 0px; width:60px">품절</span><br/>
					</c:if>
					<div class="row">
						<div class="col-11"><div style="font-size:25px; font-weight:bold">${vo.prodName}</div></div>
						<div class="col-1"><span style="font-size:25px">
							<c:if test="${empty saveVO}"><i class="fa-regular fa-bookmark save" onclick="save()" title="관심등록되지 않은 상품입니다"></i></c:if>
							<c:if test="${!empty saveVO}"><i class="fa-solid fa-bookmark save" onclick="save()" title="관심등록된 상품"></i></c:if>
							</span>
						</div>
					</div>
					
					<div style="font-size:20px; margin-bottom:50px"><br/><fmt:formatNumber value="${vo.prodPrice}" pattern="#,###"/>원</div>
					<div style="font-size:17px;">상품 코드 &nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:15px">${vo.prodCode}</span></div>
					<div style="font-size:17px;">배송비 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:15px">책(의)세계는 모두 무료배송</span></div>
					<br/>
					<!-- 옵션 선택 -->
					<select id="option" class="form-control" onchange="optionSelect()">
						<option selected disabled>옵션 선택</option>
						<c:forEach var="optionVO" items="${optionVOS}">
							<option value="${optionVO.idx},${optionVO.opName},${optionVO.opPrice}" <c:if test="${optionVO.opStock == 0}">disabled</c:if>>
								${optionVO.opName}&nbsp;&nbsp;&nbsp;(<fmt:formatNumber value="${optionVO.opPrice}" pattern="#,###"/>원)
								<c:if test="${optionVO.opStock == 0}">&nbsp;&nbsp;&nbsp;[품절]</c:if>
							</option>						
						</c:forEach>
					</select>
					
				  <form name="myform" method="post" action="${ctp}/order/productOrderNow">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
				    <input type="hidden" name="memNickname" value="${sNickname}"/>
				    <input type="hidden" name="type" value="컬렉션 상품"/>
				    <input type="hidden" name="prodIdx" value="${vo.idx}"/>
				    <input type="hidden" name="prodName" value="${vo.prodName}"/>
				    <input type="hidden" name="prodPrice" value="${vo.prodPrice}"/>
				    <input type="hidden" name="prodThumbnail" value="${vo.prodThumbnail}"/>
				    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
						<hr/>
				    <!-- 옵션 가격 출력 -->
				    <div id="optionSelect"></div>

						<div class="row" style="margin-bottom:50px; margin-top:20px">
							<div class="col text-right">
								<span style="font-size:20px;">총액 &nbsp;&nbsp;</span>
								<input type=text id="totalPrice" class="text-right" value="0" style="font-size:25px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
								<span style="font-size:20px; margin-right:15px">&nbsp;원</span>
							</div>
						</div>
				  </form>
				  <div class="row">
				  	<div class="col"><button type="button" onclick="order()" <c:if test="${vo.prodStatus == '품절'}">disabled</c:if> class="btn3">바로구매</button></div>
				  	<div class="col"><button type="button" onclick="cart()" <c:if test="${vo.prodStatus == '품절'}">disabled</c:if> class="btn2">장바구니</button></div>
				  	<div class="col">
				  		<button type="button" onclick="save()" class="btn2">
				  		<c:if test="${empty saveVO}">관심상품</c:if>
				  		<c:if test="${!empty saveVO}">관심상품 취소</c:if>
				  		</button>
			  		</div>
				  </div>
				  
				</div>
			</div>
			<div class="row">
				<div class="col text-center">
					<div id="detail"></div>
					<div style="margin-top:150px" class="text-center pill-nav">
						<a href="#detail" class="active">상세설명</a> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
						<a href="#info">기타안내</a> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
						<a href="#q&a">Q&A</a>
					</div>
					<hr style="height:1px; background:#282828;"/>
					<img src="${ctp}/collection/${vo.prodDetail}"/>
				</div>
			</div>
			<div class="row">
				<div class="col text-center">
					<div id="info"></div>
					<div style="margin-top:150px" class="text-center pill-nav">
						<a href="#detail">상세설명</a> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
						<a href="#info" class="active">기타안내</a> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
						<a href="#q&a">Q&A</a>
					</div>
					<hr style="height:1px; background:#282828;"/>
					<div class="text-left">
						<br/>고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br/><br/>  

무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.<br/>  
주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.<br/>
<p><br/><br/></p>
배송 방법 : 기타<br/>
배송 지역 : 전국지역<br/>
배송 비용 : 무료배송<br/>
배송 기간 : 3일 ~ 7일<br/>
배송 안내 : - 산간벽지나 도서지방은 배송이 다소 지연될 수 있습니다.<br/>
고객님께서 주문하신 상품은 입금 확인 후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br/>
<p><br/><br/></p>
<span style="font-weight:bold">교환 및 반품이 가능한 경우</span><br/>
- 상품을 공급 받으신 날로부터 7일이내 단, 가전제품의<br/>
  경우 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.<br/>
- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과<br/>
  다르거나 다르게 이행된 경우에는 공급받은 날로부터 3월이내, 그사실을 알게 된 날로부터 30일이내<br/><br/>

<span style="font-weight:bold">교환 및 반품이 불가능한 경우</span><br/>
- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여<br/>
  포장 등을 훼손한 경우는 제외<br/>
- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우<br/>
  (예 : 가전제품, 식품, 음반 등, 단 액정화면이 부착된 노트북, LCD모니터, 디지털 카메라 등의 불량화소에<br/>
  따른 반품/교환은 제조사 기준에 따릅니다.)<br/>
- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 단, 화장품등의 경우 시용제품을<br/>
  제공한 경우에 한 합니다.<br/>
- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우<br/>
- 복제가 가능한 상품등의 포장을 훼손한 경우<br/>
  (자세한 내용은 고객만족센터 1:1 E-MAIL상담을 이용해 주시기 바랍니다.)<br/><br/>

※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.<br/>
  (색상 교환, 사이즈 교환 등 포함)<br/>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col text-center">
					<div id="q&a"></div>
					<div style="margin-top:150px" class="text-center pill-nav">
						<a href="#detail">상세설명</a> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
						<a href="#info">기타안내</a> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
						<a href="#q&a" class="active">Q&A</a>
					</div>
					<hr style="height:1px; background:#282828;"/>
					
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html>