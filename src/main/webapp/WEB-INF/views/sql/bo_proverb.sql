show tables;

create table bo_proverb (
	idx int not null auto_increment,        /* 고유번호 */
	content varchar(300) not null,          /* 내용 */
	origin varchar(50),                     /* 작성자 */
	            
	primary key(idx)
);

desc bo_proverb;
drop table bo_proverb;
ALTER TABLE bo_proverb AUTO_INCREMENT = 1;
