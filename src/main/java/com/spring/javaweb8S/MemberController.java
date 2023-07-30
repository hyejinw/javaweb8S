package com.spring.javaweb8S;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.AdminService;
import com.spring.javaweb8S.service.MemberService;
import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.DeliveryVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.PointUseVO;
import com.spring.javaweb8S.vo.PointVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.RefundVO;
import com.spring.javaweb8S.vo.SaveVO;
import com.spring.javaweb8S.vo.SubscribeVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
	// 로그인 창
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("cMid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST, produces="application/text; charset=utf-8")
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required=false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required=false) String idSave,
			HttpSession session) throws UnsupportedEncodingException {
		MemberVO vo = memberService.getMidCheck(mid);
		
		if(vo == null || vo.getMemberDel().equals("탈퇴")) {
			return "redirect:/message/memberMidNo";
		}	
		else if(!passwordEncoder.matches(pwd, vo.getPwd())) {
			return "redirect:/message/memberPwdNo";
		}
		
		// 회원정보 일치
		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("sNickname", vo.getNickname());
		session.setAttribute("sMemType", vo.getMemType());
		// 커뮤니티 메뉴에 띄울 회원 사진, 세션에 저장
		session.setAttribute("sMemPhoto", vo.getMemPhoto());
		
		if(idSave.equals("on")) {
			Cookie cookie = new Cookie("cMid", mid);
			cookie.setMaxAge(60*60*24*7);
			response.addCookie(cookie);
		}
		else {
			Cookie[] cookies = request.getCookies();
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
					break;
				}
			}
		}
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strToday = sdf.format(today);

		// 오늘 처음 방문 시는 오늘 방문 카운트(todayCnt)를 0으로 세팅
		if (!vo.getLastVisit().substring(0, 10).equals(strToday)) {
			vo.setTodayCnt(0);
		}

		// 로그인한 사용자의 총 방문 수, 오늘 방문 수, 마지막 방문일을 변경
		memberService.setMemberLoginProcess(vo);
		
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");
		return "redirect:/message/memberLoginOk?nickname="+nickname;
	}
	
	// 회원가입 창
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet(Model model) {
		
		int proverbNum = memberService.getProverbTotalNum();
		
		// 1 ~ 명언 총 개수 사이의 랜덤한 정수를 얻는다.
		int randomNum = (int) ((Math.random() * proverbNum) + 1);
		ProverbVO proverbVO = memberService.getRandomProverb(randomNum - 1);
		
		model.addAttribute("proverbVO", proverbVO);
		return "member/memberJoin";
	}
	
	// 회원가입 시, 아이디 중복 검사
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMidCheck(mid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 회원가입 시, 별명 중복 검사
	@ResponseBody
	@RequestMapping(value = "/memberNicknameCheck", method = RequestMethod.POST)
	public String memberNicknameCheckt(String nickname) {
		MemberVO vo = memberService.getNicknameCheck(nickname);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 회원가입 시, 추천인 아이디 검색!
	@ResponseBody
	@RequestMapping(value = "/recoMid", method = RequestMethod.POST)
	public String recoMidPost(String recoMid) {
		MemberVO vo = memberService.getMidCheck(recoMid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 회원가입 시, 이메일 인증!
	@ResponseBody
	@RequestMapping(value = "/memberEmailAuth", method = RequestMethod.POST)
	public String memberEmailAuthPost(String email, HttpServletRequest request) throws MessagingException {
		
		// 이메일 인증용 랜덤 숫자배열 6자리
		UUID uid = UUID.randomUUID();
		String emailAuth = uid.toString().substring(0,6);
		
		// 이메일 전송!
		mailAuthSend(email, emailAuth, request);
		return emailAuth;
	}

	// 이메일 인증코드 발송
	private void mailAuthSend(String toMail, String emailAuth, HttpServletRequest request) throws MessagingException {
		String title = "책(의)세계에서 발송한 이메일 인증코드입니다";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		String content = "";
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
		content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>이메일 인증코드를 보내드립니다.</h4><br>";
		content += "<br><hr><h2><font color='blue'>"+emailAuth+"</font></h2><br>";
		content += "<br><h4>위 인증코드를 입력해주세요!</h4>";
		content += "<h3>책(의)세계 드림</h3><br>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
		
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		File file = new File(realPath + "logo.png");
//		FileSystemResource file = new FileSystemResource("D:\\javaweb\\springframework\\project\\javaweb8S\\src\\main\\webapp\\resources\\images\\logo.png");
//		FileSystemResource file = new FileSystemResource("//Users//fromj//coding//javaweb//springframework//javaweb8S//javaweb8S//src//main//webapp//resources//images//logo.png");
		messageHelper.addInline("logo.png", file);

		// 메일 전송
		mailSender.send(message);
	}
	
	// 로그아웃
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) throws UnsupportedEncodingException {
		//String nickname = (String) session.getAttribute("sNickname");
		String nickname = (String) session.getAttribute("sNickname");
		
		session.invalidate();
		nickname = URLEncoder.encode(nickname, "UTF-8");
		return "redirect:/message/memberLogout?nickname="+nickname;
	}
	
	// 아이디 찾기 창
	@RequestMapping(value = "/idFinder", method = RequestMethod.GET)
	public String idFinderGet() {
		return "member/idFinder";
	}
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/idFinder", method = RequestMethod.POST, produces="application/text; charset=utf-8")
	public String idFinderPost(
			@RequestParam(name = "name", defaultValue = "", required = false) String name,
			@RequestParam(name = "email", defaultValue = "", required = false) String email) {
		String res = memberService.getMidFinder(name, email);
		
		if(res == null || res.isEmpty()) {
			res = "입력하신 정보와 일치하는 회원이 없습니다.";
		}
		return res;
	}
	
	// 비밀번호 찾기 창
	@RequestMapping(value = "/pwdFinder", method = RequestMethod.GET)
	public String pwdFinderGet() {
		return "member/pwdFinder";
	}

	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value = "/pwdFinder", method = RequestMethod.POST, produces="application/text; charset=utf-8")
	public String pwdFinderPost(HttpServletRequest request,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "email", defaultValue = "", required = false) String email) throws MessagingException {
		String res = memberService.getPwdFinder(mid, email);
		
		if(res == null || res.isEmpty()) {
			res = "입력하신 정보와 일치하는 회원이 없습니다.";
		}
		
		// 이메일로 임시 비밀번호 전송
		else {
			// 임시 비밀번호 랜덤 숫자배열 6자리
			UUID uid = UUID.randomUUID();
			String tempPwd = uid.toString().substring(0,6);

			// 회원이 임시 비밀번호를 변경할 수 있도록 유도하기 위한 임시 세션 1개 생성
			HttpSession session = request.getSession();
			session.setAttribute("sTempPwd", "Ok");
			
			// 발급받은 임시비밀번호를 암호화시켜서 DB에 저장
			memberService.setMemberPwdUpdate(mid, passwordEncoder.encode(tempPwd));
			
			// 이메일 전송!
			mailTempPwdSend(email, tempPwd, request);
		}
		return res;
	}
	
	// 이메일로 임시 비밀번호 발송 
	private void mailTempPwdSend(String email, String tempPwd, HttpServletRequest request) throws MessagingException {
		String title = "책(의)세계에서 발송한 임시 비밀번호입니다";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		String content = "";
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
		content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>임시 비밀번호를 보내드립니다.</h4><br>";
		content += "<br><hr><h2><font color='blue'>"+tempPwd+"</font></h2><br>";
		content += "<br><h4>로그인 후, 마이페이지에서 비밀번호를 변경해주세요!</h4>";
		content += "<h3>기쁜 마음으로, 책(의)세계 드림</h3><br>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		File file = new File(realPath + "logo.png");		
//		FileSystemResource file = new FileSystemResource("D:\\javaweb\\springframework\\project\\javaweb8S\\src\\main\\webapp\\resources\\images\\logo.png");
//		FileSystemResource file = new FileSystemResource("//Users//fromj//coding//javaweb//springframework//javaweb8S//javaweb8S//src//main//webapp//resources//images//logo.png");
		messageHelper.addInline("logo.png", file);

		// 메일 전송
		mailSender.send(message);
	}
	

	// 회원가입
	@Transactional
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo,
			@RequestParam(name="recoMid", defaultValue = "", required=false) String recoMid) {
		
		if(memberService.getMidCheck(recoMid) != null) {
			vo.setPoint(10000);
			
			// 추천인 포인트 증가
			memberService.setMemberPoint(recoMid, 5000);
			// 추천인 point 테이블 처리
			memberService.setRecoMidPointInsert(recoMid, 5000, "추천인 가입");
		}
		else vo.setPoint(5000);
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));  // 비밀번호 암호화
		
		int res = memberService.setMember(vo);   // 회원 가입
		
		
		// 뉴스레터 비회원 구독 중인지 확인
		String booksletterIdx = memberService.getBooksletterCheck(vo.getEmail());
		
		// 맞다면, 회원 별명 추가
		if(booksletterIdx != null) memberService.setBooksletterInsert(booksletterIdx, vo.getNickname());
			
		
		// 회원 포인트 적립
		if(memberService.getMidCheck(recoMid) != null) memberService.setPointInsert(vo.getNickname(), 10000, "가입 축하포인트 + 추천인 가입");
		else memberService.setPointInsert(vo.getNickname(), 5000, "가입 축하포인트");
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	// 회원 마이페이지
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String memberPageGet(HttpSession session, Model model) {
		String nickname = (String) session.getAttribute("sNickname");
		
		// 회원 기본 정보 +  가용 포인트
		MemberVO memberVO = memberService.getMemberInfo(nickname);
		model.addAttribute("memberVO", memberVO);
		
		// 총 포인트
		String totalPoint = memberService.getTotalPoint(nickname);
		model.addAttribute("totalPoint", totalPoint);
		
		// 사용 포인트
		String totalUsedPoint = memberService.getTotalUsedPoint(nickname);
		model.addAttribute("totalUsedPoint", totalUsedPoint);
		
		// 총 주문 횟수, 총 주문 금액
		OrderVO orderVO = memberService.getTotalOrder(nickname);
		model.addAttribute("orderVO", orderVO);
		
		// 최근 3개월 동안의 주문 현황 상태 개수 (결제완료, 배송준비중, 배송중, 배송완료, 환불완료)
		String orderLevel1Num = memberService.getOrderStatusNum("결제완료", nickname);
		String orderLevel2Num = memberService.getOrderStatusNum("배송준비중", nickname);
		String orderLevel3Num = memberService.getOrderStatusNum("배송중", nickname);
		String orderLevel4Num = memberService.getOrderStatusNum("배송완료", nickname);
		String orderLevel5Num = memberService.getOrderStatusNum("환불완료", nickname);
		
		model.addAttribute("orderLevel1Num", orderLevel1Num);
		model.addAttribute("orderLevel2Num", orderLevel2Num);
		model.addAttribute("orderLevel3Num", orderLevel3Num);
		model.addAttribute("orderLevel4Num", orderLevel4Num);
		model.addAttribute("orderLevel5Num", orderLevel5Num);
		
		return "member/myPage";
	}
	
	// 마이페이지, 주문 관리창
	@RequestMapping(value = "/myPage/order", method = RequestMethod.GET)
	public String orderListGet(Model model, HttpSession session,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "상품명", required = false) String search,
			@RequestParam(name="startDate", defaultValue = "", required = false) String startDate,
			@RequestParam(name="endDate", defaultValue = "", required = false) String endDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		PageVO pageVO = new PageVO();
		ArrayList<OrderVO> vos = new ArrayList<OrderVO>();
		
		String nickname = (String) session.getAttribute("sNickname");
		
		if(search.equals("invoice")) {
			pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "myPageOrderWithInvoice", sort, nickname+"/"+search, searchString, startDate, endDate);
			vos = memberService.getOrderWithInvoiceSearchList(sort, search, searchString, startDate, endDate, nickname, pageVO.getStartIndexNo(), pageSize);
		}
		else {
			pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "myPageOrder", sort, nickname+"/"+search, searchString, startDate, endDate);
			vos = memberService.getOrderSearchList(sort, search, searchString, startDate, endDate, nickname, pageVO.getStartIndexNo(), pageSize);
		}
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "member/myPage/order";
	}
	
	// 주문 관리창, 주문 상세 정보(팝업)
	@RequestMapping(value = "/myPage/orderInfo", method = RequestMethod.GET)
	public String orderInfoGet(Model model, int idx, HttpSession session) {

		String memNickname = (String) session.getAttribute("sNickname");
		
		OrderVO vo = adminService.getOrderInfo(idx);
		DeliveryVO deliveryVO = adminService.getDeliveryInfo(idx);
		MemberVO memberVO = adminService.getMemberInfo(memNickname);
		AddressVO addressVO = adminService.getAddressInfo(vo.getAddressIdx());
		RefundVO refundVO = adminService.getRefundInfo(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addressVO", addressVO);
		model.addAttribute("refundVO", refundVO);
		
		return "member/myPage/orderInfo";
	}
	
	// 주문 관리창, 정기구독 주문 상세 정보(팝업)
	@RequestMapping(value = "/myPage/subOrderInfo", method = RequestMethod.GET)
	public String subOrderInfoGet(Model model, int idx, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		OrderVO vo = adminService.getOrderInfo(idx);
		ArrayList<DeliveryVO> deliveryVOS = adminService.getSubDeliveryInfo(idx);
		MemberVO memberVO = adminService.getMemberInfo(memNickname);
		AddressVO addressVO = adminService.getAddressInfo(vo.getAddressIdx());
		SubscribeVO subscribeVO = adminService.getSubscribeInfo(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("deliveryVOS", deliveryVOS);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addressVO", addressVO);
		model.addAttribute("subscribeVO", subscribeVO);
		
		return "member/myPage/subOrderInfo";
	}
	
	// 마이페이지, 주문 조회창 구매확정
	@ResponseBody
	@RequestMapping(value = "/myPage/orderComplete", method = RequestMethod.POST)
	public String orderCompletePost(int idx, String memNickname) {
		
		// 구매확정
		memberService.setOrderComplete(idx);
		
		// 포인트 지급
		memberService.setOrderPointInsert(idx, memNickname);
	
		// 회원 테이블 포인트 값 변경
		memberService.setMemberPointUpdate(idx, memNickname);
		
		return "";
	}
	
	// 마이페이지 반품 신청
	@Transactional
	@RequestMapping(value = "/myPage/refundInsert", method = RequestMethod.POST)
	public String refundInsertPost(MultipartFile file, RefundVO vo) {

		if(vo.getMaIdx().equals("0")) vo.setMaIdx(null);
		if(vo.getOpIdx().equals("0")) vo.setOpIdx(null);
		
		// 1) 주문 테이블 수정
		// 주문 테이블 상품 상태 변경 (반품신청)
		memberService.setOrderRefundStatus(vo.getOrderIdx());
		
		// 일부만 반품
		if(vo.getOriginOrderNum() != vo.getRefundNum()) {
			
			// 나머지 상품은 구매확정 포인트 지급
			int point = Integer.parseInt(String.format("%.0f", (vo.getOriginPaidPrice() - vo.getRefundPrice()) * 0.05));
			memberService.setPartlyOrderPointInsert(vo.getOrderIdx(), point, vo.getMemNickname());
			
			// 회원 테이블 포인트 값 변경
			memberService.setPartlyMemberPointUpdate(point, vo.getMemNickname());
		}
		
		// 2) 반품 테이블 추가
		// 반품 코드 생성
		SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
		Date today = new Date();
		String str = format.format(today);
		UUID uid = UUID.randomUUID();
		
		vo.setRefundCode(str + uid.toString().substring(0,5));
		int res = memberService.setRefundInsert(file, vo);
		
		if(res != 0) return "redirect:/message/refundInsertOk";
		else return "redirect:/message/refundInsertNo";
	}
	
	// 마이페이지, 회원정보 창
	@RequestMapping(value = "/myPage/profile", method = RequestMethod.GET)
	public String orderListGet(Model model, HttpSession session) {
		
		// 회원정보
		String nickname = (String) session.getAttribute("sNickname");
		MemberVO vo = memberService.getMemberInfo(nickname);
		model.addAttribute("vo", vo);
		
		return "member/myPage/profile";
	}
	
	// 마이페이지, 회원정보 창에서 회원정보 수정
	@ResponseBody
	@RequestMapping(value = "/myPage/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo, HttpSession session) {

		// 비밀번호 수정 시 처리
		if(vo.getPwd() != "") {
			
			// 1) 암호화
			vo.setPwd(passwordEncoder.encode(vo.getPwd()));  // 비밀번호 암호화
			
			// 2) 임시비밀번호 발급 중이었으면 session 삭제
			if(session.getAttribute("sTempPwd") != null) session.removeAttribute("sTempPwd");
			
			// 3) 비밀번호 변경일 변경 --> myBatis로 처리
		}
		// 별명 세션값 변경
		session.setAttribute("sNickname", vo.getNickname());
		memberService.setMemberUpdate(vo);
		
		return "";
	}
	
	// 마이페이지, 회원정보 창에서 탈퇴용 비밀번호 검사
	@ResponseBody
	@RequestMapping(value = "/myPage/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String pwd, String memberDelPwd) {
		
		String res = "0";
		if(passwordEncoder.matches(memberDelPwd, pwd)) res = "1"; 
		
		return res;
	}
	
	// 마이페이지, 회원정보 창에서 탈퇴용 비밀번호 검사
	@RequestMapping(value = "/myPage/memberDelete", method = RequestMethod.POST)
	public String memberDeletePost(MemberVO vo, HttpSession session) throws UnsupportedEncodingException {
		
		// 회원탈퇴
		int res = memberService.setMemberDelete(vo);
		
		if(res != 0) {  // 탈퇴 성공 시
			String nickname = (String) session.getAttribute("sNickname");
			nickname = URLEncoder.encode(nickname, "UTF-8");
			session.invalidate();   // 세션 끊기
			return "redirect:/message/memberDeleteOk?nickname="+nickname;
		} 
		else return "redirect:/message/memberDeleteNo";
	}
	
	// 마이페이지, 관심상품 창
	@RequestMapping(value = "/myPage/wishlist", method = RequestMethod.GET)
	public String wishlistGet(Model model, HttpSession session,
			@RequestParam(name = "sort", defaultValue = "컬렉션 상품", required = false) String sort) {
		
		// 관심 상품
		String nickname = (String) session.getAttribute("sNickname");
		ArrayList<SaveVO> vos = memberService.getSaveList(nickname, sort);
		model.addAttribute("vos", vos);
		model.addAttribute("vosNum", vos.size());
		model.addAttribute("sort", sort);
		
		
		return "member/myPage/wishlist";
	}
	
	// 마이페이지 관심상품 삭제(여러 개)
	@ResponseBody
	@RequestMapping(value = "/myPage/saveIdxesDelete", method = RequestMethod.POST)
	public String cartIdxesDeletePost(String checkRow) {
		
		List<String> saveIdxList = new ArrayList<String>();
		String[] checkedSaveIdx = checkRow.split(",");
		
		for(int i=0; i < checkedSaveIdx.length; i++){
			saveIdxList.add(checkedSaveIdx[i].toString());
		}

		memberService.setSaveIdxesDelete(saveIdxList);

		return "";
	}
	
	// 마이페이지 관심상품 삭제(단일)
	@ResponseBody
	@RequestMapping(value = "/myPage/saveDelete", method = RequestMethod.POST)
	public String saveDeletePost(int idx) {
		
		memberService.setSaveDelete(idx);
		
		return "";
	}
	
	// 마이페이지, 배송 주소록 관리창
	@RequestMapping(value = "/myPage/address", method = RequestMethod.GET)
	public String addressGet(Model model, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		ArrayList<AddressVO> vos = memberService.getAddressList(memNickname);
		model.addAttribute("vos", vos);
		
		model.addAttribute("addressNum", vos.size());
		
		return "member/myPage/address";
	}
	
	// 주문창, 주소록 리스트 창(팝업)
	@RequestMapping(value = "/myPage/addressList", method = RequestMethod.GET)
	public String addressListGet(Model model, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		ArrayList<AddressVO> vos = memberService.getAddressList(memNickname);
		model.addAttribute("vos", vos);
		
		model.addAttribute("addressNum", vos.size());
		
		return "member/myPage/addressList";
	}
	
	// 마이페이지, 주소록 등록 창(팝업)
	@RequestMapping(value = "/myPage/addressInsert", method = RequestMethod.GET)
	public String addressListGet() {
		return "member/myPage/addressInsert";
	}
	
	// 마이페이지, 주소록 수정 창(팝업)
	@RequestMapping(value = "/myPage/addressUpdate", method = RequestMethod.GET)
	public String addressUpdateGet(int idx, Model model) {
		
		AddressVO vo = memberService.getAddressInfo(idx);
		model.addAttribute("vo", vo);
		
		return "member/myPage/addressUpdate";
	}
	
	// 마이페이지 주소록 삭제
	@ResponseBody
	@RequestMapping(value = "/myPage/addressDelete", method = RequestMethod.POST)
	public String addressDeletePost(int idx) {
		
		memberService.setAddressDelete(idx);
		return "";
	}
	
	// 마이페이지, 포인트 적립내역 관리창
	@RequestMapping(value = "/myPage/point", method = RequestMethod.GET)
	public String pointGet(Model model, HttpSession session,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		String nickname = (String) session.getAttribute("sNickname");

		// 회원 기본 정보 +  가용 포인트
		MemberVO memberVO = memberService.getMemberInfo(nickname);
		model.addAttribute("memberVO", memberVO);
		
		// 총 포인트
		String totalPoint = memberService.getTotalPoint(nickname);
		model.addAttribute("totalPoint", totalPoint);
		
		// 사용 포인트
		String totalUsedPoint = memberService.getTotalUsedPoint(nickname);
		model.addAttribute("totalUsedPoint", totalUsedPoint);
		
		// 포인트 적립 내역 + 페이징 처리
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myPagePoint", sort, nickname);
		ArrayList<PointVO> vos = memberService.getPointList(nickname, sort, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("sort", sort);
		
		// 포인트 사용 내역은 따로 아래에!!!!!!!
		return "member/myPage/point";
	}
	
	// 마이페이지, 포인트 사용내역 관리창
	@RequestMapping(value = "/myPage/pointUse", method = RequestMethod.GET)
	public String pointUseGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		String nickname = (String) session.getAttribute("sNickname");
		
		// 회원 기본 정보 +  가용 포인트
		MemberVO memberVO = memberService.getMemberInfo(nickname);
		model.addAttribute("memberVO", memberVO);
		
		// 총 포인트
		String totalPoint = memberService.getTotalPoint(nickname);
		model.addAttribute("totalPoint", totalPoint);
		
		// 사용 포인트
		String totalUsedPoint = memberService.getTotalUsedPoint(nickname);
		model.addAttribute("totalUsedPoint", totalUsedPoint);
		
		// 포인트 적립 내역 + 페이징 처리
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myPagePointUse", "", nickname);
		ArrayList<PointUseVO> vos = memberService.getPointUseList(nickname, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "member/myPage/pointUse";
	}
	
	// 마이페이지, 구독관리 창
	@RequestMapping(value = "/myPage/subscribe", method = RequestMethod.GET)
	public String subscribeGet(Model model, HttpSession session) {
		
		String nickname = (String) session.getAttribute("sNickname");
		
		// 뉴스레터 구독 정보
		ArrayList<BooksletterVO> booksletterVOS = memberService.getBooksletterInfo(nickname);
		model.addAttribute("booksletterVOS", booksletterVOS);
		
		// 매거진 정기 구독 정보
		ArrayList<SubscribeVO> subscribeVOS = memberService.getSubscribeInfo(nickname);
		model.addAttribute("subscribeVOS", subscribeVOS);
		
		return "member/myPage/subscribe";
	}
	
	// 마이페이지, 구독관리 창에서 뉴스레터 구독 취소
	@ResponseBody
	@RequestMapping(value = "/myPage/booksletterDelete", method = RequestMethod.POST)
	public String booksletterDeletePost(int idx) {

		memberService.setBooksletterDelete(idx);
		return "";
	}
	
	// 마이페이지, 구독관리 창에서 매거진 정기구독 취소신청
	@ResponseBody
	@RequestMapping(value = "/myPage/subscribeCancel", method = RequestMethod.POST)
	public String subscribeCancelPost(int idx) {
		
		memberService.setSubscribeCancel(idx);
		return "";
	}
	
	// 마이페이지, 구독관리 창에서 매거진 정기구독 정기배송지 변경
	@ResponseBody
	@RequestMapping(value = "/myPage/orderAddressIdxChange", method = RequestMethod.POST)
	public String orderAddressIdxChangePost(OrderVO vo) {
		
		memberService.setOrderAddressIdxChange(vo);
		return "";
	}
	
	// 마이페이지, 문의관리창
	@RequestMapping(value = "/myPage/ask", method = RequestMethod.GET)
	public String myPageAskGet(HttpSession session, Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "제목", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {
	
		String memNickname = (String) session.getAttribute("sNickname");
		
		// 문의 내역
		// sort 에 들어올 수 있는 값: 전체, 답변완료, 답변전, 비공개, 공개
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myPageAskSearch", memNickname+"/"+sort+"/"+search, searchString);
		ArrayList<AskVO> vos = memberService.getMemAskSearch(pageVO.getStartIndexNo(), pageSize, memNickname, sort, search, searchString);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("askNum", vos.size());
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("sort", sort);
		
		
		return "member/myPage/ask";
	}
	
	// 임시 비밀번호 받고 확인한 다음에 삭제하자
	// 이게 뭐지?????????
//	비밀번호 변경  
//	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.GET)
//	public String memberPwdUpdateGet(HttpSession session, String pwdFlag) {
//		if(!pwdFlag.equals("")) session.setAttribute("sPwdFlag", "pwdFlag");
//		return "member/memberPwdUpdate";
//	}
//	
//	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
//	public String memberPwdUpdatePost(String mid, String pwd, HttpSession session) {
//		
//		memberService.setMemberPwdUpdate(mid, passwordEncoder.encode(pwd));
//		if(session.getAttribute("sTempPwd") != null) session.removeAttribute("sTempPwd");
//		
//		return "redirect:/message/memberPwdUpdateOk";
//	}
	
}
