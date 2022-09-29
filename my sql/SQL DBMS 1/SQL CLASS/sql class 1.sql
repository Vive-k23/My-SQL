create table employee
(emp_id int,
name varchar(20),
dept varchar(20),
salary float
);
desc employee;
alter table employee drop dept;
alter table employee modify name varchar(10);
alter table employee change name name varchar(10);
alter table employee add designation varchar(15) after name;
drop table student;

insert into employee
values
(101,'swapnil','data analyst',400000),
(104,'mayur','data scentist',50000),
(105,'aman','sales executive',20000);
select * from employee;
update employee set designation ='data scientist'
where emp_id=101;
update employee set designation='sales'
where emp_id=101;
select * from employee where salary>20000 and designation='sales';

select *, salary+10000 from employee
where salary>50000;

select * from employee;


create table date_time
(dt date,
ti time,
dttime datetime
);
desc date_time;
insert into date_time values('2022/05/12','14:38','2022/05/12 14:38:05');
select * from date_time;
insert into date_time values(current_date(), current_time(), now());


use hr;
select salary, salary+2000 as additional_bonus from employees;

-- null--

select commission_pct,commission_pct*100 commission from employees;


select current_date() from dual; -- dual is dummy table available in SQL--
select current_date(),current_time() from dual; -- immediate data
select 1+2+3 from dual;

select 3+4 as 'sum' , 6*3 as 'multiple' from dual;

-- list records whose bonus more then 10000
select salary, salary+10000 as bonus from employees
where salary+1000>10000;


-- distinct rows
select employee_id,department_id from employees;
-- list distinct 
select distinct department_id from employees;
select distinct department_id,job_id from employees;
-- what are
select * from employees where job_id ='IT_PROG';
select department_id,hire_date from employees where first_name in ('Neena','bruce');
select department_id,hire_date from employees where first_name like'%Neena%';

select * from employees where manager_id is null;
select *,salary as annual from employees where job_id='IT_PROG' and salary>5000;


select * from employees where department_id not in(90,80,70);
select first_name,last_name,salary from employees;
use hr;
select department_name,department_id from departments where department_name like 'IT%';

-- order by-sorting
select employee_id,first_name,salary from employees
order by salary desc;
select employee_id,first_name,department_id,salary from employees
order by salary desc;
select first_name, last_name from employees where last_name like'%LI%'
order by first_name;

select first_name,department_id,hire_date from employees
order by department_id asc,hire_date desc;

-- Limit--
select * from employees limit 5;
select * from employees limit 1,1;

select * from employees limit 4,3;

select employee_id,first_name,last_name,job_id,salary from employees
order by salary desc limit 5 ;
select employee_id ,concat(first_name,last_name),job_id, salary from employees order by salary desc limit 5;

select * from employees where job_id='St_MAN'
order by salary desc limit 2,1;

select * from employees where salary>10000 limit 2;

-- FUNCTION--
-- single row Function--
-- 1 numeric function---
select round(45.9234,2),round(45.92,0); -- round--

select truncate(45.9234,2),truncate(45.92,1); -- truncate-- will not round off it will trim and give the data--

select floor(25.05); -- floor--- will give nearest whole number--
select floor(25.99);

select ceiling(25.99); -- ceiling --- will give nearest highest number--

select concat('welcome', ' ','to', ' ', 'sql');
select lower(concat(first_name, ' ', last_name))name from employees;

select substr('welcome to sql',9,2);  -- extract a string by indexing--
select length('Hello World');

select instr('Hello World','W'); --- index postion of the particular character in the string--

select lpad(salary,8,'*') from employees; -- use for formatting--

select replace('jack and jule','j','bl') replaced;

select length(trim(' welcome ')); -- will remove space


select employee_id,concat(first_name,last_name) name,job_id,length(last_name),instr(first_name,'a'),instr(last_name,'a') from employees
where job_id like'%REP%' and last_name like'%a%';
select employee_id,substring_index(first_name,1,3) from employees;


-- DATE FORMAT--


select period_diff(202208,202005);-- diference between two period

select adddate('2022/05/09',interval 1 day); -- will give new date at regular interval
select period_diff(202211,202212);
select adddate('2022/05/09',interval 2 day);
select subdate('2022/05/09',interval 1 year);-- will give back date at regular interval

select date_format(curdate(), '%d  %m %Y');
select date_format(curdate(),'%d %m %Y');
select date_format(curdate(), '%a');
select date_format(curdate(), '%c');
select date_format(curdate(), '%b %d');
select str_to_date("10 August 2020","%d %M %Y");
select current_date();
select date_format(curdate(),'%d %m %Y');
select date_format(curdate(),'%m %d %Y');
select date_format(curdate(),'%D% %M %y');
select str_to_date('05 11 2020 10 30 43','%m %d %Y %h %i %s');
select str_to_date('Wednesday May 11 2022','%W %M %d %y' );
select hire_date ,adddate(hire_date, interval  100 day),subdate(hire_date, interval  1 month) from employees where department_id=90;

-- list of employees join in year 1992
select * from employees where date_format(hire_date,'%Y')='1995';
select * from employees where date_format(hire_date,'%m')='01';
select * from employees where year(hire_date)=1995;
select * from employees where substr(hire_date,1,4)='1995';

