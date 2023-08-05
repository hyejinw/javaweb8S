package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.DiceVO;
import com.spring.javaweb8S.vo.PointVO;

public interface GameDAO {

	public String getTodayDiceLuckyNum();

	public void setTodayDiceLuckyNum();

	public ArrayList<PointVO> getGamePoint(@Param("nickname") String nickname, @Param("pointReason") String pointReason);

	public ArrayList<DiceVO> getDiceList(@Param("nickname") String nickname);

	public DiceVO getDiceTodayRes(@Param("nickname") String nickname);

	public void setDiceTodayRes(@Param("nickname") String nickname);

	public void setDiceFailUpdate(@Param("memNickname") String memNickname);

	public void setDiceSuccessUpdate(@Param("memNickname") String memNickname);

	public void setSuccessPointInsert(@Param("memNickname") String memNickname, @Param("pointReason") String pointReason, @Param("point") int point);

	public void setMemberPointUpdate(@Param("memNickname") String memNickname, @Param("point") int point);

}
