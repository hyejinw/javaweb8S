package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class StatisticVO안씀 {
	// 매거진 정기구독
	private int s1;  // 구독중
	private int s2;  // 구독종료
	private int s3;  // 구독취소신청
	private int s4;  // 구독취소
	
	// 뉴스레터 구독
	private int l1;  // 구독중
	private int l2;  // 구독취소
	
	// 주문
	private int o1;  // 결제완료
	private int o2;  // 배송준비중
	private int o3;  // 배송중
	
	// 반품
	private int r1;  // 반품신청
	private int r2;  // 반품중
	private int r3;  // 반품완료
	
	// 3개의 책(최근 1개월)
	private int c1;  // 신규기록
	private int c2;  // 신규문장수집
}
