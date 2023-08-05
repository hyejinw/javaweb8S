package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class ReflectionVO {
	private int idx;
	private int bookIdx;
	private String memNickname;
	private String title;
	private String content;
	private int refSave;
	private int refView;
	// int 지만 값 등록/수정 시, checkbox사용을 위해 String으로 선언
	private String replyOpen;
	private String refDate;
	private String refHostIp;
	private String refDel;
	
	// 리스트에 띄울 책 썸네일
	private String thumbnail;
	
	// 리스트에 띄울 작성자 프로필
	private String memPhoto;
	
	// 리스트에 띄울 댓글 개수
	private int replyNum;
	
	// 기록 작성 시, 도서명 + 출판사
	private String bookTitle;
	private String publisher;
	
	// 상세창, 저자
	private String authors;
}
