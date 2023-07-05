show tables;

create table bo_book (
	idx int not null auto_increment,      /* 책 고유번호 */
	title varchar(200) not null,          /* 도서 제목 */
	contents text,                        /* 도서 소개 */
	url text,                             /* 도서 상세 URL */
  isbn varchar(50) not null,            /* ISBN 10/13 */
	datetime datetime not null,           /* 도서 출판날짜 */
	authors text not null,                /* 도서 저자 리스트 */
	publisher varchar(50) not null,       /* 도서 출판사 */
	translators text,                     /* 도서 번역자 리스트 */
  price int,                            /* 도서 정가 */
	sale_price int,                       /* 도서 판매가 */
  thumbnail text,                       /* 도서 표지 미리보기 */
  status varchar(15),                   /* 도서 판매 상태 */
 	
	bookRate double default 0,                      /* 도서 평점 */
	save int default 0 not null,                    /* 저장 등록 수 */  
	bookUpdate datetime default now() not null,     /* 도서 저장 날짜 */
	            
	primary key(idx)
);

desc bo_book;
drop table bo_book;
ALTER TABLE bo_book AUTO_INCREMENT = 1;


show tables;

-- 책 저장
create table bo_bookSave (
	idx int not null auto_increment,    /* 책 고유번호 */
	bookIdx int not null,               /* 도서 고유번호(외래키) */
	memNickname varchar(20) not null,   /* 회원 별명 */

	
	primary key(idx),
	
	foreign key(bookIdx) references bo_book(idx)
	on update cascade
	on delete cascade,
	
	foreign key(memNickname) references bo_member(nickname)
	on update cascade
	on delete cascade
);

desc bo_bookSave;
drop table bo_bookSave;
ALTER TABLE bo_bookSave AUTO_INCREMENT = 1;