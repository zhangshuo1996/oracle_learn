-- 5-1
select hiredate 
from emp
where empno = 7788;

-- 5-2
alter session set nls_date_language = 'AMERICAN';

-- 5-4

declare
    v_date Date;
begin
    v_date := '8-MAR-2014';
END;
/

-- 5-5

declare
    v_date Date;
begin
    v_date := 'MAR-8-2014';
END;
/

-- 5-6
declare
    v_date Date;
begin
    v_date := TO_DATE('2014-03-08', 'YYYY-MM-DD');
END;
/


-- 5-7
set verify off
set serveroutput on
declare
    v_annual_sal emp.sal%TYPE; -- 存放年薪的变量类型与emp.sal的类型是相通的
begin
    /*
    hahah
    */
    v_annual_sal := &p_monthly_sal * 12;
    DBMS_OUTPUT.PUT_LINE('年薪是:' || v_annual_sal); -- 显示年薪
END;
/



-- 5-11
declare
    v_desc varchar2(100) := '解放先驱--';
    v_pointer varchar2(25) := 'jinlian';
    v_string_length InTEGER(5);
begin
    DBMS_OUTPUT.PUT_LINE(v_desc || v_pointer);
    v_string_length := LENGTH(v_desc || v_pointer);
    DBMS_OUTPUT.PUT_LINE('以上中文字符串的长度：' || v_string_length);
END;
/

-- 5-14
set line 100
set pagesize 40;
set serveroutput on
declare
    v_daji_findings varchar2(100000);
    v_daji1 varchar2(250) := '你知道历史上daji？？'
    DBMS_OUTPUT.PUT_LINE(v_daji_findings);
END;


-- 5-15
create sequence dog_seq
    start with 100
    increment by 1
    maxvalue 380380
    nocache
    nocycle;


-- 5-16
declare 
    v_dog_id NUMBER := 0;
begin
    v_dog_id := dog_seq.NEXTVAL;
    DBMS_OUTPUT.PUT_LINE('当前的狗号')