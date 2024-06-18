--INSERT
--���̺� ������ ������ �����ϴ� ���
DESC DEPARTMENTS;
--1ST
INSERT INTO DEPARTMENTS VALUES(280,'DEVELOPER',NULL,1700);
SELECT * FROM DEPARTMENTS;
--DML���� Ʈ������� �׻� ��ϵǴµ�, ROLLBACK �̿��ؼ� �ǵ��� �� ����
ROLLBACK;
--2ND (�÷��� ��������)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME , LOCATION_ID) VALUES(280,'DEVELOPER',1700);

----------------------------------------
--INSERT ������ �������� �˴ϴ�. 
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES ((SELECT MAX(DEPARTMENT_ID)+10 FROM DEPARTMENTS),'DEV');
ROLLBACK;
--INSERT ������ �������� (������)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); --���̺� ���� ����

SELECT * FROM EMPS; -- �� ���̺� ���� ���̺��� Ư�� �����͸� �۴� ����

INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME , EMAIL, HIRE_DATE , JOB_ID)
(SELECT EMPLOYEE_ID , LAST_NAME , EMAIL,HIRE_DATE,JOB_ID  FROM EMPLOYEES WHERE JOB_ID ='SA_MAN');

DESC EMPS;

COMMIT; -- TRANSACTION�� �ݿ���


--------------------------------------
--UPDATE
SELECT * FROM EMPS;
--������Ʈ ������ ����ϱ� ������ SELECT�� �ش簪�� ������ ������ Ȯ���ϰ� , ������Ʈ ó���ؾ� �մϴ�.
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; --KEY�� ���ǿ� ���°� �Ϲ����Դϴ�.
UPDATE EMPS SET SALARY = NVL(SALARY,0) + 1000 WHERE EMPLOYEE_ID>=145;
ROLLBACK;
--������Ʈ������ ����������
--1ST(���ϰ� ��������)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;
SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
--2ND(������ ��������)
UPDATE EMPS SET(SALARY, COMMISSION_PCT, MANAGER_ID , DEPARTMENT_ID) 
= (SELECT SALARY, COMMISSION_PCT , MANAGER_ID , DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=100)
WHERE EMPLOYEE_ID = 148;

--3RD (WHERE���� ������)
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');
------------------------------------------------------------------------------------
--DELETE����
--Ʈ������� �ֱ� ������ , �����ϱ����� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� �� Ȯ���ϴ� ������ ������.
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; -- KEY�� ���ؼ� ����� ���� �����ϴ�.
--DELETE ������ ��������
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
ROLLBACK;
--------------------------------------------------------------------------------
--DELETE���� ���� ����Ǵ� ���� �ƴմϴ�.
--���̺��� ��������(FK)������ ������ �ִٸ� , �������� �ʽ��ϴ� (�������Ἲ ����)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; --EMPLOYEES���� 100�� �����͸� FK�� ����ϰ� �ֱ⶧���� ���� �� ����.

-----------------------------------------------------------------------------
--MERGE�� - Ÿ�����̺� �����Ͱ� ������ UPDATE , ������ INSERY ������ �����ϴ� ����.

--1ST
SELECT * FROM EMPLOYEES WHERE JOB_ID ='IT_PROG';

MERGE INTO EMPS A --Ÿ�����̺�
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B --��ĥ���̺�
ON(A.EMPLOYEE_ID = B.EMPLOYEE_ID) --������ Ű
WHEN MATCHED THEN -- ��ġ�ϴ� ���
     UPDATE SET A.SALARY = B.SALARY,
                A.COMMISSION_PCT = B.COMMISSION_PCT,
                A.HIRE_DATE = SYSDATE
                --.....����
