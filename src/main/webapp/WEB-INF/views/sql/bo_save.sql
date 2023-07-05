show tables;

create table bo_save (
	idx int not null auto_increment,      /* 저장 고유번호 */
	memNickname varchar(20) not null,     /* 회원 별명 */
	type varchar(10) not null,            /* 상품 타입 */
	
	maIdx int,                            /* 매거진 고유번호 */
  prodIdx int,                          /* 상품 고유번호 */
	
  prodName varchar(100) not null,       /* 매거진/상품명 */
	prodPrice int not null,               /* 매거진/상품 가격 */
	prodThumbnail varchar(250) not null,  /* 썸네일 이미지 */
	            
	primary key(idx),
	
	foreign key(memNickname) references bo_member(nickname)     
	on update cascade														              	 
	on delete cascade,
	
	foreign key(maIdx) references bo_magazine(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null,

	foreign key(prodIdx) references bo_product(idx)     
	on update cascade														              	 /* 원본 삭제 시, null 처리. */
	on delete set null
);

desc bo_save;
drop table bo_save;
ALTER TABLE bo_save AUTO_INCREMENT = 1;