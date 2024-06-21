--제어문
/*
IF 조건절 THEN
ELSE IF 조건절 THEN
ELSE~~~
END IF;
*/

SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101)); --1~101미만 랜덤수

BEGIN
    DBMS_OUTPUT.PUT_LINE('점수' || POINT);
   /* 
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점 입니다');
    ELSE POINT>= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점 입니다');
    ELSE POINT >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점 입니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점입니다');
    END IF;
    */
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A학점 입니다.');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B학점 입니다.');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C학점 입니다.');
         ELSE DBMS_OUTPUT.PUT_LINE('F학점 입니다.');
END CASE;
END;

-----------------------------------------------------------------------
--WHILE문

DECLARE
    CNT NUMBER := 1;
BEGIN
    WHILE CNT<=9
    LOOP
        DBMS_OUTPUT.PUT_LINE('3 X '||CNT|| '=' || CNT *3);
        CNT:=CNT+1;
    
    END LOOP;

END;

----------------------------------------------------
DECLARE

BEGIN

    FOR I IN 1..9 -- 1~9까지
    
    LOOP
        CONTINUE WHEN I = 5; --I가 5면 다음으로
        DBMS_OUTPUT.PUT_LINE('3 X ' || I || '=' || I*3);
        --EXIT WHEN I = 5;
    
    END LOOP;
    
END;
-----------------------------------------------------------------------------------
DECLARE

BEGIN
    FOR I IN 2..9 LOOP
 
    FOR J IN 1..9  LOOP -- 1~9까지

        DBMS_OUTPUT.PUT_LINE(I  ||' X '|| J || ' = ' || I*J);

    END LOOP;
    END LOOP;
END;

-------------------------------------------------------------------------
--커서

DECLARE
     NAME VARCHAR2(30);
BEGIN
    --SELECT 결과가 여러행 이라서 ERR가 납니다.
    SELECT FIRST_NAME 
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

    DBMS_OUTPUT.PUT_LINE(NAME);
END;

--------------------------------------------------------------------------

DECLARE
    NM VARCHAR2(30);
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME , SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
BEGIN
    OPEN X; --커서 선언
        DBMS_OUTPUT.PUT_LINE ('--------커서 시작 --------');
        
    LOOP
    FETCH X INTO NM , SALARY; -- NM변수와 , SALARY 저장
    EXIT WHEN X%NOTFOUND; --X커서의 더이상 읽을 값이 없으면 TRUE
    
    DBMS_OUTPUT.PUT_LINT(NM);
    DBMS_OUTPUT.PUT_LINT(SALARY);
    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------커서 종료 ---------');
    DBMS_OUTPUT.PUT_LINE('데이터수:' || X%ROWCOUNT); --커서에서 읽은 데이터 수
    
CLOSE X;

END;
--------------------------------------------------------------------------------
--
--4. 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.
--
DECLARE
    CURSOR X IS
    SELECT DEPARTMENT_ID , SUM(SALARY)
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY DEPARTMENT_ID DESC;

    x_dept_id employees.department_id%TYPE;
    x_total_salary NUMBER;

BEGIN
    OPEN X;
LOOP
    FETCH X INTO x_dept_id,x_total_salary;
    EXIT WHEN X%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('부서'|| x_dept_id || ', 급여함: '|| x_total_salary);
    END LOOP;
    
    CLOSE X;
END;

  



--5. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
--
--연도별 급여합은?
DECLARE 
    CURSOR X IS SELECT A , 
                SUM(SALARY) AS B
      FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS A,
      SALARY
      FROM EMPLOYEES
      )
      GROUP BY A;
BEGIN
    FOR I IN X -- 커서를 FOR IN 구문에 넣으면 OPEN , CLOSE 생략 가능
    LOOP
        --DBMS_OUTPUT.PUT_LINE(I.A|| ' ' || I.B);
        INSERT INTO EMP_SAL VALUES(I.A,I.B);
    END LOOP;
END;

SELECT * FROM EMP_SAL;
    



