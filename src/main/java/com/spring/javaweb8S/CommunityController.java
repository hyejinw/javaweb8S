package com.spring.javaweb8S;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb8S.service.CommunityService;
import com.spring.javaweb8S.vo.MemberVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService communityService;
	
	// 커뮤니티 가이드 창
	@RequestMapping(value = "/guide", method = RequestMethod.GET)
	public String guideGet() {
		return "community/guide";
	}
	
	// 커뮤니티 메인 창
	@RequestMapping(value = "/communityMain", method = RequestMethod.GET)
	public String communityMainGet(Model model, HttpSession session) {
		String nickname = (String) session.getAttribute("sNickname");
		
		MemberVO memberVO = communityService.getMemberInfo(nickname);
		model.addAttribute("memberVO", memberVO);
		
		return "community/communityMain";
	}
	
	
}
