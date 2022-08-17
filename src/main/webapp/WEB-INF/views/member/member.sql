show tables;

create table member2(
	idx int not null auto_increment,   /* 회원 고유번호 */ 
	mid varchar(20) not null,          /* 아이디(중복불허) */ 
	pwd varchar(100) not null,         /* 비밀번호(암호화처리) */
	name varchar(20) not null,         /* 성명 */   
	tel varchar(20) not null,          /* 휴대전화 */
	email varchar(50) not null,        /* 이메일(아이디/ 비밀번호 분실 시 필요)-형식 체크할 것 */
	address varchar(100) not null,     /* 주소 */
	startDate datetime default now(),   /* 최초 가입일 */
	lastDate datetime default now(),    /* 마지막 접속일 */
	userDel char(2) default 'NO',      /* 회원 탈퇴 신청 여부(OK : 탈퇴신청회원, NO : 현재 가입중인 회원) */
	level int default 1,               /* 1:일반회원 2:GOLD 3:VIP  0:관리자 */
	point int default 0,
	primary key(idx)
);

drop table member2;

insert into member2 values(default, 'admin', '1234', '관리자', '010-3423-2704', 'cjsk1126@naver.com', '경기도 안성시 공도로 142', default,default,default,default);
select * from member2;

desc member2;
ALTER TABLE member2 ADD COLUMN point int default 5000;
