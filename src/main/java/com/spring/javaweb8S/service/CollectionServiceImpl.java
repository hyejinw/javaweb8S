package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.CollectionDAO;
import com.spring.javaweb8S.vo.CollectionVO;

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
}
