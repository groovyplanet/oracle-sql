--그룹함수
--NULL이 제외된 데이터들에 대해서 적용됨.
SELECT MAX(SALARY),MIN(SALARY),SUM(SALARY),ROUND(AVG(SALARY),0), COUNT(SALARY) FROM EMPLOYEES;
--MIN,MAX는 날짜 문자에도 적용됩니다.
SELECT MIN(HIRE_DATE),MAX(HIRE_DATE),MIN(FIRST_NAME),MAX(FIRST_NAME) FROM EMPLOYEES;
--COUNT() 두가지 사용 방법
SELECT COUNT(*) , COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--부서가 80인 사람들 중 , 커미션이 가장 높은 사람
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

--그룹함수는, 일반 컬럼이랑 동시에 사용이 불가능.
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;
--그룹함수 뒤에 OVER()를 붙이면 , 일반컬럼과 동시에 사용이 가능함.
SELECT FIRST_NAME , AVG(SALARY) OVER(), COUNT(*)OVER(),SUM(SALARY) OVER() FROM EMPLOYEES;

-----------------------------------------------------------

--GROUP BY절 - WHERE절 ORDER절 사이에 적습니다.
SELECT DEPARTMENT_ID ,
SUM(SALARY),
ROUND(AVG(SALARY),0),
MIN(SALARY),
MAX(SALARY),
COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

--GROUP화 시킨 컬럼만 , SELECT 구문에 적을 수 있습니다.
SELECT DEPARTMENT_ID,
       FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --에러

-- 2개 이상의 그룹화(하위 그룹)
SELECT DEPARTMENT_ID , 
        JOB_ID,
        SUM(SALARY)AS "부서직무별급여합",
        AVG(SALARY) AS "부서직무별급여평균",
        COUNT(*)AS "부서인원수",
        COUNT(*) OVER() AS "전체카운트" --COUNT(*) OVER() 사용하면 , 총 행의 개수를 출력 가능.
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;
--그룹함수는 WHERE에 적을 수 없음
SELECT DEPARTMENT_ID,
       AVG(SALARY)
       FROM EMPLOYEES
       WHERE AVG(SALARY)>= 5000 -- 그룹의 조건을 적는 곳은 HAVING이라고 따로 있음.
       GROUP BY DEPARTMENT_ID;
       
-----------------------------------------------------------------------------------
--HAVING절 - 그룹바이의 조건
SELECT DEPARTMENT_ID , SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 100000 OR COUNT(*) >=5;

SELECT DEPARTMENT_ID, JOB_ID,AVG(SALARY), COUNT(*), COUNT(COMMISSION_PCT) AS 커미션받는사람
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA%'
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

--
-- 부서아이디가 NULL이 아닌 데이터중에서 , 입사일은 05년도인 사람들의 부서별 급여평균, 급여합을 구하고,
-- 평균 급여는 5000이상인 데이터만 , 부서아이디로 내림차순

SELECT DEPARTMENT_ID,
AVG(SALARY) 평균급여,
SUM(SALARY) 급여함 
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%' --행의 조건
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000 --그룹바이의 조건
ORDER BY DEPARTMENT_ID DESC;
-------------------------------------------------------------------------------
--시험대비용
--ROLLUP- GROUPBY절과 함께 사용되고 , 상위그룹에 합계 , 토탈 등을 구합니다.
SELECT DEPARTMENT_ID,
SUM(SALARY),
AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID); -- 전체 그룹에 대한 총계

SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID , JOB_ID) -- 총계 , 주그룹에 대한 총계
ORDER BY DEPARTMENT_ID;

--CUBE - 롤업 + 서브그룹에 총계가 추가됨
SELECT DEPARTMENT_ID,
       JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID , JOB_ID)
ORDER BY DEPARTMENT_ID;

--GROUPING함수 - 그룹바이로 만들어진 경우는 0반환 , 롤업 또는 큐브로 만들어진 행인 경우는 1을 반환
SELECT DECODE(GROUPING(DEPARTMENT_ID),1,'총계',DEPARTMENT_ID)AS DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID),1,'소계',JOB_ID)AS JOB_ID,
       AVG(SALARY),
       GROUPING(DEPARTMENT_ID),
       GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID , JOB_ID)
ORDER BY DEPARTMENT_ID;

------------------------------------------------------------
SELECT JOB_ID, 
       COUNT(*) AS 사원수
FROM EMPLOYEES
GROUP BY JOB_ID;

SELECT JOB_ID, 
       AVG(SALARY) AS 평균월급
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY 평균월급 DESC;

SELECT JOB_ID, 
       MIN(HIRE_DATE) AS 가장빠른입사일
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY MIN(HIRE_DATE) DESC;

--2
SELECT TO_CHAR(HIRE_DATE,'YY'),
       COUNT(*) AS 사원수
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');

--3
SELECT DEPARTMENT_ID, 
AVG(SALARY) AS 평균급여
FROM EMPLOYEES
WHERE SALARY>=1000
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 2000;

--4
SELECT * FROM EMPLOYEES;
SELECT DEPARTMENT_ID,
TRUNC(AVG(SALARY+(SALARY*COMMISSION_PCT)),2)월급평균
, SUM(SALARY+(SALARY*COMMISSION_PCT))총급여, 
COUNT(*)사원수
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;

--5
SELECT 
TRUNC(AVG(SALARY+(SALARY*COMMISSION_PCT)),2)급여평균,
SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL 
AND TO_CHAR(HIRE_DATE, 'YY') = '05'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY+(SALARY*COMMISSION_PCT))>=10000;

--6
SELECT DECODE(GROUPING (JOB_ID),1,'합계',JOB_ID),
SUM(SALARY),
AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);

--7
SELECT DECODE(GROUPING(DEPARTMENT_ID),1,'합계',DEPARTMENT_ID) AS DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID),1,'소계',JOB_ID) AS JOB_ID,
       COUNT(*)AS TOTAL,
      SUM(SALARY)AS SUM
      FROM EMPLOYEES
      GROUP BY ROLLUP(DEPARTMENT_ID , JOB_ID)
      ORDER BY SUM;
      










