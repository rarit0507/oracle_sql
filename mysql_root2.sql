use kh;

show tables;

-- 근본적으로 켜거나 끄기(sql_safe_updates, autocommit)
-- Select 문을 활용한 Update Safe Mode => sql_safe_updates
-- SQL 실행 시 자동 커밋 => autocommit
-- 아래 내용을 수정하고, MySQL 서버를 재시작하게 되면 Safe Mode와 AutoCommit이 비활성화됨.
	-- C:\programData\MYSQL Server 8.0\my.ini
	-- [mysqld]
	-- sql_safe_updates= 0;
	-- autocommit=0		-- mysql, mariaDB는 이게 자동으로 켜져 있음.
    
-- workBench에서 해당 내용을 설정하고 싶다면,
-- SET 명령에 해당 옵션을 설정하면 됨.
-- SET SQL_SAFE_UPDATES = 0
-- SET AUTOCOMMIT = FALSE : 트랜잭션 처리가 필요한 경우 반드시 OFF(FALSE)이어야 함.

SET SQL_SAFE_UPDATES = 0;

-- 1) 회원 테이블에 다음과 같은 내용을 추가하시오.
insert into member values('kkt','a1004','김기태','가산동 123','010-1004-1004','2023-09-12');

-- 2) 도서 테이블에 다음 데이터를 추가하시오.			
insert into book values (default,'IT','스프링프레임워크',38000,8,'김기태','정복사','2022-09-10');

-- 3) 판매 테이블에 다음 튜플(레코드)을 추가하시오.
insert into sales values(default,1,'kkt',2,null,default);

update sales set money=(select bookprice from book where bookid=sales.bno) * amount where sno=19;

-- 4) 회원 테이블에 기본값이 0인 숫자 데이터를 저장할 포인트(pt) 컬럼을 추가하시오.
alter table member add pt int default 0;

-- 5) 회원 테이블에 방문횟수(visited) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add visited int default 0;

-- 6) 회원 테이블에 이메일(email) 컬럼을 추가하시오(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add email varchar(20) not null;

-- 7) 회원 테이블에 지역코드(areacode) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add areacode varchar(8) not null;

-- 8) 회원 테이블에 있는 컬럼 중에서 방문횟수 컬럼을 제거하시오.
alter table member drop column visited;

-- 9) 회원 테이블에 지역(areacode) 컬럼의 이름을 areadata 로 변경하시오.
alter table member rename column areacode to areadata;

-- 10) 판매(sales) 테이블을 복제하여 판매2(sales2) 테이블을 만드시오.
create table sales2 (select * from sales);
select * from sales2;

-- 11) 도서 테이블을 복제하여 도서2(book2) 테이블을 만드시오.
create table book2 (select * from book);

-- 12) 회원 테이블을 복제하여 회원2(member2) 테이블을 만드시오.
create table member2 (select * from member);

-- 13) 판매2(sales2) 테이블을 제거하시오.
drop table sales2;

-- ★★★14) 복제된 회원2(member2) 테이블에서 아이디가 j가 포함된 회원을 삭제하시오.
delete from member2 where id like '%j%';

-- ★★★15) 회원(member) 테이블에서 모든 회원에 대한 포인트를 100 이 지급될 수 있도록 변경하시오.
update member set pt=pt+100;
	-- 값 변경은 alter가 아니라 update임
select * from member;

-- 16) 회원(member) 테이블에서 회원의 아이디가 lsh인 회원의 주소를 '도화동 27'로 변경하시오.
update member set address='도화동 27' where id='lsh';

-- ★★★17) 회원2(member2) 테이블에서 연락처가 02인 회원에 대하여 가입일을 오늘날짜로 변경하시오.
update member2 set reg_date = now() where tel like '02%';

-- 18) 도서2(book2) 테이블에서 도서 분류가 HC인 레코드에 대하여 도서 수량을 5로 변경하시오.
update book2 set bookcount=5 where bookkind='HC';
select * from book2;

-- 19) 도서2(book2) 테이블에서 도서 분류가 TC인 튜플을 제거하시오.
delete from book2 where bookkind='TC';

-- 20) 도서2(book2) 테이블에 도서상태(ckdata) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table book2 add column ckdata varchar(20);

-- 21) 도서2(book2) 테이블에 도서 수량이 7이하인 튜플에 대하여 도서상태를 '재입고요망' 으로 내용을 추가하시오.
update book2 set ckdata='재입고요망' where bookcount<=7;

-- ★★★22) 회원2(member2) 테이블에 id를 기본키로 추가하시오.
alter table member2 add constraint pkey1 primary key(id);

-- ★★★23) 도서2(book2) 테이블에 도서코드(bookid)를 기본키로 도서분류(bookkind)를 외래키로 추가하시오.
alter table book2 add constraint pbkey1 primary key(bookid);

