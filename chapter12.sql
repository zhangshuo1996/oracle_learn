-- 12-1
SET serveroutput ON 
DECLARE 
    v_job emp_pl.job%TYPE;
BEGIN
    SELECT job INTO v_job
    FROM emp_pl
    where job = '保安';

    DBMS_OUTPUT.PUT_LINE(v_job);
END;
/    



-- 12-2
SET serveroutput ON 
DECLARE 
    v_job emp_pl.job%TYPE := '&p_job';
BEGIN
    SELECT job INTO v_job
    FROM emp_pl
    where job = '保安';

    DBMS_OUTPUT.PUT_LINE(v_job);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('该语句提取了太多的行，可以使用cursor来解决这一问题');
END;
/    


-- 12-3
SET verify OFF
SET serveroutput ON
DECLARE
    e_emps_remaining EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_emps_remaining, -2292);
    v_deptno dept.deptno%TYPE := &p_deptno;

BEGIN
    DELETE FROM dept
    WHERE deptno = v_deptno;
    COMMIT;
EXCEPTION
    WHEN e_emps_remaining THEN  
        DBMS_OUTPUT.PUT_LINE('无法删除这个部门' || TO_CHAR(v_deptno) 
        || '，因为在这个部门中还有员工！');
END;
/

-- 12-4
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE deptno = 20;

-- 12-5
INSERT INTO emp (empno, ename, job, sal, deptno)
VALUES (3838, '铁蛋', '保安', 1250, 38);


-- 12-6
SET verify OFF
SET serveroutput ON
DECLARE
    e_insert_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_insert_excep, -02291);
    v_deptno dept.deptno%TYPE := &p_deptno;

BEGIN
    INSERT INTO emp (empno, ename, job, sal, deptno)
    VALUES (3838, '铁蛋', '保安', 1250, v_deptno);

EXCEPTION
    WHEN e_insert_excep THEN  
        DBMS_OUTPUT.PUT_LINE(v_deptno || '部门并不存在');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


-- 12-7
CREATE TABLE errors
    (   username        VARCHAR2(255),
        error_date      DATE,
        error_code      NUMBER(10),
        error_message   VARCHAR2(255)
    );


-- 12-8
SET verify OFF
SET serveroutput ON
DECLARE
    v_empno emp.empno%TYPE := &p_empno;
    v_deptno dept.deptno%TYPE := &p_deptno;

    v_error_code NUMBER;
    v_error_message VARCHAR2(255);

BEGIN
    INSERT INTO emp (empno, ename, job, sal, deptno)
    VALUES          (v_empno, '铁蛋', '保安', 1250, v_deptno);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;

        INSERT INTO errors (username, error_date, error_code, error_message)
        VALUES             (USER, SYSDATE, v_error_code, v_error_message);

        COMMIT;
END;
/

-- 12-12

SET verify OFF
set serveroutput ON
DECLARE
    e_invalid_employee EXCEPTION;

BEGIN
    UPDATE emp_pl
    SET job = '&p_job'
    WHERE empno = &p_empno;

    IF SQL%NOTFOUND THEN
        RAISE e_invalid_employee;
    END IF;
    COMMIT;
EXCEPTION
    WHEN e_invalid_employee THEN
        DBMS_OUTPUT.PUT_LINE('该员工不存在，这是一个无效的员工号！');
END;
/


-- 12-14
SET verify OFF
SET serveroutput ON
DECLARE
    DELETE FROM emp_pl
    WHERE ename = '&p_ename'; --??
    -- DBMS_OUTPUT.PUT_LINE(SQL%NOTFOUND);
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20174, '公司没有雇佣这一员工');
    END IF;
END;
/


-- 12-15
DECLARE
    e_invalid_employee EXCEPTION;
    PRAGMA EXCEPTION_INIT (e_invalid_employee, -20274);

BEGIN
    DELETE FROM emp_pl
    WHERE ename = '&p_ename';
    IF SQL%NOTFOUND THEN
        RAISE e_invalid_employee;
    END IF;
    COMMIT;
EXCEPTION
    WHEN e_invalid_employee THEN
        RAISE_APPLICATION_ERROR(-20274, '公司未雇佣这一员工');
END;
/