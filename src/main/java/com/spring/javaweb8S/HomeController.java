package com.spring.javaweb8S;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.service.HomeService;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.MagazineVO;

@Controller
public class HomeController {

	@Autowired
	HomeService homeService;
	
	@Autowired
	BookInsertSearch bookInsert;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		// 신규 매거진 20개 
		ArrayList<MagazineVO> magazineVOS = homeService.getNewMagazines();
		model.addAttribute("magazineVOS", magazineVOS);
		
		
		// 장바구니 제품 수 
		String nickname = (String) session.getAttribute("sNickname");
		if(nickname != "") {
			int cartNum = homeService.getCartNum(nickname);
			model.addAttribute("cartNum", cartNum);	
		}
		
		return "home";
	}
	
	// 책 랜덤 추출기
	@ResponseBody
	@RequestMapping(value = "/home/randomBook", method = RequestMethod.POST)
	public BookVO randomBookPost() throws UnsupportedEncodingException {

		ArrayList<String> randomAlphabet = new ArrayList<String>();
		
		// 대문자 A-Z 알파벳 생성
		for(int i = 0; i < 26; i++) {
			char ch = (char)(i + 65);
			randomAlphabet.add(String.valueOf(ch));
		}
		
		// 소문자 a-z 알파벳 생성
		for(int i = 0; i < 26; i++) {
			char ch = (char)(i + 97);
			randomAlphabet.add(String.valueOf(ch));
		}
		
		// 숫자도 넣어주면 좋겠다.
		
		// 받침없는 한글
		String[] temp = new String[] {"가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하",
				"갸", "냐", "댜", "랴", "먀", "뱌", "샤", "야", "쟈", "챠", "캬", "탸", "퍄", "햐",
				"거", "너", "더", "러", "머", "버", "서", "어", "저", "처", "커", "터", "퍼", "허",
				"겨", "네", "데", "레", "메", "베", "세", "에", "제", "체", "케", "테", "페", "헤",
				"고", "노", "도", "로", "모", "보", "소", "오", "조", "초", "코", "토", "포", "호",
				"교", "뇨", "된", "료", "묘", "뵤", "쇼", "요", "좌", "좌", "쵸", "좌", "퇴", "효",
				"구", "누", "두", "루", "무", "부", "수", "우", "주", "추", "쿠", "투", "푸", "후",
				"규", "뉴", "듀", "류", "뮤", "비", "시", "이", "지", "치", "키", "티", "피", "히",
				"기", "니", "디", "리", "미", "비", "시", "이", "지", "치", "키", "티", "피", "히",
				"그", "느", "드", "르", "므", "브", "스", "으", "즈", "츠", "크", "트", "프", "흐",
				"귀", "니"};
		
		for(int i =0; i < temp.length; i++) { 
			randomAlphabet.add(temp[i]); 
		}
		
		// 랜덤 글자 위치 하나 추출
		int randomNum = (int) (Math.random() * (randomAlphabet.size()));
		
		// 랜덤 글자로 bookInsert에서 검색
		ArrayList<BookVO> bookVOS = new ArrayList<BookVO>();
		bookVOS = bookInsert.bookInsert(randomAlphabet.get(randomNum));
		
		// 검색 결과가 없으면 재 검색
		while(bookVOS.size() == 0) {
			randomNum = (int) (Math.random() * (randomAlphabet.size()));
			bookVOS = bookInsert.bookInsert(randomAlphabet.get(randomNum));
		}
		
		// 검색 결과에서 하나의 결과만 랜덤 추출
		int bookRandomNum = (int) (Math.random() * (bookVOS.size()));
		BookVO bookVO = bookVOS.get(bookRandomNum);

		return bookVO;
	}

	
}
