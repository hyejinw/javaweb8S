package com.spring.javaweb8S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String listGet(@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			Model model) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "가입되셨습니다. 책(의)세계에 오신 걸 환영합니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "가입 과정에서 오류가 발생했습니다.\\n재시도 부탁드립니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		
		
		return "include/message";
	}
	
	
}