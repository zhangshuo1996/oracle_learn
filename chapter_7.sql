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