show tables;

create table bo_delivery (
	idx int not null auto_increment,         /* 배송 고유번호 */
	memNickname varchar(20),				         /* 회원 별명(외래키) */
	
	orderIdx int not null,                   /* 주문 고유번호(외래키) */
	addressIdx int not null,                 /* 배송지 고유번호(외래키) */
	refundIdx int,                           /* 환불 고유번호 */
	invoice varchar(30),                     /* 송장 번호 */
	deliveryStatus varchar(20) not null,     /* 주문 상태 */
	deliveryDate datetime default now(),     /* 배송 날짜 */
	deliveryReason char(5),                  /* 배송 사유 */
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null,

	foreign key(orderIdx) references bo_order(idx)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade														              	 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(addressIdx) references bo_address(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete cascade
);


desc bo_delivery;
drop table bo_delivery;
ALTER TABLE bo_delivery AUTO_INCREMENT = 1;
	