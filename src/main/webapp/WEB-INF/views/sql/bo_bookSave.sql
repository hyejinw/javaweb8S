
-- 책 저장
create table bo_bookSave (
	idx int not null auto_increment,    /* 책 고유번호 */
	memNickname varchar(20) not null,   /* 회원 별명(외래키)  */
	categoryName varchar(60) not null,  /* 카테고리명(외래키)  */
	bookIdx int not null,               /* 도서 고유번호(외래키) */
	
	primary key(idx),
	
	foreign key(memNickname) references bo_member(nickname)
	on update cascade
	on delete cascade,
	
	foreign key(memNickname) references bo_member(nickname)
	on update cascade
	on delete cascade,
	
	foreign key(bookIdx) references bo_book(idx)
	on update cascade
	on delete cascade
);

desc bo_bookSave;
drop table bo_bookSave;
ALTER TABLE bo_bookSave AUTO_INCREMENT = 1;


show tables;

-- 책 저장 카테고리
create table bo_bookSaveCategory (
	idx int not null auto_increment,              /* 책 저장 카테고리 고유번호 */
	memNickname varchar(20) not null,             /* 회원 별명(외래키) */
	categoryName varchar(60) not null,						/* 카테고리명 */				
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_bookSaveCategory;
drop table bo_bookSaveCategory;
ALTER TABLE bo_bookSaveCategory AUTO_INCREMENT = 1;
	