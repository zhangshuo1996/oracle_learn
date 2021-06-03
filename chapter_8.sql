-- 8-1
select empno, hiredate, job, sal, deptno 
from emp_pl
where deptno > 20;

-- 8-2
set serveroutput on
set verify off
declare 
    v_empno     emp_pl.empno%TYPE;
    v_deptno    emp_pl.deptno%TYPE := &p_deptno;
    v_sal       emp_pl.sal%TYPE := &p_sal;
    v_hiredate  emp_pl.hiredate%TYPE := SYSDATE;
    v_job       emp_pl.job%TYPE :='&p_job';
    v_counter   NUMBER(2) := 1;
    v_max_num   NUMBER(2) := &p_max_num;
begin   
    select max(empno) into v_empno from emp_pl;
    LOOP
        insert into emp_pl(empno, hiredate, job, sal, deptno)
        values ((v_empno + v_counter), v_hiredate, v_job, v_sal, v_deptno);
        v_counter := v_counter + 1;
        EXIT WHEN v_counter > v_max_num;
    END LOOP;
END;
/

-- 8-4
select empno, hiredate, job, sal, deptno
from emp_pl
where deptno > 20;


-- 8-7
set serveroutput on
set verify off
declare
    v_deptno    dept.deptno%TYPE;
    v_loc       dept.loc%TYPE := '&p_loc';
    v_counter   NUMBER(2) := 1;
    v_max_num   NUMBER(2) := &p_max_num;
begin
    WHILE v_counter <= v_max_num LOOP
        INSERT INTO dept_pl(deptno, loc)
        VALUES(dept_id_sequence.NEXTVAL, v_loc);
        v_counter := v_counter + 1;
    END LOOP;
END;
/

-- 8-8
select *
from dept_pl;