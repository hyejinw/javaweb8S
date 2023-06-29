show tables;

create table bo_magazine (
	idx int not null auto_increment,         /* 매거진 고유번호 */
	maCode varchar(10) not null,             /* 상품 코드 */
	maType varchar(10) not null,             /* 상품 타입 */
	maTitle varchar(100) not null,           /* 제목 */
  maPrice int not null,                    /* 가격 */
	maThumbnail varchar(250) not null,       /* 상품 썸네일 */
	maDetail varchar(250) not null,          /* 상품 설명 */
	maDate datetime default now() not null,  /* 발행일 */
	maStock int default 100 not null,        /* 재고 수량 */
  maSaleQuantity int default 0 not null,   /* 판매 수량 */
  maSave int default 0 not null,           /* 저장 등록 수 */
  maOpen char(5) default '공개',            /* 공개 유무 */
	            
	primary key(idx)
);

desc bo_magazine;
drop table bo_magazine;
ALTER TABLE bo_magazine AUTO_INCREMENT = 1;

