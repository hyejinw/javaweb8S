show tables;

create table bo_refund (
	idx int not null auto_increment,         /* 배송 고유번호 */
	memNickname varchar(20),                 /* 회원 별명(외래키) */
	
	orderIdx int not null,                   /* 주문 고유번호(외래키) */
	maIdx int,                               /* 매거진 고유번호(외래키) */
	opIdx int,                               /* 옵션 고유번호(외래키) */
	
	refundNum int not null,                  /* 반품 개수 */ 
	refundCode varchar(30) not null,         /* 환불 코드 */
	refundStatus varchar(20) not null,       /* 환불 상태 */
	refundDate datetime default now(),       /* 환불 날짜 */
	manageDate datetime default now(),       /* 처리 날짜 */
	
	refundReason varchar(20) not null,       /* 환불 사유 */
	refundDetail text,                       /* 환불 상세 사유 */
	refundPhoto varchar(250),                /* 관련 사진 */
	
	refundPrice char(5),                     /* 환불 금액 */
	refundPoint int,                         /* 반환 포인트 */
	deliveryPrice int,                       /* 배송비 */
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null,

	foreign key(orderIdx) references bo_order(idx)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade														              	 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(maIdx) references bo_magazine(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null,
	
	foreign key(opIdx) references bo_option(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null
);


desc bo_refund;
drop table bo_refund;
ALTER TABLE bo_refund AUTO_INCREMENT = 1;
	