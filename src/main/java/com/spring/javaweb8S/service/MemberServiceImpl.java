package com.spring.javaweb8S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.MemberDAO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.ProverbVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	// 아이디 중복 검사, 추천인 검색
	@Override
	public MemberVO getMidCheck(String mid) {
		return memberDAO.getMidCheck(mid);
	}

	// 별명 중복 검사
	@Override
	public MemberVO getNicknameCheck(String nickname) {
		return memberDAO.getNicknameCheck(nickname);
	}

	// 회원가입
	@Override
	public int setMember(MemberVO vo) {
		return memberDAO.setMember(vo);
	}

	// 추천인 아이디 적립금(5000)
	@Override
	public void setMemberPoint(String recoMid, int point) {
		memberDAO.setMemberPoint(recoMid, point);
	}
	
	// 추천인 아이디 적립(5000): 적립금 테이블
	@Override
	public void setRecoMidPointInsert(String recoMid, int point, String pointReason) {
		memberDAO.setRecoMidPointInsert(recoMid, point, pointReason);
	}
	
	// 회원 가입 적립
	@Override
	public void setPointInsert(String nickname, int point, String pointReason) {
		memberDAO.setPointInsert(nickname, point, pointReason);
	}
	
	// 로그인 성공
	@Override
	public void setMemberLoginProcess(MemberVO vo) {
		memberDAO.setMemberLoginProcess(vo);
	}

	// 아이디 찾기
	@Override
	public String getMidFinder(String name, String email) {
		return memberDAO.getMidFinder(name, email);
	}

	// 비밀번호 찾기
	@Override
	public String getPwdFinder(String mid, String email) {
		return memberDAO.getPwdFinder(mid, email);
	}

	// 비밀번호 변경
	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}
	
	// 회원가입 시, 뉴스레터 비회원 구독 중인지 확인
	@Override
	public String getBooksletterCheck(String email) {
		return memberDAO.getBooksletterCheck(email);
	}
	
	// 회원가입 시, 뉴스레터 비회원 구독 중이라면 별명 넣어주기
	@Override
	public void setBooksletterInsert(String booksletterIdx, String nickname) {
		memberDAO.setBooksletterInsert(booksletterIdx, nickname);
	}

	// 회원가입 창, 명언 총 개수
	@Override
	public int getProverbTotalNum() {
		return memberDAO.getProverbTotalNum();
	}

	// 랜덤 명언 가져오기
	@Override
	public ProverbVO getRandomProverb(int randomNum) {
		return memberDAO.getRandomProverb(randomNum);
	}


	

}
