-- 7-1
set verify off
set serveroutput on
declare
    v_age NUMBER := &p_age;
begin
    IF v_age < 60 
    then
        DBMS_OUTPUT.PUT_LINE('未到退休年龄');
    END IF;
END;
/

-- 7-3
set verify off
set serveroutput on
declare
    v_age NUMBER := &p_age;
    v_gender char(1) := '&p_sex';
begin
    IF (v_age BETWEEN 18 AND 35) AND (v_gender = 'F') 
    then
        DBMS_OUTPUT.PUT_LINE('下任女秘书');
    END IF;
END;
/

-- 7-6
alter session set NLS_DATE_LANGUAGE = 'AMERICAN';

-- 7-8
set verify off
set serveroutput on
declare
    v_shipdate DATE := '&p_shipdate';
    v_orderdate DATE := '&p_orderdate';
    v_ship_flag varchar2(16);
begin
    IF v_shipdate - v_orderdate < 8  
    then
        v_ship_flag := 'ACCEPTABLE';
        DBMS_OUTPUT.PUT_LINE('服务不错');
    ELSE
        v_ship_flag := 'UNACCEPTABLE';
        DBMS_OUTPUT.PUT_LINE('该公司服务太差');
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_ship_flag);
END;
/


-- 7-9
set verify off
set serveroutput on
declare
    v_age NUMBER := &p_age;
begin
    IF v_age < 60 
    then
        DBMS_OUTPUT.PUT_LINE('未到退休年龄');
    ELSIF v_age < 65 then
        DBMS_OUTPUT.PUT_LINE('可以退休， 半价进入公园');
    ELSIF v_age < 80 then
        DBMS_OUTPUT.PUT_LINE('可以退休， 免费公交');
    ELSE
        DBMS_OUTPUT.PUT_LINE('免费蹦极！');
    END IF;
END;
/

-- 7-13
set verify off
set serveroutput on
declare
    v_degree char(1) := UPPER('&p_degree');
    v_description varchar2(250);
begin
    v_description := CASE v_degree
        WHEN 'B' THEN '此人拥有学士学位'
        WHEN 'M' THEN '此人拥有硕士学位'
        WHEN 'D' THEN '此人拥有博士学位'
        ELSE '此人拥有壮士学位'
    END;   
    DBMS_OUTPUT.PUT_LINE(v_description);
END;
/


-- 7-17
set verify off
set serveroutput on
declare
    v_degree char(1) := UPPER('&p_degree');
    v_description varchar2(250);
begin
    v_description := CASE v_degree
        WHEN 'B' THEN '此人拥有学士学位'
        WHEN 'M' THEN '此人拥有硕士学位'
        WHEN 'D' THEN '此人拥有博士学位'
        ELSE '此人拥有壮士学位'
    END;   
    DBMS_OUTPUT.PUT_LINE(v_description);
END;
/

-- 7-18
set verify off
set serveroutput on
declare
    v_degree char(1) := UPPER('&p_degree');
begin
    CASE v_degree
        WHEN 'B' THEN 
            DBMS_OUTPUT.PUT_LINE('此人拥有学士学位');
        WHEN 'M' THEN 
            DBMS_OUTPUT.PUT_LINE('此人拥有硕士学位');
        WHEN 'D' THEN
            DBMS_OUTPUT.PUT_LINE('此人拥有博士学位');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('此人拥有壮士学位');
    END CASE;   
END;
/

-- 7-25
set verify off
set serveroutput on
declare
    v_empno NUMBER := &p_empno;
    v_ename varchar2(30);
    v_job emp.job%TYPE;
    v_sal emp.sal%TYPE;
begin
    select job into v_job from emp where empno = v_empno;

    CASE v_job
        WHEN 'SALESMAN' THEN 
            select empno, ename, job, sal * 1.5
            into v_empno, v_ename, v_job, v_sal
            from emp 
            where empno = v_empno;
            DBMS_OUTPUT.PUT_LINE(v_job || ' ' || v_ename || ' 加薪后的工资为 ： ' || v_sal);
        
        WHEN 'CLERK' THEN 
            select empno, ename, job, sal * 1.2
            into v_empno, v_ename, v_job, v_sal
            from emp 
            where empno = v_empno;
            DBMS_OUTPUT.PUT_LINE(v_job || ' ' || v_ename || ' 加薪后的工资为 ： ' || v_sal);
        
        WHEN 'ANALYST' THEN 
            select empno, ename, job, sal * 1.25
            into v_empno, v_ename, v_job, v_sal
            from emp 
            where empno = v_empno;
            DBMS_OUTPUT.PUT_LINE(v_job || ' ' || v_ename || ' 加薪后的工资为 ： ' || v_sal);
        
        WHEN 'MANGAGER' THEN 
            select empno, ename, job, sal * 1.40
            into v_empno, v_ename, v_job, v_sal
            from emp 
            where empno = v_empno;
            DBMS_OUTPUT.PUT_LINE(v_job || ' ' || v_ename || ' 加薪后的工资为 ： ' || v_sal);
    END CASE;   
END;
/
-- 7-27
select empno, ename, job, sal
from emp
where empno = 7900;
