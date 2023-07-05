show tables;

create table bo_cart (
	idx int not null auto_increment,         /* 장바구니 고유번호 */
	memNickname varchar(20) not null,        /* 회원 별명(외래키) */
	type varchar(10) not null,               /* 상품 타입 */
	
	maIdx int,                               /* 매거진 고유번호(외래키) */
	prodIdx int,                             /* 상품 고유번호(외래키) */
	opIdx int,                               /* 옵션 고유번호(외래키) */
	
	prodName varchar(100) not null,          /* 매거진/상품명 */
	prodPrice int not null,                  /* 매거진/상품 가격 */
	prodThumbnail varchar(250) not null,     /* 메인 이미지 */
	
	opName varchar(50),                      /* 옵션명 */
	opPrice int,                             /* 옵션 가격 */
	
	num int not null,                        /* 상품 수량 */
	totalPrice int not null,                 /* 총 상품 가격 */
	cartDate datetime default now(),         /* 저장 날짜 */
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade														              	 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(maIdx) references bo_magazine(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null,
	
	foreign key(prodIdx) references bo_product(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null,
	
	foreign key(opIdx) references bo_option(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null
);


desc bo_cart;
drop table bo_cart;
ALTER TABLE bo_cart AUTO_INCREMENT = 1;
	