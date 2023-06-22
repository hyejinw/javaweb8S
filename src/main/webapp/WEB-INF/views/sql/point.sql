show tables;


desc point;
drop table point;
ALTER TABLE point AUTO_INCREMENT = 0;
	
create table point (
	idx int not null auto_increment,         /* ������ ������ȣ */
	memMid varchar(20) not null,             /* ȸ�� ������ȣ(�ܷ�Ű) */
	orderIdx int,                            /* �ֹ� ������ȣ(�ܷ�Ű) */
	point int not null,                      /* ���� ����Ʈ */
	pointReason varchar(250) not null,       /* ���� ���� */
	pointStartDate varchar(50) not null,     /* ������ */

	primary key(idx),
	foreign key(memMid) references member(mid)     /* �ܷ�Ű ����: �ݵ�� ������ Ű���߸� �Ѵ�. */
	on update cascade															 /* ������ ������ ���󰣴�. */
	on delete cascade
);

	,
	foreign key(orderIdx) references order(idx)    /* �ܷ�Ű ����: �ݵ�� ������ Ű���߸� �Ѵ�. */
	on update cascade															 /* ������ ������ ���󰣴�. */
	on delete cascade