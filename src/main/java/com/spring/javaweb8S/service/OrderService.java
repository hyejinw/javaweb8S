package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;

public interface OrderService {

	public MemberVO getMemberInfo(String memNickname);

	public ArrayList<CartVO> getProductCartList(String memNickname);

	public ArrayList<CartVO> getMagazineCartList(String memNickname);

	public ArrayList<CartVO> getSubscribeCartList(String memNickname);

}
