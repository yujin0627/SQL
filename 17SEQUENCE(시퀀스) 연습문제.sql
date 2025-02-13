--문제 1

CREATE TABLE EMPS(
    EMPS_NO VARCHAR2(30) PRIMARY KEY,
    EMPS_NAME VARCHAR2(30)
);

-- 이 테이블에 PK를 2025-00001 형식으로 INSERT하려고 합니다.
-- 다음 값은 2025-00002 형식이 됩니다.
-- 시퀀스를 만들고, INSERT 넣을 때, 위 형식처럼 값이 들어갈 수 있도록 INSERT를 넣어주세요.

CREATE SEQUENCE EMPS_SEQ NOCACHE; -- 숫자를 관리할 수 있는 PK가 만들어짐
INSERT INTO EMPS VALUES (TO_CHAR(SYSDATE, 'YYYY') || '-' || LPAD(EMPTS_SEQ.NEXTVAL, 5, 0), 'EMAMPLE' );
SELECT * FROM EMPS;