show tables;

create table bo_block (
	idx int not null auto_increment,              /* 차단 친구 고유번호 */
	memNickname varchar(20) not null,             /* 차단한 회원 별명(외래키) */
	blockedNickname varchar(20) not null,         /* 차단당한 회원 별명(외래키) */
	blockDate datetime default now() not null,    /* 차단일 */
	
	primary key(idx),
	
	foreign key(memNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade,
	foreign key(blockedNickname) references bo_member(nickname)     /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade												               		  /* 원본의 변경을 따라간다. */
	on delete cascade
);

desc bo_block;
drop table bo_block;
ALTER TABLE bo_block AUTO_INCREMENT = 1;
	