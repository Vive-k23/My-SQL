--------- SQL WEEK 2 -----------------
---- write a query to list the employees who works in the sales 
use hr;
select employee_id,department_id,department_name from employees join departments using(department_id) where department_name='sales';
 ---- using subquery-----
select * from employees where department_id=( select department_id from departments where department_name='sales');
select avg(salary) from employees where department_id=( select department_id from departments where department_name='sales');

select count(employee_id) from employees where salary>(select salary from employees where first_name='susan');
select employee_id from employees where department_id!=(select department_id from employees where first_name='den');

select employee_id from employees where salary<(select salary from employees where first_name='Gerald');

select employee_id from employees where department_id in(select department_id from departments where department_name in('sales','finance'));

select employee_id,first_name,salary from employees where salary>all(select salary  from employees where hire_date like '%2000%');

select * from employees where salary>all(select avg(salary) from employees);


select employee_id,first_name from employees where job_id like '%sa_rep%'and salary>any
(select salary from employees where job_id like '%sa_man%');

select employee_id,first_name from employees where salary<any(select salary from employees where job_id like '%sh_clerk%');
select * from employees where department_id in(
select department_id from departments where location_id=(
select location_id from locations where city='seattle'));


select location_id, city,state_province from locations where country_id in(
select country_id from countries where region_id=(
select region_id from regions where region_name='asia'));



select department_id from employees where first_name='gerald';

select * from employees where (salary,department_id)=(select salary,department_id from employees where first_name='gerald');

select * from employees where (salary,department_id)=(select salary, department_id from employees where salary between 10000 and 20000 and 
department_id in(10,20));
select min(q.salary) from
(select salary,first_name from employees order by salary desc limit 5) q;

select count(q.employee_id) from
(select employee_id from employees where first_name like 'a%')q;

select avg(salary) avg_sal , department_id from employees group by department_id having avg_sal>
(select salary from employees where first_name = 'lex' );


create table employee1(
employee_id int,
first_name varchar(10),
salary int,
department_id int
);
insert into employee1(
select employee_id ,first_name, salary,department_id from employees where first_name like 'a%');

select * from employee1;
select * from employees j where salary<
(select avg(salary) from employees i where i.department_id=j.department_id group by department_id);

select * from employees where salary<all
(select avg(salary) from employees);


select * from employees j where exists (select * from employees i where i.manager_id=j.employee_id);

select * from departments i where exists(select salary from employees j where j.department_id=i.department_id 
 group by department_id having salary>4000);


select *   from employees i where exists(select * from job_history j where j.employee_id=i.employee_id);

--- window function---------Day-2---------
select * ,sum(salary) over(partition by department_id) from employees;

select department_id , sum(salary) over() from employees;
select department_id , sum(salary) over(partition by department_id) from employees;

select *,row_number() over(partition by department_id)rowss from employees;

select *,row_number() over(partition by department_id order by salary )rowss from employees;



select *,rank() over(order by salary) from employees;

select *,dense_rank() over(partition by department_id order by salary) from employees;

select*, row_number() over(partition by salary), rank() over(order by salary), dense_rank() over(order by salary) from employees where department_id in(60,90);


select *,ntile(10) over(partition by department_id)bins from employees;
select*,lag(salary) over() from employees;

select*,lag(salary) over(partition by department_id)deptsalary from employees;

select*,lag(salary,2) over(partition by department_id)deptsalary from employees;

select*,lag(salary,2,100) over(partition by department_id)deptsalary from employees;

 select*,lag(salary,2,200) over(partition by department_id)deptsalary from employees;
 
 select *,lag(salary) over(partition by department_id)as deptsalary,
