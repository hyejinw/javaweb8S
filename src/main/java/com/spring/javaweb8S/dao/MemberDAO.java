package com.spring.javaweb8S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.ProverbVO;

public interface MemberDAO {

	public MemberVO getMidCheck(@Param("mid") String mid);

	public MemberVO getNicknameCheck(@Param("nickname") String nickname);

	public int setMember(@Param("vo") MemberVO vo);

	public void setMemberPoint(@Param("recoMid") String recoMid, @Param("point") int point);

	public void setMemberLoginProcess(@Param("vo") MemberVO vo);

	public String getMidFinder(@Param("name") String name, @Param("email") String email);

	public String getPwdFinder(@Param("mid") String mid, @Param("email") String email);

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setRecoMidPointInsert(@Param("recoMid") String recoMid, @Param("point") int point, @Param("pointReason") String pointReason);

	public void setPointInsert(@Param("nickname") String nickname, @Param("point") int point, @Param("pointReason") String pointReason);

	public String getBooksletterCheck(@Param("email") String email);

	public void setBooksletterInsert(@Param("booksletterIdx") String booksletterIdx, @Param("nickname") String nickname);

	public int getProverbTotalNum();

	public ProverbVO getRandomProverb(@Param("randomNum") int randomNum);

	public void setBookSaveCategoryInsert(@Param("nickname") String nickname);

}
