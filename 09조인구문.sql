SELECT * FROM INFO;
SELECT * FROM AUTH;

--INNER JOIN - 붙을 수 없는 데이터는 나오지 않음
SELECT *
FROM INFO 
/*INNER*/ JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;

SELECT INFO.ID,
        INFO.TITLE,
        INFO.CONTENT,
        INFO.AUTH_ID, -- AUTH_ID는 양측에 다 있는 KEY, 테이블.컬럼명 기입해줘야 합니다.
        AUTH.NAME
FROM INFO 
/*INNER*/ JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- 테이블이 ALIAS
SELECT I.ID,
        I.TITLE,
        A.AUTH_ID,
        A.NAME,
        A.JOB
FROM INFO I --테이블 엘리어스
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;
--연결할 키가 같다면 USING 구문을 사용할 수 있음
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING (AUTH_ID);
-----------------------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN (OUTER생략가능)
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT OUTER JOIN - 오른쪽 테이블이 기준이 되서, 오른쪽 테이블은 다 나옴
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT 조인의 테이블 자리만 바꿔주면 LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

--FULL OUTER JOIN - 양쪽 데이터 누락없이 다 나옴
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN (잘못된 조인의 형태 - 실제로 쓸일은 없음)
SELECT * FROM INFO I CROSS JOIN AUTH A;
--------------------------------------------------------------------------------
--SELF JOIN (하나의 테이블을 가지고 조인을 거는 것 - 조건 테이블 안에 연결 가능한 키가 필요함)
SELECT * FROM EMPLOYEES;

SELECT * 
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON E.MANAGER_ID = E2.EMPLOYEE_ID;

--------------------------------------------------------------------------------
--오라클 조인 - 오라클에서만 사용할 수있고, 조인할 테이블을 FROM에 씁니다. 조인 조건을 WHERE에 씁니다.

--오라클 INNER JOIN
SELECT * 
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID;

-- 오라클 LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID(+); -- 붙일 테이블에 +

--오라클 RIGHT JOIN
SELECT *
FROM INFO I, AUTH A;
-------------------------------------------------------------------------------------------------
WHERE I.AUTH_ID(+) = A.AUTH_ID; --
-- 오라클 FULL OUTER JOIN은 없음

--크로스조인은 잘못된 조인(조인 조건을 안적었을 때 나타남)
SELECT *
FROM INFO I, AUTH A;

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--조인은 여러번 할 수도 있음
SELECT E.EMPLOYEE_ID,
        E.FIRST_NAME,
        D.DEPARTMENT_NAME,
        L.CITY
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE EMPLOYEE_ID >= 150;
--평범하게 생각하면 N테이블에 1테이블을 붙이는게 가장 많다.

--1 에 N 을 붙임
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;