package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class SaveVO {
	private int idx;
	private String memNickname;
	private String type;
	private int maIdx;
	private int prodIdx;
	private String prodName;
	private int prodPrice;
	private String prodThumbnail;
}
