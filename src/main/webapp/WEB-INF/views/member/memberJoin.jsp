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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<div id="container" style="margin:80px 0px">
<div class="container-xl p-5 my-5"  id="top">	
	<form name="myform" method="post" style="width:80%; margin:0px auto">
    <h2 class="text-center" style="margin-bottom:50px">JOIN</h2>
    <h5 class="text-right">${proverbVO.content}</h5>
    <h6 class="text-right">-${proverbVO.origin}</h6>
    <br/>
  	<small style="color:red; margin-top:15px">별(*) 표시는 필수 입력사항입니다.</small><br/><br/>
    <div class="form-group">
      <label for="mid">아이디 <span class="must">*</span> &nbsp; &nbsp;<input type="button" id="midBtn" value="아이디 중복체크" class="btn btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control radiusForm" name="mid" id="mid" onchange="midCheck()" placeholder="아이디를 입력하세요." required autofocus/>
    	<div id="midError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 <span class="must">*</span></label>
      <input type="password" class="form-control radiusForm" maxlength=20 name="pwd" id="pwd" onchange="pwdCheck()" placeholder="비밀번호를 입력하세요." required />
      <div id="pwdError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="pwd2">비밀번호 확인 <span class="must">*</span></label>
      <input type="password" class="form-control radiusForm" maxlength=20 name="pwd2" id="pwd2" onchange="pwd2Check()" placeholder="비밀번호를 입력하세요." required />
      <div id="pwdError2" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="nickname">별명 <span class="must">*</span> &nbsp; &nbsp;<input type="button" id="nicknameBtn" value="별명 중복체크" class="btn btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control radiusForm" name="nickname" id="nickname" onchange="nicknameCheck()" placeholder="별명을 입력하세요." autofocus required />
    	<div id="nicknameError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="name">성명 <span class="must">*</span></label>
      <input type="text" class="form-control radiusForm" name="name" id="name" onchange="nameCheck()" placeholder="성명을 입력하세요." required />
    	<div id="nameError" class="text-primary"></div>
    </div>
    <div class="form-group" style="margin:30px 0px 15px 0px">
      <label for="email1" >이메일 <span class="must">*</span> &nbsp; &nbsp; 
      <input type="button" id="emailBtn" onclick="sendCode()" value="이메일 인증" class="btn btn-sm" />  &nbsp; &nbsp; <span id="emailSpinner" class="spinner-border spinner-border-sm"  style="display:none"></span>
      <input type="button" id="changeEmail" onclick="enableEmailChange()" value="이메일 변경" class="btn btn-sm" style="display:none" /></label>
        <div class="input-group">
          <input type="text" class="form-control radiusForm" id="email1" name="email1" onblur="emailCheck()" placeholder="Email을 입력하세요." required />
          <div class="input-group-append">
            <select name="email2" id="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="nate.com">nate.com</option>
              <option value="yahoo.com">yahoo.com</option>
            </select>
          </div>
        </div>
    	<div id="emailError" class="text-primary"></div>
      <input type="hidden" name="email" id="email"/>
    </div>
    <div class="form-group">
      <label for="code">인증코드 &nbsp; &nbsp; 
    	<button type="submit" id="codeCheck" class="btn btn-sm" onclick="codeAuth()" disabled>인증</button></label>
      <input type="text" name="code" id="code" class="form-control radiusForm" disabled />
    </div>
    <div class="form-group">
      <div class="input-group mt-5 mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 <span class="must">*</span></span> &nbsp;&nbsp;
            <select name="tel1" id="tel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="02">02</option>
              <option value="031">031</option>
              <option value="032">032</option>
              <option value="041">041</option>
              <option value="042">042</option>
              <option value="043">043</option>
              <option value="051">051</option>
              <option value="052">052</option>
              <option value="061">061</option>
              <option value="062">062</option>
            </select>  -
        </div>
        <input type="number" name="tel2" id="tel2" size=4 maxlength=4 oninput='handleOnInput(this, 4)' class="form-control inputs"/>  -
        <input type="number" name="tel3" id="tel3" size=4 maxlength=4 oninput='handleOnInput(this, 4)' onchange="telCheck()" class="form-control inputs"/>
    	  <input type="hidden" name="tel" id="tel"/>
      </div>
      <div id="telError" class="text-primary"></div>
    </div> 
    <div class="form-group">
      <label for="recoMid"><i class="fa-solid fa-user-group"></i> 추천인 아이디&nbsp;&nbsp;<small>(신규회원과 추천인 모두 5000point씩 적립됩니다)</small></label>
      <input type="text" class="form-control radiusForm" name="recoMid" id="recoMid" placeholder="추천인 아이디를 입력하세요." />
    	<div id="recoMidCheck" class="text-success"></div>
    </div>
    
  	<hr/>
  	<br/>
  	<div class="form-check">
		  <label class="form-check-label">
