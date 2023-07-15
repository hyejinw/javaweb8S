package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class RefundVO {
	private int idx;
	private String memNickname;
	
	private int orderIdx;
	private String refundCode;
	private String refundStatus;
	private String refundDate;
	
	private String refundReason;
	private String refundDetail;
	private String refundPhoto;
	private String refundPrice;
	private String refundPoint;
	private String deliveryPrice;
}
