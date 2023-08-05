package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.MagazineDAO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.SaveVO;

@Service
public class MagazineServiceImpl implements MagazineService {

	@Autowired
	MagazineDAO magazineDAO;

	// 매거진 리스트
	@Override
	public ArrayList<MagazineVO> getMagazineList(String search, String maDate, int startIndexNo, int pageSize) {
		return magazineDAO.getMagazineList(search, maDate, startIndexNo, pageSize);
	}

	// 매거진 발행일 리스트
	@Override
	public ArrayList<String> getMaDate() {
		return magazineDAO.getMaDate();
	}

	// 매거진 상품 상세페이지
	@Override
	public MagazineVO getMagazineProduct(int idx) {
		return magazineDAO.getMagazineProduct(idx);
	}

	// 매거진 관심 저장 유무 확인용
	@Override
	public SaveVO getMagazineSave(String nickname, int idx) {
		return magazineDAO.getMagazineSave(nickname, idx);
	}

	// 매거진 저장
	@Override
	public void setMagazineSave(SaveVO vo) {
		magazineDAO.setMagazineSave(vo);
	}

	// 매거진 저장 취소
	@Override
	public void setMagazineSaveDelete(String memNickname, int maIdx) {
		magazineDAO.setMagazineSaveDelete(memNickname, maIdx);
	}

	// 매거진 장바구니 저장 유무 확인용
	// 기존 장바구니 내역 중, 같은 상품 존재 확인
	@Override
	public CartVO getMagazineCartSearch(String nickname, int idx) {
		return magazineDAO.getMagazineCartSearch(nickname, idx);
	}
	
	// 매거진 장바구니 추가
	@Override
	public void setMagazineCartInsert(CartVO vo) {
		magazineDAO.setMagazineCartInsert(vo);
	}

	// 매거진 장바구니 수량 증가
	@Override
	public void setMagazineCartUpdate(CartVO vo) {
		magazineDAO.setMagazineCartUpdate(vo);
	}

	// 매거진 테이블 저장 등록 수 변경
	@Override
	public void setMaSaveNumUpdate(int maIdx, int maSaveNum) {
		magazineDAO.setMaSaveNumUpdate(maIdx, maSaveNum);
	}

  // 매거진 상세창, 문의내역 전체 가져오기
	@Override
	public ArrayList<AskVO> getMagazineAsk(int idx, String category) {
		return magazineDAO.getMagazineAsk(idx, category);
	}

	
}
