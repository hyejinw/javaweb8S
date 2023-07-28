package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private int idx;
	private String category;
	private String noticeTitle;
	private String noticeContent;
	private int noticeView;
	private String noticeDate;
	private String important;
	private String noticeOpen;
}
