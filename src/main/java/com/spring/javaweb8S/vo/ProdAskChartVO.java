package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class ProdAskChartVO {
	private String prodName;
	private int salesNum;
	
	// 문의용
	private String category;
	private int askNum;
	
}
