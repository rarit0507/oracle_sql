create database test;
show databases;
use test;

create table tb_member(member_id varchar(50),
member_pwd varchar(50),
member_name varchar(20),
grade int,
area_code varchar(10));
insert into tb_member values('hong01','pass01','홍길동',10,'02');
insert into tb_member values('leess99','pass02','이순신',10,'032');
insert into tb_member values('ss50000','pass03','신사임당',30,'031');
insert into tb_member values('iu93','pass04','아이유',30,'02');
insert into tb_member values('pcs1234','pass05','박철수',20,'031');
insert into tb_member values('you_js','pass06','유재석',10,'02');
insert into tb_member values('kyh9876','pass07','김영희',20,'031');

create table tb_grade(grade_code int, grade_name varchar(20));
insert into tb_grade values(10,'일반회원');
insert into tb_grade values(20,'우수회원');
insert into tb_grade values(30,'특벽회원');

create table tb_area(area_code varchar(10), area_name varchar(20));
insert into tb_area values('02','서울');
insert into tb_area values('031','경기');
insert into tb_area values('032','인천');

select * from tb_member;
select * from tb_grade;
select * from tb_area;

