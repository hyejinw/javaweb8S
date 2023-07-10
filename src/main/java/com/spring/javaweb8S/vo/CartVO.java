package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class CartVO {
	private int idx;
	private String memNickname;
	private String type;
	
	private int maIdx;
	private int prodIdx;
	private int opIdx;
	
	private String prodName;
	private int prodPrice;
	private String prodThumbnail;
	
	private String opName;
	private int opPrice;
	
	private int num;
	private int totalPrice;
	private String cartDate;
	
	// 컬렉션 정보 (장바구니용)
	private String colName;
	private int colIdx;
	private String colDetail;
	
	// 저장 정보 (장바구니용)
	private int saveIdx;
}
