-- 1-1
select area_name 지역명, member_id 아이디, member_name 이름, grade_name 등급명	-- // 지역명, 등급명 없음
from tb_member
join tb_grade on (tb_member.grade = tb_grade.grade_code) -- 정확히 테이블을 지시해주는 게 정확하다
join tb_area using (area_code = area_code)	-- 이게 어디 area_code인지 알 수 없음. 1. using 2.tb_member. tb_area. 명시
where area_code = (
	select area_code from tb_member
where tb_member.member_name = '김영희')	-- alias가 괄호 안에 없어서 '이름' alias 인식 못함
order by 이름;	-- desc는 내림차순

-- 1-2
select member_id as 아이디, member_pwd 비밀번호, member_name as 이름, grade_name as 등급명	-- 문제에서 제시하는 지역명 빠짐 -> 지역명이 출력되지 않음
from tb_member
join tb_grade using(grade_code) -- tb_member에 gradecode 존재X 컬럼명 불일치 오류 발생

where (grade, area_code) = 
(select grade, area_code from tb_member	-- 아이디 1234 없음
where member_id - '1234')
order by member_id desc;


-- 1-3
'select rownum 번호 -- rownum 컬럼 부재하므로 출력 불가for	--> 제거
from' (select member_id, member_name, grade_name	-- ,  + area_name(지역명 출력이 문제 조건에 있음)
from tb_member	 grade_name 		-- + area_name
join tb_grade on(grade = grade_code) -- 틀린 건 아닌데 테이블 명시해줘야

where area_name = ('서울','경기'))	-- 이름으로 바꿔야.<- 서울과 경기를 비교할 수 없음

order by member_id;	-- order by 구문이 괄호 밖에 있으므로 실행 불가
-- select 검색 2중으로 함
