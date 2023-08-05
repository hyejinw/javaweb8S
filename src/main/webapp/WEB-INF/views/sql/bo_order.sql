show tables;

create table bo_order (
	idx int not null auto_increment,         /* 주문 고유번호 */
	memNickname varchar(20),                 /* 회원 별명(외래키) */
	type varchar(10) not null,               /* 상품 타입 */
	orderCode varchar(30) not null,          /* 주문 코드 */
	
	addressIdx int not null,                 /* 배송지 고유번호(외래키) */
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
	paidPrice int not null,                  /* 실제 구매 가격 */
	usedPoint int not null default 0,        /* 사용 포인트 */
	orderDate datetime default now(),        /* 주문 날짜 */
	orderStatus varchar(20) not null,        /* 주문 상태 */
	manageDate datetime default now(),       /* 처리 날짜 */
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)    
	on update cascade														              	
	on delete set null,
	
	foreign key(addressIdx) references bo_address(idx)     
	on update cascade														              	
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


desc bo_order;
drop table bo_order;
ALTER TABLE bo_order AUTO_INCREMENT = 1;
	