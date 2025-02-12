-- DDL문 (트랜잭션이 없습니다 , 한번 날리면 끝, 되돌리기 안됨(안전장치가 없음))
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2), --숫자 2자리
    DEPT_NAME VARCHAR2(30), -- 30BYTE (한글은 15글자, 영어는 30글자)
    DEPT_YN CHAR(1), -- 고정문자 1BYTE (고정크기의 1BYTE를 사용함 더 적게 사용해도 똑같은 크기의 BYTE를 사용한다)
    DEPT_DATE DATE, -- 날짜차입
    DEPT_BOUNS NUMBER(10, 2), -- 전체 숫자 10자리, 소수점 2자리 사용
    DEPT_CONTENT LONG -- 최대가 2기가 가변문자열 (VARCHAR2 보다 더큰 문자열), 많이 사용X
);

DESC DEPTS;
INSERT INTO DEPTS VALUES(99, 'HELLO', 'Y', SYSDATE, 3.14, 'HELLO WORLD~~~~ BYE');
INSERT INTO DEPTS VALUES(100, 'HELLO', 'N', SYSDATE, 3.14, 'HELLO WORLD'); -- DEPT_NO의 자리수 초과 
INSERT INTO DEPTS VALUES(100, 'HELLO', '가', SYSDATE, 3.14, 'HELLO'); -- DEPT_YN의 BYTE 초과
SELECT * FROM DEPTS;


--------------------------------------------------------------------------------

-- 컬럼 추가 ADD
ALTER TABLE DEPTS ADD (DEPT_COUNT NUMBER(3));
SELECT * FROM DEPTS;

-- 컬럼명 변경 RENAME COLUMN TO 
ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

-- 컬럼 수정 MODIFY
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5);
ALTER TABLE DRPTS MODIFY DEPT_NAME VARCHAR2(1); -- 기존데이터가 변경할 크기를 넘어가는 경우, 변경 불가.
DESC DEPTS;

-- 컬럼 삭제 DROM COLUMN
ALTER TABLE DEPTS DROP COLUMN EMP_COUNT;


--------------------------------------------------------------------------------

-- 테이블 삭제 DROP
DROP TABLE EMPS;
DROP TABLE DEPARTMENTS; -- FK가 참조하는 내용이 있어서 테이블 삭제가 안됨 (FK에 위배)
-- 부서테이블은 직원 테이블과 제약조건이 연결되어 있어서, 삭제 불가
--DROP TABLE DEPARTMENTS CASCADE 제약조건명; -- 제약조건이라는 것을 삭제하면서 테이블을 지움


-- 테이블 자르기 TRUNCATE -- 데이터를 전부 지우고 데이터가 저장되는 저장공간까지 같이 해제 시킴 ( 데이터 전부 지우고, 데이터의 저장공간 해제)
-- INSEERT하면 데이터가 들어감
TRUNCATE TABLE DEPTS;
SELECT * FROM DEPTS;
