package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.SaveVO;

public interface OrderService {

	public MemberVO getMemberInfo(String memNickname);

	public ArrayList<CartVO> getProductCartList(String memNickname);

	public ArrayList<CartVO> getMagazineCartList(String memNickname);

	public ArrayList<CartVO> getSubscribeCartList(String memNickname);

	public void setCartProdNumUpdate(CartVO vo);

	public void setCartIdxesDelete(List<String> cartIdxList);

	public void setCartIdxDelete(int idx);

	public void setSaveDelete(String memNickname, int idx);

	public void setSaveInsertPost(SaveVO vo);

	public ArrayList<CartVO> getCartList(String memNickname, List<String> cartIdxList);

	public AddressVO getDefaultAddress(String memNickname);

	public ArrayList<AddressVO> getAddressList(String memNickname);

}
