--문제 1.
--EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
--EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서 
--각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)

-- INNER 106행 (붙을 수 없는 데이터가 안나옴)
SELECT count(*)
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --106행

-- LEFT OUTER 107행
SELECT count(*)
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --107행

-- RIGHT OUTER 122행
SELECT count(*)
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --122행

-- FULL OUTER 123행
SELECT count(*)
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --123행

--문제 2.
--EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
--조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
--조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS 이름,
       E.DEPARTMENT_ID
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE EMPLOYEE_ID = 200;


--문제 3.
--EMPLOYEES, JOBS테이블을 INNER JOIN하세요
--조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
--HINT) 어떤 컬럼으로 서로 연결되 있는지 확인
SELECT * FROM EMPLOYEES;
SELECT * FROM JOBS;

SELECT CONCAT(FIRST_NAME, LAST_NAME) AS 이름,
       E.JOB_ID,
       JOB_TITLE
FROM EMPLOYEES E
FULL OUTER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY 이름;


--문제 4.
--JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
SELECT * FROM JOBS;
SELECT * FROM JOB_HISTORY;

SELECT * 
FROM JOBS J
LEFT OUTER JOIN JOB_HISTORY H
ON J.JOB_ID = H.JOB_ID;

--문제 5.
--Steven King의 부서명을 출력하세요.
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT DEPARTMENT_NAME
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';


--문제 6.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
SELECT *
FROM EMPLOYEES 
CROSS JOIN DEPARTMENTS;

--문제 7.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
--급여, 부서명, 근무지를 출력하세요. (Alias를 사용)


----------------------------------------------------------------------------------------------------
--문제 8.
--employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
--출력하세요.


--문제 9.
--departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용


--문제 10. 
--join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
--힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.


--문제 11. 
--EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
--조건) 매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요


--보너스 문제 12.
--윌리엄스미스(William smith)의 직급도(상급자)를 구하세요.

