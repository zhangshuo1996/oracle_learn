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

-- 11-4
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