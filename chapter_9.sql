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

-- 9—12
set verify off
declare
    v_emp_rec ex_emp%ROWTYPE;
begin
    select empno, ename, job, mgr, hiredate, sal, comm, deptno, hiredate
    INTO v_emp_rec
    from emp
    where empno = &employee_number;

    INSERT INTO ex_emp
    VALUES v_emp_rec;
END;
/

-- 9-14
set verify off
declare
    v_emp_rec ex_emp%ROWTYPE;
begin
    select *
    INTO v_emp_rec
    from ex_emp
    where empno = &employee_number and ROWNUM = 1;

    v_emp_rec.leavedate := CURRENT_DATE;

    UPDATE ex_emp
    set ROW = v_emp_rec
    where empno = v_emp_rec.empno;
END;
/


-- 9-16
set verify off
set serveroutput on
declare
    TYPE ename_table_type IS TABLE OF emp.ename%TYPE
        INDEX BY PLS_INTEGER;
    TYPE hiredate_table_type IS TABLE OF DATE
        INDEX BY BINARY_INTEGER;

    ename_table     ename_table_type;
    hiredate_table  hiredate_table_type;
    v_count         NUMBER(6) := &p_count;

begin
    FOR i IN 1..v_count LOOP
        ename_table(i) := '武大';
        hiredate_table(i) := SYSDATE + 14;
        DBMS_OUTPUT.PUT_LINE(ename_table(i) || ':' || hiredate_table(i));
    END LOOP;
END;
/

-- 9-17
set verify off
set serveroutput on
declare
    TYPE ename_table_type IS TABLE OF emp.ename%TYPE
        INDEX BY PLS_INTEGER;
    TYPE hiredate_table_type IS TABLE OF DATE
        INDEX BY BINARY_INTEGER;

    ename_table     ename_table_type;
    hiredate_table  hiredate_table_type;

begin
    ename_table(-8) := '武大';
    hiredate_table(-8) := SYSDATE + 14;
    DBMS_OUTPUT.PUT_LINE(ename_table(-8) || ':' || hiredate_table(-8));
END;
/

-- 9-18
set verify off
set serveroutput on
declare
    TYPE ename_table_type IS TABLE OF emp.ename%TYPE
        INDEX BY PLS_INTEGER;
    TYPE hiredate_table_type IS TABLE OF DATE
        INDEX BY BINARY_INTEGER;

    ename_table     ename_table_type;
    hiredate_table  hiredate_table_type;

begin
    ename_table(-8) := '武大';
    hiredate_table(-8) := SYSDATE + 14;
    DBMS_OUTPUT.PUT_LINE(ename_table(-8) || ':' || hiredate_table(-8));
    DBMS_OUTPUT.PUT_LINE(ename_table(-7) || ':' || hiredate_table(-7));
END;
/

-- 9-19
declare
    TYPE emp_num_type IS TABLE OF NUMBER
    INDEX BY varchar2(38);

    Total_employees emp_num_type;

    i varchar2(38);

begin
    SELECT count(*) INTO Total_employees('ACCOUNTING')
    FROM emp 
    WHERE deptno = 10;
    
    SELECT count(*) INTO Total_employees('RESEARCH')
    FROM emp 
    WHERE deptno = 20;

    
    SELECT count(*) INTO Total_employees('SALES')
    FROM emp 
    WHERE deptno = 30;

    i := Total_employees.FIRST;
    DBMS_OUTPUT.PUT_LINE('按照升序列出每个部门的名字和员工数');


    WHILE i IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Total number of employees in ' || i || ' is ' || TO_CHAR(Total_employees(i))
        );
        i := Total_employees.NEXT(i);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10));
    i := Total_employees.LAST;
    DBMS_OUTPUT.PUT_LINE('按照降序列出每个部门的名字和人员数');

    WHILE i IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Total number of employees in ' || i  || ' is ' || TO_CHAR(Total_employees(i))
        );
        i := Total_employees.PRIOR(i);
    END LOOP;
END;
/


-- 9-20

INSERT INTO dept_pl(deptno, dname, loc)
VALUES(50, '保卫部', '将军堡');

select * from dept_pl;


-- 9-23
set serveroutput on
set verify off

declare
    TYPE dept_table_type IS TABLE OF
    dept_pl%ROWTYPE INDEX BY PLS_INTEGER;

    dept_table dept_table_type;
    v_count NUMBER(3) := 5;
    j       NUMBER(3);

begin
    FOR i IN 1..v_count 
    LOOP
        SELECT * INTO dept_table(i*10) 
        FROM dept_pl
        WHERE deptno = i * 10;
    END LOOP;

    j := dept_table.FIRST;
    WHILE j IS NOT NULL 
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            dept_table(j).deptno || ' ' || dept_table(j).dname || ' ' || dept_table(j).loc
        );
        j := dept_table.NEXT(j);
    END LOOP;
END;
/