<!-- 		    <input type="checkbox" class="form-check-input check-all"><small>이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</small> -->
		    <input type="checkbox" class="form-check-input check-all"><small>이용약관 및 개인정보수집 및 이용에 모두 동의합니다.</small>
		  </label>
		</div>
  	<br/>
		<div class="form-group">
    	<label for="agreement1">[필수] 이용약관 동의</label>
    	<textarea class="form-control" rows="7" readonly>
제1조(목적)
이 약관은 주식회사 책(전자상거래 사업자)이 운영하는 책샵 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리.의무 및 책임사항을 규정함을 목적으로 합니다.
※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」

제2조(정의)
① “몰”이란 주식회사 책이 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.
④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.

제3조 (약관 등의 명시와 설명 및 개정)
① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호.모사전송번호.전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보보호책임자등을 이용자가 쉽게 알 수 있도록 책샵 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회.배송책임.환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.
⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.

제4조(서비스의 제공 및 변경)
① “몰”은 다음과 같은 업무를 수행합니다.
  1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
  2. 구매계약이 체결된 재화 또는 용역의 배송
  3. 기타 “몰”이 정하는 업무
② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.
③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.
④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.

제5조(서비스의 중단)
① “몰”은 컴퓨터 등 정보통신설비의 보수점검.교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.

제6조(회원가입)
① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.
  1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
  2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
  3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.
④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.

제7조(회원 탈퇴 및 자격 상실 등)
① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.
② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.
  1. 가입 신청 시에 허위 내용을 등록한 경우
  2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
  3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
  4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
③ “몰”이 회원 자격을 제한.정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.
④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.

제8조(회원에 대한 통지)
① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.
② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.

제9조(구매신청)
① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다.
  1. 재화 등의 검색 및 선택
  2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력
  3. 약관내용, 청약철회권이 제한되는 서비스, 배송료.설치비 등의 비용부담과 관련한 내용에 대한 확인
  4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)
  5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의
  6. 결제방법의 선택
② “몰”이 제3자에게 구매자 개인정보를 제공·위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이 때 “몰”은 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보 이용 목적 및 보유·이용 기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조 제1항에 의한 개인정보 처리위탁의 경우 등 관련 법령에 달리 정함이 있는 경우에는 그에 따릅니다.

제10조 (계약의 성립)
① “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.
  1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
  2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우
  3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우
② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.
③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.

제11조(지급방법)
“몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
3. 온라인무통장입금
4. 전자화폐에 의한 결제
5. 수령 시 대금지급
6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제
7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제
8. 기타 전자적 지급 방법에 의한 대금 지급 등

제12조(수신확인통지.구매신청 변경 및 취소)
① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.
② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.

제13조(재화 등의 공급)
① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.
② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의.과실이 없음을 입증한 경우에는 그러하지 아니합니다.

제14조(환급)
“몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.

제15조(청약철회 등)
① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.
② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.
  1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
  2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
  3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
  4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우
③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.
④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.

제16조(청약철회 등의 효과)
① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율(괄호 부분 삭제)을 곱하여 산정한 지연이자를 지급합니다.
② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.
③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.
④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.

제17조(개인정보보호)
① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.
② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.
③ “몰”은 이용자의 개인정보를 수집·이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다.
④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.
⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보보호 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.
⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.
⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 처리하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.
⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.
⑨ “몰”은 개인정보의 수집·이용·제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.

제18조(“몰“의 의무)
① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화.용역을 제공하는데 최선을 다하여야 합니다.
② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.
③ “몰”이 상품이나 용역에 대하여 「표시.광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시.광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.
④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.

제19조(회원의 ID 및 비밀번호에 대한 의무)
① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.

제20조(이용자의 의무)
이용자는 다음 행위를 하여서는 안 됩니다.
1. 신청 또는 변경시 허위 내용의 등록
2. 타인의 정보 도용
3. “몰”에 게시된 정보의 변경
4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위

