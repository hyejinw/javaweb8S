package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class MagazineVO {
	private int idx;
	private String maCode;
	private String maType;
	private String maTitle;
	private int maPrice;
	private String maThumbnail;
	private String maDetail;
	private String maDate;
	private int maStock;
	private int maSaleQuantity;
	private int maSave;
	private String maOpen;
}
