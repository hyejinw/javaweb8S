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
	
	// 구독 종료된 회원, 구독 유지 유도용 이메일 주소
	private String email;
}
