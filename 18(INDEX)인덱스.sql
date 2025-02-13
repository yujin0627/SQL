-- 인덱스 (검색을 빠르게하는 HINT 역할)
-- INDEX의 종류로는 고유인덱스, 비고유인덱스가 있습니다.
-- 고유인덱스 (PK, UN)를 만들때 자동으로 생성되는 인덱스 입니다.
-- 비고유인덱스는 일반 컬럼에 지정해서 조회를 빠르게 할 수 있는 인덱스 입니다.
-- 단, INDEX는 조회를 빠르게 하지만, 무작위하게 많이 사용되면 오히려 성능저하를 나타낼 수도 있습니다.
-- 주로 사용되는 컬럼에서 SELECT절이 속도저하가 있으면, 일단 먼저 고려해볼 사항이 인덱스 입니다.
-- PK, UK는 값의 수정이 덜하다 (삭제, 추가만 가능) -> 인덱스 번호를 달아서 더빠르게 값을 찾을 수 있도록 도와줌
-- 자주 수정되는 컬럼에 인덱스를 달면 값이 수정될 때마다 인덱스의 값까지 같이 바뀌게 되어서 오히려 성능의 저하가 올 수도 있다. 
-- 따라서 모든 컬럼에 인덱스를 붙이는건 좋지 못한 방법이다.

DROP TABLE EMPS;
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES);
-- 복사할때 제약조건은 복사되지 않음 PK도 없음

SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy'; 
-- F10 눌렀을때 OPTIONS = FULL 테이블 전체를 다 뒤졌다

-- FIRST_NAME 컬럼에 인덱스 부착
CREATE INDEX ENPS_IDX ON EMPS(FIRST_NAME);
SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy';

-- 인덱스 삭제( 삭제 하더라도 테이블에 영향을 미치지 않습니다.)
DROP INDEX EMPS_IDX;

-- 결합인덱스 (여러 컬럼을 묶어서 생성할 수 있습니다.)
CREATE INDEX EMPS_IDX ON EMPS(FIRST_NAME, LAST_NAME);

SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy'; -- 인덱스 HINT를 받음

SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg'; -- 인덱스 HINT를 받음

SELECT * FROM EMPS WHERE LAST_NAME = 'Greenberg'; -- 인덱스 HINT를 못받음


--고유 인덱스
CREATE UNIQUE INDEX 인덱스명 ON 테이블명(부착할컬럼); -- PK, UK 만들때 자동생성해줍니다 (PK, UK 조회할 때 인덱스 효과를 받습니다.)

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;
