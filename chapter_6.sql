-- 6-1
declare
    v_deptno dept.deptno%TYPE;
    v_loc    varchar2(28);
begin
    select deptno, loc
    into v_deptno, v_loc
    from dept
    where dname = 'ACCOUNTING';
END;
/


-- 6-2
declare 
    v_deptno dept_deptno%TYPE;
    v_loc    varchar2(38);
begin
    select deptno, loc 
    into v_deptno, v_loc
    from dept
    where dname = 'accounting'
END;
/

-- 6-3
declare 
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
begin
    select ename, sal
    into v_ename, v_sal
    from emp
    where job = 'CLERK';
END;
/
