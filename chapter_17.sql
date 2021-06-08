-- 17-1
alter session set nls_date_lanuage = 'AMERICAN';

-- 17-2
CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON emp_pl 
BEGIN 
    IF (TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN')) OR
        (TO_CHAR(SYSDATE, 'HH24:MI')) NOT BETWEEN '8:00' AND '18:00'
    THEN
        RAISE_APPLICATION_ERROR(-20038, '操作已经记录在系统中， 非工作时间不允许插入数据');
    END IF;
END;
/

-- 17-3
INSERT INTO emp_pl(empno, ename, hiredate, job, sal)
VALUES (9000, '武大', SYSDATE, '烙饼师', 9988);


-- 17-4
SELECT empno, ename, hiredate, job, sal
FROM emp_pl
WHERE sal > 4000;

-- 17-5带有条件谓词的语句触发器
CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT OR UPDATE OR DELETE ON emp_pl
    BEGIN 
        IF (TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN')) OR
            (TO_CHAR(SYSDATE, 'HH24:MI')) NOT BETWEEN '8:00' AND '18:00'
        THEN
            IF DELETING THEN
                RAISE_APPLICATION_ERROR(-20038, '操作已经记录在系统中， 非工作时间不允许删除数据');
            ELSIF INSERTING THEN
                RAISE_APPLICATION_ERROR(-20038, '操作已经记录在系统中， 非工作时间不允许插入数据');
            ELSIF UPDATING ('SAL') THEN
                RAISE_APPLICATION_ERROR(-20038, '操作已经记录在系统中， 非工作时间不允许更新数据');
            ELSE
                RAISE_APPLICATION_ERROR(-20038, '操作已经记录在系统中， 非工作时间不允许修改数据');
            END IF;
        END IF;
    END;
/

-- 17-6 7 8 9
DELETE emp_pl
WHERE deptno = 20;

INSERT INTO emp_pl(empno, ename, hiredate, job, sal)
VALUES(3838, ' xx ', SYSDATE, '销售经理', 9999);


UPDATE emp_pl
SET sal = 1748;


UPDATE emp_pl
SET job = 'CEO';
