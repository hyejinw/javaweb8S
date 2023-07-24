package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int idx;
	private String memNickname;
	private String type;
	private String orderCode;
	
	private int addressIdx;
	private int maIdx;
	private int prodIdx;
	private int opIdx;
	
	private String prodName;
	private int prodPrice;
	private String prodThumbnail;
	
	private String opName;
	private int opPrice;
	
	private int num;
	private int totalPrice;
	private int paidPrice;
	private int usedPoint;
	
	private String orderDate;
	private String orderStatus;
	private String manageDate;
	
	// 마이페이지용
	private int orderNum;
	private int totalPaidPrice;
	private int refundNum;
	
	// 이 아래는 관리자 및 회원 페이지에서 쓰게 되면 쓰고 아니면 삭제 필요
	// 컬렉션 정보 (장바구니용)
	private String colName;
	private int colIdx;
	private String colDetail;
	
	// 저장 정보 (장바구니용)
	private int saveIdx;
	
	// 상품&매거진 재고
	private int stock;
}
