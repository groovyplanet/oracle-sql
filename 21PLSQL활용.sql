--���
/*
IF ������ THEN
ELSE IF ������ THEN
ELSE~~~
END IF;
*/

SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101)); --1~101�̸� ������

BEGIN
    DBMS_OUTPUT.PUT_LINE('����' || POINT);
   /* 
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A���� �Դϴ�');
    ELSE POINT>= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B���� �Դϴ�');
    ELSE POINT >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C���� �Դϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F�����Դϴ�');
    END IF;
    */
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A���� �Դϴ�.');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B���� �Դϴ�.');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C���� �Դϴ�.');
         ELSE DBMS_OUTPUT.PUT_LINE('F���� �Դϴ�.');
END CASE;
END;

-----------------------------------------------------------------------
--WHILE��

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

    FOR I IN 1..9 -- 1~9����
    
    LOOP
        CONTINUE WHEN I = 5; --I�� 5�� ��������
        DBMS_OUTPUT.PUT_LINE('3 X ' || I || '=' || I*3);
        --EXIT WHEN I = 5;
    
    END LOOP;
    
END;
-----------------------------------------------------------------------------------
DECLARE

BEGIN
    FOR I IN 2..9 LOOP
 
    FOR J IN 1..9  LOOP -- 1~9����

        DBMS_OUTPUT.PUT_LINE(I  ||' X '|| J || ' = ' || I*J);

    END LOOP;
    END LOOP;
END;

-------------------------------------------------------------------------
--Ŀ��

DECLARE
     NAME VARCHAR2(30);
BEGIN
    --SELECT ����� ������ �̶� ERR�� ���ϴ�.
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
    OPEN X; --Ŀ�� ����
        DBMS_OUTPUT.PUT_LINE ('--------Ŀ�� ���� --------');
        
    LOOP
    FETCH X INTO NM , SALARY; -- NM������ , SALARY ����
    EXIT WHEN X%NOTFOUND; --XĿ���� ���̻� ���� ���� ������ TRUE
    
    DBMS_OUTPUT.PUT_LINT(NM);
    DBMS_OUTPUT.PUT_LINT(SALARY);
    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------Ŀ�� ���� ---------');
    DBMS_OUTPUT.PUT_LINE('�����ͼ�:' || X%ROWCOUNT); --Ŀ������ ���� ������ ��
    
CLOSE X;

END;
--------------------------------------------------------------------------------
--
--4. �μ��� �޿����� ����ϴ� Ŀ�������� �ۼ��غ��ô�.
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
    DBMS_OUTPUT.PUT_LINE('�μ�'|| x_dept_id || ', �޿���: '|| x_total_salary);
    END LOOP;
    
    CLOSE X;
END;

  



--5. ������̺��� ������ �޿����� ���Ͽ� EMP_SAL�� ���������� INSERT�ϴ� Ŀ�������� �ۼ��غ��ô�.
--
--������ �޿�����?
DECLARE 
    CURSOR X IS SELECT A , 
                SUM(SALARY) AS B
      FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS A,
      SALARY
      FROM EMPLOYEES
      )
      GROUP BY A;
BEGIN
    FOR I IN X -- Ŀ���� FOR IN ������ ������ OPEN , CLOSE ���� ����
    LOOP
        --DBMS_OUTPUT.PUT_LINE(I.A|| ' ' || I.B);
        INSERT INTO EMP_SAL VALUES(I.A,I.B);
    END LOOP;
END;

SELECT * FROM EMP_SAL;
    



