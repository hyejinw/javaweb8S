package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.SaveVO;

public interface CollectionDAO {

	// 페이징 처리용
	public int collectionTotRecCnt(@Param("search") String search);
	public int productTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<CollectionVO> getCollectionList(@Param("search") String search, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<CollectionVO> getProductList(@Param("search") String search, @Param("colIdx") String colIdx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public SaveVO getProductSave(@Param("nickname") String nickname, @Param("idx") int idx);
	
	public CartVO getProductCartSearch(@Param("nickname") String nickname, @Param("idx") int idx);
	
	public CollectionVO getProdCollection(@Param("idx") int idx);
	
	public ProductVO getProductInfo(@Param("idx") int idx);
	
	public ArrayList<OptionVO> getProdOption(@Param("idx") int idx);
	
	public void setProductSave(@Param("vo") SaveVO vo);
	
	public void setProductSaveDelete(@Param("memNickname") String memNickname, @Param("prodIdx") int prodIdx);
	
	public ArrayList<Integer> getProductOpCartSearch(@Param("memNickname") String memNickname, @Param("prodIdx") int prodIdx, @Param("optionList") ArrayList<CartVO> optionList);
	
	public void setProductOpCartUpdate(@Param("vo") CartVO vo, @Param("updateOption") ArrayList<CartVO> updateOption);
	
	public void setProductOpCartInsert(@Param("vo") CartVO vo, @Param("insertOption") ArrayList<CartVO> insertOption);
	
	public void setProdSaveNumUpdate(@Param("prodIdx") int prodIdx, @Param("prodSaveNum") int prodSaveNum);
	
	public ArrayList<AskVO> getProductAsk(@Param("idx") int idx, @Param("category") String category);


}
