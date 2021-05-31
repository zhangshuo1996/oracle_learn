desc emp;

select empno, ename, job, sal
from dept
where sal >= 1500
order by job, sal desc;

select ename
from emp

-- 3-16
select empno, ename, job, sal
from emp
where sal >= 1500
order by job, sal desc

-- 3-21
select empno, ename, job, sal
from dept
where sal >= 1500
order by job, sal desc

--3-25
select empno, ename, job, sal
from emp
where sal >= 1500
order by job, sal desc


-- 3-31
select empno, ename, job, sal
from emp
where sal >= 1500
order by job, sal desc

-- 3-48
select e.last_name, d.department_name
from hr.employees e, hr.departments department_name
where e.department_id = d.department_id;


































