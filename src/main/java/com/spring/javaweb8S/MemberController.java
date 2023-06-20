package com.spring.javaweb8S;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/member")
public class MemberController {

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

	
	
	
}
