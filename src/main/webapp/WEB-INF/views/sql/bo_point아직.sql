show tables;


desc bo_point;
drop table bo_point;
ALTER TABLE bo_point AUTO_INCREMENT = 1;
	
create table bo_point (
	idx int not null auto_increment,         /* 적립금 고유번호 */
	memMid varchar(20) not null,             /* 회원 고유번호(외래키) */
	orderIdx int,                            /* 주문 고유번호(외래키) */
	point int not null,                      /* 적립 포인트 */
	pointReason varchar(250) not null,       /* 적립 사유 */
	pointStartDate varchar(50) not null,     /* 적립일 */

	primary key(idx),
	foreign key(memMid) references bo_member(mid)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade
);

	,
	foreign key(orderIdx) references order(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade
