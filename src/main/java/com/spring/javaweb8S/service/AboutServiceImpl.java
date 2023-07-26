package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.AboutDAO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.ProductVO;

@Service
public class AboutServiceImpl implements AboutService {
	
	@Autowired
	AboutDAO aboutDAO;

	// 소개 창, 뉴스레터를 위한 기존 등록 이메일 유무 확인 + 해당 별명들 가져오기
	@Override
	public List<String> getNicknameListFromEmail(String email) {
		return aboutDAO.getNicknameListFromEmail(email);
	}

	// 소개 창, 뉴스레터를 위한 기존 등록 이메일 유무 확인 + 해당 별명들 가져오기
	@Override
	public String[] getNicknameListWithEmail(String email) {
		return aboutDAO.getNicknameListWithEmail(email);
	}

	// 소개 창, 뉴스레터 등록
	@Override
	public void getBooksletterInsert(String email, String memNickname) {
		aboutDAO.getBooksletterInsert(email, memNickname);
	}

	// 뉴스레터 이미 구독 중인지 확인
	@Override
	public String getBooksletterCheck(String email, String memNickname) {
		return aboutDAO.getBooksletterCheck(email, memNickname);
	}

	// 문의 등록창, 상품정보
	@Override
	public ProductVO getProductInfo(String originIdx) {
		return aboutDAO.getProductInfo(originIdx);
	}

	// 문의 등록창, 매거진 + 정기구독 정보
	@Override
	public MagazineVO getMagazineInfo(String originIdx) {
		return aboutDAO.getMagazineInfo(originIdx);
	}

	// 문의 등록창, 매거진 리스트(상세 카테고리용)
	@Override
	public String[] getMagazineTitle(String maType) {
		return aboutDAO.getMagazineTitle(maType);
	}

	// 문의 등록창, 컬렉션상품 리스트(상세 카테고리용)
	@Override
	public String[] getProductName() {
		return aboutDAO.getProductName();
	}

	// 문의 등록
	@Override
	public int setAskInsert(AskVO vo) {
		return aboutDAO.setAskInsert(vo);
	}

	// 전체 문의 내역
	@Override
	public ArrayList<AskVO> getAskSearch(int startIndexNo, int pageSize, String sort, String search,
			String searchString) {
		return aboutDAO.getAskSearch(startIndexNo, pageSize, sort, search, searchString);
	}

	// 문의 상세창
	@Override
	public AskVO getAskDetail(int idx) {
		return aboutDAO.getAskDetail(idx);
	}
	
}
