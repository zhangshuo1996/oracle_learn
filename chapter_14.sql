-- 14-1
CREATE OR REPLACE FUNCTION get_sal
    (v_id IN emp_pl.empno%TYPE)
    RETURN NUMBER
IS
    v_salary emp_pl.sal%TYPE := 0;
BEGIN
    SELECT sal
    INTO v_salary
    FROM emp_pl
    WHERE empno = v_id;
    RETURN (v_salary);
END get_sal;
/

-- 14-2
SELECT empno, ename, job, sal
FROM emp_pl
WHERE deptno = 20;

-- 14-3
SET serveroutput on
DECLARE 
    v_sal emp_pl.sal%TYPE;
BEGIN
    v_sal := get_sal(7902);
    DBMS_OUTPUT.PUT_LINE('7902号员工的工资为： ' || v_sal);
END;
/

-- 14-4
VARIABLE g_salary NUMBER
EXECUTE :g_salary := get_sal(7902)
PRINT g_salary

-- 14-6
SELECT ename, job, get_sal(empno), deptno
FROM emp_pl
WHERE deptno = 20;


-- 14-7 -- 14-10
COL FIRST_NAME FOR a15
COL LAST_NAME FOR a15
COL PHONE_NUMBER FOR a15

-- 14-10
SELECT employee_id, first_name, last_name, phone_number
FROM employees
WHERE rownum < 11;


-- 14-11
CREATE OR REPLACE FUNCTION format_phone
    (p_phone_no IN VARCHAR2)
    RETURN VARCHAR2
IS
    v_phone VARCHAR2(38);
BEGIN
    v_phone := '(' || SUBSTR(p_phone_no, 1, 3) ||
                ') ' || SUBSTR(p_phone_no, 5, 3) ||
                '-' || SUBSTR(p_phone_no, 9);
    RETURN v_phone;
END format_phone;
/ 

-- 14-12
COL PHONE for a25


-- 14-13
SELECT employee_id, first_name, last_name, format_phone(phone_number) "Phone"
FROM employees;


-- 14-14
SELECT empno, ename, job, sal
FROM emp_pl
WHERE deptno > 40;


-- 14-15
CREATE OR REPLACE FUNCTION insert_plus_sal(p_sal NUMBER)
RETURN NUMBER
IS

BEGIN
    INSERT INTO emp_pl(empno, ename, hiredate, job, sal, deptno)
    VALUES (3838, '武大', SYSDATE, '特级饼师', p_sal, 70);
    RETURN (p_sal + 250);
END;
/


-- 14-16
UPDATE emp_pl
SET sal = insert_plus_sal(9000)  -- 插入的时候无法设置表中的值
WHERE empno = 7938;

-- 14-17
CREATE OR REPLACE FUNCTION query_plus_sal(p_increase NUMBER)
RETURN NUMBER IS
    v_sal NUMBER;
BEGIN
    SELECT sal INTO v_sal
    FROM emp_pl
    WHERE empno = 7902;
    RETURN (v_sal + p_increase);
END;
/


-- 14-18
UPDATE emp_pl
SET sal = query_plus_sal(250)
WHERE empno = 7938;

-- 14-19
CREATE OR REPLACE FUNCTION test11g(
    p_100 IN NUMBER DEFAULT 99,
    p_50 IN NUMBER DEFAULT 50
)
RETURN NUMBER
IS
    v_num NUMBER;
BEGIN
    v_num := p_50 + (p_100 * 2);
    RETURN v_num;
END test11g;
/


-- 14-20
SELECT test11g(p_100 => 100)
FROM dual;

-- 14-21
col object_name for a20

SELECT object_id, object_name, created, status
FROM user_objects
WHERE object_type = 'FUNCTION'

-- 14-23
DROP FUNCTION test11g;