package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class PointUseVO {
	private int idx;
	private String memNickname;
	private int orderIdx;
	private int usedPoint;
	private String pointUseDate;
}
