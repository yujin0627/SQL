-- 시험의 단골문제
-- 분석함수

--RANK() OVER() - 등수의 중복을 
SELECT FIRST_NAME, 
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC) AS 중복등수,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) AS 중복없는등수,
       ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 일련번호,
       ROWNUM -- 정렬이 되면 순서가 바뀜
FROM EMPLOYEES;