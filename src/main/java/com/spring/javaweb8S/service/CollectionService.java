package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.CollectionVO;

public interface CollectionService {

	public ArrayList<CollectionVO> getCollectionList(String search, int startIndexNo, int pageSize);

	public ArrayList<CollectionVO> getProductList(String search, String colIdx, int startIndexNo, int pageSize);

}
