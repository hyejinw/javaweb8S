package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class ChartVO {
	private int colCnt;
	private int maCnt;
	private int subCnt;
	private String average;
	private String date;
	
	// 임시용
	private int cnt;
}
