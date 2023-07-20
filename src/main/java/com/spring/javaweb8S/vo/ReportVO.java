package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class ReportVO {
	private int idx;
	private String memNickname;
	private String reportCategory;
	private int originIdx;
	private String message;
	private String reply;
	private String reportDate;
	private String reportDone;
	private String reportHostIp;
}
