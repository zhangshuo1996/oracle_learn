set serverout on;

-- 4-3
declare
    v_desc varchar2(100) := '运动先驱--';
    v_pointer varchar2(25);
begin
    DBMS_OUTPUT.PUT_LINE (v_desc || v_pointer);
    v_pointer := '妲己';
    DBMS_OUTPUT.PUT_LINE (v_desc || v_pointer);
END;
/


-- 4-3
declare
    v_desc varchar2(100) := '运动先驱--';
    v_pointer varchar2(25) := '金莲';
begin
    DBMS_OUTPUT.PUT_LINE (v_desc || v_pointer);
    v_pointer := '妲己';
    v_desc := '职业女性';
    DBMS_OUTPUT.PUT_LINE (v_desc || v_pointer);
END;
/


-- 4-5
declare 
    v_special_day varchar2(250);
begin  
    v_special_day := q'!Happy International Women's day on 8th March to women!';
    DBMS_OUTPUT.PUT_LINE(v_special_day);
    v_special_day := q'[too many chinese people, qixi was celebrate to "lover's day".]';
    DBMS_OUTPUT.PUT_LINE(v_special_day);
END;
/

'


-- 4-
declare
    v_ename varchar2(25);
    v_total_sal NUMBER(12, 2) := 0;
    v_count  BINARY_INTEGER := 0;
    v_shipdate Date := SYSDATE + 21;
    c_tax_rate CONSTANT NUMBER(4,2) := 19.50;
    c_color CONSTANT varchar2(15) := 'white';
    v_flag BOOLEAN NOT NULL := FALSE;
    /

-- 4-6
declare 
    True_Love BOOLEAN := FALSE;
begin
    True_Love := NULL;
END;
/


-- 4-7
variable g_dog_weight NUMBER
begin
    :g_dog_weight := 38;
END;
/

print g_dog_weight


-- 4-9
variable g_ename varchar2(15)
variable g_sal NUMBER
variable g_job varchar2(10)
begin
    select ename, job, sal into :g_ename, :g_job, :g_sal
    from emp
    where empno = 7902;
END;
/

print g_ename
print g_job
print g_sal

print g_dog_weight


-- 4-14
select ename , job, sal
from emp
where empno = 7902;


-- 4-15
set verify off
set autoprint on
variable g_ename varchar2(15)
variable g_sal NUMBER
variable g_job varchar2(10)

declare
    v_empno NUMBER(5) := &empno;
begin
    select ename, job, sal into :g_ename, :g_job, :g_sal
    from emp
    where empno = &empno;
END;
/