제21조(연결“몰”과 피연결“몰” 간의 관계)
① 상위 “몰”과 하위 “몰”이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고 합니다.
② 연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다.

제22조(저작권의 귀속 및 이용제한)
① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.
② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.

제23조(분쟁해결)
① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치.운영합니다.
② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.
③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.

제24조(재판권 및 준거법)
① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.

부 칙(시행일) 이 약관은 년 월 일부터 시행합니다.
    	</textarea>
    </div>
   	<div class="form-check">
		  <label class="form-check-label">
		    <input type="checkbox" id="agreement1" class="form-check-input agree"><small>이용약관에 동의합니다.</small>
		  </label>
		</div>
    <br/><br/>
		<div class="form-group">
    	<label for="agreement2">[필수] 개인정보 수집 및 이용 동의</label>
    	<textarea class="form-control" rows="7" readonly>
1. 개인정보 수집목적 및 이용목적

가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산

콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송 , 금융거래 본인 인증 및 금융 서비스

나. 회원 관리

회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등 민원처리 , 고지사항 전달

2. 수집하는 개인정보 항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 전화번호 , 휴대전화번호 , 이메일 , 14세미만 가입자의 경우 법정대리인의 정보

3. 개인정보의 보유기간 및 이용기간

원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.

가. 회사 내부 방침에 의한 정보 보유 사유

o 부정거래 방지 및 쇼핑몰 운영방침에 따른 보관 : 회원탈퇴 후 5일까지

나. 관련 법령에 의한 정보보유 사유

o 계약 또는 청약철회 등에 관한 기록

-보존이유 : 전자상거래등에서의소비자보호에관한법률

-보존기간 : 5년

o 대금 결제 및 재화 등의 공급에 관한 기록

-보존이유: 전자상거래등에서의소비자보호에관한법률

-보존기간 : 5년

o 소비자 불만 또는 분쟁처리에 관한 기록

-보존이유 : 전자상거래등에서의소비자보호에관한법률

-보존기간 : 3년

o 로그 기록

-보존이유: 통신비밀보호법

-보존기간 : 1개월

※ 동의를 거부할 수 있으나 거부시 회원 가입이 불가능합니다.
    	</textarea>
    </div>
  	<div class="form-check">
		  <label class="form-check-label">
		    <input type="checkbox" id="agreement2" class="form-check-input agree"><small>개인정보 수집 및 이용에 동의합니다.</small>
		  </label>
		</div>
		<div class="text-center" style="margin: 50px 0px">
    	<button type="button" onclick="joinCheck()" class="jClick" style="background-color:#F5EBE0; font-size: 0.9em; border-color:#282828; color:black">회원가입</button>
      <input type="hidden" name="memType" value="일반"/>
  	</div>
  </form>
