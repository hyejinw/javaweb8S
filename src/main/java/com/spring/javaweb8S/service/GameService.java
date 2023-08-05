package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.DiceVO;
import com.spring.javaweb8S.vo.PointVO;

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

}
