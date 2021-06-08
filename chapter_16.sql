-- 16-1
CREATE OR REPLACE PACKAGE dept_pkg 
IS
    PROCEDURE add_dept  
        (p_deptno IN dept_pl.deptno%TYPE,
        p_name IN dept_pl.dname%TYPE DEFAULT '服务',
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇');
    PROCEDURE add_dept
        (p_name IN dept_pl.dname%TYPE DEFAULT '服务', 
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇');
END dept_pkg;
/


-- 16-2
CREATE OR REPLACE PACKAGE BODY dept_pkg
IS
    PROCEDURE add_dept
        (p_deptno IN dept_pl.deptno%TYPE,
        p_name IN dept_pl.dname%TYPE DEFAULT '服务',
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇')
    IS  
    BEGIN
        INSERT INTO dept_pl(deptno, dname, loc)
        VALUES (p_deptno, p_name, p_loc);
    END add_dept;

    PROCEDURE add_dept
     (p_name IN dept_pl.dname%TYPE DEFAULT '服务', 
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇')
    IS
    BEGIN
        INSERT INTO dept_pl(deptno, dname, loc)
            VALUES (deptid_sequence.NEXTVAL, p_name, p_loc);
    END add_dept;
END dept_pkg;
/


-- 16-3
SELECT * FROM dept_pl;

-- 16-4
EXECUTE dept_pkg.add_dept(38, '公关', '公主坟')


EXECUTE dept_pkg.add_dept('保安', '威虎山')


-- 16-13
CREATE OR REPLACE PACKAGE BODY salary_pkg 
IS
    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER)
    IS 
    BEGIN
        IF validate(p_new_sal, p_grade)
        THEN
            v_std_salary := p_new_sal;
        ELSE
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
    
    FUNCTION validate (p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS 
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal
        INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;
END salary_pkg;
/


-- 16-14
CREATE OR REPLACE PACKAGE  BODY salary_pkg 
IS
    -- 前向声明
    FUNCTION validate(p_sal NUMBER, p_grade NUMBER) RETURN BOOLEAN;

    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER)
    IS 
    BEGIN
        IF validate(p_new_sal, p_grade)
        THEN
            v_std_salary := p_new_sal;
        ELSE
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
    
    FUNCTION validate (p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS 
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal
        INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;
END salary_pkg;
/

-- 16-16
CREATE OR REPLACE PACKAGE  BODY salary_pkg 
IS

    FUNCTION validate(p_sal NUMBER, p_grade NUMBER) RETURN BOOLEAN;

    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER)
    IS 
    BEGIN
        IF validate(p_new_sal, p_grade)
        THEN
            v_std_salary := p_new_sal;
        ELSE
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
    
    FUNCTION validate (p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS 
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal
        INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;

    BEGIN 
        SELECT AVG(sal) INTO v_std_salary
        FROM emp;
END salary_pkg;
/

-- 16-17
SET serveroutput ON
BEGIN
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 16-18
SELECT AVG(sal)
FROM emp;

-- 16-19
CREATE OR REPLACE PACKAGE dept_bi 
IS
    FUNCTION average_salary(p_deptno IN NUMBER) RETURN NUMBER;
    FUNCTION employee_num(p_deptno IN NUMBER) RETURN NUMBER;
END dept_bi;
/


-- 16-20
CREATE OR REPLACE PACKAGE BODY dept_bi
IS
    FUNCTION average_salary(p_deptno IN NUMBER) RETURN NUMBER
    IS
        v_average_sal emp.sal%TYPE;
    BEGIN
        SELECT AVG(sal) INTO  v_average_sal
        FROM emp 
        WHERE deptno = p_deptno;
        RETURN v_average_sal;
    END average_salary;

    FUNCTION employee_num(p_deptno IN NUMBER) RETURN NUMBER 
    IS
        v_emp_num NUMBER(8);
    BEGIN
        SELECT COUNT(*) INTO v_emp_num
        FROM emp
        WHERE deptno = p_deptno;
        RETURN v_emp_num;
    END employee_num;
END dept_bi;
/

-- 16-21
SELECT deptno, dname, dept_bi.average_salary(20) "AVERAGE Salary",
        dept_bi.employee_num(20) "Emploee Number"
FROM dept
WHERE deptno = 20;

-- 16-22
SELECT deptno, AVG(sal), COUNT(*)
FROM emp
GROUP BY deptno;


-- 16-23
SELECT deptno, dname, 
    dept_bi.average_salary(deptno) "AVERAGE Salary",
    dept_bi.employee_num(deptno) "Emploee Number"
FROM dept;

-- 16-24
SELECT * FROM salgrade

-- 16-25
SET serveroutput ON
BEGIN
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 16-26
EXECUTE salary_pkg.reset_salary(888, 1);


-- 16-27
BEGIN
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 16-28
BEGIN
    DBMS_OUTPUT.PUT_LINE(scott.salary_pkg.v_std_salary);
END;
/

-- 16-29
UPDATE scott.salgrade
SET losal = 900
WHERE grade = 1;


-- 16-30
SELECT *
FROM scott.salgrade;


-- 16-31
BEGIN
    DBMS_OUTPUT.PUT_LINE(scott.salary_pkg.v_std_salary);
END;
/


-- 16-32
EXECUTE scott.salary_pkg.reset_salary(938, 1);

-- 16-33
BEGIN
    DBMS_OUTPUT.PUT_LINE(scott.salary_pkg.v_std_salary);
END;
/

-- 16-34
EXECUTE scott.salary_pkg.reset_salary(898, 1);

-- 16-35
BEGIN
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 16-36
SELECT * FROM salgrade;


-- 16-38
BEGIN   
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 16-39
SELECT *
FROM salgrade;


-- 16-42
EXECUTE salary_pkg.reset_salary(789, 1);

-- 16-43
SET serverout ON
BEGIN
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/


-- 16-44
CREATE OR REPLACE PACKAGE employee_pkg 
IS
    PROCEDURE open_emp;
    FUNCTION next_employee(p_n NUMBER := 1) RETURN BOOLEAN;
    PROCEDURE close_emp;
END employee_pkg;
/


-- 16-45
CREATE OR REPLACE PACKAGE BODY employee_pkg 
IS
    CURSOR emp_cursor 
    IS
        SELECT empno FROM emp;
    
    PROCEDURE open_emp IS
    BEGIN 
        IF NOT emp_cursor%ISOPEN
        THEN
            OPEN emp_cursor;
        END IF;
    END open_emp;
     
    FUNCTION next_employee(p_n NUMBER := 1) RETURN BOOLEAN
    IS
        v_emp_id emp.empno%TYPE;
    BEGIN
        FOR count IN 1..p_n LOOP    
            FETCH emp_cursor INTO v_emp_id;
            EXIT WHEN emp_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Employee NUMBER: ' || (v_emp_id));
        END LOOP;
        RETURN emp_cursor%FOUND;
    END next_employee;

    PROCEDURE close_emp 
    IS
    BEGIN   
        IF emp_cursor%ISOPEN 
        THEN
            CLOSE emp_cursor;
        END IF;
    END close_emp;
END employee_pkg;
/


-- 16-46 --47
SET serveroutput ON

EXECUTE employee_pkg.open_emp

-- 16-48
DECLARE 
    more_rows BOOLEAN := employee_pkg.next_employee(5);
BEGIN
    IF NOT more_rows 
    THEN
        employee_pkg.close_emp;
    END IF;
END;
/


-- 16-52
CREATE OR REPLACE PACKAGE employee_dog 
IS
    TYPE emp_table_type IS TABLE OF emp%ROWTYPE
        INDEX BY PLS_INTEGER;
    PROCEDURE get_emp(p_emps OUT emp_table_type);
END employee_dog;
/


-- 16-53
CREATE OR REPLACE PACKAGE BODY employee_dog 
IS
    PROCEDURE get_emp(p_emps OUT emp_table_type) 
    IS  
        v_count BINARY_INTEGER := 1;
    BEGIN
        FOR emp_record IN (SELECT * FROM emp)
        LOOP    
            p_emps(v_count) := emp_record;
            v_count := v_count + 1;
        END LOOP;
    END get_emp;
END employee_dog;
/


-- 16-54
SET serveroutput ON
DECLARE
    employees employee_dog.emp_table_type;
BEGIN
    employee_dog.get_emp(employees);

    FOR i IN 1..8 LOOP
        DBMS_OUTPUT.PUT_LINE('Emp ' || i || ': ' || employees(i).ename || ' ' || employees(i).job 
                            || ' ' || employees(i).sal);
    END LOOP;
END;
/