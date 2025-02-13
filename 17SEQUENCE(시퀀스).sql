-- 시퀀스 (순차적으로 증가하는 값)
-- 보통 PK를 지정하는데 사용할 수 있음.
SELECT * FROM USER_SEQUENCES;

-- 생성
CREATE SEQUENCE DEPTS_SEQ; -- 기본값으로 지정이 되면서 시퀀스가 생성됩니다.

DROP SEQUENCE DEPTS_SEQ; -- 시퀀스 삭제

CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1 -- 값이 몇씩 증가할지 지정
    START WITH 1 -- 시작값
    MAXVALUE 10 -- 최대값
    MINVALUE 1 -- 최소값
    NOCYCLE -- 시퀀스가 MAX에 도달했을 때 재사용X
    NOCACHE; -- 시퀀스는 메모리(캐시)에 두지 않음 (CACHE를 사용하면 CACHE값이 계속해서 증가함)
    
    
DROP TABLE DEPTS;

CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);


-- 시퀀스 사용 방법 2가지
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- NEXTVAL가 한번 싱행이 되고난 이후에 확인이 가능합니다.
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 한번 NEXTVAL가 일어나면 후진은 불가능 (전진만 가능하고 후진은 불가능하다)

INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'EXAMPLE'); -- MAXVALUES에 도달하면, 더 이상 사용이 불가능
SELECT * FROM DEPTS;

-- 시퀀스의 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

-- 시퀀스가 이미 테이블에서 사용중에 있으면, 스퀀스는 DROP하면 안됩니다.
-- 주기적으로 시퀀스를 초기화 해야 한다면? (꼼수 , 올바른 정석은 아님)
-- PK - SEQUENCE --> YYYY-SEQUENCE    ->  SEQUENCE는 한계가 있기 때문에 초기화 되더라도 상관없음 년도가 달라져 중복되지 않음
-- 시퀀스 증가값을 -현재값으로 바꾸고 - 전진을 시킴 - 다시 시퀀스 증가값을 양수값으로 바꿔 - 시퀀스가 초기화

-- 시퀀스 증가값을 -현재값으로 바꾸고
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -50 MINVALUE 0;

-- 전진을 시킴
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;

-- 다시 시퀀스 증가값을 양수값으로 바꿔
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;

-- 시퀀스가 초기화
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;






