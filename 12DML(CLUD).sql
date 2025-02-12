-- DML 문
-- INSERT
-- DESC 테이블명 -> 테이블의 구조를 빠르게 확인 (NOT NULL -> 무조건 값을 넣어야함 NULL값이 들어가면 안됨)
DESC DEPARTMENTS; 

-- 1ST (컬럼을 정확히 일치시키는 경우)
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700); -- 들어간 것 처럼 보이지만 확정 된 것은아님

SELECT * FROM DEPARTMENTS;

-- DML문은 트랜잭션이 항상 적용이 됩니다.
ROLLBACK; -- 일시적으로 저장된 데이터를 되돌리기 함

--2ND (컬럼을 지정해서 넣는 경우)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVELOPER', 1700);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, MANAGER_ID) VALUES(290, 'DBA', 1700, 100);

-- INSERT구문도 서브쿼리가 됩니다.
-- 실습을 위한 사본테이블 생성
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- EMPS테이블 만드는데 데이터는 복제 X
DESC EMPS;
SELECT * FROM EMPS;

--1ST
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN');

-- 2ND 값을 넣을 때 서브쿼리를 사용하여 넣을 수도 있음 VALUSES( (서브쿼리) , .....)
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES( (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Lex'), 'EXAMPLE', 'EXAMPLE', SYSDATE, 'EXAMPLE');


--------------------------------------------------------------------------------

--UPDATE구문 (WHERE절 없이 사용하면 안됨 -> 모든 행이 전부 바뀜)
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 120;
UPDATE EMPS SET FIRST_NAME = 'HONG', SALARY = 3000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 120;
UPDATE EMPS SET FIRST_NAME = 'HONG'; -- WHERE절로 조건을 붙여주지 않으면 모든 행이 전부 다 바뀜 주의!!!!!!
ROLLBACK;


-- UPDATE문 서브쿼리
UPDATE EMPS
SET (MANAGER_ID, JOB_ID, SALARY) = -- 업데이트 하고싶은 컬럼만 지정
    (SELECT MANAGER_ID, JOB_ID, SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 201)
WHERE EMPLOYEE_ID = 120;


--------------------------------------------------------------------------------

-- DELETE구문
-- 삭제하기 전에 SELECT 로 삭제할 데이터를 꼭 확인하세요.
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 121;
DELETE FROM EMPS; -- 모든 데이터가 전부 삭제됨 
DELETE FROM EMPS WHERE EMPLOYEE_ID = 120; -- WHERE절로 삭제할 데이터를 지정해줘야함

-- DELETE서브쿼리
DELETE FROM EMPS WHERE EMPLOYEE_ID = (SELECT EMPLOYEE_ID FROM EMPS WHERE LAST_NAME = 'Fripp');
DELETE FROM EMPS WHERE JOB_ID = (SELECT EMPLOYEE_ID FROM EMPS WHERE EMPLOYEE_ID = 121); -- 1개의 행만 삭제되는 것이 아니라 여러개의 행이 삭제됨 
--121번의 JOB_ID와 같은 행은 전부 삭제됨 (4개 삭제)


-- 모든 데이터가 전부 지워질 수 있는 것은 아님
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- 50번 부서(PK)는 EMPLOYEES 테이블에서 참조(FK)되고 있기 때문에 삭제가 일어나면 참조 무결성 제약을 위배합니다. 따라서 삭제가 안됨!
-- 삭제를 하고 싶다면 참조(FK)로 연결되어있는 데이터를 전부 삭제한 뒤 삭제가 가능하다
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 50;


--------------------------------------------------------------------------------
-- MERGE구문 : 데이터가 있으면 UPDATE, 없으면 INSERT를 문장을 수행하는 병합구문
-- 1ST
SELECT * FROM EMPS;

MERGE INTO EMPS E1 -- MERGE를 시킬 타겟테이블
    USING (SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN') E2 -- 병합할 테이블(서브쿼리)
    ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID) -- E1과 E2 데이터가 연결되는 조건
WHEN MATCHED THEN -- 일치할 때 수행할 작업
    UPDATE SET E1.SALARY = E2.SALARY,
               E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN -- 일치하지 않을 때 수행할 작업
    INSERT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES(E2.EMPLOYEE_ID, E2.LAST_NAME, E2.EMAIL, E2.HIRE_DATE, E2.JOB_ID);


-- 처음 데이터가 없었을때 데이터가 INSERT(병합)됨 
-- 데이터가 병합 된 뒤 다시 실행하면 그 뒤엔 데이터가 존재하기 때문에 UPDATE됨
SELECT * FROM EMPS; 
ROLLBACK;


-- 2ND - MARGE구문으로 직접 특정 데이터에 값을 넣고자 할 때 사용할 수 있음
MERGE INTO EMPS E1
    USING DUAL
    ON (E1.EMPLOYEE_ID = 120) 
WHEN MATCHED THEN -- 일치할 때 수행할 작업
    UPDATE SET E1.SALARY = 10000,
               E1.HIRE_DATE = SYSDATE
WHEN NOT MATCHED THEN -- 일치하지 않을 때 수행할 작업
    INSERT(LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES('EXAMPLE', 'EXAMPLE', SYSDAYE, 'EXAMPLE');
    

SELECT * FROM EMPS;
    
--------------------------------------------------------------------------------

--사본테이블 만들기 (연습용으로 씀)
CREATE TABLE EMP1 AS (SELECT * FROM EMPLOYEES); -- 테이블 구조 + 데이터 복사
SELECT * FROM EMP1;
    
CREATE TABLE EMP2 AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- 테이블 구조만 복사     
SELECT * FROM EMP2;

-- 테이블 삭제
DROP TABLE EMP1;
DROP TABLE EMP2;