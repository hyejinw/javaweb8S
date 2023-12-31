package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class ProductVO {
  //	컬렉션 상품
	private int idx;
	private int colIdx;
	private int bookIdx;
	private String bookTitle;
	private String prodCode;
	private String prodName;
	private int prodPrice;
	private String prodReason;
	private String prodThumbnail;
	private String prodDetail;
	private String prodDate;
	private int prodSaleQuantity;
	private int prodSave;
	private String prodStatus;
	private String prodOpen;
	
	// 옵션
	private int opIdx;
	private int prodIdx;
	private String opName;
	private int opPrice;
	private int opStock;
	
	// 컬렉션 관련
	private String colName;
}
