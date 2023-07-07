package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class CollectionVO {
	private int idx;
	private String colName;
	private String colDetail;
	private String colThumbnail;
	private String colDate;
	private String colOpen;
	
	// 컬렉션 당 상품 개수
	private int colProdNum;
}
