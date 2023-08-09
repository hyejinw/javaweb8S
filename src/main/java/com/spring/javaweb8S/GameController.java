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
import com.spring.javaweb8S.vo.RouletteVO;

@Controller
@RequestMapping("/game")
public class GameController {

	@Autowired
	GameService gameService;
	
	// 주사위 게임창
	@RequestMapping(value = "/dice", method = RequestMethod.GET)
	public String diceGet(Model model, HttpSession session) {
		
		String nickname = (String) session.getAttribute("sNickname");
		if(nickname != null) {
			
			// 오늘 기록
			DiceVO diceVO = gameService.getDiceTodayRes(nickname);
			
			if(diceVO == null) {
				gameService.setDiceTodayRes(nickname);
				diceVO = gameService.getDiceTodayRes(nickname);
				
			}
			model.addAttribute("diceVO", diceVO);
			
			// 회원 적립 포인트 (게임 포인트만)
			ArrayList<PointVO> pointVOS = gameService.getGamePoint(nickname, "주사위게임");
			model.addAttribute("pointVOS", pointVOS);
			
			// 회원 주사위 기록
			ArrayList<DiceVO> vos = gameService.getDiceList(nickname);
			model.addAttribute("vos", vos);
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
	
	
	// 룰렛 게임창
	@RequestMapping(value = "/roulette", method = RequestMethod.GET)
	public String rouletteGet(Model model, HttpSession session) {
		
		String nickname = (String) session.getAttribute("sNickname");
		if(nickname != null) {
			
			// 오늘 기록
			RouletteVO rouletteVO = gameService.getRouletteTodayRes(nickname);
			if(rouletteVO == null) {
				gameService.setRouletteTodayRes(nickname);
				rouletteVO = gameService.getRouletteTodayRes(nickname);
			}
			model.addAttribute("rouletteVO", rouletteVO);
			
			// 회원 적립 포인트 (게임 포인트만)
			ArrayList<PointVO> pointVOS = gameService.getGamePoint(nickname, "룰렛게임");
			model.addAttribute("pointVOS", pointVOS);
			
			// 회원 주사위 기록
			ArrayList<RouletteVO> vos = gameService.getRouletteList(nickname);
			model.addAttribute("vos", vos);
			
		}
		return "game/roulette";
	}
	
	// 룰렛, 오늘의 전적 업데이트
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/rouletteUpdate", method = RequestMethod.POST)
	public String rouletteUpdatePost(String memNickname, String totPoint) {

		if(!totPoint.equals("")) {
			gameService.setRouletteSuccessUpdate(memNickname, Integer.parseInt(totPoint));
			
			// 포인트 지급
			gameService.setSuccessPointInsert(memNickname, "룰렛게임", Integer.parseInt(totPoint));
			
			// 회원 포인트 업데이트
			gameService.setMemberPointUpdate(memNickname, Integer.parseInt(totPoint));
		}
		else gameService.setRouletteFailUpdate(memNickname);

		return "";
	}
}