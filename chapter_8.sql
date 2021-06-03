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

-- 8-9
set serveroutput on
set verify off
declare
    v_empno emp_pl.empno%TYPE;
    v_deptno emp_pl.deptno%TYPE := &p_deptno;
    v_sal emp_pl.sal%TYPE := &p_sal;
    v_hiredate  emp_pl.hiredate%TYPE := SYSDATE;
    v_job       emp_pl.job%TYPE :='&p_job';
    v_counter   NUMBER(2) := 1;
    v_max_num   NUMBER(2) := &p_max_num;
begin
    select max(empno) into v_empno 
    from emp_pl;
    while v_counter <= v_max_num LOOP
        INSERT INTO emp_pl(empno, hiredate, job, sal, deptno)
        VALUES((v_empno + v_counter), v_hiredate, v_job, v_sal, v_deptno);
        v_counter := v_counter + 1;
    END LOOP;
END;
/

-- 8-10
select empno, hiredate, job, sal, deptno
from emp_pl
where deptno > 20;


-- 8-14
set serveroutput on
set verify off
declare
    v_deptno dept.deptno%TYPE;
    v_loc dept.loc%TYPE := '&p_loc';
    v_max_num NUMBER(2) := &p_max_num;
begin
    FOR i IN 1..v_max_num LOOP
        INSERT INTO dept_pl(deptno, loc)
        VALUES(dept_id_sequence.NEXTVAL, v_loc);
    END LOOP;
END;
/


-- 8-15
select *
from dept_pl;

-- 8-16
set serveroutput on
set verify off
declare 
    v_empno     emp_pl.empno%TYPE;
    v_deptno    emp_pl.deptno%TYPE := &p_deptno;
    v_sal       emp_pl.sal%TYPE := &p_sal;
    v_hiredate  emp_pl.hiredate%TYPE := SYSDATE;
    v_job       emp_pl.job%TYPE := '&p_job';
    v_max_num   NUMBER(2) := &p_max_num;
begin
    select max(empno) into v_empno
    from emp_pl;

    FOR i IN 1..v_max_num LOOP
        INSERT INTO emp_pl(empno, hiredate, job, sal, deptno)
        VALUES((v_empno + i), v_hiredate, v_job, v_sal, v_deptno);
    END LOOP;
END;
/

-- 
select empno, hiredate, job, sal, deptno
from emp_pl
where deptno > 20;


-- 8-20
set serveroutput on
set verify off
declare 
    v_empno     emp_pl.empno%TYPE;
    v_deptno    emp_pl.deptno%TYPE := &p_deptno;
    v_sal       emp_pl.sal%TYPE := &p_sal;
    v_hiredate  emp_pl.hiredate%TYPE := SYSDATE;
    v_job       emp_pl.job%TYPE := '&p_job';
    v_max_num   NUMBER(2) := &p_max_num;
begin
    select max(empno) into v_empno
    from emp_pl;

    FOR i IN REVERSE 1..v_max_num LOOP
        INSERT INTO emp_pl(empno, hiredate, job, sal, deptno)
        VALUES((v_empno + i), v_hiredate, v_job, v_sal, v_deptno);
    END LOOP;
END;
/


-- 8-22 循环嵌套标识
declare
    v_total     NUMBER := 0;
    v_factorial NUMBER := 1;
    v_num       NUMBER := &p_num;
begin
    <<Outer_Loop>>
    FOR i IN 1..v_num LOOP
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('1 ~ ' || i || '的自然数总和是 ： ' || v_total);
        <<Inner_Loop>>
        FOR j IN 1..v_num LOOP  
            EXIT Inner_Loop WHEN i+j > 4;
            v_factorial := v_factorial * j;
            DBMS_OUTPUT.PUT_LINE('自然数 ' || j || '的阶乘是: ' || v_factorial);
        END LOOP;
        v_factorial := 1;
    END LOOP Outer_Loop;
END;
/

-- 8-24
set serveroutput on
declare
    v_total     NUMBER := 0;
    v_factorial NUMBER := 1;
    v_num       NUMBER := &p_num;
begin
    <<Outer_Loop>>
    FOR i IN 1..v_num LOOP
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('1 ~ ' || i || '的自然数总和是 ： ' || v_total);
        <<Inner_Loop>>
        FOR j IN 1..v_num LOOP  
            EXIT Outer_Loop WHEN i+j > 4;
            v_factorial := v_factorial * j;
            DBMS_OUTPUT.PUT_LINE('自然数 ' || j || '的阶乘是: ' || v_factorial);
        END LOOP;
        v_factorial := 1;
    END LOOP Outer_Loop;
END;
/

-- 8-25
set verify off
set serveroutput on
declare
    v_total     NUMBER := 0;
    v_factorial NUMBER := 1;
    v_num       NUMBER := &p_num;
begin
    <<Outer_Loop>>
    FOR i IN 1..v_num LOOP
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('1 ~ ' || i || '的自然数总和是 ： ' || v_total);
        <<Inner_Loop>>
        FOR j IN 1..v_num LOOP  
            EXIT Outer_Loop WHEN i+j > 4;
            v_factorial := v_factorial * j;
            DBMS_OUTPUT.PUT_LINE('自然数 ' || j || '的阶乘是: ' || v_factorial);
        END LOOP;
        v_factorial := 1;
    END LOOP Outer_Loop;
END;
/

-- 8-26
set verify off
set serveroutput on
declare
    v_total     NUMBER := 0;
    v_factorial NUMBER := 1;
    v_num       NUMBER := &p_num;
begin
    <<Outer_Loop>>
    FOR i IN 1..v_num LOOP
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('1 ~ ' || i || '的自然数总和是 ： ' || v_total);
        <<Inner_Loop>>
        FOR j IN 1..v_num LOOP  
            CONTINUE Outer_Loop WHEN i+j > 4;
            v_factorial := v_factorial * j;
            DBMS_OUTPUT.PUT_LINE('自然数 ' || j || '的阶乘是: ' || v_factorial);
        END LOOP;
        v_factorial := 1;
    END LOOP Outer_Loop;
END;
/


-- 8-27
set verify off
set serveroutput on
declare
    v_total     NUMBER := 0;
    v_factorial NUMBER := 1;
    v_num       NUMBER := &p_num;
begin
    <<Outer_Loop>>
    FOR i IN 1..v_num LOOP
        v_factorial := 1;
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('1 ~ ' || i || '的自然数总和是 ： ' || v_total);
        <<Inner_Loop>>
        FOR j IN 1..v_num LOOP  
            CONTINUE Outer_Loop WHEN i+j > 4;
            v_factorial := v_factorial * j;
            DBMS_OUTPUT.PUT_LINE('自然数 ' || j || '的阶乘是: ' || v_factorial);
        END LOOP;
    END LOOP Outer_Loop;
END;
/


-- 8-27
set verify off
set serveroutput on
declare
    v_total     NUMBER := 0;
    v_num       NUMBER := &p_num;
begin
    <<Outer_Loop>>
    FOR i IN 1..v_num LOOP
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('1 ~ ' || i || '的自然数总和是 ： ' || v_total);
        begin   
            declare
                v_factorial NUMBER := 1;
            begin
                <<Inner_Loop>>
                FOR j IN 1..v_num LOOP  
                    CONTINUE Outer_Loop WHEN i+j > 4;
                    v_factorial := v_factorial * j;
                    DBMS_OUTPUT.PUT_LINE('自然数 ' || j || '的阶乘是: ' || v_factorial);
                END LOOP;
            END;
        END;
    END LOOP Outer_Loop;
END;
/