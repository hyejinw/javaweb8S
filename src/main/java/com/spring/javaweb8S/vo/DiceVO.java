package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class DiceVO {
	private int idx;
	private String memNickname;
	private int trial;
	private int totPoint;
	private int success;
	private String diceDate;
}
