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

--데이터 검색
select * from member;
select id,name,birth from member;
select id,name,birth from member where birth between '1980-01-01' and '1985-12-31'; --생일이 1980~1985년생인 회원의 id, name, birth 검색
select id,name from member where id like '%i%' or id like '%e%';    --아이디에 i나 e가 포함된 회원(member) 정보 검색
--'i%' : i로 시작하는 것
--'%i' : i로 끝나는 것

select * from member where id='kim' or id='lee' or id='cho';    --아이디가 'kim','lee','cho' 인 회원(member) 정보 검색
select * from member where id in ('kim','lee','cho');           --in 연산자 이용
select * from member where id not in ('kim','lee','cho');       --not in 연산자 : id가 'kim','lee','cho'가 아닌 회원(member) 정보 검색

--컬럼명이 길거나, 수식이나 함수를 적용하여 컬럼을 구성할 경우
--컬럼에 대한 alias(별칭)를 붙일 수 있다.
select id,name,substr(name,1,1) from member;    --substr : 사람의 성씨(이름 첫 글자) 출력(이름, 첫글자부터, 1글자)
--java에서 rs.getString("surname"); 처럼 alias로 호출해야 함.

select * from member;

--Update--
update member set email='lee@naver.com' where id='lee';     --id가 'lee'인 회원의 이메일 주소 업데이트

--id가 'kim'인 회원을 강제탈퇴--
delete from member where id='kim';

--alter--
alter table member add regdate timestamp default sysdate;    --테이블 멤버 추가하기. sysdate(Oracle) : 현재날짜(mariaDB,MySql : currentDate)
alter table member add point int default 0; --테이블 멤버 추가. point 컬럼 추가, 기본값 0.
alter table member rename column regdate to reg;    --멤버(member)테이블의 컬럼명 변경
alter table member modify pw int;   --규칙성 위배(애초에 varchar로 설정되어 있었음, 실행불가)
alter table member modify pw varchar(200);
alter table member drop column point;   --point 컬럼 삭제

desc member;    --desc : 구조 보는 명령(Oracle, MariaDB, MySql), 기본키와 기본값은 desc에 출력되지 않음.
select * from member;

commit;

alter table member rename to temp1;     --테이블명 변경(member->temp1)
desc temp1;

create table temp2 (no int, name varchar(200), point int);

insert into temp2 values (1, 'kim', 90);
insert into temp2 values (2, 'Keanu', 100);
insert into temp2 values (3, 'lee', 40);
insert into temp2(name, point) values ('이', 65);    --no가 null(추가는 됨)

select * from temp2;

delete from temp2 where no is null;     --no가 null인 항목 제거
alter table temp2 add constraints key1 primary key (no);    --기본키(=제약조건) 설정(null값 있으면 안 됨. 있으면 지워야)

-------------------------EMP, POS 테이블 생성------------------------------------
create table emp(no int, name varchar(100), pcode int, constraints key2 primary key (no));     --emp 테이블 생성, 기본키를 뒤에 설정할 수도 있음
insert into emp values (1, '김', 1);
insert into emp values (2, '이', 2);
insert into emp values (3, '이', 3);
insert into emp values (4, '이', 4);
insert into emp values (5, '이', 5);

update emp set name='박' where no=3;
update emp set name='최' where no=4;
update emp set name='조' where no=5;

create table pos(pcode int primary key, pname varchar(100));    --pos 테이블 생성, 기본키를 앞에 설정함.
insert into pos values (1, '이사');
insert into pos values (2, '부장');
insert into pos values (3, '과장');
insert into pos values (4, '사원');

--emp는 1~5, pos(참조테이블)은 1~4. 외래키(참조키) 설정 불가
insert into pos values (5, '인턴');   --이걸 하든가

select * from emp;
select * from pos;
--------------------------------------------------------------------------------
alter table emp add constraints fkey foreign key (pcode) references pos(pcode); --emp테이블의 pcode는 pos테이블의 pcode를 참조하겠다.(외래키 생성)(참조무결성 위반)

select * from ALL_CONSTRAINTS;  --제약조건 모두 검색
select * from ALL_CONSTRAINTS where OWNER='C##TEST123';     --검색할 땐 대문자로 써줘야. 오너가 C##TEST123인 테이블의 모든 제약조건 검색
select * from ALL_CONSTRAINTS where TABLE_NAME='EMP';

alter table emp drop constraint key2;   --제약조건 key2 제거

drop table emp;
drop table pos;     --pos는 emp와 연결되어 참조되고 있기 때문에 바로 지울 수 없음
drop table pos cascade constraints;    --연결까지 한 번에 제거. cascade : 연쇄 삭제

desc emp;
desc pos;

commit;


----------------고급SQL------------------------------------------
-- 뷰 생성1
create view view_emp as select * from emp;  --뷰 생성(명령어가 생성된 거지 실제 테이블이 만들어진 게 아님)
select * from emp;      --둘이 같음
select * from view_emp; --둘이 같음
--select문이 길 때 걍 view로 문장을 저장하는 것

