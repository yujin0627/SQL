-- 문자열 함수
-- LOWER() 모든 문자를 소문자로 만들어줌
-- UPPER() 모든 문자를 대문자로 만들어줌
-- INITCAP() 문자의 첫글자만 대문자, 나머지 소문자
SELECT 'abcDEF' FROM DUAL; -- 가짜 테이블 형태를 만들어줌 어떤 값을 넣어서 비교할 때 사용 
SELECT 'abcDEF', LOWER('abcDEF'), UPPER('abcDEF'), INITCAP('abcDEF') FROM DUAL; -- INITCAP -> 첫글자만 대문자로 바꾸어줌
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME) FROM EMPLOYEES;

-- LENGTH() - 길이, INSTR(타겟, '찾을문자') - 문자열 찾기 -> 해당문자를 찾아 문자열의 몇번째에 있는지 위치를 반환
SELECT FIRST_NAME, LENGTH(FIRST_NAME), INSTR(FIRST_NAME, 'a') FROM EMPLOYEES;

-- SUBSTR(타겟, 시작위치, 자를문자개수) - 문자열 자르기 -> 자른문자열을 반환, CONCAT(A, B) - 문자열 붙이기
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 1, 3) FROM EMPLOYEES;
SELECT CONCAT(FIRST_NAME, LAST_NAME), FIRST_NAME||LAST_NAME FROM EMPLOYEES;

-- LPAD(타겟 , 문자열의 개수(문자열의 길이지정), 지정한 문자열의 공백을 채울 문자)- 왼쪽공백을 특정 값으로 채움
-- RPAD(타겟 , 문자열의 개수(문자열의 길이지정), 지정한 문자열의 공백을 채울 문자)- 오른쪽공백을 특정 값으로 채움
SELECT LPAD(FIRST_NAME, 10, '*') FROM EMPLOYEES;
SELECT RPAD(FIRST_NAME, 10, '*') FROM EMPLOYEES;

-- TRIM - 양쪽공백제거, LTRIM - 왼쪽에서 제거, RTRIM - 오른쪽에서 제거
SELECT TRIM(' HELLO WORLD '), LTRIM(' HELLO WORLD '), RTRIM(' HELLO WORLD ') FROM EMPLOYEES;
SELECT LTRIM( 'HELLO WORLD', 'HELLO') FROM DUAL; -- 매개변수 2개면 지워짐
SELECT RTRIM( 'HELLO WORLD', 'WORLD') FROM DUAL;

-- REPLACE(타켓, 찾을문자, 변경문자) - 문자열 변경
SELECT REPLACE('피카츄 라이츄 파이리 꼬북이 버터플', '꼬북이', '어니부기') FROM DUAL;

-- 함수는 NESTED(중첩)이 가능하다
SELECT REPLACE(REPLACE('피카츄 라이츄 파이리 꼬북이 버터플', '꼬북이', '어니부기'), ' ', '>') FROM DUAL;