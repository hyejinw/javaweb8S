package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class BookVO {
	String title;
	String contents;
	String url;
	String isbn;
	String datetime;
	String authors;
	String publisher;
	String translators;
	int price;
	int sale_price;
	String thumbnail;
	String status;
}
