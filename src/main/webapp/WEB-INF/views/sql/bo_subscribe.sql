show tables;

create table bo_subscribe (
	idx int not null auto_increment,              /* 적립금 고유번호 */
	memNickname varchar(20),                      /* 회원 고유번호(외래키) */
	subIdx int not null,                          /* 정기구독 고유번호 */
	orderIdx int not null,                        /* 주문 고유번호 */
	subStartDate datetime default now() not null, /* 시작일 */
	subExpireDate datetime not null,              /* 종료일 */
	subSendNum int default 6,                     /* 발송 잔여 횟수 */
	subStatus char(10) default '구독중',            /* 구독 유지 유무 */
	subRefund int,                                /* 구독 취소 환불금 */ 
	subRefundPoint int,                           /* 구독 취소 환불포인트 */ 
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete set null
);

desc bo_subscribe;
drop table bo_subscribe;
ALTER TABLE bo_subscribe AUTO_INCREMENT = 1;
	