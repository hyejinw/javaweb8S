show tables;

-- 컬렉션 상품
create table bo_product (
	idx int not null auto_increment,      /* 컬렉션 상품 고유번호 */
	
	colIdx int not null,                  /* 컬렉션 고유번호 */
	bookIdx int,              					  /* 도서 고유번호 */
	bookTitle varchar(200),	          	  /* 도서 제목 */
	
	prodCode varchar(20) not null,        /* 상품 코드 */
	prodName varchar(100) not null,       /* 상품명 */
	prodPrice int not null,               /* 가격 */
	prodReason text,                      /* 상품 선정 이유 */
	prodThumbnail varchar(250) not null,  /* 상품 썸네일 */
	prodDetail varchar(250) not null,     /* 상품 상세설명 */
	prodDate datetime not null default now(),  /* 등록일 */
	prodSaleQuantity int not null default 0,   /* 판매 수량 */
	prodSave int not null default 0,           /* 저장 등록 수 */
	prodStatus char(5) default '판매',           /* 상품 상태 */
	prodOpen char(5) default '공개',             /* 공개 유무 */
	 
	primary key(idx),
	foreign key(colIdx) references bo_collection(idx)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade														              	 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(bookIdx) references bo_book(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null
);

desc bo_product;
drop table bo_product;
ALTER TABLE bo_product AUTO_INCREMENT = 1;


-- 컬렉션 상품 옵션
create table bo_option (
	idx int not null auto_increment,      /* 컬렉션 상품 옵션 고유번호 */
	prodIdx int not null,                 /* 상품 고유번호호 */
	opName varchar(50) not null,       	  /* 옵션명 */
	opPrice int not null,                 /* 옵션 가격 */
	opStock int default 0 not null,       /* 재고 수량 */
	
	primary key(idx),
	
	foreign key(prodIdx) references bo_product(idx)        /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade														         	 /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_option;
drop table bo_option;
ALTER TABLE bo_option AUTO_INCREMENT = 1;



	