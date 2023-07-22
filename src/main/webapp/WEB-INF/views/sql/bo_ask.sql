show tables;

create table bo_ask (
	idx int not null auto_increment,         		  /* 적립금 고유번호 */
	memNickname varchar(20),                 		  /* 회원 별명(외래키) */
	email varchar(50),                       		  /* 비회원 이메일 */
	pwd varchar(50),                              /* 비회원 비밀번호 */
	category varchar(20) not null,         		    /* 문의 종류 */
	originIdx int,                            		/* 출처 고유번호 */
	askTitle varchar(200) not null,        		    /* 제목 */
	askContent text not null,               		  /* 내용 */
	answer text,                              		/* 답변 내용 */
	secret char(7) default '공개' not null,   			/* 공개 유무 */
	askDate datetime default now() not null,  		/* 작성 날짜 */
	answeredAsk char(7) default '답변전' not null,  /* 답변 유무 */  
	answerDate datetime default now(),        		/* 답변 작성 날짜 */
	askHostIp varchar(200) not null,           		/* IP주소 */
	askDel char(5) default '미삭제',             		/* 삭제 신청 여부 */  

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete set null
);

desc bo_ask;
drop table bo_ask;
ALTER TABLE bo_ask AUTO_INCREMENT = 1;
	