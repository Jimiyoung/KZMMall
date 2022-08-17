show tables;

create table notice2(
	idx int not null auto_increment, /*글 고유번호*/
	name varchar(20) not null,       /*작성자*/
	title varchar(100) not null,     /*제목*/
	content text not null,           /*내용*/
	wDate datetime default now(),    /*작성일*/
	readNum int default 0,           /*조회수*/
	mid varchar(20) not null,        /*회원 아이디(게시글 조회 시 사용)*/
	pin int not null default 0,      /*게시물 상단고정  고정:1 아니면:0*/  
	primary key(idx)                 /* 게시판의 기본 키 : 고유번호*/
);

desc notice;

insert into notice value (default, '관리맨', '게시판 서비스를 시작합니다', '이곳은 게시판입니다', default, default,'admin');
insert into notice value (default, '관리맨', '1.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', ' 서비스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '비스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '판 서비스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '시판 서비스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '게시판 서작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '게시판 서니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '게시판 서스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '게시판 비스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
insert into notice value (default, '관리맨', '게시판 서스를 시작합니다.', '이곳은 게시판입니다.', default, default,'admin');
select * from notice;

select *, cast(TIMESTAMPDIFF(MINUTE,wDate,NOW())/60 as signed integer) from notice2 order by idx desc;
select *,cast(TIMESTAMPDIFF(MINUTE,wDate,NOW())/60 as signed integer) AS diffTime from notice2 order by idx desc; 

select idx, title from notice2 where idx in(
			(select idx from notice2 where <![CDATA[idx < 5]]> order by idx desc limit 1),
			(select idx from notice2 where <![CDATA[idx > 5]]> limit 1));
			
select idx, title from notice2 where idx in(
      (select idx from notice2 where idx > 5 limit 1),
      (select idx from notice2 where idx < 5 order by idx desc limit 1)
    );			