create table bookkind(kindcode varchar(6) primary key, kindname varchar(50));
insert into bookkind values ('IT', 'IT관련서적');
insert into bookkind values ('NV','소설');
insert into bookkind values ('DV','자기계발');
insert into bookkind values ('HC','역사');
insert into bookkind values ('TC','일반상식');

alter table book2 add constraint fbkey foreign key(bookkind) references bookkind(kindcode);
desc book2;

-- 24) 도서2(book2) 테이블에서 출판일(pubdate)가 2022년 8월 인 데이터의 수량을 5씩 더 증가시키시오.
update book2 set bookcount=bookcount+5
where pubdate between '2022-08-01' and '2022-08-31';

-- 25) 회원(member) 테이블에서 모든 회원의 모든 정보를 조회하시오.
select * from member;

-- ★★★26) 판매(sales) 테이블에서 구매한 적이 있는 회원의 아이디를 중복을 제거하여 조회하시오.
select distinct id,password,name from member where id in (select id from sales);

-- 27) 도서(book) 테이블에서 도서종류(bookkind)가 IT인 튜플을 검색하시오.
select * from book where bookkind='IT';

-- 28) 회원(member) 테이블에서 아이디가 k가 포함된 회원의 이름(name),  연락처(tel) 컬럼을 검색하시오.


-- 29) 판매(sales) 테이블에서 수량(amount)이 2이상인 레코드를 검색하시오.


-- 30) 도서(book) 테이블에서 단가(bookprice)가 19000이상 30000이하인 데이터의 도서명(booktitle), 도서가격(bookprice), 저자(author) 를 조회하시오.


-- 31) 도서(book) 테이블에서 출판사(pubcom)이 한빛미디어 이거나 남가람북스인 튜플의 도서명(booktitle), 저자(author), 수량(bookcount)를 조회하시오.


-- 32) 도서(book) 테이블에서 출판일(pubdate)이 2022년인 튜플을 검색하시오.


-- 33) 회원(member) 테이블에서 비밀번호(password)가 5글자 이상인 회원의 아이디(id), 이름(name), 주소(tel)을 검색하시오.


-- 34) 도서(book) 테이블에서 출판일(pubdate)을 기준으로 오름차순하여 검색하되 출판일(pubdate)이 같은 경우 도서코드(bookid)의 내림차순으로 하시오.


-- 35) 도서(book) 테이블에서 도서의 수량(bookcount)가 10권 미만인 튜플에 대하여 도서분류(bookkind), 도서명(booktitle), 출판사(pubcom) 을 검색하되 그 결과가 저자(author)의 오름차순으로 정렬하여 표시되도록 하시오.


-- 36) 도서(book) 테이블에서 도서분류(bookkind)가 IT, NV, TC가 아닌 레코드의 도서코드(bookid), 도서명(booktitle), 저자(author) 를 검색하되 그 결과가 출판일을 기준으로 내림차순되어 표시되도록 하시오.


-- 36) 판매(sales) 테이블의 전체 구매 건수를 출력하되 표시되는 컬럼명은 구매건수로 출력될 수 있도록 조회하시오.
select count(*) as "구매건수" from sales;
	-- alias("구매건수")는 영어일 경우 큰따옴표 필수X, 영어 외 문자나 띄어쓰기 존재할 시 사용alter	--count(*) : 함수

-- 37) 판매(sales) 테이블의 회원별 구매 건수를 출력하되 회원아이디(id)와 cnt(구매건수)를 표시하되 컬럼명은 구매건수로 하며,
--     회원아이디(id)의 오름차순 정렬되어 표시되도록 하고, 구매건수(cnt)가 2 이상인 레코드만 검색되도록 하시오.
select id, count(*) as cnt from sales group by id having cnt>=2 order by id;
	-- group by에 의한 조건 : having(where X)

-- 38) 판매(sales) 테이블의 도서별 판매금액의 합계를 구하여 표시하되, 도서코드(bno), 판매금액합계 로 출력되게 하시오.


-- 39) 판매(sales) 테이블에서 가장 큰 판매금액을 출력하되, 회원아이디(id), 도서코드(bno), 판매금액이 표시되도록 하시오.


-- 40) 회원(member) 테이블에서 가입일별 인원수를 구하여 출력하되, 가입일 오름차순으로 출력되도록 하시오.


-- 41) 도서(book) 테이블에서 도서수량(bookcount)가 남은 수량이 적은 것을 기준으로 5위권까지 모든 도서 정보가 출력되도록 하시오.


-- 42) 판매(sales) 테이블에서 판매금액(money)가 큰 순으로 3위 까지인 튜플의 판매코드(sno), 도서코드(bno), 회원아이디(id)가 출력될 수 있도록 하시오.


-- 43) 회원 뷰(mem_view)를 생성하되 회원2(member2) 테이블을 활용하고, 회원 데이터 중에서 가입일을 기준으로 2022년 09월 이후에 가입한 회원을 대상으로 하시오.


-- 44) 판매 뷰(mem_view)를 생성하되 판매2(sales2) 테이블을 활용하고, 판매코드(sno), 도서코드(bno), 아이디(id), 판매금액(money) 컬럼만 추출되어 생성되게 하시오.


