show tables;

create table bo_collection (
	idx int not null auto_increment,                /* 컬렉션 고유번호 */
	colName varchar(100) not null,                  /* 컬렉션 명 */
	colDetail text not null,                        /* 컬렉션 설명 */
	colThumbnail varchar(250) not null,             /* 컬렉션 썸네일 */
	colDate datetime not null default now(),        /* 발행일 */
	colOpen char(5) default '비공개',                  /* 공개 유무 */
	
	primary key(idx)
);

desc bo_collection;
drop table bo_collection;
ALTER TABLE bo_collection AUTO_INCREMENT = 1;
	