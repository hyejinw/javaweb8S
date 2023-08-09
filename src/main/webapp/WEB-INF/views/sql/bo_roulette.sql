show tables;

create table bo_roulette (
	idx int not null auto_increment,         		  /* 룰렛 고유번호 */
	memNickname varchar(20) not null,        		  /* 회원 별명(외래키) */
	trial int not null default 2,                 /* 시도 가능 횟수 */
	totPoint int,                                 /* 총 획득 적립금 */
 	success int not null default 0,               /* 총 성공 횟수 */
 	rouletteDate datetime default now(),          /* 시도일 */
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_roulette;
drop table bo_roulette;
ALTER TABLE bo_roulette AUTO_INCREMENT = 1;
	