salary-lag(salary) over(partition by department_id)diff_deptsalary from employees;
 
 select salary,lead(salary) over(partition by department_id) from employees;
 
 select *,first_value(salary) over() from employees;
 
 select *,first_value(salary) over(partition by department_id) from employees;
 
  select *,first_value(salary) over(partition by department_id order by salary asc) from employees;
  
  select *, first_value(start_date) over(partition by employee_id order by start_date asc)start_date from job_history group by employee_id;
  
  select distinct employee_id, last_value(start_date) 
  over(partition by employee_id order by start_date range between unbounded preceding and unbounded following)
  start_date from job_history;
  
   select *,  last_value(first_name) over(partition by department_id order by salary asc
  range between unbounded preceding and unbounded following)first_name from employees;
  
  select *, last_value(salary) over(partition by department_id order by salary asc
  range between unbounded preceding and unbounded following)highest_salary,
   last_value(first_name) over(partition by department_id order by salary asc
  range between unbounded preceding and unbounded following)first_name from employees;
  
  select *,nth_value(first_name,2) over(partition by department_id order by salary desc)
  from employees;
  
  select*,percent_rank() over(order by salary)percentrank from employees where department_id=50;
  
  select*,percent_rank() over(order by salary)percentrank,
  cume_dist() over(order by salary) as cumrank from employees where department_id=50;

  select *,count(*) over(partition by department_id) from employees;
  
  select*, sum(salary) over(partition by department_id) from employees;
  
  select*, sum(salary) over(partition by department_id) from employees where department_id in(30,40);
  
  select*, sum(salary) over(rows between 2  preceding and 3  following) as sum1,
  sum(salary) over(rows between 5  preceding and 6 following) as sum2,
  sum(salary) over(rows between 1  preceding and 3 following) as sum3
  from employees;
  --- running total---
  
   select*, sum(salary) over(partition by department_id order by salary range between unbounded  preceding and current row) as sum1,
  sum(salary) over(partition by department_id order by salary range between unbounded  preceding and current row) as sum2,
  sum(salary) over(partition by department_id order by salary range between unbounded  preceding and current row) as sum3
  from employees;
  
  --- running avg------
   select*, avg(salary) over(partition by department_id order by salary range between unbounded  preceding and current row) as avg1,
  avg(salary) over(partition by department_id order by salary range between unbounded  preceding and current row) as avg1,
  avg(salary) over(partition by department_id order by salary range between unbounded  preceding and current row) as avg1
  from employees;
  
  
   --- common table expression----CTE------
  with sq1 as( select * from employees where job_id='it_prog')
  select * ,avg(salary) over(), rank()  over(order by salary)  from sq1;
  
 
with sq2 as(select*,max(salary) over(partition by department_id)hh from employees)
select *from sq2 where salary=hh;

create table ranking(select *,dense_rank() over(partition by department_id order by salary desc) as dd from employees);
select * from ranking;

------ normalisation------

---- Transaction ----
create database sql2;
use sql2;
create table student
(student_id int not null primary key,
subject varchar(20),
name varchar(20)

);
create table student_parent
(parent_id int ,
name varchar(20),
proffesion varchar(10),
foreign key(parent_id)  references student(student_id) on update set null on delete cascade
);

insert into  student values
(101,'mayur','math'),
(102,'swapnil','science');
select * from student;

insert into student_parent  values
(101,'vallabh bhai','IT'),
(102,'ishwarbhai','business');
select * from student_parent;

delete from student where student_id=101;
update student set student_id=102 where student_id=101;


use sql2;
set autocommit=0;
start transaction;
create table swapnilmc(id int, name varchar(10));
insert into swapnilmc values(101, 'mayur');
insert into swapnilmc values(102, 'swapnil');
commit;
select * from swapnilmc;
insert into swapnilmc values(103, 'gaurav');
rollback;
select * from swapnilmc;
delete from swapnilmc where id=101;
rollback;
select * from swapnilmc;


---- locking levels------

----- view-----

-- simple
--- complex
--- join
---- group
--- horizontal
----- vertical
---- row column view
----- in line view

create view employee_view as select first_name,last_name,email,phone_number, hire_date from employees;
select * from employee_view;


create view employee_view as select * from employees ;
select * from employee_view;

rename table employee_view to employee5;

  create view employee6 as select * from employees where salary >6000 ;
  
select * from employee6;

create view emp_now as select first_name, last_name,a.department_id,department_name from employees as a join departments b using(department_id);
select * from emp_now;

create view emp_now2 as select first_name,sum(salary) last_name,a.department_id,department_name,job_id from employees as a join departments b using(department_id) 
where salary>10000 group by department_id;
select * from emp_now2;




