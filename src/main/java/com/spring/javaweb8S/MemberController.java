package com.spring.javaweb8S;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.service.MemberService;
import com.spring.javaweb8S.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 창
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required=false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required=false) String idSave,
			HttpSession session) {
		MemberVO vo = memberService.getMidCheck(mid);
		
		if(vo == null || vo.getMemberDel().equals("OK")) {
			return "redirect:/message/memberMidNo";
		}	
		else if(!passwordEncoder.matches(pwd, vo.getPwd())) {
			return "redirect:/message/memberPwdNo";
		}
		
		// 회원정보 일치
		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("sNickname", vo.getNickname());
		session.setAttribute("sMemType", vo.getMemType());
		
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
		System.out.println("vo : " + vo);
		// 로그인한 사용자의 총 방문 수, 오늘 방문 수, 마지막 방문일을 변경
		memberService.setMemberLoginProcess(vo);
		return "redirect:/message/memberLoginOk?mid="+mid;
	}
	
	// 회원가입 창
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
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
	public String memberEmailAuthPost(String email) throws MessagingException {
		
		// 이메일 인증용 랜덤 숫자배열 6자리
		UUID uid = UUID.randomUUID();
		String emailAuth = uid.toString().substring(0,6);
		
		// 이메일 전송!
		mailSend(email, emailAuth);
		return emailAuth;
	}

	private void mailSend(String toMail, String emailAuth) throws MessagingException {
		String title = "책(의)세계에서 발송한 이메일 인증코드입니다";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		String content = "";
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content += "<p><img src=\"cid:navLogo.png\" width='300px'></p>";
		content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>이메일 인증코드를 보내드립니다.</h4><br>";
		content += "<br><hr><h2><font color='blue'>"+emailAuth+"</font></h2><br>";
		content += "<br><h4>위 인증코드를 입력해주세요!</h4><br>";
		content += "<br><h3>책(의)세계 드림</h3><br>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
		FileSystemResource file = new FileSystemResource("D:\\javaweb\\springframework\\project\\javaweb8S\\src\\main\\webapp\\resources\\images\\navLogo.png");
		messageHelper.addInline("navLogo.png", file);

		// 메일 전송
		mailSender.send(message);
	}

	// 회원가입
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo,
			@RequestParam(name="recoMid", defaultValue = "", required=false) String recoMid) {
		
		if(memberService.getMidCheck(recoMid) != null) {
			vo.setPoint(10000);
			memberService.setMemberPoint(recoMid, 5000);
			
			// point 테이블 추가 처리 필요
			
		}
		else {
			vo.setPoint(5000);
		}
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));  // 비밀번호 암호화
		
		System.out.println("vo : " + vo);
		int res = memberService.setMember(vo);
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	
	
}
