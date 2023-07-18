show tables;

create table bo_reply (
	idx int not null auto_increment,              /* 댓글 고유번호 */
	refIdx int not null,                          /* 기록 고유번호(외래키) */
	memNickname varchar(20) not null,             /* 작성자(회원 별명)(외래키) */
	mentionedNickname varchar(20),                /* 멘션된 회원 */
	content text not null, 			    						  /* 내용 */						
	originIdx int,                                /* 원본 댓글 고유번호 */
	originContent text,                           /* 원본 내용 */
	replyDate datetime default now() not null,    /* 작성 날짜 */
	replyHostIp varchar(100) not null,            /* IP주소 */
	replyDel char(5) default '미삭제',              /* 삭제 신청 여부 */

	primary key(idx),
	foreign key(refIdx) references bo_reflection(idx)  
	on update cascade												      
	on delete cascade,

	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(mentionedNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_reply;
drop table bo_reply;
ALTER TABLE bo_reply AUTO_INCREMENT = 1;
	
