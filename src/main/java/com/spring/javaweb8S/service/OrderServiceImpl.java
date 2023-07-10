package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.OrderDAO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDAO orderDAO;

	// 주문 창에서 사용할 회원 정보 가져오기
	@Override
	public MemberVO getMemberInfo(String memNickname) {
		return orderDAO.getMemberInfo(memNickname);
	}

	// 장바구니 창, 장바구니에 담긴 컬렉션 상품 정보 
	@Override
	public ArrayList<CartVO> getProductCartList(String memNickname) {
		return orderDAO.getProductCartList(memNickname);
	}

	// 장바구니 창, 장바구니에 담긴 매거진 상품 정보 
	@Override
	public ArrayList<CartVO> getMagazineCartList(String memNickname) {
		return orderDAO.getMagazineCartList(memNickname);
	}

	// 장바구니 창, 장바구니에 담긴 매거진 구독 상품 정보 
	@Override
	public ArrayList<CartVO> getSubscribeCartList(String memNickname) {
		return orderDAO.getSubscribeCartList(memNickname);
	}
}
