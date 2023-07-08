package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.CollectionDAO;
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
	
	
}
