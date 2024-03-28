create table board(idx int primary key GENERATED ALWAYS as identity,
				   subject varchar(100) not null,
				   content varchar(500) not null,
				   writer varchar(20) not null,
				   resdate date DEFAULT now());

insert into board values (default,'제목1','예시글 1입니다.',
						  '관리자',default);
insert into board values (default,'글제목2','예시글 2의 내용입니다.',
						  '김기태',default);
insert into board values (default,'글의 제목3',
						  '예시글 3의 조대신 글 내용입니다.',
						  '조대신',default);
insert into board values (default,'글4',
						  '샘플글 4의 내용입니다.',
						  '권민지',default);
insert into board values (default,'글의 제목5',
						  '더미글 5의 콘텐츠입니다.',
						  '이성하',default);
insert into board values (default,'글제목6',
						  '아무나 글 6의 글 내용입니다.',
						  '강범준',default);


create table user1(idm int GENERATED ALWAYS as identity,
				  id varchar(15) primary key, pw varchar(15),
				  name varchar(30), email varchar(40),
				   regdate date default current_date);

insert into user1 values(default, 'kkt', '1234', '김기태', 
						 'kkt@naver.com', default);