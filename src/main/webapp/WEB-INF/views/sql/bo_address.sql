show tables;

create table bo_address (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	memNickname varchar(20) not null,             /* 회원 고유번호(외래키) */
	defaultAddress int not null,                  /* 주문 고유번호(외래키) */
	addressName varchar(50) not null,             /* 적립 포인트 */
	name varchar(20) not null,                    /* 적립 사유 */
	tel varchar(15) not null,                     /* 적립일 */
	addressMsg text,                              /* 적립일 */
	postcode varchar(10) not null,                /* 적립일 */
	roadAddress varchar(250) not null,            /* 적립일 */
	detailAddress varchar(250) not null,          /* 적립일 */
	extraAddress varchar(250),                    /* 적립일 */
	addressDate datetime default now() not null,  /* 적립일 */
	addressDel char(5) default '미삭제',            /* 적립일 */

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_address;
drop table bo_address;
ALTER TABLE bo_address AUTO_INCREMENT = 1;
	