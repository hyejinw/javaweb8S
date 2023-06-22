package com.spring.javaweb8S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMidCheck(@Param("mid") String mid);

	public MemberVO getNicknameCheck(@Param("nickname") String nickname);

	public int setMember(@Param("vo") MemberVO vo);

	public void setMemberPoint(@Param("recoMid") String recoMid, @Param("point") int point);

}
