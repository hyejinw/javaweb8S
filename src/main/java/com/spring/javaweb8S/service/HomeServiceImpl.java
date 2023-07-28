package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.HomeDAO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	HomeDAO homeDAO;

	// 신규 매거진 리스트
	@Override
	public ArrayList<MagazineVO> getNewMagazines() {
		return homeDAO.getNewMagazines();
	}

	// 장바구니 제품 수
	@Override
	public int getCartNum(String nickname) {
		return homeDAO.getCartNum(nickname);
	}

	// 고정된 공지 가져오기
	@Override
	public ArrayList<NoticeVO> getImportantNotice() {
		return homeDAO.getImportantNotice();
	}

	// 고정 공지 3개 이하면, 일반 공지 가져오기
	@Override
	public ArrayList<NoticeVO> getExtraNotice(int limitNum) {
		return homeDAO.getExtraNotice(limitNum);
	}

	// 총 방문 수 가져오기
	@Override
	public String getTotCnt(String nickname) {
		return homeDAO.getTotCnt(nickname);
	}

	// 비밀번호 변경 6개월 경과 되었는지 확인용
	@Override
	public String getPwdUpdateDate(String nickname) {
		return homeDAO.getPwdUpdateDate(nickname);
	}

	
}
