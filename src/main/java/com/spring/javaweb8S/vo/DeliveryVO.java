package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class DeliveryVO {
	private int idx;
	private String memNickname;
	
	private int orderIdx;
	private int addressIdx;
	private int refundIdx;
	
	private String invoice;
	private String deliveryStatus;
	private String deliveryDate;
	private String deliveryReason;
	
}
