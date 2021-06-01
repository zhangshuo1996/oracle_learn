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
set serveroutput on
declare 
    v_dog_id NUMBER := 0;
begin
    v_dog_id := dog_seq.NEXTVAL;
    DBMS_OUTPUT.PUT_LINE('当前的狗号： ' || TO_CHAR(v_dog_id));
END;
/

-- 5-17
set serveroutput on
declare 
    v_dog_id NUMBER := 0;
begin
    SELECT dog_seq.NEXTVAL into v_dog_id
    FROM DUAL;
    DBMS_OUTPUT.PUT_LINE('当前的狗号是：  ' || TO_CHAR(v_dog_id));
END;
/

-- 5-18
set serveroutput on
declare
    v_dog_id NUMBER(8) := 8388;
    v_dog_service varchar2(10) := '1250';
    v_total_price v_dog_service%TYPE;
begin
    v_total_price := v_dog_service + v_dog_service;
    DBMS_OUTPUT.PUT_LINE('狗的实际售价为： ' || TO_CHAR(v_total_price));
END;
/


-- 5-20
set serveroutput on
declare
    x NUMBER := 38;
    y NUMBER := -28;
begin
    DBMS_OUTPUT.PUT_LINE(x);
    DBMS_OUTPUT.PUT_LINE(y);
    DBMS_OUTPUT.PUT_LINE(-x);
    DBMS_OUTPUT.PUT_LINE(-y);
    DBMS_OUTPUT.PUT_LINE(+x);
    DBMS_OUTPUT.PUT_LINE(+y);
    y := 10 ** 3;
    DBMS_OUTPUT.PUT_LINE(y);
END;
/


-- 5-21
set serveroutput on
declare
    v_mumdog_sex CHAR(1) := 'F';
    v_mumdog_weight NUMBER(5, 2) := 63;
begin
    declare
        v_babydog_sex CHAR(1) := 'M';
        v_babydog_weight NUMBER(5, 2) := 3.8;
    begin
        DBMS_OUTPUT.PUT_LINE(v_babydog_sex);
        DBMS_OUTPUT.PUT_LINE(v_babydog_weight);
        DBMS_OUTPUT.PUT_LINE(v_mumdog_sex);
        DBMS_OUTPUT.PUT_LINE(v_mumdog_weight);
    END;
    DBMS_OUTPUT.PUT_LINE(v_mumdog_sex);
    DBMS_OUTPUT.PUT_LINE(v_mumdog_weight);
END;
/

-- 5-22
-- 作用域的问题
declare
    v_mumdog_sex CHAR(1) := 'F';
    v_mumdog_weight NUMBER(5, 2) := 63;
begin
    declare
        v_babydog_sex CHAR(1) := 'M';
        v_babydog_weight NUMBER(5, 2) := 3.8;
    begin
        DBMS_OUTPUT.PUT_LINE(v_babydog_sex);
        DBMS_OUTPUT.PUT_LINE(v_babydog_weight);
        DBMS_OUTPUT.PUT_LINE(v_mumdog_sex);
        DBMS_OUTPUT.PUT_LINE(v_mumdog_weight);
    END;
    DBMS_OUTPUT.PUT_LINE(v_babydog_sex);
    DBMS_OUTPUT.PUT_LINE(v_babydog_weight);
END;
/

-- 5.23
declare
    v_dog_sex CHAR(1) := 'F';
    v_dog_weight NUMBER(5, 2) := 63;
begin
    declare
        v_dog_sex CHAR(1) := 'M';
        v_dog_weight NUMBER(5, 2) := 3.8;
    begin
        DBMS_OUTPUT.PUT_LINE(v_dog_sex);
        DBMS_OUTPUT.PUT_LINE(v_dog_weight);
        DBMS_OUTPUT.PUT_LINE('狗妈妈的性别为: ' || TO_CHAR(v_dog_sex));
        DBMS_OUTPUT.PUT_LINE('狗妈妈的体重为: ' || TO_CHAR(v_dog_weight));
    END;
    DBMS_OUTPUT.PUT_LINE(v_dog_sex);
    DBMS_OUTPUT.PUT_LINE(v_dog_weight);
END;
/
        
-- 5-24
begin  <<mumdog>>
declare 
    v_dog_sex CHAR(1) := 'F';
    v_dog_weight NUMBER(5, 2) := 63;
begin
    declare
        v_dog_sex CHAR(1) := 'M';
        v_dog_weight NUMBER(5, 2) := 3.8;
    begin
        DBMS_OUTPUT.PUT_LINE(v_dog_sex);
        DBMS_OUTPUT.PUT_LINE(v_dog_weight);
        DBMS_OUTPUT.PUT_LINE('狗妈妈的性别为: ' || TO_CHAR(mumdog.v_dog_sex));
        DBMS_OUTPUT.PUT_LINE('狗妈妈的体重为: ' || TO_CHAR(mumdog.v_dog_weight));
    END;
    DBMS_OUTPUT.PUT_LINE(v_dog_sex);
    DBMS_OUTPUT.PUT_LINE(v_dog_weight);
END;
END mumdog;
/


-- 5-25
<<mumdog>>
declare 
    v_dog_sex CHAR(1) := 'F';
    v_dog_weight NUMBER(5, 2) := 63;
begin
    declare
        v_dog_sex CHAR(1) := 'M';
        v_dog_weight NUMBER(5, 2) := 3.8;
    begin
        DBMS_OUTPUT.PUT_LINE(v_dog_sex);
        DBMS_OUTPUT.PUT_LINE(v_dog_weight);
        DBMS_OUTPUT.PUT_LINE('狗妈妈的性别为: ' || TO_CHAR(mumdog.v_dog_sex));
        DBMS_OUTPUT.PUT_LINE('狗妈妈的体重为: ' || TO_CHAR(mumdog.v_dog_weight));
    END;
    DBMS_OUTPUT.PUT_LINE(v_dog_sex);
    DBMS_OUTPUT.PUT_LINE(v_dog_weight);
END;
/


-- 5-26
set serveroutput on 
declare
    v_gender CHAR(1) := 'F';
    v_person varchar2(20);
begin
    IF v_gender = 'M' THEN v_person := '帅哥' ; ELSE v_person := '淑女'; END IF;
    DBMS_OUTPUT.PUT_LINE(v_person);
END;
/

-- 5-27
set serveroutput on 
declare
    v_gender CHAR(1) := 'F';
    v_person varchar2(20);
begin
    IF v_gender = 'M' THEN
        v_person := '帅哥'; 
    ELSE 
        v_person := '淑女'; 
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_person);
END;
/

