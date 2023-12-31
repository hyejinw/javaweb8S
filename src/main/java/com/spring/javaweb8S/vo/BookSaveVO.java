package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class BookSaveVO {
	private int idx;
	private String memNickname;
	private String categoryName;
	private int bookIdx;
	
	// 해당 책 저장한 회원 사진
	private String memPhoto;
	
	// bo_book 정보가 담길 예정
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
