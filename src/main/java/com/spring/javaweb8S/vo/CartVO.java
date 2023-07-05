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
}
