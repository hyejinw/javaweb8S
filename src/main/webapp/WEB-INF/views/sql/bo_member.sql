show tables;

create table bo_member (
	idx int not null auto_increment,      /* 회원 고유번호 */
	mid varchar(20) not null,             /* 회원 아이디(중복 불허) */
	pwd varchar(100) not null,            /* 회원 비밀번호(SHA 256 암호화 처리) */
	name varchar(20) not null,            /* 회원 성명 */
  nickname varchar(20) not null,        /* 회원 별명 */
	email varchar(50) not null,           /* 이메일 (아이디나 비밀번호 분실 시 사용) */
	tel varchar(15) not null,             /*전화번호(010-1234-5678)*/
	memPhoto varchar(250) not null default 'defaultImage.jpg',   /* 프로필 사진 */
	memType varchar(5) not null default '일반',   /* 회원 종류 */
  point int not null,                   /* 적립금 */

  agreement int default 1 not null,                    /* 약관동의 (0:미동의, 1:동의) */
  pwdUpdateDate datetime default now() not null,       /* 비밀번호 변경일 (6개월 이후, 변경 유도) */
 	
	totCnt int default 0 not null,                       /* 총 방문 수 */
	todayCnt int default 0,                              /* 오늘 방문 수 */  
	firstVisit datetime default now(),                   /* 가입일 */
	lastVisit datetime default now(),                    /* 마지막 방문일 */
	memberDel char(5) default '미탈퇴',                    /* 회원 탈퇴신청여부(NO:현재 활동 중, OK: 탈퇴 신청 중) */
	memberDelReason text,                                /* 회원 탈퇴사유 */
	            
	primary key(idx),
	unique key(mid),
	unique key(nickname)
);

desc bo_member;
drop table bo_member;
ALTER TABLE bo_member AUTO_INCREMENT = 1;