</div>
</div>
<footer>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</footer>
</body>
	<script>
		'use strict';
		
		// 아이디 중복버튼을 클릭했는지의 여부를 확인하기 위한 변수(버튼 클릭 후엔 내용 수정처리 불가)
		let idCheckSw = 0;
		
		// 아이디 중복 검사 
		function idCheck() {
			let mid = myform.mid.value.trim();
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자
			
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
				return false;
			}
			else if(!regex1.test(mid)) {
				document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영문/숫자만 4~20자)";
		    myform.mid.focus();
				return false;
			}
			
		$.ajax({
			type : "post",
			url  : "${ctp}/member/memberIdCheck",
			data : {mid : mid},
			success:function(res) {
				if(res == "1") {
					alert("이미 사용 중인 아이디 입니다. 다시 입력해 주세요");
					$("#mid").focus();
				}
				else  {
					alert("사용 가능한 아이디 입니다.");
					idCheckSw = 1;
					myform.mid.readOnly = true;
					$("#pwd").focus();
				}
			}
		});
		}
		
		// 별명 중복버튼을 클릭했는지의 여부를 확인하기 위한 변수(버튼 클릭 후엔 내용 수정처리 불가)
		let nicknameCheckSw = 0;
		
		// 별명 중복 검사 
		function nickCheck() {
			let nickname = myform.nickname.value.trim();
			let regex6 = /^[가-힣0-9]+$/; //(별명)한글,영문,숫자만 적어도 1자이상 
			
			if(nickname == "") {
				alert("별명을 입력하세요");
				myform.nickname.focus();
				return false;
			}
			else if(!regex6.test(nickname)) {
				document.getElementById("nicknameError").innerHTML="별명 형식에 맞춰주세요.(한글/숫자만 1자 이상)";
				myform.nickname.focus();
				return false;
			}
			
		$.ajax({
			type : "post",
			url  : "${ctp}/member/memberNicknameCheck",
			data : {nickname : nickname},
			success:function(res) {
				if(res == "1") {
					alert("이미 사용 중인 별명입니다. 다시 입력해 주세요");
					$("#nickname").focus();
				}
				else  {
					alert("사용 가능한 별명입니다.");
						myform.nickname.readOnly = true;
					nicknameCheckSw = 1;
					$("#nickname").focus();
				}
			}
		});
		}
		
		// 전화번호 길이 제한(4자리 이상부터 입력 불가)
		function handleOnInput(el, maxlength) {
		  if(el.value.length > maxlength)  {
		    el.value 
		      = el.value.substr(0, maxlength);
		  }
		}
		
		// 첫 번째 전화번호 내용 입력 후 자동으로 커서 옮기기
		$(document).ready(function() {
	    $(".inputs").keyup(function () {
	    if (this.value.length == this.maxLength) {
	      $(this).next('.inputs').focus();
	    }
	    });
		});	
		
		
		let check = true;
	
		// 가입부분 체크
		function joinCheck(){
		  let mid = document.getElementById("mid").value.trim();
		  let pwd = document.getElementById("pwd").value.trim();
		  let pwd2 = document.getElementById("pwd2").value.trim();
		  let nickname = document.getElementById("nickname").value.trim();
		  let name = document.getElementById("name").value.trim();
		  
			let email1 = myform.email1.value.trim();
			let email2 = myform.email2.value;
			let email = email1 + "@" + email2;
		
		  let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  let agreement1 = document.getElementById("agreement1").checked;
		  let agreement2 = document.getElementById("agreement2").checked;
		  
		  let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
		  let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; 
		  //(비밀번호)4자 이상 20자 이하, 영문/숫자 1개 이상 필수, 특수문자 허용
		  
		  let regex3 = /^[가-힣a-zA-Z]{2,10}$/;  // (성명)한글,영문 2~10자
	 		let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일 
	 		let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
	 		let regex6 = /^[가-힣0-9]{2,10}$/; //(별명)한글,숫자 2~10자
			
		  	
		  // 아이디 확인
		  if(!regex1.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영문/숫자만 4~20자)";
		    check = false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
			   check = true;
		  }
/*		  
			  // 비밀번호 확인
		  if(!regex2.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영문/숫자 필수, 특수문자 가능 4~20자)";
		    check = false;
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
			    
			  if(pwd2=== "") {
			    document.getElementById("pwdError2").innerHTML="비밀번호를 다시 입력해주세요.";
			    check = false;
			  }
			  else if(pwd !== pwd2) {
			    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
			    check = false;
			  }
			  else {
		  	  document.getElementById("pwdError").innerHTML="";
		  	  document.getElementById("pwdError2").innerHTML="";
		  	  check = true;
			  }
		  } 
*/		  
		  // 별명 확인
		  if(!regex6.test(nickname)){
		    document.getElementById("nicknameError").innerHTML="별명이 올바르지 않습니다.(한글/숫자만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nicknameError").innerHTML="";
			  check = true;
		  }	
				  
		  // 성명 확인
		  if(!regex3.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
			  check = true;
		  }
		   
		  // 이메일확인
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }	 
				     
	
		  // 전화번호 확인
		  if(tel2==="" || tel3===""){
		    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		    check = true;
		  }
		  
		  if(!check){
	/* 			  alert('입력된 값을 다시 확인해주세요.'); */
			  alert('책(의)세계로 갈 준비를 완료해주세요!');
			  window.scrollTo(0,130); // (그냥 위치만 바뀌는)스크롤 위로 올리기 
			  check = true;
		  }
		  else if(agreement1 == false || agreement2 == false) {
			  alert('필수 약관 동의가 필요합니다.');
		  }
		  else {
		    if(idCheckSw == 0) {
					alert("아이디 중복확인을 해주세요.");
					document.getElementById("midBtn").focus();
				} 
		    else if(nicknameCheckSw == 0) {
					alert("별명 중복확인을 해주세요.");
					document.getElementById("nicknameBtn").focus();
				} 
		    else if(emailCheckSw == 0) {
					alert("이메일 인증을 완료 해주세요.");
					document.getElementById("emailBtn").focus();
				} 
				else {
			    myform.tel.value = tel;
			    myform.email.value = email;
			   	myform.submit();
				}
		  }
		}
		
		function midCheck() {
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
			let mid = document.getElementById("mid").value.trim();
			document.getElementById("midError").innerHTML="";
			
		  // 아이디 확인
		  if(!regex1.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영문/숫자만 4~20자)";
		    check = false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
			   check = true;
		  }			
		}	
