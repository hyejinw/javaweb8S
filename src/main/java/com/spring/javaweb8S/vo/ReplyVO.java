package com.spring.javaweb8S.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int idx;
	private int refIdx;
	private String memNickname;
	private String mentionedNickname;
	private String content;
	private int groupId;
	private int level;
	private String replyDate;
	private String replyHostIp;
	private String replyDel;
	
	// 댓글 리스트 용
	private String memPhoto;
}
