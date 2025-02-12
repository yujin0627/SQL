-- 그룹함수 - 행에 대한 기초통계값
-- SUM, AVG, MAX, MIN, COUNT - 전부 NULL 이 아닌 데이터에 대해서 통계를 구합니다.
SELECT SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY), COUNT(SALARY) FROM EMPLOYEES;

-- MIN, MAX - 날짜, 문자열에도 적용이 됩니다.
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE), MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

-- COUNT 함수는 2가지 사용방법이 있음
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES; --35, NULL이 아닌 데이터에 대해서 집계
SELECT COUNT(*) FROM EMPLOYEES; -- 107, 전체행수(NULL 포함)

-- 주의할점: 그룹함수는 일반컬럼(일반함수)과 동시에 사용이 불가능 (같이 사용 할 수 없음)
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES; -- 실행 X

-- 그룹함수 뒤에 OVER()를 붙이면 전체행이 출력이 되고, 그룹함수 사용이 가능함
SELECT FIRST_NAME, AVG(SALARY) OVER(), COUNT(*) OVER() FROM EMPLOYEES; 

--------------------------------------------------------------------------------
-- GROUP BY절 - 컬럼기준으로 그룹핑
SELECT DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
-- GROUP BY 사용하면 그룹함수를 함께 사용할 수 있음
SELECT DEPARTMENT_ID, SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*)
FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

-- 주의할점 - GROUP BY에 지정되지 않은 컬럼은 SELECT절에 사용할 수 없음.
SELECT DEPARTMENT_ID
       FIRST_NAME --X -> DEPARTMENT_ID 의 이름으로 사용된 것이지 출력되지 않음
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 2개 이상의 그룹화
SELECT DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

--COUNT(*) OVER() 총 행의 수를 출력할 수도 있음
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*), COUNT(*) OVER() AS 전체행수-- COUNT(*)각 그룹에 해당하는 행 수의 집계가 나옴 ,COUNT(*) OVER() 전체 행수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- WHERE 절에 그룹의 조건을 넣는것이 아닙니다.
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID >= 50 --WHERE절엔 행에 대한 조건을 넣음
GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
WHERE SUM(SALARY) >= 50000 -- GROUP BY조건을 쓰는 곳은 HAVING이라고 있음! (그룹함수의 조건은 HAVING 에 써줌)
GROUP BY DEPARTMENT_ID;
--------------------------------------------------------------------------------
-- HAVING - 그룹 BY의 조건
-- WHERE - 일반행의 조건
SELECT DEPARTMENT_ID, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000 AND COUNT(*) >= 1;

-- 각 직무별 셀러리~들의 급여 평균이 10000이 넘는 직무는 무엇일까?
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%'
GROUP BY JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

--------------------------------------------------------------------------------
-- 시험 대비
-- ROLLUP - GROUP BY와 함께 사용되고, 상위그룹의 소계를 구합니다.
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID); -- 상위 그룹의 소계(총계)를 구해줌

--
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID, JOB_ID;

SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID) -- 각 부서에 대한 소계를 뽑음 (10,20,30,....)
ORDER BY DEPARTMENT_ID, JOB_ID;

-- CUBE - 롤업에 의해서 구해진 값 + 서브그룹의 통계가 추가됨
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID) -- 31행~50행까지 서브그룹의 통계가 추가
ORDER BY DEPARTMENT_ID, JOB_ID;

-- GROUPING() - 그룹절로 만들어진 경우에는 0을 반환, 롤업 OR 큐브로 만들어진 행의 경우에는 1을 반환
SELECT DEPARTMENT_ID
       ,JOB_ID
       ,AVG(SALARY)
       ,GROUPING(DEPARTMENT_ID)
       ,GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;


SELECT DECODE(GROUPING(DEPARTMENT_ID),1,'총계',DEPARTMENT_ID) AS DEPARTMENT_ID
        ,DECODE(GROUPING(JOB_ID),1,'소계', JOB_ID) AS JOB_ID
        ,JOB_ID
        ,AVG(SALARY)
        ,GROUPING(DEPARTMENT_ID)
        ,GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;