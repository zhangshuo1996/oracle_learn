-- 13-1
SELECT empno, ename, job, sal, deptno
FROM emp_pl
WHERE empno = 7876;


-- 13-2
CREATE OR REPLACE PROCEDURE raise_salary
(p_empno IN emp_pl.empno%TYPE, p_rate IN NUMBER)
IS

BEGIN 
    UPDATE emp_pl
    SET sal = sal * (1+ p_rate * 0.01)
    WHERE empno = p_empno;
END raise_salary;
/

-- 13-3
EXECUTE raise_salary(7876, 20);

-- 13-4
SELECT empno, ename, job, sal, deptno
FROM emp_pl
WHERE empno = 7876;

-- 13-5
SELECT empno, ename, job, sal, deptno
FROM emp_pl
WHERE empno = 7902;


-- 13-6
EXECUTE raise_salary(7902, -10);


-- 13-9
CREATE OR REPLACE PROCEDURE get_employyee
(
    p_empno IN emp.empno%TYPE,
    p_name OUT emp.ename%TYPE,
    p_salary OUT emp.sal%TYPE,
    p_job OUT emp.job%TYPE
)
IS
BEGIN
    SELECT ename, sal, job
    INTO p_name, p_salary, p_job
    FROM emp
    WHERE empno = p_empno;
END get_employyee;
/

-- 13-10
SET serveroutput ON
DECLARE
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
    v_job   emp.job%TYPE;
BEGIN
    get_employyee(7788, v_ename, v_sal, v_job);
    DBMS_OUTPUT.PUT_LINE(v_job || ' ' || v_ename || 
                '工资为： ' || TO_CHAR(v_sal, 'L99,999.00'));
END;
/

-- 13-12
CREATE OR REPLACE PROCEDURE standard_phone
(p_phone_no IN OUT VARCHAR2) 
IS

BEGIN
    p_phone_no := '(' || SUBSTR(p_phone_no, 1, 3) || ')' ||
                    SUBSTR(p_phone_no, 4, 3) || ' ' ||
                    SUBSTR(p_phone_no, 7);
END standard_phone;
/

-- 13-13
VARIABLE g_phone_no VARCHAR2(20)
EXECUTE :g_phone_no := '8004449444'

-- 13-14
EXECUTE standard_phone(:g_phone_no);


-- 13-15
DELETE dept_pl
WHERE deptno > 40;


-- 13-16
DROP SEQUENCE dept_id_sequence;

-- 13-17
CREATE SEQUENCE deptid_sequence
START WITH 50
INCREMENT BY 5
MAXVALUE 1000
NOCACHE
NOCYCLE;

-- 13-18
CREATE OR REPLACE PROCEDURE add_dept
    (v_name IN dept_pl.dname%TYPE DEFAULT '服务',
    v_loc   IN dept_pl.loc%TYPE DEFAULT '狼山镇')
IS
BEGIN   
    INSERT INTO dept_pl
    VALUES (deptid_sequence.NEXTVAL, v_name, v_loc);
END add_dept;
/


-- 13-19
SELECT * FROM dept_pl;

-- 13-20
BEGIN
    add_dept;
    add_dept('公关', '公主坟');
    add_dept(v_loc =>'将军堡', v_name=>'保卫');
    add_dept(v_loc=>'驴士');
END;
/

-- 13-22
SELECT empno, ename, job, sal
FROM emp_pl
WHERE deptno = 30;


-- 13-23
SET verif OFF
DECLARE 
    v_deptno emp_pl.deptno%TYPE := &p_deptno;
    v_rate NUMBER(8, 2) := &p_rate;

    CURSOR emp_cursor IS
        SELECT empno
        FROM emp_pl
        WHERE deptno = v_deptno;

BEGIN
    FOR emp_record In emp_cursor LOOP
        raise_salary(emp_record.empno, v_rate);
    END LOOP;
    COMMIT; 
END;
/

-- 13-25
SELECT empno, ename, job, sal
FROM emp_pl
WHERE deptno = 20;

-- 13-27
CREATE TABLE log_table
    (user_id VARCHAR2(38),
    log_date DATE,
    empno NUMBER(8));

-- 13-28
SELECT empno, ename, job, sal
FROM emp_pl
WHERE job = '保安';


-- 13-29
CREATE OR REPLACE PROCEDURE audit_emp_dml
    (p_id IN emp_pl.empno%TYPE)
IS
    PROCEDURE log_exec
    IS 
    BEGIN
        INSERT INTO log_table (user_id, log_date, empno)
        VALUES (USER, SYSDATE, p_id);
    END log_exec;
BEGIN
    DELETE FROM emp_pl
    WHERE empno = p_id;
    log_exec;
END audit_emp_dml;
/

-- 13-30
EXEC audit_emp_dml(7939);

-- 13-32
SELECT *
FROM log_table

-- 13-38
SELECT * 
FROM dept_pl;

-- 13-39
SET serveroutput ON
CREATE OR REPLACE PROCEDURE add_depte
    (p_name IN dept_pl.dname%TYPE DEFAULT '服务',
    p_loc   IN dept_pl.loc%TYPE DEFAULT '狼山镇')

IS
BEGIN
    INSERT INTO dept_pl
    VALUES (deptid_sequence.NEXTVAL, p_name, p_loc);
    DBMS_OUTPUT.PUT_LINE('添加部门 ： ' || p_name);
END add_depte;
/

-- 13-40
CREATE OR REPLACE PROCEDURE create_depts 
IS
BEGIN
    add_depte;
    add_depte;
    add_depte('保安', '将军堡');
END;
/

-- 13-41
EXEC create_depts;

-- 13-43
alter table dept_pl
modify (deptno NUMBER(6));

-- 13-46
col object_name for a20;


-- 13-47
SELECT object_id, object_name, created, status
FROM user_objects
WHERE object_type = 'PROCEDURE';

-- 13-48
DROP PROCEDURE add_dept;