--��������
--? ���ѽð� : 50��
--? EMPLOYEES ���̺� �����͸� ����ؾ� �մϴ�
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES; 
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME FROM EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID =50;
SELECT EMPLOYEE_ID, FIRST_NAME|| ' ' || LAST_NAME AS NAME, DEPARTMENT_ID FROM EMPLOYEES WHERE DEPARTMENT_ID =50;
--5. ��� ����� �̸�, �޿� �׸��� 300�޷� �λ�� �޿��� ����ϼ���.
SELECT FIRST_NAME|| ' ' || LAST_NAME AS NAME , SALARY AS �޿�, SALARY+300 AS �λ�ȱ޿� FROM EMPLOYEES;
--6. �޿��� 10000���� ū ����� �̸��� �޿��� ����ϼ���.
SELECT FIRST_NAME|| ' ' || LAST_NAME AS NAME , SALARY FROM EMPLOYEES WHERE SALARY >10000;
--7. ���ʽ��� �޴� ����� �̸��� ����, ���ʽ����� ����ϼ���.
SELECT FIRST_NAME|| ' ' || LAST_NAME AS NAME ,JOB_ID,COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
--8. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(BETWEEN ������ ���)
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , HIRE_DATE, SALARY FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31';
--9. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(LIKE ������ ���)
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , HIRE_DATE, SALARY FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%';
--10. ��� ����� �̸��� �޿��� �޿��� ���� ������� ���� ��������� ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , SALARY FROM EMPLOYEES ORDER BY SALARY DESC ; 
--11. �� ���Ǹ� 60�� �μ��� ����� ���ؼ��� �����ϼ���. (�÷�: department_id)
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , SALARY FROM EMPLOYEES WHERE department_id =60 ORDER BY SALARY DESC;
--12. �������̵� IT_PROG �̰ų�, SA_MAN�� ����� �̸��� �������̵� ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , department_id FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'SA_MAN';
--13. Steven King ����� ������ ��Steven King ����� �޿��� 24000�޷� �Դϴ١� �������� ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME || '����� �޿���' || SALARY, '�޷� �Դϴ�'  
FROM EMPLOYEES WHERE FIRST_NAME ='Steven' AND LAST_NAME = 'King';
--14. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� ����ϼ���. (�÷�:job_id)
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%';
--15. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� �������̵� ������� ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME , JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%' ORDER BY JOB_ID;
