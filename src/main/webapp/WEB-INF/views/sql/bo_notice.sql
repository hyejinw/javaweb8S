show tables;

create table bo_notice (
	idx int not null auto_increment,         		  /* 공지사항 고유번호 */
	category varchar(20) not null,          		  /* 공지 종류 */
	noticeTitle varchar(200) not null,       		  /* 제목 */
	noticeContent text not null,                  /* 내용 */
  noticeView int default 0 not null,						/* 조회수 */
  noticeDate datetime default now() not null,   /* 등록 날짜 */
  important int default 0,                      /* 상단 고정 */ 
  noticeOpen char(5) default '공개',							/* 공개 유무 */
	
	primary key(idx)
);

desc bo_notice;
drop table bo_notice;
ALTER TABLE bo_notice AUTO_INCREMENT = 1;
	