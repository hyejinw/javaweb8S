package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class SubChartVO {
	private String subDate;
	private int subNum;
	
	// 날짜 뿌려주기용 
	private String year;
	private String month;
	private String day;
	
	// 뉴스레터용
	private int letterNum;
}
