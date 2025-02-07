-- 형변환 함수
-- 자동형변환을 제공합니다. NUMBER <-> 문자, DATE <-> 문자
SELECT * FROM EMPLOYEES WHERE SALARY >= '10000';
SELECT HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE = '05/09/30'; -- 자동형변환

-- 강제형변환
-- TO_CHAR = 날짜 -> 문자로 강제 형변환 ( 날짜 포멧형식 쓰입니다 )
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL; -- 사람이 볼 수 있는 문자로 바꾸어 준 것
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL; --데이트 포멧형식이 아닌값은 ""로 묶으면 됨
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD AM') FROM EMPLOYEES;

-- TO_CHAR = 숫자 -> 문자로 강제 형변환 ( 숫자 포멧형식 쓰입니다 )  문자는 왼쪽에서부터 채워나간다
SELECT TO_CHAR(20000, '9999999999') FROM DUAL; -- 9는 자릿수를 의미
SELECT TO_CHAR(20000, '09999999999') FROM DUAL; -- 남는 자리는 0으로 채움
SELECT TO_CHAR(20000, '9999') FROM DUAL; -- 자리가 부족하면 $으로 처리됨
SELECT TO_CHAR(20000.123, '9999999.999') FROM DUAL; -- 소수점 자리까지 변환이 가능함
SELECT TO_CHAR(20000, 'L999,999.99') FROM DUAL; --$는 그냥 쓰면 됩니다. L을 붙이면 각 나라에 맞는 지역화폐기호가 나옴

-- TO_NUMBER = 문자 -> 숫자로 강제 형변환
SELECT '2000' + 2000 FROM DUAL; --자동 형변환을 해주어 숫자로 값이 계산됨
SELECT TO_NUMBER('$2,000', '$9,999') + 2000 FROM DUAL; -- 숫자로 형변환(형변환 할 문자를 숫자 형식에 맞춰 써주면 형변환됨)

-- TO_DATE = 문자 -> 날짜로 강제 형변환
SELECT TO_DATE('2024-02-07', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2024-02-07', 'YYYY-MM-DD') - HIRE_DATE FROM EMPLOYEES;
SELECT TO_DATE('2024년 02월 07일', 'YYYY"년" MM"월" DD"일"') FROM DUAL; -- 년, 월, 일 같은 문자는 포멧형식이 아니므로 " " 사용하여 묶어준다
SELECT TO_DATE('2024-02-07 02:33:24', 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

--------------------------------------------------------------------------------

-- NULL 처리 함수
-- NVL(타겟, NULL 일 경우 대체할 값)
SELECT NVL(3000,0), NVL(NULL, 0), NULL * 3000 FROM DUAL; -- NULL에 연산이 들어가면 어떤 연산이던 NULL이 나온다
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT AS 실제급여 FROM EMPLOYEES; -- NULL 이 들어가 있어서 연산값이 NULL
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * NVL(COMMISSION_PCT, 0) AS 실제급여 FROM EMPLOYEES; -- NULL을 NVL(NULL이 들어갈 수도 있는 타겟, 대체할 값)

-- NVL2(타겟, NULL이 아닐때, NULL 일 때)
SELECT NVL2( NULL, 'NOT NULL', 'NULL') FROM DUAL;
SELECT FIRST_NAME
    ,COMMISSION_PCT
    ,NVL2(COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT, SALARY)
FROM EMPLOYEES;

-- DECODE(값, 비교값, 결과값, ....., ELSE문)
SELECT DECODE('B', 'A', 'A입니다', 'B', 'B입니다', 'C', 'C입니다' , '나머지입니다') FROM DUAL;
SELECT DECODE(JOB_ID, 'IT_PROG', SALARY * 1.1
                    , 'FI_MGR', SALARY * 1.2
                    , 'AD_VP', SALARY * 1.3
                    , SALARY)
    ,JOB_ID
FROM EMPLOYEES;

-- CASE ~ WHEN ~ THEN ~ ELSE ~ END
SELECT FIRST_NAME
       ,JOB_ID
       ,SALARY
       ,CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 1.14
                    WHEN 'FI_MGR' THEN SALARY * 1.2
                    WHEN 'AD_VP' THEN SALARY * 1.3
                    ELSE SALARY
       END
FROM EMPLOYEES;

-- 2ND - WHEN 조건식을 넣을 수도 있음
SELECT FIRST_NAME
       ,JOB_ID
       ,SALARY
       ,CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 1.14
             WHEN JOB_ID = 'FI_MGR' THEN SALARY * 1.2
             WHEN JOB_ID = 'AD_VP' THEN SALARY * 1.3
             ELSE SALARY
       END
FROM EMPLOYEES;

-- COALESCE(값, 값, ....) 코어레스 - NULL이 아닌 첫번째 인자값을 반환하는 함수
SELECT COALESCE('A', 'B', 'C') FROM DUAL;
SELECT COALESCE('NULL', 'B', 'C') FROM DUAL;
SELECT COALESCE('NULL', 'NULL', 'C') FROM DUAL;
SELECT COALESCE('NULL', 'NULL', 'NILL') FROM DUAL;
SELECT COALESCE(COMMISSION_PCT, 0), NAL(COMMISSION_PCT, 0) FROM EMPLOYEES;