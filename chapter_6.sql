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

-- 6-4
variable g_deptno NUMBER;
variable g_loc varchar2(38)
declare
    v_deptno dept.deptno%TYPE;
    v_loc    varchar2(38);
begin
    select deptno, loc 
    into v_deptno, v_loc
    from dept
    where dname = 'ACCOUNTING';
    :g_deptno := v_deptno;
    :g_loc := v_loc;
END;
/

-- 6-7
set serveroutput on
declare 
    v_deptno dept.deptno%TYPE;
    v_loc varchar2(38);
begin
    select deptno, loc
    into v_deptno, v_loc
    from dept
    where dname = 'ACCOUNTING';
    DBMS_OUTPUT.PUT_LINE(v_deptno);
    DBMS_OUTPUT.PUT_LINE(v_loc);
END;
/

-- 6-8
select * 
from dept;

-- 6-9
select deptno, loc
from dept
where dname = 'ACCOUNTING';

-- 6-13
set serveroutput on
set verify off
declare 
    v_sum_sal emp.sal%TYPE;
    v_deptno NUMBER NOT NULL := &p_department_id;
begin
    select sum(sal) -- group function
    into v_sum_sal
    from emp
    where deptno = v_deptno;
    DBMS_OUTPUT.PUT_LINE(v_deptno || '号部门的工资总和为：  ' || v_sum_sal);
END;
/


-- 6-20
declare
    ename emp.ename%TYPE;
    hiredate emp.hiredate%TYPE;
    sal emp.sal%TYPE;
    empno emp.empno%TYPE;
begin
    select ename, hiredate, sal
    into ename, hiredate, sal
    from emp
    where  empno = empno;
END;
/

-- 6-21
declare
    ename emp.ename%TYPE;
    hiredate emp.hiredate%TYPE;
    sal emp.sal%TYPE;
    v_empno emp.empno%TYPE := 7788;
begin
    select ename, hiredate, sal
    into ename, hiredate, sal
    from emp
    where  empno = v_empno;
END;
/

-- 6-22
create TABLE emp_pl
AS
select * 
from emp;

-- 6-23
select ename, job, sal 
from emp_pl;

-- 6-24
create TABLE
dept_pl
AS
select *
from dept;

-- 6-25
select *
from dept_pl;

-- 6-26
create sequence dept_id_sequence
start with 50
increment by 5
maxvalue 99
nocache
nocycle;


-- 6-27
col sequence_name for a18

-- 6-28
select sequence_name, min_value, max_value, increment_by, last_number
from user_sequences;

-- 6-29
begin   
    insert into dept(deptno, dname, loc)
    values (dept_id_sequence.NEXTVAL, '公关部', '公主坟区');
END;
/

-- 6-32
select empno, ename, job, sal
from emp
where job = 'CLERK';

--6-33
set vertify off
declare 
    v_sal_increase emp.sal%TYPE := &p_salary_incerase;
begin   
    update emp
    set sal = sal + v_sal_increase
    where job = 'CLERK';
END;
/

--6-34

select empno, ename, job, sal
from emp
where job = 'CLERK';


-- 6-35
select empno, ename, job, sal
from emp
where job = 'CLERK'

-- 6-38
select *
from emp_pl
where job = 'SALESMAN'
order by sal;


--6-39
set verify off
declare 
    v_job emp_pl.job%TYPE := '&p_job';
    v_sal  emp_pl.sal%TYPE := '&p_salary';
begin
    delete from emp_pl
    where job = v_job
    AND sal > v_sal;
END;
/

-- 6-40
select *
from emp_pl
where job = 'SALESMAN'
order by sal;

