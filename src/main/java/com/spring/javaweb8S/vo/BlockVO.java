package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class BlockVO {
	private int idx;
	private String memNickname;
	private String blockedNickname;
	private String blockDate;
	
	// 마이페이지용 차단당한 회원 고유번호
	private int blockedMemIdx;
}
