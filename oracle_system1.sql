-- DBA로 접속
conn / as sysdba;

-- user(계정) 추가
create user c##test123 identified by 20240325;

-- 테이블 생성 권한 부여
grant create any table to c##test123;

-- 접속권한, 자원접근권한, 관리자 권한 부여
grant connect, resource, dba to c##test123;

-- 테이블공간을 사용할 수 있는 권한 부여	
alter user c##test123 default tablespace users quota unlimited on users;

-- 사용자 전환
conn c##test123/20240325

-- 현재 사용 중인 계정 확인
show user;