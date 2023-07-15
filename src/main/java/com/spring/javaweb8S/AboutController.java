package com.spring.javaweb8S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.service.AboutService;

@Controller
@RequestMapping("/about")
public class AboutController {

	@Autowired
	AboutService aboutService;
	
	// 책(의)세계란, 소개 창
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String aboutGet() {
		return "about/about";
	}
	
	// 소개 창, 뉴스레터를 위한 기존 등록 이메일 유무 확인 + 해당 별명들 가져오기
	@ResponseBody
	@RequestMapping(value = "/booksletterEmailCheck", method = RequestMethod.POST)
	public String[] booksletterEmailCheckPost(String email) {
		
		String[] memNicknameArray = aboutService.getNicknameListWithEmail(email);
		
		return memNicknameArray;
	}
	
	// 이미 뉴스레터 구독 중인지 확인
	@ResponseBody
	@RequestMapping(value = "/booksletterCheck", method = RequestMethod.POST)
	public String booksletterCheckPost(String email, 
			@RequestParam(name = "memNickname", defaultValue = "", required = false) String memNickname) {
		
		String booksletterDate = aboutService.getBooksletterCheck(email, memNickname);
		
		if(booksletterDate != null) return booksletterDate.substring(0,10);
		else return booksletterDate;
		
	}
	
	// 소개 창, 뉴스레터 등록
	@ResponseBody
	@RequestMapping(value = "/booksletterInsert", method = RequestMethod.POST)
	public String booksletterInsertPost(String email, String memNickname) {
		
		aboutService.getBooksletterInsert(email, memNickname);
		return "";
	}
	
}
