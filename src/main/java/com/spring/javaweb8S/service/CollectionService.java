package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.SaveVO;

public interface CollectionService {

	public ArrayList<CollectionVO> getCollectionList(String search, int startIndexNo, int pageSize);

	public ArrayList<CollectionVO> getProductList(String search, String colIdx, int startIndexNo, int pageSize);

	public SaveVO getProductSave(String nickname, int idx);

	public CartVO getProductCartSearch(String nickname, int idx);

	public CollectionVO getProdCollection(int idx);

	public ProductVO getProductInfo(int idx);

	public ArrayList<OptionVO> getProdOption(int idx);

	public void setProductSave(SaveVO vo);

	public void setProductSaveDelete(String memNickname, int prodIdx);

	public ArrayList<Integer> getProductOpCartSearch(String memNickname, int prodIdx, ArrayList<CartVO> optionList);

	public void setProductOpCartUpdate(CartVO vo, ArrayList<CartVO> updateOption);

	public void setProductOpCartInsert(CartVO vo, ArrayList<CartVO> insertOption);

	public void setProdSaveNumUpdate(int prodIdx, int prodSaveNum);

}
