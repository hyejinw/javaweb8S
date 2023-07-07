package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.CollectionVO;

public interface CollectionDAO {

	// 페이징 처리용
	public int collectionTotRecCnt(@Param("search") String search);
	public int productTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<CollectionVO> getCollectionList(@Param("search") String search, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<CollectionVO> getProductList(@Param("search") String search, @Param("colIdx") String colIdx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);


}
