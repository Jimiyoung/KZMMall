show tables;

create table as2(
	idx int not null auto_increment, /*글 고유번호*/
	name varchar(20) not null,       /*작성자*/
	pwd varchar(50) not null,        /*비밀번호*/
	tel varchar(20) not null,        /*연락처*/
	email varchar(50) not null,        /*이메일*/
	productName varchar(50) not null,  /*제품이름*/
	place varchar(50) not null,        /*구입처*/
	purchaseDate varchar(50) not null,     /*구입날짜*/
	wDate datetime default now(),    /*작성일*/
	title varchar(50) not null,    /*제목*/
	content text not null,           /*내용*/
	open char(2) default 'NO',      /*글 공개:OK 비공개:NO*/  
	sw char(2) default 'NO',     /* 확인여부(OK : 확인, NO : 확인 전) */
	primary key(idx)                 /* 게시판의 기본 키 : 고유번호*/
);
ALTER TABLE as2 ADD mid varchar(20) not null;

select * from as2 where mid = 'kzm123'

/*댓글테이블(asReply2)*/
create table asReply2(
	idx 		 int not null auto_increment, /*댓글의 고유번호*/
	asIdx int not null,           			/*원본글의 고유번호(외래키로 지정)*/
	name varchar(20) not null,   			/*댓글 올린이의 이름*/
	wDate 	 datetime default now(),    	/*댓글 올린 날짜*/
	content  text not null,           		/*댓글 내용*/
	level int not null default 0,         /*댓글레벨. 부모댓글의 레벨은 0*/
	levelOrder int not null default 0,    /*댓글의 순서. 부모댓글의 levelOrder은 0*/
	primary key(idx),                			/*주키(기본키)는 idx*/
	foreign key(asIdx) references as2(idx) /* as2 테이블의 idx를 asReply2테이블의 외래키로 설정.*/
);
desc as2;
desc asReply2;