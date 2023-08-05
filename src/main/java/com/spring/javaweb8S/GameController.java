package com.spring.javaweb8S;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.service.GameService;
import com.spring.javaweb8S.vo.DiceVO;
import com.spring.javaweb8S.vo.PointVO;

@Controller
@RequestMapping("/game")
public class GameController {

	@Autowired
	GameService gameService;
	
	// 게임 메인창 = 책나무 게임창
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainGet(Model model, HttpSession session) {
		
		String nickname = (String) session.getAttribute("sNickname");
		if(nickname != null) {
			// 회원 정보
			
			// 회원 적립 포인트 (게임 포인트만)
			
			// 회원 
		}
		
		
		return "game/main";
	}
	
	// 주사위 게임창
	@RequestMapping(value = "/dice", method = RequestMethod.GET)
	public String diceGet(Model model, HttpSession session) {
		
		String nickname = (String) session.getAttribute("sNickname");
		if(nickname != null) {
			
			// 회원 적립 포인트 (게임 포인트만)
			ArrayList<PointVO> pointVOS = gameService.getGamePoint(nickname, "주사위게임");
			model.addAttribute("pointVOS", pointVOS);
			
			// 회원 주사위 기록 (최근 6개월?)
			ArrayList<DiceVO> vos = gameService.getDiceList(nickname);
			model.addAttribute("vos", vos);
			
			// 오늘 기록
			DiceVO diceVO = gameService.getDiceTodayRes(nickname);
			if(diceVO == null) {
				gameService.setDiceTodayRes(nickname);
				diceVO = gameService.getDiceTodayRes(nickname);
			}
			model.addAttribute("diceVO", diceVO);
			
		}
		// 오늘의 번호
		String luckyNum = gameService.getTodayDiceLuckyNum();
		if(luckyNum == null) {
			gameService.setTodayDiceLuckyNum();
			luckyNum = gameService.getTodayDiceLuckyNum();
		}
			
		model.addAttribute("luckyNum", luckyNum);
		return "game/dice";
	}
	
	// 주사위, 오늘의 전적 업데이트
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/diceUpdate", method = RequestMethod.POST)
	public String diceUpdatePost(String memNickname, String flag) {
		
		// flag가 1이면 성공이고, 0이면 실패
		
		if(flag.equals("1")) {
			gameService.setDiceSuccessUpdate(memNickname);
			
			// 포인트 지급
			gameService.setSuccessPointInsert(memNickname, "주사위게임", 500);
			
			// 회원 포인트 업데이트
			gameService.setMemberPointUpdate(memNickname, 500);
		}
		else gameService.setDiceFailUpdate(memNickname);

		return "";
	}
	
}