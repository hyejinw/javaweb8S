package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String nickname;
	private String email;
	private String tel;
	private String memPhoto;
	private String memType;
	private int point;
	private int agreement;
	private String pwdUpdateDate;
	private int totCnt;
	private int todayCnt;
	private String firstVisit;
	private String lastVisit;
	private String memberDel;
	private String memberDelReason;
}
