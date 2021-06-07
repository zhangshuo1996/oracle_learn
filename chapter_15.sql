-- 15-1
CREATE OR REPLACE PACKAGE salary_pkg
IS
    v_std_salary NUMBER := 1380;
    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER);
END salary_pkg;
/

-- 15-2
SET serveroutput ON
BEGIN  
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 15-3
BEGIN
    salary_pkg.v_std_salary := 1111;
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

DESC salgrade

SELECT * FROM salgrade;

-- 15-6
CREATE OR REPLACE PACKAGE BODY salary_pkg
IS
    FUNCTION validate(p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE  grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;

    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER) 
    IS
    BEGIN
        IF validate(p_new_sal, p_grade) THEN
            v_std_salary := p_new_sal;
        ELSE    
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
END salary_pkg;
/

-- 15-7
SET serveroutput ON
BEGIN 
    salary_pkg.reset_salary(2250, 4);
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/


-- 15-8
EXECUTE salary_pkg.reset_salary(2250, 4);


-- 15-9
BEGIN
    DBMS_OUTPUT.PUT_LINE(salary_pkg.v_std_salary);
END;
/

-- 15-10
EXECUTE salary_pkg.reset_salary(1999, 4);

-- 15-11
connect system/wang