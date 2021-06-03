-- 9-1
set verify off;
set serveroutput on;
declare 
    TYPE emp_record_type IS RECORD 
        (   empno  NUMBER(4) NOT NULL := &p_empno,
            ename       emp.ename%TYPE,
            job         emp.job%TYPE,
            sal         emp.sal%TYPE,
            hiredate    emp.hiredate%TYPE
        );
    v_increase_sal NUMBER(8, 2) DEFAULT &p_increase_sal;
    emp_record emp_record_type;
begin
    select empno, ename,job, sal, hiredate
    into emp_record
    from emp
    where empno = emp_record.empno;

    emp_record.hiredate := SYSDATE;
    emp_record.sal := emp_record.sal + v_increase_sal;
    DBMS_OUTPUT.PUT_LINE(emp_record.empno);
    DBMS_OUTPUT.PUT_LINE(emp_record.ename);
    DBMS_OUTPUT.PUT_LINE(emp_record.job);
    DBMS_OUTPUT.PUT_LINE(emp_record.sal);
    DBMS_OUTPUT.PUT_LINE(emp_record.hiredate);
END;
/

-- 9-2
select empno, ename, job, sal, hiredate
from emp
where empno = 7788;


-- 9-4
create TABLE ex_emp
AS 
    select *
    from emp
    where 1 = 2;

-- 9-5
alter TABLE ex_emp
ADD (leavedate DATE);


-- 9-9
set verify off;
declare
    emp_rec emp%ROWTYPE;
begin
    select * INTO emp_rec
    from emp
    where empno = &employee_number;

    INSERT INTO ex_emp(empno, ename, job, mgr, hiredate, 
                        leavedate, sal, comm, deptno)
    VALUES(emp_rec.empno, emp_rec.ename, emp_rec.job, emp_rec.mgr, emp_rec.hiredate,
                    SYSDATE, emp_rec.sal, emp_rec.comm, emp_rec.deptno);
    COMMIT;
END;
/

select * from ex_emp;