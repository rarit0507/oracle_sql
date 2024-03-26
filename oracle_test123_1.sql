--테이블 생성
create table member(no int not null, id varchar(20) primary key, pw varchar(300), name varchar(100), birth timestamp, email varchar(300));

--시퀀스 생성
create sequence c##test123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

--데이터 추가
insert into member values(mem_seq.nextval, 'kim', '1234', '김기태','1981-12-25','kkt@gmail.com');
insert into member values(mem_seq.nextval, 'lee', '4321', '이예린','2001-05-07','yrl@gmail.com');
insert into member values(mem_seq.nextval, 'Rian', '1010', 'RianCalix','1997-10-10','rian1010@gmail.com');
insert into member values(mem_seq.nextval, 'Alice', '7894', 'Alice','1999-04-24','aliceA@gmail.com');
insert into member values(mem_seq.nextval, 'Kain', '5464', 'KainBellmer','1996-09-21','kain@gmail.com');
insert into member values(mem_seq.nextval, 'Abel', '0000', 'Abel','1000-05-04','abel@gmail.com');

--데이터 검색(where : 조건 검색)
select * from member;
select id, name, birth from member where birth>='1980-01-01' and birth<='1989-12-31'; --컬럼명 이용한 검색
-- = select id, name, birth from member where birth between '1980-01-01' and '1989-12-31';

select id, name, birth from member where id like '%i%'; --i자가 포함되어 있는 것 / i%(=i로 시작하는 것)
