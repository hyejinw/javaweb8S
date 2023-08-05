package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class InspiredVO {
	private int idx;
	private int bookIdx;
	private String memNickname;
	private String insContent;
	private String page;
	private String explanation;
	private int insSave;
	private String insDate;
	private String insHostIp;
	private String insDel;
	
	// 커뮤니티 기록 상세창
	private int insSaveIdx;
	
	// 커뮤니티 마이페이지
	private String bookTitle;
	private String authors;
	private String publisher;
	
}