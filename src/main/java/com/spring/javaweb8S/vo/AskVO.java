package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class AskVO {
	private int idx;
	private String memNickname;
	private String email;
	private String pwd;
	private String category;
	private int originIdx;
	private String askTitle;
	private String askContent;
	private String answer;
	private String secret;
	private String askDate;
	private String answeredAsk;
	private String answerDate;
	private String askHostIp;
	private String askDel;
	
	// 문의 등록용 상품명
	private String originName;
}
