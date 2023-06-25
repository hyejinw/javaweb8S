package com.spring.javaweb8S.service;

import com.spring.javaweb8S.vo.MemberVO;

public interface MemberService {

	public MemberVO getMidCheck(String mid);

	public MemberVO getNicknameCheck(String nickname);

	public int setMember(MemberVO vo);

	public void setMemberPoint(String recoMid, int point);

	public void setMemberLoginProcess(MemberVO vo);

	public String getMidFinder(String name, String email);

	public String getPwdFinder(String mid, String email);

	public void setMemberPwdUpdate(String mid, String encode);

}