WHEN NOT MATCHED THEN -- ��ġ���� �ʴ� ���
     INSERT /*INTO*/ (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
     VALUES(B.EMPLOYEE_ID,B.LAST_NAME , B.EMAIL , B.HIRE_DATE , B.JOB_ID);
     
SELECT * FROM EMPS;

--2RD -- ������������ �ٸ� ���̺��� �������°� �ƴ϶� ���� ���� ���� �� DUAL�� �� ���� �ֽ��ϴ�.
MERGE INTO EMPS A
USING DUAL
ON(A.EMPLOYEE_ID >=107) --����
WHEN MATCHED THEN -- ��ġ�ϸ�
     UPDATE SET A.SALARY = 10000,
                A.COMMISSION_PCT = 0.1,
                A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN -- ��ġ���� ������
INSERT (EMPLOYEE_ID , LAST_NAME , EMAIL,HIRE_DATE , JOB_ID)
VALUES (107,'HONG','EXAMPLE',SYSDATE,'DBA');

------------------------------------------------------------------------------
DROP TABLE EMPS;
--CTAS - ���̺� ���� ����
CREATE TABLE EMPS AS SELECT * FROM EMPLOYEES; --�����ͱ��� ����

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1=2); --������ ����

SELECT * FROM EMPS;
------------------------------------------------------------------------
--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
--DEPTS���̺��� ������ INSERT �ϼ���.
--DROP TABLE DEPTS;
--SELECT * FROM DEPTS;
--CREATE TABLE DEPTS(
--                DEPARTMENT_ID NUMBER PRIMARY KEY, 
--                DEPARTMENT_NAME VARCHAR2(50),
--                MANAGER_ID NUMBER,
--                LOCATION_ID NUMBER);
--INSERT INTO DEPTS (DEPARTMENT_ID,DEPARTMENT_NAME,LOCATION_ID) VALUES (290,'����',1800);
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES (280, '����' , NULL ,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES (290, 'ȸ���' , NULL ,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES (300, '����' , 301 ,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES (310, '�λ�' , 302 ,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES (320, '����' , 303 ,1700);

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. DEPARTMENT_ID�� 301�� �ѹ��� �����ϼ���.

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Bank'
WHERE DEPARTMENT_NAME = 'IT Support';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;


UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT_Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT_Helpdek';
       
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID IN (290, 300, 310, 320);


--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = 320;
--(SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = '����')
--2. �μ��� NOC�� �����ϼ���
--DELETE FROM DEPTS
--WHERE DEPARTMENT_NAME ='NOC';
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220;

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
CREATE TABLE CLONE AS SELECT * FROM DEPTS;
DELETE FROM CLONE
WHERE DEPARTMENT_ID >200;
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;

--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO DEPTS E
USING (SELECT * FROM DEPARTMENTS) D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHEN MATCHED THEN
UPDATE SET 
        E.DEPARTMENT_NAME = D.DEPARTMENT_NAME,
        E.MANAGER_ID = D.MANAGER_ID,
        E.LOCATION_ID = D.LOCATION_ID
WHEN NOT MATCHED THEN
INSERT VALUES(D.DEPARTMENT_ID ,D.DEPARTMENT_NAME,D.MANAGER_ID,D.LOCATION_ID);

SELECT * FROM DEPTS;

--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
--3. obs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY>6000);

SELECT *FROM JOBS_IT;
INSERT INTO JOBS_IT(JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) VALUES ('IT_DEV','����Ƽ������',6000,20000);
INSERT INTO JOBS_IT(JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) VALUES ('NET_DEV','��Ʈ��ũ������',5000,20000);
INSERT INTO JOBS_IT(JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) VALUES ('SEC_DEV','���Ȱ�����',6000,19000);

MERGE INTO JOBS_IT J
USING (SELECT * FROM JOBS WHERE MIN_SALARY >0 )S
ON (J.JOB_ID = S.JOB_ID)
WHEN MATCHED THEN
UPDATE SET 
        J.MIN_SALARY = S.MIN_SALARY,
        J.MAX_SALARY = S.MAX_SALARY
WHEN NOT MATCHED THEN
INSERT VALUES(S.JOB_ID,S.JOB_TITLE,S.MIN_SALARY,S.MAX_SALARY);

SELECT * FROM JOBS_IT;





