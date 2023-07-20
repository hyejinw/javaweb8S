show tables;

create table bo_report (
	idx int not null auto_increment,              /* 신고 고유번호 */
	memNickname varchar(20) not null,             /* 회원 별명(외래키) */
	reportCategory varchar(10) not null,          /* 종류 */
	originIdx int not null,                       /* 출처 고유번호 */
	message text not null,                        /* 내용 */  
	reply	text,	                                  /* 관리자 답글 */
	reportDate datetime default now() not null,   /* 신고일 */
	reportDone varchar(5) default '처리 전' not null, /* 처리 유무 */
	reportHostIp varchar(200) not null,             /* IP주소 */

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_report;
drop table bo_report;
ALTER TABLE bo_report AUTO_INCREMENT = 1;
	