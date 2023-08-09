package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.DiceVO;
import com.spring.javaweb8S.vo.PointVO;
import com.spring.javaweb8S.vo.RouletteVO;

public interface GameService {

	public String getTodayDiceLuckyNum();

	public void setTodayDiceLuckyNum();

	public ArrayList<PointVO> getGamePoint(String nickname, String pointReason);

	public ArrayList<DiceVO> getDiceList(String nickname);

	public DiceVO getDiceTodayRes(String nickname);

	public void setDiceTodayRes(String nickname);

	public void setDiceFailUpdate(String memNickname);

	public void setDiceSuccessUpdate(String memNickname);

	public void setSuccessPointInsert(String memNickname, String pointReason, int point);

	public void setMemberPointUpdate(String memNickname, int point);

	public ArrayList<RouletteVO> getRouletteList(String nickname);

	public RouletteVO getRouletteTodayRes(String nickname);

	public void setRouletteTodayRes(String nickname);

	public void setRouletteSuccessUpdate(String memNickname, int totPoint);

	public void setRouletteFailUpdate(String memNickname);

}
