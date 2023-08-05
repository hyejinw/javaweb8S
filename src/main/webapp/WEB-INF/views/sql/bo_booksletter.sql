show tables;

create table bo_booksletter (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	memNickname varchar(20),                      /* 회원 고유번호 */
	email varchar(50) not null,                   /* 이메일 */
	booksletterDate datetime default now(),       /* 등록일 */ 
	sendNum int default 0,                        /* 발송 횟수 */
	booksletterStatus char(5) default '구독중',     /* 구독 유지 유무 */

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_booksletter;
drop table bo_booksletter;
ALTER TABLE bo_booksletter AUTO_INCREMENT = 1;
	