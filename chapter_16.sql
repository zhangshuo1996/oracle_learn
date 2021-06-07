-- 16-1
CREATE OR REPLACE PACKAGE dept_pkg 
IS
    PROCEDURE add_dept  
        (p_deptno IN dept_pl.deptno%TYPE,
        p_name IN dept_pl.dname%TYPE DEFAULT '服务',
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇');
    PROCEDURE add_dept
        (p_name IN dept_pl.dname%TYPE DEFAULT '服务', 
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇');
END dept_pkg;
/


-- 16-2
CREATE OR REPLACE PACKAGE BODY dept_pkg
IS
    PROCEDURE add_dept
        (p_deptno IN dept_pl.deptno%TYPE,
        p_name IN dept_pl.dname%TYPE DEFAULT '服务',
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇')
    IS  
    BEGIN
        INSERT INTO dept_pl(deptno, dname, loc)
        VALUES (p_deptno, p_name, p_loc);
    END add_dept;

    PROCEDURE add_dept
     (p_name IN dept_pl.dname%TYPE DEFAULT '服务', 
        p_loc IN dept_pl.loc%TYPE DEFAULT '狼山镇')
    IS
    BEGIN
        INSERT INTO dept_pl(deptno, dname, loc)
            VALUES (deptid_sequence.NEXTVAL, p_name, p_loc);
    END add_dept;
END dept_pkg;
/


-- 16-3
SELECT * FROM dept_pl;

-- 16-4
EXECUTE dept_pkg.add_dept(38, '公关', '公主坟')


EXECUTE dept_pkg.add_dept('保安', '威虎山')


-- 16-13
CREATE OR REPLACE PACKAGE  BODY salary_pkg 
IS
    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER)
    IS 
    BEGIN
        IF validate(p_new_sal, p_grade)
        THEN
            v_std_salary := p_new_sal;
        ELSE
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
    
    FUNCTION validate (p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS 
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal
        INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;
END salary_pkg;
/


-- 16-14
CREATE OR REPLACE PACKAGE  BODY salary_pkg 
IS
    -- 前向声明
    FUNCTION validate(p_sal NUMBER, p_grade NUMBER) RETURN BOOLEAN;

    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER)
    IS 
    BEGIN
        IF validate(p_new_sal, p_grade)
        THEN
            v_std_salary := p_new_sal;
        ELSE
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
    
    FUNCTION validate (p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS 
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal
        INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;
END salary_pkg;
/

-- 16-16
CREATE OR REPLACE PACKAGE  BODY salary_pkg 
IS

    FUNCTION validate(p_sal NUMBER, p_grade NUMBER) RETURN BOOLEAN;

    PROCEDURE reset_salary(p_new_sal NUMBER, p_grade NUMBER)
    IS 
    BEGIN
        IF validate(p_new_sal, p_grade)
        THEN
            v_std_salary := p_new_sal;
        ELSE
            RAISE_APPLICATION_ERROR(-20038, '工资超限');
        END IF;
    END reset_salary;
    
    FUNCTION validate (p_sal NUMBER, p_grade NUMBER)
    RETURN BOOLEAN 
    IS 
        v_min_sal salgrade.losal%TYPE;
        v_max_sal salgrade.hisal%TYPE;
    BEGIN
        SELECT losal, hisal
        INTO v_min_sal, v_max_sal
        FROM salgrade
        WHERE grade = p_grade;
        RETURN (p_sal BETWEEN v_min_sal AND v_max_sal);
    END validate;

    BEGIN 
        SELECT AVG(sal)
END salary_pkg;
/