show tables;

create table bo_defaultPhoto (
	idx int not null auto_increment,         /* 고유번호 */
	photoName varchar(250) not null,         /* 사진 파일명 */
	memo varchar(250),                       /* 설명 */
	photoDate datetime default now(),        /* 업로드 일 */
	            
	primary key(idx)
);

desc bo_defaultPhoto;
drop table bo_defaultPhoto;
ALTER TABLE bo_defaultPhoto AUTO_INCREMENT = 1;