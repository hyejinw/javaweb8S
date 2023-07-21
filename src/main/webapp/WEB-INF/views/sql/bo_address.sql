show tables;

create table bo_address (
	idx int not null auto_increment,              /* 배송지 주소 고유번호 */
	memNickname varchar(20) not null,             /* 회원 별명(외래키) */
	defaultAddress int not null,                  /* 기본 주소 여부 */
	addressName varchar(50) not null,             /* 배송지 명 */
	name varchar(20) not null,                    /* 수령인 */
	tel varchar(15) not null,                     /* 전화번호 */
	addressMsg text,                              /* 배송 메시지 */
	postcode varchar(10) not null,                /* 우편번호 */
	roadAddress varchar(250) not null,            /* 기본주소 */
	detailAddress varchar(250) not null,          /* 상세주소 */
	extraAddress varchar(250),                    /* 부가주소 */
	addressDate datetime default now() not null,  /* 등록일 */
	addressDel char(5) default '미삭제',            /* 삭제 유무 */

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_address;
drop table bo_address;
ALTER TABLE bo_address AUTO_INCREMENT = 1;
	