package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class SubscribeVO {
	private int idx;
	private String memNickname;
	private int orderIdx;
	private String subStartDate;
	private String subExpireDate;
	private int subSendNum;
	private String subStatus;
	private int subRefund;
	private int subRefundPoint;
	
	// 구독 종료된 회원, 구독 유지 유도용 이메일 주소
	private String email;
	
	// 구독 관리창, 구독권 종류 + 매거진 고유번호
	private String prodName;
	private int maIdx;
}
