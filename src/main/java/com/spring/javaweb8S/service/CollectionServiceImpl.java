package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.CollectionDAO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.SaveVO;

@Service
public class CollectionServiceImpl implements CollectionService {
	
	@Autowired
	CollectionDAO collectionDAO;

	// 컬렉션 창, 컬렉션 리스트
	@Override
	public ArrayList<CollectionVO> getCollectionList(String search, int startIndexNo, int pageSize) {
		return collectionDAO.getCollectionList(search, startIndexNo, pageSize);
	}

	// 컬렉션 창, 상품 리스트
	@Override
	public ArrayList<CollectionVO> getProductList(String search, String colIdx, int startIndexNo, int pageSize) {
		return collectionDAO.getProductList(search, colIdx, startIndexNo, pageSize);
	}

	// 상품 관심 저장 유무 확인
	@Override
	public SaveVO getProductSave(String nickname, int idx) {
		return collectionDAO.getProductSave(nickname, idx);
	}

	// 상품 장바구니 저장 유무 확인
	@Override
	public CartVO getProductCartSearch(String nickname, int idx) {
		return collectionDAO.getProductCartSearch(nickname, idx);
	}

	// 해당 상품의 컬렉션 정보
	@Override
	public CollectionVO getProdCollection(int idx) {
		return collectionDAO.getProdCollection(idx);
	}

	// 해당 상품 상세 내용
	@Override
	public ProductVO getProductInfo(int idx) {
		return collectionDAO.getProductInfo(idx);
	}

	// 해당 상품 옵션
	@Override
	public ArrayList<OptionVO> getProdOption(int idx) {
		return collectionDAO.getProdOption(idx);
	}

	// 상품 저장
	@Override
	public void setProductSave(SaveVO vo) {
		collectionDAO.setProductSave(vo);
	}

	// 상품 저장 취소
	@Override
	public void setProductSaveDelete(String memNickname, int prodIdx) {
		collectionDAO.setProductSaveDelete(memNickname, prodIdx);
	}

  // 기존 장바구니 내역 중, 같은 상품 존재 확인(닉네임, 상품 고유번호, 옵션 내용으로 검색)
	@Override
	public ArrayList<Integer> getProductOpCartSearch(String memNickname, int prodIdx, ArrayList<CartVO> optionList) {
		return collectionDAO.getProductOpCartSearch(memNickname, prodIdx, optionList);
	}

	// 장바구니 상품 옵션 수량만 변경
	@Override
	public void setProductOpCartUpdate(CartVO vo, ArrayList<CartVO> updateOption) {
		collectionDAO.setProductOpCartUpdate(vo, updateOption);
	}

	// 장바구니에 상품 추가
	@Override
	public void setProductOpCartInsert(CartVO vo, ArrayList<CartVO> insertOption) {
		collectionDAO.setProductOpCartInsert(vo, insertOption);
	}

	// 상품 테이블 저장 등록 수 변경
	@Override
	public void setProdSaveNumUpdate(int prodIdx, int prodSaveNum) {
		collectionDAO.setProdSaveNumUpdate(prodIdx, prodSaveNum);
	}

	// 상품 상세창, 상품 문의
	@Override
	public ArrayList<AskVO> getProductAsk(int idx, String category) {
		return collectionDAO.getProductAsk(idx, category);
	}
	
	
}
