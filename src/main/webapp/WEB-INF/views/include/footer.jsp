<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	a:link {text-decoration: none !important;}
	a:visited {text-decoration: none !important;}
	a:hover {text-decoration: none !important;}
	a:active {text-decoration: none !important;}
</style>
<script>
	'use strict';
	
	// 3개의 책으로 이동하기
	function move() {
		if(confirm('3개의 책으로 이동하시겠습니까?')) {
			location.href = "${ctp}/community/communityMain";
		}	
	}
</script>
<!-- Footer -->
<footer class="w3-container" style="background-color:#282828; color:#DDDDDD">
	<div class="row" style="margin-top: 20px">
		<div class="col text-center">
			<a href="${ctp}/about/about"><span style="font-size:20px; font-weight:bold">책(의)세계란</span></a>
		</div>
		<div class="col text-center">
			<a href="${ctp}/magazine/magazineList"><span style="font-size:20px; font-weight:bold">책 Chaeg 매거진</span></a>
		</div>
		<div class="col text-center">
			<a href="javascript:move()"><span style="font-size:20px; font-weight:bold">3개의 책</span></a>
		</div>
		<div class="col text-center">
			<a href="${ctp}/game/dice"><span style="font-size:20px; font-weight:bold">게임</span></a>
		</div>
	</div>
	<hr/>
	<div class="row" style="margin:50px 200px">
		<div class="col-8">
			법인명(상호) : 주식회사 책(의)세계 | 대표자(성명) : 우혜진<br/>
			사업자 등록번호 안내 : [105-88-09681]<br/>
			통신판매업 신고 : 제2019-서울종로-0831호[사업자정보확인]<br/>
			전화 : 02-6228-5589 | 팩스 : 02-6442-5589<br/>
			주소 : 03015 서울특별시 종로구 세검정로 243 (신영동) 2층 (신영동 176-24)<br/>
			이메일 : info@chaeg.co.kr | info@chaeg.co.kr 개인정보보호책임자 : 우혜진(info@chaeg.co.kr)<br/><br/>
			Copyright © 책(의)세계. All rights reserved.
		</div>
		<div class="col-4">
			<span style="font-size:23px; font-weight:bold">고객센터<br/>
			02-6228-5589</span><br/><br/>
			월-금 09:30~18:30 | 첫째,둘째 금요일 휴무 <br/>
			토, 일, 공휴일 휴무 | 점심시간 12:00~13:00<br/>
			하나은행 298-910034-05304 [ 주식회사 책(의)세계 ]<br/>
		</div>
	</div>
</footer>