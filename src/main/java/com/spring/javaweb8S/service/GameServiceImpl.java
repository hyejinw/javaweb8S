package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.GameDAO;
import com.spring.javaweb8S.vo.DiceVO;
import com.spring.javaweb8S.vo.PointVO;

@Service
public class GameServiceImpl implements GameService {

	@Autowired
	GameDAO gameDAO;
	
	
	// 주사위 게임, 오늘의 번호 가져오기
	@Override
	public String getTodayDiceLuckyNum() {
		return gameDAO.getTodayDiceLuckyNum();
	}

	// 주사위 게임, 오늘의 번호 추가
	@Override
	public void setTodayDiceLuckyNum() {
		gameDAO.setTodayDiceLuckyNum();
	}

	// 게임, 회원 포인트 적립 내역
	@Override
	public ArrayList<PointVO> getGamePoint(String nickname, String pointReason) {
		return gameDAO.getGamePoint(nickname, pointReason);
	}

	// 주사위 게임, 전적 가져오기
	@Override
	public ArrayList<DiceVO> getDiceList(String nickname) {
		return gameDAO.getDiceList(nickname);
	}

	// 주사위 게임, 오늘의 전적 가져오기
	@Override
	public DiceVO getDiceTodayRes(String nickname) {
		return gameDAO.getDiceTodayRes(nickname);
	}

	// 주사위 게임, 오늘의 전적 추가
	@Override
	public void setDiceTodayRes(String nickname) {
		gameDAO.setDiceTodayRes(nickname);
	}

	// 주사위 게임, 실패 업데이트
	@Override
	public void setDiceFailUpdate(String memNickname) {
		gameDAO.setDiceFailUpdate(memNickname);
	}

	// 주사위 게임, 성공 업데이트
	@Override
	public void setDiceSuccessUpdate(String memNickname) {
		gameDAO.setDiceSuccessUpdate(memNickname);
	}

	// 주사위 게임, 성공 포인트 지급
	@Override
	public void setSuccessPointInsert(String memNickname, String pointReason, int point) {
		gameDAO.setSuccessPointInsert(memNickname, pointReason, point);
	}

	// 게임 성공 시, 회원 테이블 포인트 업데이트
	@Override
	public void setMemberPointUpdate(String memNickname, int point) {
		gameDAO.setMemberPointUpdate(memNickname, point);
	}

}
