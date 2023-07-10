package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.OrderDAO;
import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.SaveVO;

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
	// 장바구니 창에서 컬렉션 상품 수량 변경
	@Override
	public void setCartProdNumUpdate(CartVO vo) {
		orderDAO.setCartProdNumUpdate(vo);
	}

	// 장바구니 상품 삭제(여러 개)
	@Override
	public void setCartIdxesDelete(List<String> cartIdxList) {
		orderDAO.setCartIdxesDelete(cartIdxList);
	}
	// 장바구니 상품 삭제(단일)
	@Override
	public void setCartIdxDelete(int idx) {
		orderDAO.setCartIdxDelete(idx);
	}
	// 관심 상품 취소
	@Override
	public void setSaveDelete(String memNickname, int idx) {
		orderDAO.setSaveDelete(memNickname, idx);
	}

	// 관심 상품 등록
	@Override
	public void setSaveInsertPost(SaveVO vo) {
		orderDAO.setSaveInsertPost(vo);
	}
	
	// 주문창, 선택된 상품 보여주기(여러 개)
	@Override
	public ArrayList<CartVO> getCartList(String memNickname, List<String> cartIdxList) {
		return orderDAO.getCartList(memNickname, cartIdxList);
	}

	// 주문창, 회원의 기본 주소 정보 가져오기
	@Override
	public AddressVO getDefaultAddress(String memNickname) {
		return orderDAO.getDefaultAddress(memNickname);
	}
	
	// 주문창, 주소록 리스트(팝업)
	@Override
	public ArrayList<AddressVO> getAddressList(String memNickname) {
		return orderDAO.getAddressList(memNickname);
	}
	
}
