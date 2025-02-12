-- 제약조건 - 컬럼에 원치않는 데이터가 입력, 삭제, 수정되는 것을 방지하기 위한 조건
-- PRIMARY KEY - 테이블의 고유키, 중복X, NULL X, PK는 테이블에 1개
-- UNIQUE - 중복X, NULL O
-- NOT NULL - NULL을 허용하지 않음
-- FOREING KEY - 참조하는 테이블의 PK를 넣어놓은 컬럼, 중복 O, NULL O
-- CHECK - 컬럼에 대한 데이터 제한 (WHERE절과 유사)

-- 제약조건을 확인하는 명령문 OR 마우스로 확인
SELECT * FROM user_constraints;
-- 테이블별로 제약조건을 확인하는 방법 (테이블선택-> 제약조건)
SELECT * FROM employees;

--1st (열레벨)
DROP TABLE DEPTS;
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2)           CONSTRAINT DEPTS_DPET_NO_PK PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)      CONSTRAINT DEPTS_DEPT_NAME_NN NOT NULL ,
    DEPT_DATE DATE              DEFAULT SYSDATE, -- 값이 들어가지 않을 때 자동으로 지정되는 기본값 (제약조건 X)
    DEPT_PHONE VARCHAR2(30)     CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1)         CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M')), --CHECK(DEPT_GENDER IN ('F', 'M')) - WHERE 절 조건처럼 써줌
    LOCA_ID NUMBER(4)           CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES LOCATIONS (LOCATION_ID)
    );
 
 DROP TABLE DEPTS;   
--------------------------------------------------------------------------------

-- (CONSTRAINT 는 생략 가능) - 이름이 자동생성
DROP TABLE DEPTS;
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2)           PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)      NOT NULL ,
    DEPT_DATE DATE              DEFAULT SYSDATE, -- 값이 들어가지 않을 때 자동으로 지정되는 기본값 (제약조건 X)
    DEPT_PHONE VARCHAR2(30)     UNIQUE,
    DEPT_GENDER CHAR(1)         CHECK(DEPT_GENDER IN ('F', 'M')), --CHECK(DEPT_GENDER IN ('F', 'M')) - WHERE 절 조건처럼 써줌
    LOCA_ID NUMBER(4)           REFERENCES LOCATIONS (LOCATION_ID)
);

DROP TABLE DEPTS;

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, NULL, '010...', 'F', 1700); -- NOT NULL 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'HONG', '010...', 'X', 1700); -- CHECK 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'HONG', '010...', 'F', 100); -- FK 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'HONG', '010...', 'F', 1700);

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(2, NULL, '010...', 'F', 1700); -- UNIQUE 제약 위배 '010...'이 이미 저장되었기 때문에 중복X


-- 개체 무결성 : 기본키에 NOT NULL일 수 없고, 중복 될 수 없다는 규칙
-- 참조 무결성 : 참조하는 테이블의 PK만 FK컬럼에 들어갈 수 있다는 규칙
-- 도메인 무결성 : CHECK, UNIQUE제약 안에서만 데이터가 들어갈 수 있다는 규칙 (CHECK, UNIQUE제약을 위배 할 수 없다)
