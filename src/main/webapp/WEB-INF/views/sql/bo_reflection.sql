show tables;

create table bo_reflection (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	bookIdx int,                                  /* 도서 고유번호(외래키) */
	memNickname varchar(20) not null,             /* 작성자(회원 별명)(외래키) */
	title varchar(100) not null,     						  /* 제목 */			
	content text not null,											  /* 내용 */						
	refSave int default 0 not null, 						  /* 저장 등록 수 */			
	refView int default 0 not null, 						  /* 조회 수 */			
	replyOpen int default 1,       						    /* 댓글 허용 여부 */			
	refDate datetime default now() not null,   	  /* 올린 날짜 */			
	refHostIp varchar(100) not null,              /* IP주소 */
	refDel char(5) default '미삭제',                /* 삭제 신청 여부 */
	
	
	primary key(idx),
	foreign key(bookIdx) references bo_book(idx)  
	on update cascade												      
	on delete set null,
	
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);


desc bo_reflection;
drop table bo_reflection;
ALTER TABLE bo_reflection AUTO_INCREMENT = 1;

-- 기록 저장
create table bo_refSave (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	refIdx int not null,                          /* 기록 고유번호(외래키) */
	memNickname varchar(20) not null,             /* 저장한 회원 별명(외래키) */
	refSaveDate datetime default now() not null,  /* 저장 날짜 */	
	
	primary key(idx),
	foreign key(refIdx) references bo_reflection(idx)  
	on update cascade												      
	on delete cascade,
	
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);


desc bo_refSave;
drop table bo_refSave;
ALTER TABLE bo_refSave AUTO_INCREMENT = 1;