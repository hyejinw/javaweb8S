show tables;

create table bo_dice (
	idx int not null auto_increment,         		  /* 주사위 고유번호 */
	memNickname varchar(20) not null,        		  /* 회원 별명(외래키) */
	trial int not null default 3,                 /* 시도 가능 횟수 */
	totPoint int,                                 /* 총 획득 적립금 */
 	success int not null default 0,               /* 총 성공 횟수 */
 	diceDate datetime default now(),              /* 시도일 */
	
	primary key(idx),
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_dice;
drop table bo_dice;
ALTER TABLE bo_dice AUTO_INCREMENT = 1;
	


create table bo_todayDice (
	idx int not null auto_increment,         		  /* 오늘의 주사위 번호 고유번호 */
	luckyNum int not null,        		            /* 오늘의 번호 */
 	todayDiceDate datetime default now(),         /* 생성일 */
	
	primary key(idx)
);

desc bo_todayDice;
drop table bo_todayDice;
ALTER TABLE bo_todayDice AUTO_INCREMENT = 1;
	

