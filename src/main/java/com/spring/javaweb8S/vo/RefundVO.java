package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class RefundVO {
	private int idx;
	private String memNickname;
	
	private int orderIdx;
	private String maIdx;
	private String opIdx;
	
	private int refundNum;
	private String refundCode;
	private String refundStatus;
	private String refundDate;
	private String manageDate;
	
	private String refundReason;
	private String refundDetail;
	private String refundPhoto;
	private int refundPrice;
	private int refundPoint;
	private int deliveryPrice;
	
	// 초기 상품 주문 개수
	private int originOrderNum;
	
	// 초기 상품 주문 실제 구매가격
	private int originPaidPrice;
	
	// 반품 상품명
	private String prodName;
}
