SELECT * FROM EMPLOYEES;
--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT FIRST_NAME || LAST_NAME, REPLACE(HIRE_DATE, '/', '') FROM EMPLOYEES ORDER BY FIRST_NAME || LAST_NAME;
SELECT CONCAT( CONCAT(FIRST_NAME, ' '), LAST_NAME) AS 이름
    , 
    REPLACE(HIRE_DATE, '/', '') AS 입사일자
FROM EMPLOYEES ORDER BY 이름; -- ORDER BY 에서는 AS의 이름을 사용 할 수 있다
--문제 2.
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT LPAD (SUBSTR(PHONE_NUMBER, 4,12), 11, '02') FROM EMPLOYEES; -- 틀렸음
SELECT SUBSTR( PHONE_NUMBER, 4) FROM EMPLOYEES; --  매개변수 1개만 넣으면 매개변수부터 끝까지 잘라줌
SELECT CONCAT('(02)', SUBSTR( PHONE_NUMBER, 4)) FROM EMPLOYEES;

--문제 3. EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT RPAD( SUBSTR(FIRST_NAME, 1, 3), LENGTH(FIRST_NAME), '*') AS NAME, LPAD(SALARY, 10, '*') AS SALARY FROM EMPLOYEES WHERE LOWER(JOB_ID) = 'it_prog';
SELECT RPAD( SUBSTR(FIRST_NAME, 1, 3), LENGTH(FIRST_NAME), '*') AS NAME
    , LPAD( SALARY, 10, '*') AS SALARY 
    FROM EMPLOYEES WHERE LOWER(JOB_ID) = 'it_prog';