-- 45) 도서 뷰(book_view)를 생성하되 도서2(book2) 테이블을 활용하고, 도서 데이터 중에서 도서분류(bookkind)가 'IT', 'TC', 'HC' 인 데이터를 대상으로 하며, 컬럼은 도서분류(bookkind), 도서명(booktitle), 도서가격(bookprice), 출판사(pubcom) 만으로 구성되게 하시오.


-- 46) 도서 뷰(book_view)에서 도서가격(bookprice)가 현재 가격에서 10% 인상이 될 수 있도록 데이터를 갱신하시오.


-- 47) 판매 뷰(sales_view)를 편집하되 기존 select 구문에서 수량(amount) 가 2이상인 조건을 추가되게 하시오.


-- 48) 회원 뷰(mem_view)에서 아이디(id)가 y로 끝나는 회원의 데이터를 삭제하시오.


-- 49) 판매 뷰(sales_view) 를 제거하시오.


-- 50) 판매 뷰(sales_view) 를 제거하시오.


-- 51) 상반기 판매순번 시퀀스(sd_seq)를 만들되 1부터 1씩 증가하도록 생성하시오.


-- 52) 상반기 판매순번 시퀀스(sd_seq)를 시작값이 6부터 될수 있도록 수정하시오.


-- 53) 상반기 판매순번 시퀀스(sd_seq)의 현재값이 조회될 수 있도록 하시오.


-- 54) 상반기 판매순번 시퀀스(sd_seq)를 제거하시오.


-- 55) 서브쿼리를 이용하여 구매한 적이 있는 (판매 테이블에 있는) 회원의 이름(name)을 중복성을 제거하여 조회하시오.


-- 56) 서브쿼리를 이용하여 판매되지 않은 (판매 테이블에 있는) 도서의 정보를 조회하시오.


-- 57) 서브쿼리를 활용하여 판매 테이블에서 판매금액의 평균이상인 모든 컬럼을 조회하시오.


-- 58) 내부조인을 활용하여 판매된 적이 있는 도서이름(booktitle), 도서가격(bookprice), 판매수량(amount), 판매금액(money) 을 조회하시오.


-- 58) 내부조인을 활용하여 구매한 적이 있는 회원아이디(id), 회원명(name), 연락처(tel)을 조회하시오.


-- 59) 외부조인을 활용하여 판매되지 않은 도서의 도서명(booktitle), 도서가격(bookprice), 저자(author) 을 조회하시오.(연관쿼리 이용해야)
select distinct booktitle,bookprice,author from book
where bookid in (select bno from sales);
	-- 차집합
select distinct a.booktitle,a.bookprice,a.author
from book a left join sales b
on a.bookid=b.bno where b.bno is null;

	-- 서브쿼리
select distinct booktitle,bookprice,author from book
where bookid not in(select bno from sales);

	-- 연관 쿼리(join, in 사용X)
select distinct a.booktitle,a.bookprice,a.author
from book a where not exists (
	select 1 from sales b where a.bookid=b.bno
);

-- 60) 외부조인을 활용하여 구매한 적이 없는 회원의 회원아이디(id), 회원명(name) 을 조회하시오.
	-- 차집합
select distinct a.id,a.name from member a left join sales b
on a.id=b.id where b.id is null;

	-- 서브쿼리
select id, name from member
where id not in(select id from sales);

	-- 연관 쿼리(join, in 사용X)
select distinct a.id,a.name
from member a where not exists (
	select 1 from sales b where a.id=b.id
);


-- 61) 판매(sales)와 판매2(sales2) 테이블을 합집합하여 종합 판매 뷰(tot_sales_view)를 생성하시오. 
create view tot_sales_view as
(select * from sales UNION select * from sales2);

-- 62) 회원(member)와 회원2(member2) 테이블을 교집합하여 중복회원 뷰(cross_mem_view)를 생성하시오. 
	-- MySQL은 연관쿼리를 활용하여 교집합 생성
create view cross_mem_view as
select a.id, a.password, a.name, a.address
from member a, member2 b
where a.id=b.id;
select * from cross_mem_view;

-- 63) 도서(book)와 도서2(book2) 테이블을 차집합하여 도서(book)에만 있는 도서 뷰(minus_book_view)를 생성하시오. 
	-- 차집합은 연관쿼리보다는 서브쿼리나 외부 조인 이용
    -- 서브쿼리 이용한 차집합 뷰 작성
create view minus_book_view as
select bookid, bookkind, booktitle, bookcount from book
where bookid not in (
	select distinct bookid from book2
);
	-- 외부조인 이용한 차집합 뷰 작성
create view minus_book_view2 as
select a.bookid, a.bookkind, a.booktitle, a.bookcount
from book a left join book2 b on a.bookid = b.bookid
where b.bookid is null;



select * from member;
select * from book;
select * from book2;
select * from sales;
select * from sales2;
desc member;
desc book;
desc sales;