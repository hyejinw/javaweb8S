package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class PointVO {
	private int idx;
	private String memNickname;
	private int orderIdx;
	private int point;
	private String pointReason;
	private String pointStartDate;
}
