package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class BookVO {
	private int idx;
	private String title;
	private String contents;
	private String url;
	private String isbn;
	private String datetime;
	private String authors;
	private String publisher;
	private String translators;
	private int price;
	private int sale_price;
	private String thumbnail;
	private String status;
	
	private double bookRate;
	private int save;
	private String bookUpdate;
}