/*		
		function pwdCheck() {
				
			let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영문/숫자 1개 이상 필수, 특수문자 허용
			let pwd = document.getElementById("pwd").value.trim();
			document.getElementById("pwdError").innerHTML="";
			
		  // 비밀번호 확인
		  if(!regex2.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영문/숫자 필수, 특수문자 가능 4~20자)";
		    check = false;
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
	  	  check = true;
	  	}	
		}
		function pwd2Check() {
			let pwd = document.getElementById("pwd").value.trim();
			let pwd2 = document.getElementById("pwd2").value.trim();
			document.getElementById("pwdError").innerHTML="";
			document.getElementById("pwdError2").innerHTML="";
			
			
		  // 비밀번호 확인2
		  if(pwd !== pwd2) {
			    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
			    check = false;
		  }
		  else {
	  	  document.getElementById("pwdError").innerHTML="";
	  	  document.getElementById("pwdError2").innerHTML="";
	  	  check = true;
		  }
		} 
*/		
		function nameCheck() {
			
			let regex3 = /^[가-힣a-zA-Z]{2,10}$/;  // (성명)한글,영문 2~10자
			let name = document.getElementById("name").value.trim();
			document.getElementById("nameError").innerHTML="";
			
		  // 성명 확인
		  if(!regex3.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
			  check = true;
		  }			
		}
		
		function nicknameCheck() {
			let regex6 = /^[가-힣0-9]{2,10}$/; //(별명)한글,숫자 2~10자
			let nickname = document.getElementById("nickname").value.trim();
			document.getElementById("nicknameError").innerHTML="";
			
		  // 별명 확인
		  if(!regex6.test(nickname)){
		    document.getElementById("nicknameError").innerHTML="별명이 올바르지 않습니다.(한글/숫자만 2~10자)";
		    check = false;
		  }
		  else {
			  document.getElementById("nicknameError").innerHTML="";
			  check = true;
		  }			
		}
		
		function emailCheck() {
			let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일
			let email1 = document.getElementById("email1").value.trim();
		  document.getElementById("emailError").innerHTML="";
	
		  // 이메일확인
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }			
		}
		
		// 이메일 인증버튼을 클릭했는지의 여부를 확인하기 위한 변수
		let emailCheckSw = 0;
	      
		let emailInput1 = document.getElementById('email1');
		let emailInput2 = document.getElementById('email2');
	  let emailBtn = document.getElementById('emailBtn');
	  let changeEmailBtn = document.getElementById('changeEmail');
	  let codeInput = document.getElementById('code');
	  let codeCheck = document.getElementById('codeCheck'); 
	  let emailSpinner = document.getElementById('emailSpinner'); 
	  let timerId;
	  let timerElement = document.createElement('span');
	  timerElement.id = 'timer';
	  codeCheck.parentNode.appendChild(timerElement);
	  let emailAuth = "";
	  
	  
	  function sendCode() {
			let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일
			let email1 = document.getElementById("email1").value.trim();
		  document.getElementById("emailError").innerHTML="";
	
		  // 이메일확인
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
				
			  // 이메일 스피너 생성
			  emailSpinner.style.display = 'inline-block';
			  
				let email1 = myform.email1.value.trim();
	    	let email2 = myform.email2.value;
	    	let email = email1 + "@" + email2;
				
	      // 인증코드 이메일 발송 처리
	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/member/memberEmailAuth",
	    	  data : {email : email},
	    	  success : function(res) {
	    		  emailAuth = res;
	    		  
				    emailInput1.readOnly = true;
				    emailInput2.disabled = true;
				    emailBtn.disabled = true;
				    changeEmailBtn.style.display = 'inline-block';
				    timerId = startTimer();
				    enableCodeCheck(); 
						
				    alert("메일함에서 인증코드를 확인해주세요.");
						// 이메일 스피너 가리기
					  emailSpinner.style.display = 'none';
	    	  },
	    	  error : function() {
	    		  alert('이메일 인증 오류가 발생했습니다. 재시도 부탁드립니다.')
						// 이메일 스피너 가리기
					  emailSpinner.style.display = 'none';
	    	  }
	      });
		    
		  }
		
	  }
	
	  function enableEmailChange() {
	    emailInput1.readOnly = false;
	    emailInput2.disabled = false;
	    changeEmailBtn.style.display = 'none';
	    codeInput.value = '';
	    timerElement.textContent = '';
	    codeInput.disabled = true;
	    clearInterval(timerId);
	    emailBtn.disabled = false;
	    disableCodeCheck();
	  }
	
	  function startTimer() {
		  let timeLeft = 180;
	
	
	    function countDown() {
	      if (timeLeft === -1) {
	        clearInterval(timerId);
	        disableCodeCheck();
	      } else {
	        timerElement.textContent = '                 (남은 시간: ' + timeLeft + '초)';
	        timeLeft--;
	      }
	    }
	
	    countDown();
	    return setInterval(countDown, 1000);
	  }
	
	  function enableCodeCheck() {
	    codeCheck.disabled = false;
	    codeInput.disabled = false;
	  } 
	
	  function disableCodeCheck() {
	    codeCheck.disabled = true;
	    codeInput.disabled = true;
	  }
	
	  function disableVerification() {
	    emailBtn.disabled = true;
	    emailInput1.readOnly = true;
	    emailInput2.disabled = true;
	    changeEmailBtn.style.display = 'none';
	    clearInterval(timerId);
	  }
	
		function codeAuth() {
			let code = document.getElementById('code').value;
			
			if(code == emailAuth) {
				alert('이메일 인증에 성공했습니다!');
				disableCodeCheck();
				disableVerification();
				emailCheckSw = 1;
			}
			else {
				alert('인증코드가 일치하지 않습니다. 재시도 부탁드립니다.');
				enableCodeCheck();
			}
		}
	
	
		function telCheck() {
			let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
		  let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  // 전화번호 확인
		  if(tel2==="" || tel3===""){
		    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		    check = true;
		  }
		}
		
		$(document).ready(function(){
			$('#recoMid').focusout(function(){
				let recoMid =document.getElementById("recoMid").value.trim();
				let str = '';
				
				if(recoMid != '') {
					$.ajax({
						type : "post",
						url : "${ctp}/member/recoMid",
						data : {recoMid : recoMid},
						success : function(res) {
							if(res == '1') {
							  /* check = true; 이걸 이렇게 주는 게 맞나? */
								str += '<span>존재하는 회원입니다.</span>';
							}
							else {
								str += '<span>존재하지 않는 회원입니다. 적립이 불가능합니다 :)</span>';
							}
							$('#recoMidCheck').html(str);
						},
						error : function() {
							alert('추천인 아이디 검색 오류\n재시도 부탁드립니다.');
						}
					});
				}
				else {
					$('#recoMidCheck').html(str);
				}
			});
			
			
			$('.check-all').click(function(){
				$('.agree').prop('checked',this.checked);
			});
		});
	

	</script>
	<style>
		html {scroll-behavior:smooth;}
		body {color:#212529;}
		#container {font-size: 1.1em;}
		
		.text-primary {
			font-size: 0.8em;
			padding:2px 10px;
		}
		.text-success {
			font-size: 0.8em;
			padding:2px 10px;
		}
		.radiusForm {
			border-radius:70px; 
		}
		.jClick {
			width:100%;
		  max-width: 300px;
	    padding: 15px;
	    border-radius:500px; 
		}
/* 		.btn {
		  background-color: white;
  		border-color: #ffa0c5;
  		color: #ffa0c5;
  		border-width: medium;
		}
		.btn:hover {
			background-color: #ffa0c5;
			color: white;
		} */
		.btn {
		  background-color: white;
  		border-color: #9DB2BF;
  		color: #9DB2BF;
  		border-width: medium;
		}
		.btn:hover {
			background-color: #27374D;
			color: white;
		}
		.must {
  		color: red;
		}
	</style>
</html>