--DDL문장 (트랜잭션이 없습니다)
--CREATE , ALTER , DROP

DROP TABLE DEPTS; -- 테이블삭제

CREATE TABLE DEPTS(
       DEPT_NO NUMBER(2), --숫자 2자리
       DEPT_NAME VARCHAR2(30), --30바이트 (한글은 15글자 , 숫자/영어 30글자)
       DEPT_YN CHAR(1), -- 고정문자 1BYTE (VARCHAR2 대체가능)
       DEPT_DATE DATE,
       DEPT_BONUS NUMBER(10,2), --정수 10자리 , 소수점 2자리수 까지 저장한다.
       DEPT_CONTENT LONG --2기가 가변 문자열 (VARCHAR2 보다 더 큰 - DB마다 이름이 조금씩 다름)
);

SELECT * FROM DEPTS;
DESC DEPTS;
ROLLBACK;
INSERT INTO DEPTS VALUES(99 , 'HELLO' , 'Y' , SYSDATE, 3.14,'LONG TEXT~~~');
INSERT INTO DEPTS VALUES(100, 'HELLO' , 'Y' , SYSDATE,3.14,'LONG~TEXT~'); --DEPT_NO 초과
INSERT INTO DEPTS VALUES(1,'HELLO','가',SYSDATE,3.14,'LONG~TEXT~'); --한글은 2바이트
----------------------------------------------------------------
--테이블의 구조 변경 ALTER
--ADD , MODIFY , RENAME COLUMN , DROP COLUMN
DESC DEPTS;
SELECT * FROM DEPTS;
ALTER TABLE DEPTS ADD DEPT_COUNT NUMBER(3); --마지막에 컬럼 추가
 
ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT; --컬럼명 변경

ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5); --컬럼의 크기를 수정
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(1);
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(1); -- cannot decrease column length because some value is too big
--기존 데이터가 변경할 크기보다 큰 경우 , 변경이 불가하다.
ALTER TABLE DEPTS DROP COLUMN EMP_COUNT; -- 컬럼 삭제

----------------------------------------------------------------------------
--테이블 삭제
DROP TABLE DEPTS CASCADE 제약조건명; --테이블이 가지는 FK 제약조건을 삭제하면서 , 테이블을 날려버림 (위험) 
DROP TABLE DEPTS; -- DEPARTMENT는 EMPLOYEES 테이블과 참조관계를 가지고 있어서 , 한번에 삭제되지 않음.
---------------------------------------------------------------------------





