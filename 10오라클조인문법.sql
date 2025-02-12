-- 오라클에서 사용하는 조인 문법도 있음

-- 조인을 할때 조인의 테이블 FROM에 ,로 나열
-- WHERE절에서 조인의 조건을 기술함

SELECT * FROM AUTH;
SELECT * FROM INFO;

-- 이너조인(내부조인)
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID;

-- 아우터조인(외부조인)
--LEFT OUTER JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID(+); --LEFT JOIN 왼쪽을 오른쪽에 붙이겠다는 의미

--RIGHT OUTER JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID(+) = A.AUTH_ID; --RIGHT JOIN 오른쪽에 왼쪽을 붙이겠다는 의미

-- 오라클에서 FULL OUTER 조인은 없습니다

-- 크로스조인읜 조인 조건을 적지 않으면 됩니다
SELECT * 
FROM INFO I, AUTH A; -- CROSS 조인