-- control flow function--

 -- if(expr1,expr2,expr3) -If expr1 is True, return expr2,otherwise expr3
 
 select employee_id,salary, if(salary>10000, 'good','low') from employees;
 
 
 -- IFNULL(expr1,expr2) if expr is not null return expr1 otherwise expr2
 select commission_pct, ifnull(commission_pct,1)impute from employees;
 
 


select department_id, nullif(department_id, 100) from employees;

select salary, if(salary>15000,'good','bad')sal_grade from employees;

select employee_id,department_id,salary, ifnull(commission_pct,0) from employees
where department_id=80 or department_id=90;

-- case structure--
use hr;
select last_name,job_id,salary,
case
when salary<5000 then 'lower sal'
when salary<10000 then 'Medium level'
when salary<15000 then 'Good level'
else 'Better level'
end as "Grade level" from employees;
select employee_id, job_id ,salary,
case
when salary<5000 then 'lower'
when salary <10000 then 'medium'
when salary <15000 then 'good'
else 'better'
end as 'grade level' from employees;


-- sql constraints-- specify rules for data in table
-- not null-- cannot be a null value
-- Unique --does not allow duplicates in the table
-- primary key-- 
-- foreign key, 
-- check
-- default--
use hr;
create table author
(id int,
name varchar(10) not null default 'Mr.X',
country varchar(10) not null check(country in('USA','UK','UAE')),
page int check (page>0),
primary key(id)
);
desc author;
insert into author
(id,country,page)
values(101,'Uk',15);

show create table author;
select * from author;
select'mayur';
-- set operation--
select '* '
union
select '**'
union
select '***';

-- group function--

select count(*) from employees;
select count(employee_id)from employees;
select count(department_id)from employees;
select count(ifnull(department_id,0))from employees;

select avg(ifnull(commission_pct,0))from employees;
select count(distinct(department_id)) from employees;
use hr;

select salary,salary+2000 as bonus from employees;

select min(salary),max(salary) from employees;

-- COALESCE--
select commission_pct ,coalesce(commission_pct,0) from employees;
select commission_pct,manager_id ,coalesce(commission_pct),coalesce(manager_id) from employees;


-- grouop by--
-- no of people working for each department
set sql_mode='only_full_group_by';
select department_id, count(employee_id) from employees
group by department_id;


-- 
select department_id, count(employee_id) from employees where department_id in(80,100)
group by department_id;
-- 
select department_id,count(employee_id)employee_count,
case
when count(employee_id)=1 then'junior department'
when count(employee_id)in(2,3) then'intermediate department'
when count(employee_id)>3 then'senior department'
end as 'department' from employees where department_id is not null group by department_id;


-- having clause--
-- list those department_id where maximum salary>10000--
select department_id, max(salary)mx from employees
group by department_id
having mx>10000;

-- from
-- where
-- group by
-- having
-- select(distinct)
-- order by
-- limit
-- select,from,where,group having order by,limit
-- list the number of jobs available in  the organiasation
select distinct job_id from employees;
select sum(salary) from employees
group by department_id;
select employee_id ,avg(salary) from employees where department_id=50
group by employee_id;

select manager_id, min(salary)min_sal from employees
group by manager_id order by salary desc;

select department_id, max(salary)-min(salary)maxmin from employees 
group by department_id
having maxmin>2000;
select department_id, count(employee_id)mx from employees
group by department_id having mx>2;

-- joins--
select employees.first_name,employees.last_name,employees.department_id,departments.department_name from employees  join departments 
on employees.department_id=departments.department_id;

select first_name,last_name,e.department_id,d.department_name from employees as e join departments as d
on e.department_id=d.department_id;

select first_name,last_name,City,l.state_province,e.department_id,d.department_name from employees as e join departments as d
on e.department_id=d.department_id join locations as l on d.location_id=l.location_id;

select first_name,last_name,e.department_id,d.department_name from employees as e join departments as d
on e.department_id=d.department_id where e.department_id in(80,40);

select e.department_id,d.department_name from employees as e right join departments as d

on e.department_id=d.department_id;

select first_name,last_name,min_salary,max_salary,max_salary-min_salary as max_min,j.job_id,j.job_title from employees as e join jobs as j
on e.job_id=j.job_id;

select department_name,avg(salary),count(employee_id) from employees as e join departments as d
on e.department_id=d.department_id where commission_pct is not null group by department_name;

select first_name,last_name,j.job_id,department_id,max_salary-min_salary as max_min from employees as e left join jobs as j
on e.job_id=j.job_id where department_id=80;

-- Self join--

-- display the first name , last name 

select * from employees where salary;
select e.first_name,e.last_name,e.salary,e1.salary as salary1 from employees e join employees e1 
where e.salary<e1.salary and e1.employee_id=182;

select e.first_name as emp_first_name,e1.first_name as mgr_first_name from employees e join employees e1 where e.employee_id=e1.manager_id;
select d.department_name,count(e.employee_id) from employees e join departments d on e.employee_id=d.department_id
group by department_name;

select e.first_name,l.City from employees as e join departments d on e.department_id=d.department_id
join locations as l on l.location_id=d.location_id where l.city='london';

select e.first_name,e.hire_date,e1.hire_date,e1.manager_id from employees e join employees e1
 where e.hire_date>e1.hire_date and e.employee_id=e1.manager_id;
 
 select month(hire_date) mn,city,count(employee_id)cnt from employees e join departments d on e.department_id=d.department_id 
 join locations as l on l.location_id=d.location_id where city='seattle' group by mn having cnt>2;
 
 

 





