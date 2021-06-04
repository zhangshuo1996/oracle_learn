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