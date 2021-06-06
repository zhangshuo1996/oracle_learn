-- 11-1
set serveroutput on
declare
    
    CURSOR emp_cursor IS
        SELECT *
        from emp;
    
BEGIN
    FOR emp_record IN emp_cursor LOOP
        IF emp_record.deptno = 20 
        THEN    
            DBMS_OUTPUT.PUT_LINE(emp_record.job || ' ' 
                || emp_record.ename || '在研发部门工作');
        END IF;
    END LOOP; -- 隐含关闭cursor
END;
/


-- 11-3
set serveroutput on
BEGIN
    FOR emp_record IN (SELECT * FROM emp) LOOP
        --隐含打开cursor ，并提取数据行
        IF emp_record.deptno = 20 
        THEN
            DBMS_OUTPUT.PUT_LINE(emp_record.job || ' ' 
                || emp_record.ename || '在研发部门工作');
        END IF;
    END LOOP;
END;
/

-- 11-4
set serveroutput on
declare 
    CURSOR dept_total_cursor IS 
        SELECT d.deptno, d.dname, e.av_salary, e.min_salary,
                e.max_salary, e.emp_total
        FROM dept d, (
            SELECT deptno, AVG(sal) av_salary, MIN(sal) min_salary, 
                    MAX(sal) max_salary, COUNT(*) emp_total
            FROM emp
            GROUP BY deptno            
        ) e
        WHERE d.deptno = e.deptno AND e.av_salary >= 2000;
BEGIN
    FOR dept_record IN dept_total_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(dept_record.deptno || ' ' || dept_record.dname
                            || ' ' || dept_record.av_salary
                            || ' ' || dept_record.min_salary
                            || ' ' || dept_record.max_salary
                            || ' ' || dept_record.emp_total);
    END LOOP;
END;
/

-- 11-5
set serveroutput on
declare 
    CURSOR dept_total_cursor IS 
        SELECT d.deptno, d.dname, e.av_salary, e.min_salary,
                e.max_salary, e.emp_total
        FROM dept d, (
            SELECT deptno, ROUND(AVG(sal), 2) av_salary, MIN(sal) min_salary, 
                    MAX(sal) max_salary, COUNT(*) emp_total
            FROM emp
            GROUP BY deptno            
        ) e
        WHERE d.deptno = e.deptno AND e.av_salary >= 2000
        ORDER BY d.deptno;
BEGIN
    FOR dept_record IN dept_total_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(dept_record.deptno || ' ' || dept_record.dname
                            || ' ' || dept_record.av_salary
                            || ' ' || dept_record.min_salary
                            || ' ' || dept_record.max_salary
                            || ' ' || dept_record.emp_total);
    END LOOP;
END;
/

-- 11-7
set serveroutput on
declare
    CURSOR emp_cursor (p_deptno NUMBER, p_job VARCHAR2) IS
        select * FROM emp_pl
        where deptno = p_deptno AND job = p_job
        ORDER BY empno;
    
    v_emp_record emp_cursor%ROWTYPE;

BEGIN
    -- OPEN emp_cursor(20, 'ANALYST');
    -- LOOP
    --     FETCH emp_cursor INTO v_emp_record;
    --     EXIT WHEN emp_cursor%NOTFOUND OR
    --                 emp_cursor%NOTFOUND IS NULL;
    --     DBMS_OUTPUT.PUT_LINE(v_emp_record.empno || ' ' ||
    --                         v_emp_record.ename || ' ' ||
    --                         v_emp_record.job || ' ' ||
    --                         v_emp_record.sal || ' ' ||
    --                         v_emp_record.deptno);
    -- END LOOP;
    -- CLOSE emp_cursor;

    FOR emp_record IN emp_cursor(70, '保安') LOOP
        DBMS_OUTPUT.PUT_LINE(v_emp_record.empno || ' ' ||
                            v_emp_record.ename || ' ' ||
                            v_emp_record.job || ' ' ||
                            v_emp_record.sal || ' ' ||
                            v_emp_record.deptno);
    END LOOP;
END;
/


-- 11-8  
declare 
    CURSOR emp_cursor IS
        SELECT empno, ename, sal
        FROM emp_pl
        where deptno = 70
        FOR UPDATE OF sal NOWAIT;

BEGIN
    OPEN emp_cursor;
END;
/

-- 11-9 使用新的会话执行
UPDATE emp_pl
set sal = 3838
WHEREdeptno = 70;


-- 11-11
SELECT empno, ename, job, sal, deptno
FROM emp_pl
WHERE deptno = 70;


-- 11-13
UPDATE emp_pl
set sal = 8888
WHERE empno = 7936;


-- 11-15
SELECT empno, ename, job, sal, deptno
FROM emp_pl
WHERE deptno = 70;


-- 11-16
declare
    CURSOR emp_cursor IS
        SELECT * FROM emp_pl
        WHERE deptno = 70
        FOR UPDATE OF sal NOWAIT;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        UPDATE emp_pl
        SET sal = emp_record.sal * 0.15
        WHERE CURRENT OF emp_cursor; -- 更新当前行
    END LOOP;
    COMMIT;
END;
/