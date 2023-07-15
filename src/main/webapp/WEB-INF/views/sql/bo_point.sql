show tables;

create table bo_point (
	idx int not null auto_increment,         /* 적립금 고유번호 */
	memNickname varchar(20) not null,        /* 회원 별명(외래키) */
	orderIdx int,                            /* 주문 고유번호 */
	point int not null,                      /* 적립 포인트 */
	pointReason varchar(250) not null,       /* 적립 사유 */
	pointStartDate datetime default now() not null,     /* 적립일 */

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname) 
	on update cascade														
	on delete cascade
);

desc bo_point;
drop table bo_point;
ALTER TABLE bo_point AUTO_INCREMENT = 1;
	

	
create table bo_pointUse (
	idx int not null auto_increment,         /* 적립금 고유번호 */
	memNickname varchar(20) not null,        /* 회원 별명(외래키) */
	orderIdx int,                            /* 사용한 주문 고유번호 */
	usedPoint int not null,                  /* 사용 포인트 */
	pointUseDate datetime default now() not null,       /* 사용일 */

	primary key(idx),
	foreign key(memNickname) references bo_member(nickname) 
	on update cascade														
	on delete cascade
);

desc bo_pointUse;
drop table bo_pointUse;
ALTER TABLE bo_pointUse AUTO_INCREMENT = 1;