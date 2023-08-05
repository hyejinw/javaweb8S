show tables;

create table bo_inspired (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	bookIdx int,                                  /* 도서 고유번호(외래키) */
	memNickname varchar(20) not null,             /* 작성자(회원 별명)(외래키) */
	insContent text not null,										  /* 내용 */						
	page varchar(30) not null,	                  /* 페이지 */
	explanation text,	                            /* 설명 */
	insSave int default 0 not null,               /* 저장 등록 수 */
	insDate datetime default now() not null,      /* 올린 날짜 */
	insHostIp varchar(100) not null,              /* IP주소 */
	insDel char(5) default '미삭제',                /* 삭제 신청 여부 */

	primary key(idx),
	
	foreign key(bookIdx) references bo_book(idx)  
	on update cascade												      
	on delete set null,
	
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_inspired;
drop table bo_inspired;
ALTER TABLE bo_inspired AUTO_INCREMENT = 1;
	


-- 문장 수집 저장
create table bo_insSave (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	insIdx int not null,                          /* 문장 수집 고유번호(외래키) */
	memNickname varchar(20) not null,             /* 저장한 회원 별명(외래키) */
	insSaveDate datetime default now() not null,  /* 저장 날짜 */	
	
	primary key(idx),
	foreign key(insIdx) references bo_inspired(idx)  
	on update cascade												      
	on delete cascade,
	
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);


desc bo_insSave;
drop table bo_insSave;
ALTER TABLE bo_insSave AUTO_INCREMENT = 1;
