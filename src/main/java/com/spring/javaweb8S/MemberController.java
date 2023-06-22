package com.spring.javaweb8S;

import org.springframework.beans.factory.annotation.Autowired;
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

	// 로그인 창
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet() {
		return "member/memberLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost() {
		
		
		return "member/memberLogin";
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
