-- 숫자함수
-- ROUND - 반올림
SELECT ROUND(45.923, 2), ROUND(45.923, 0), ROUND(45.923, -1) FROM DUAL;

-- TRUNC - 절삭
SELECT TRUNC(45.923, 2), TRUNC(45.923), TRUNC(45.923, -1) FROM DUAL; 
-- 매개값을 하나만 주면 자동으로 매개변수의 기본값이 0으로 설정되어, 정수부분까지 절삭

-- ABS 절대값, CELL 올림, FLOOR 내림 , MOD 나머지
SELECT ABS(-3), CEIL(3.14), FLOOR(3.14), MOD(5, 2) FROM DUAL;
-- 내림은 무조건 정수 기준,  절삭은 정수 기준이 아니라 매개변수를 주고 그 기준으로 잘라줌


-- 날짜 함수
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL; -- +시분초 까지 같이 표기됨

-- 날짜는 연산이 가능
SELECT SYSDATE + 1, SYSDATE - 1 FROM DUAL; -- 날짜
SELECT SYSDATE - HIRE_DATE FROM EMPLOYEES; -- 일수
SELECT (SYSDATE - HIRE_DATE) / 7 FROM EMPLOYEES; -- 주

-- 날짜 반올림, 절삭 ROUND, TRUNK
SELECT STSDATE, ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL; -- 일 기준으로 반올림, 절삭

SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- 년 기준으로 절삭
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- 월 기준으로 절삭


