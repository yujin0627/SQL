-- 단일행 서브쿼리 - SELECT한 결과가 1행인 서브쿼리
-- 서브쿼리는 ()로 묶는다. 연산자보다는 오른쪽에 나온다

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT *
FROM EMPLOYEES WHERE SALARY >= 12008;

SELECT *
FROM EMPLOYEES WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');


--직원번호가 103번인 사람과 동일한 직무를 가진 사람
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT * 
FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

SELECT * 
FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);


-- 주의할 점 - 단일행 서브쿼리는 반드시 하나의 행을 리턴해야 합니다.
-- 서브쿼리가 반환하는 행이 여러행이라면, 다중행 연산자를 쓰면 됩니다.
SELECT SALARY
FROM EMPLOYEES WHERE FIRST_NAME = 'David';

SELECT SALARY
FROM EMPLOYEES 
WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- David 의 값이 한개가 아니라 비교연산자만 사용이 안됨


-- 다중행 서브쿼리 - 여러행이 리턴되는 서브쿼리
SELECT SALARY
FROM EMPLOYEES WHERE FIRST_NAME = 'David';


-- > ANY 은 최소값 보다 큰 데이터 (4800, 6800, 9500)
SELECT *
FROM EMPLOYEES 
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- < ANY 의 최대값 9500 보다 작은 데이터
SELECT *
FROM EMPLOYEES 
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- > ALL 최대값 9500 보다 큰 데이터
SELECT *
FROM EMPLOYEES 
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- < ALL 최소값 4800 보다 작은 데이터
SELECT *
FROM EMPLOYEES 
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- IN 은 정확히 일치하는 데이터가 나옴
SELECT *
FROM EMPLOYEES 
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--------------------------------------------------------------------------------

-- 스칼라 서브쿼리 - SELECT절에 들어오는 서브쿼리, 조인을 대체할 수 있음
-- 조인할 쿼리의 컬럼이 1개일때 가져오려면 훨씬 유리함
-- 계획설명 코스트 3  코스트가 낮은것이 좋음
SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E;

--JOIN구문으로  F10 눌러서 계획설명 확인 - 좀 더 빠르게 실행하기 위해 HASH JOIN 을 걸었다 코스트 7
SELECT FIRST_NAME,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- 스칼라 쿼리는 한번에 하나의 컬럼을 가지고 옵니다. 많은 열을 가지고 올때는 가독성이 떨어질 수 있습니다.
SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME, MANAGER_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) -- 실행X 가져오는 서브쿼리의 쿼리개수는 1개여야 함 
FROM EMPLOYEES E;

SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID), -- 따로 써줘야함
       (SELECT MANAGER_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E;

-- 스칼라 쿼리는 다른 테이블의 1개의 컬럼만 가지고 올때 조인보다 유리할 수 있음
-- 회원별 JOBS 테이블의 TITLE을 가지고 오고, 부서테이블의 부서명을 조회
-- SCALAR 유리
SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID),
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID)
FROM EMPLOYEES E;


--------------------------------------------------------------------------------
--인라인 뷰 - FROM절 하위에 서브쿼리가 들어갑니다.
-- SELECT절에서 만든 가상 컬럼에 대해서 조외를 해 나갈때 사용합니다.
SELECT *
FROM (SELECT *
      FROM (SELECT *
            FROM EMPLOYEES)
);


-- ROWNUM(조회가 일어난 순서)은 조회된 순서에 대해서 번호가 붙기 때문에 ORDER BY를 시키면 순서가 뒤바뀝니다.
SELECT EMPLOYEE_ID,
       FIRST_NAME,
       SALARY
FROM EMPLOYEES;

SELECT ROWNUM 
       EMPLOYEE_ID,
       FIRST_NAME,
       SALARY
FROM EMPLOYEES; -- 정렬이 되어있음

SELECT ROWNUM 
       EMPLOYEE_ID,
       FIRST_NAME,
       SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC; -- ORDER BY 때문에 순서가 뒤바뀜

-- 인라인뷰로 ROWNUM붙이기
SELECT *
FROM EMPLOYEES
ORDER BY SALARY DESC;


SELECT ROWNUM,
       EMPLOYEE_ID,
       FIRST_NAME,
       SALARY
FROM (SELECT *
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      ) -- 순서대로 정렬되어 나옴
WHERE ROWNUM > 0 AND ROWNUM <= 10;
      
      
SELECT ROWNUM,
       EMPLOYEE_ID,
       FIRST_NAME,
       SALARY
FROM (SELECT *
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      ) 
WHERE ROWNUM > 10 AND ROWNUM <= 20; -- 10~20번째 데이터가 나와야 하는데, ROWNUM은 1부터 시작하여 조회가 가능해서 중간에 조회가 안됨

-- 인라인뷰로 FROM절에 필요한 컬럼을 가상의 컬럼으로 만들어 놓고, 조회 (계속해서 만들고 SELECT 하기 가능함)
--SELECT --필요한 컬럼을 가상으로 만듦
--FROM ();

SELECT ROWNUM AS RN, -- RN, NAME 가상의 컬럼
       FIRST_NAME||LAST_NAME AS NAME,
       SALARY
FROM (
      SELECT * 
      FROM EMPLOYEES
      ORDER BY SALARY DESC
);

SELECT *
FROM(
    SELECT ROWNUM AS RN, -- RN, NAME 가상의 컬럼
         FIRST_NAME||LAST_NAME AS NAME,
         SALARY
    FROM (
        SELECT * 
        FROM EMPLOYEES
        ORDER BY SALARY DESC
    )
)
WHERE RN > 10 AND RN <= 20;

  
SELECT *
FROM(
    SELECT ROWNUM AS RN, -- RN, NAME 가상의 컬럼
         --A.FIRST_NAME||A.LAST_NAME AS NAME,
         --A.SALARY
         A.*
    FROM (
        SELECT * 
        FROM EMPLOYEES
        ORDER BY SALARY DESC
    ) A --테이블의 별칭 (테이블 엘리어스)
)
WHERE RN > 10 AND RN <= 20; 


-- 인라인뷰 EX
-- 근속년수 컬럼, COMMISSION이 더해진 급여 컬럼을 가상으로 만들고 조회~
SELECT FIRST_NAME||' '||LAST_NAME AS 이름,
       TRUNC((SYSDATE - HIRE_DATE) /365) AS 근속년수,
       SALARY + SALARY * NVL(COMMISSION_PCT, 0) AS 급여
FROM EMPLOYEES
ORDER BY 근속년수;

-- 가상의 컬럼을 만들어 계속해서 조회 사용이 가능함
SELECT *
FROM (
     SELECT FIRST_NAME||' '||LAST_NAME AS 이름,
            TRUNC((SYSDATE - HIRE_DATE) /365) AS 근속년수,
            SALARY + SALARY * NVL(COMMISSION_PCT, 0) AS 급여
     FROM EMPLOYEES
     ORDER BY 근속년수
);
