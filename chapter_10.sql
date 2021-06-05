-- 10-1
set verify off
declare
    v_rows_updated varchar2(38);
    v_deptno emp_pl.deptno%TYPE := &p_deptno;

BEGIN
    UPDATE emp_pl
    SET sal = 9999
    WHERE deptno = v_deptno;
    v_rows_updated := (SQL%ROWCOUNT || '行数据已经被修改了');
    DBMS_OUTPUT.PUT_LINE(v_rows_updated);

END;
/


-- 10-3
select empno, ename, job, sal
from emp_pl
where deptno in(30, 70);

-- 10-4 无法直接执行
declare
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_job   emp.job%TYPE;
    v_sal   emp.sal%TYPE;

    CURSOR emp_cursor IS
        SELECT empno, ename, job, sal
        FROM emp
        WHERE deptno = 20
        ORDER BY sal;

    v_deptno    dept.deptno%TYPE;
    v_dname     dept.dname%TYPE;
    v_loc       dept.loc%TYPE;

    CURSOR dept_cursor IS
        SELECT *
        FROM dept
        ORDER BY loc;



-- 10-5
set serveroutput on
declare 
    v_empno     emp.empno%TYPE;
    v_ename     emp.ename%TYPE;
    v_job       emp.job%TYPE;
    v_sal       emp.sal%TYPE;
    CURSOR emp_cursor IS
        SELECT empno, ename, job, sal
        FROM emp
        WHERE empno = 7900;

BEGIN
    OPEN emp_cursor;
    FETCH emp_cursor INTO v_empno, v_ename, v_job, v_sal;
    DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename || ' ' || v_job || ' ' || v_sal);
END;
/


-- 10-7
set serveroutput on
declare 
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_job       emp.job%TYPE;
    v_sal       emp.sal%TYPE;
    CURSOR emp_cursor IS
        SELECT empno, ename, job, sal
        FROM emp
        WHERE deptno = 20;

BEGIN
    OPEN emp_cursor;
    FETCH emp_cursor INTO v_empno, v_ename, v_job, v_sal;
    DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename || ' ' || v_job || ' ' || v_sal);
END;
/

-- 10-9
set serveroutput on
declare 
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_job       emp.job%TYPE;
    v_sal       emp.sal%TYPE;
    CURSOR emp_cursor IS
        SELECT empno, ename, job, sal
        FROM emp
        ORDER BY sal;

BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_empno, v_ename, v_job, v_sal;
        EXIT WHEN emp_cursor%ROWCOUNT > 80 OR emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename || ' ' || v_job || ' ' || v_sal);
    END LOOP;
    CLOSE emp_cursor;
END;
/


-- 10-10

set serveroutput on
declare
    v_empno     emp.empno%TYPE;
    v_ename     emp.ename%TYPE;
    v_job       emp.job%TYPE;
    v_sal       emp.sal%TYPE;

    CURSOR emp_cursor IS
        SELECT empno, ename, job, sal
        from emp
        ORDER BY sal;
    
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_empno, v_ename, v_job, v_sal;
        EXIT WHEN emp_cursor%ROWCOUNT > 100 OR emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename || ' ' || v_job || ' ' || v_sal);
    END LOOP;
    CLOSE emp_cursor;
END;
/

-- 10-11
set serveroutput on
declare
    
    CURSOR emp_cursor IS
        SELECT *
        from emp;
    
    emp_record emp_cursor%ROWTYPE;

    TYPE emp_table_type IS TABLE OF
        emp%ROWTYPE INDEX BY PLS_INTEGER;

    v_emp_record emp_table_type;
    n NUMBER(3) := 1;
    
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        v_emp_record(n) := emp_record; -- 赋值
        n := n + 1;
    END LOOP;
    CLOSE emp_cursor;

    <<Outer_Loop>>
    FOR i IN v_emp_record.FIRST..v_emp_record.LAST LOOP
        FOR j IN v_emp_record.FIRST..v_emp_record.LAST LOOP
            IF v_emp_record(i).empno = v_emp_record(j).mgr
            THEN
                DBMS_OUTPUT.PUT_LINE(v_emp_record(i).job || ' ' || ' ' 
                    || v_emp_record(i).ename || '是真正的经理，不是光杆司令！！！');
                CONTINUE Outer_Loop;
            END IF;
        END LOOP ;
    END LOOP Outer_Loop;
END;
/

-- 10-12
SELECT empno, ename, job, mgr
from emp;