--뷰 생성2
create view view_emp2 as select * from emp where no>=3;
select * from view_emp where no>=3; --둘이 같음
select * from view_emp2;            --둘이 같음

drop view view_emp; --뷰 제거
drop view view_emp2; --뷰 제거
--뷰 수정 : alter view view_mep2 as select * from emp where no>=2 or name like
--뷰는 수정하지 않는다. 통상적으로 안 함

---------- 시퀀스(자동순번) 생성/수정/제거/적용/조회 ----------
--시퀀스 생성
create sequence emp_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

select * from emp;

-- emp_seq의 시퀀스 정보 조회
    -- alter sequence emp_seq 수정할내용
    alter sequence emp_seq start with 6 increment by 1; --이미 5번까지 들어가 있으니 6번부터 시작해야 함. alter 이용
--(근데 시작번호는 바꿀 수 없음. 시퀀스 자체를 지우고 다시 6번부터 생성하는 걸로 만들어야)

-- 시퀀스 제거
drop sequence emp_seq;
    create sequence emp_seq increment by 1 start with 6 minvalue 1 maxvalue 9999 nocycle;

select * from all_sequences where sequence_name = 'EMP_SEQ';    --모든 시퀀스 보기

--emp 테이블에 no값을 다음 순번(nextval)으로 적용하여 레코드 추가
insert into emp values (emp_seq.nextval,'고', 3);    --nextval : 다음 값부터 생성
select * from emp;

--현재 시퀀스값 조회
select emp_seq.currval from dual; 

------ 테이블 ------
--테이블 복제
create table emp2 as select * from emp;
desc emp2;  -- 단, 제약조건은 복제되지 않음

select * from emp2;

-- no 컬럼을 기본키로 설정
alter table emp2 modify no int primary key;

-- 내부 조인(inner join)
select a.no, a.name, b.pcode, b.pname from emp a inner join pos b on a.pcode=b.pcode;   --내부 조인(inner join). 외래키와 별개 개념(a의 pcode와 b의 pcode가 같은 것만 출력되도록 하겠다)
-- 외부 조인(outer join, [outer] 생략 가능)
select a.no, a.name, b.pcode, b.pname from emp a left outer join pos b on a.pcode=b.pcode;
select a.no, a.name, b.pcode, b.pname from emp a right outer join pos b on a.pcode=b.pcode;

select * from pos;

-- 연관쿼리
select a.no, a.name, b.pname from emp a, pos b where a.pcode=b.pcode;       --alias 필요O(from emp 'a', pos 'b')
select emp.no, emp.name, pos.pname from emp, pos where emp.pcode=pos.pcode; --alias 필요 x

select * from emp2;
delete from emp2 where no=3 or no=5;
insert into emp2 values (7, '오', 4);
insert into emp2 values (8, '성', 5);
-------- 서브쿼리(=2중쿼리 이상) --------
--서브쿼리1(일치쿼리)(emp2 테이블에 존재하는 no만 emp 테이블에서 조회) => 교집합 출력
select no, name from emp where no in (select no from emp2);
--서브쿼리2(불일치쿼리)(emp2 테이블에 존재하지 않는 no만 emp 테이블에서 조회) => 차집합 출력
select no, name from emp where no not in (select no from emp2);

select * from emp, pos; -- 두 테이블 간의 product - emp:6 pos:5 = 6*5가지 경우의 수

update emp set pcode=4 where no=4 or no=6 or no=2;
-- pcode별로 그룹화 --
select distinct pcode, count(*) as cnt from emp group by pcode;
    -- 그룹화하는 항목과 출력하는 항목이 동일해야 함(pname)
    -- 직위별 인원수 join문 -> 그룹화하는 항목 : 직위명(pname)
select pos.pname, count(emp.no) as cnt from pos, emp where pos.pcode=emp.pcode group by pos.pname
order by pos.pname;  -- : 집계. (by pos.pname : 그룹화하는 항목)
--집계 함수 : count, sum, avg, max, min

select * from emp order by name;    --정렬하여 출력 : order by, (order by ~~ desc : 내림차순 / 생략 or 'ares(?)' : 오름차순)
-- order by 구절은 반드시 맨 끝에 지정해야 함.

-- 집합연산 시에는 연산하는 두 개의 테이블의 구조가 같거나, 연산하는 컬럼 타입이 같아야 함.
-- 집합연산 UNION(합집합), INTERSECT(교집합), MINUS(차집합)
create view uni_view as (select * from emp union select * from emp2);
select * from uni_view;
create view int_view as (select * from emp intersect select * from emp2);
select * from int_view;
create view min_view1 as (select * from emp minus select * from emp2);
create view min_view2 as (select * from emp2 minus select * from emp);
select * from min_view1;
select * from min_view2;
