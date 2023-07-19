package com.spring.javaweb8S.service;

import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.ProverbVO;

public interface MemberService {

	public MemberVO getMidCheck(String mid);

	public MemberVO getNicknameCheck(String nickname);

	public int setMember(MemberVO vo);

	public void setMemberPoint(String recoMid, int point);

	public void setMemberLoginProcess(MemberVO vo);

	public String getMidFinder(String name, String email);

	public String getPwdFinder(String mid, String email);

	public void setMemberPwdUpdate(String mid, String encode);

	public void setRecoMidPointInsert(String recoMid, int point, String pointReason);

	public void setPointInsert(String nickname, int point, String pointReason);

	public String getBooksletterCheck(String email);

	public void setBooksletterInsert(String booksletterIdx, String nickname);

	public int getProverbTotalNum();

	public ProverbVO getRandomProverb(int randomNum);

	public void setBookSaveCategoryInsert(String nickname);

}
