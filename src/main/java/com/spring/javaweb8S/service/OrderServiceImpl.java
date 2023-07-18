package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.OrderDAO;
import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OrderVO;
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

  // 기본주소로 설정 시, 기존 기본주소가 있다면 해당 주소를 일반으로 변경
	@Override
	public void setDefaultAddressReset(String memNickname) {
		orderDAO.setDefaultAddressReset(memNickname);
	}

	// 주소 등록
	@Override
	public void setAddressInsert(AddressVO vo) {
		orderDAO.setAddressInsert(vo);
	}
	
  // 주문창, 주소록 삭제
	@Override
	public void setAddressIdxesDelete(List<String> addressIdxList) {
		orderDAO.setAddressIdxesDelete(addressIdxList);
	}
	
	// 주문창, 주소록 수정 창에서 해당 주소정보 가져오기
	@Override
	public AddressVO getAddressInfo(int idx) {
		return orderDAO.getAddressInfo(idx);
	}

	// 주문창, 주소록 수정
	@Override
	public void setAddressUpdate(AddressVO vo) {
		orderDAO.setAddressUpdate(vo);
	}

	// 주문 내역 추가
	@Override
	public void setOrderInsert(ArrayList<OrderVO> orderVOS) {
		orderDAO.setOrderInsert(orderVOS);
	}

	// 배송 데이터 추가
	@Override
	public void setDeliveryInsert(ArrayList<OrderVO> orderVOS) {
		orderDAO.setDeliveryInsert(orderVOS);
	}

	// 바로 주문하기 임시
	@Override
	public String getCartIdx(CartVO cartVO) {
		return orderDAO.getCartIdx(cartVO);
	}

	// 매거진 정기 구독 처리
	@Override
	public void setSubscribeInsert(ArrayList<OrderVO> subVOS) {
		orderDAO.setSubscribeInsert(subVOS);
	}

	// 적립금 사용 테이블 처리
	@Override
	public void setPointUseInsert(ArrayList<OrderVO> pointUseVOS) {
		orderDAO.setPointUseInsert(pointUseVOS);
	}

	// 회원 테이블 포인트, 적립금 사용액 만큼 빼기 
	@Override
	public void setMemberPointUpdate(int totalUsedPoint, String memNickname) {
		orderDAO.setMemberPointUpdate(totalUsedPoint, memNickname);
	}

	// 상품 옵션 재고 변경
	@Override
	public void setProdOpStockUpdate(ArrayList<OrderVO> prodOrderVOS) {
		orderDAO.setProdOpStockUpdate(prodOrderVOS);
	}
	
	// 현 재고 0인 상품 고유번호 가져오기
	@Override
	public ArrayList<String> getProdStockUpdateIdx() {
		return orderDAO.getProdStockUpdateIdx();
	}

	// 현 재고 0인 상품 품절로 상태 변경
	@Override
	public void setProdStockUpdate(ArrayList<String> prodStockUpdateIdx) {
		orderDAO.setProdStockUpdate(prodStockUpdateIdx);
	}

	// 매거진 재고 변경
	@Override
	public void setMaStockUpdate(ArrayList<OrderVO> maOrderVOS) {
		orderDAO.setMaStockUpdate(maOrderVOS);
	}

	// 상품 판매 수량 변경
	@Override
	public void setProdSaleQuantityUpdate(ArrayList<OrderVO> prodOrderVOS) {
		orderDAO.setProdSaleQuantityUpdate(prodOrderVOS);
	}

  // 상품 or 매거진 테이블 저장 등록 수 변경
	@Override
	public void setSaveNumUpdate(SaveVO vo, int saveNum) {
		orderDAO.setSaveNumUpdate(vo, saveNum);
	}
	
}
