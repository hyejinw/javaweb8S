show tables;

create table member (
	idx int not null auto_increment,      /* ȸ�� ������ȣ */
	mid varchar(20) not null,             /* ȸ�� ���̵�(�ߺ� ����) */
	pwd varchar(100) not null,            /* ȸ�� ��й�ȣ(SHA 256 ��ȣȭ ó��) */
	name varchar(20) not null,            /* ȸ�� ���� */
  nickname varchar(20) not null,        /* ȸ�� ���� */
	email varchar(50) not null,           /* �̸��� (���̵� ��й�ȣ �н� �� ���) */
	tel varchar(15) not null,             /*��ȭ��ȣ(010-1234-5678)*/
	memPhoto varchar(250) not null default 'defaultImage.jpg',   /* ������ ���� */
	memType varchar(5) not null default '�Ϲ�',   /* ȸ�� ���� */
  point int not null,                   /* ������ */

  agreement int default 1 not null,                    /* ������� (0:�̵���, 1:����) */
  pwdUpdateDate datetime default now() not null,       /* ��й�ȣ ������ (6���� ����, ���� ����) */
 	
	totCnt int default 0 not null,                       /* �� �湮 �� */
	todayCnt int default 0,                              /* ���� �湮 �� */  
	firstVisit datetime default now(),                   /* ������ */
	lastVisit datetime default now(),                    /* ������ �湮�� */
	memberDel char(2) default 'NO',                      /* ȸ�� Ż���û����(NO:���� Ȱ�� ��, OK: Ż�� ��û ��) */
	memberDelReason text,                                /* ȸ�� Ż����� */
	            
	primary key(idx),
	unique key(mid),
	unique key(nickname)
);

desc member;
drop table member;
ALTER TABLE member AUTO_INCREMENT = 0;