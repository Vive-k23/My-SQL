#SQL Set-G2
create database sql_case_study;
#Datasets Used: Names_Sub.csv
use sql_case_study;
select * from names_sub ;
#1.	Get names and number of characters in the name string where the number of characters in the name is an even number.
select name, length(name) as lenth from names_sub where length(name)%2=0 ;
#2.	Get the states and average of the Count column where the average of the Count column is greater than 80. Round the value of the Count column. 
select state ,avg(count) from names_sub  group by state having avg(count)>80  ;
#3.	Which is the most nonunique name used in Canada? 
select name,count(name) from names_sub where state like '%CA' group by name having count(name)>1;
#4.	Create a new table containing the people who were born in the year 1997.
create table people (select	name,Year from names_sub where Year=1997);
select * from people;
drop table people;
#5.	Display the records containing the people who were born between 1997 and 2000. 
select name, year from names_sub where year in
(select year from names_sub where year in(1997,2000));
#Datasets Used: HR Schema
use hr;
select * from employees;
#1.	Get employee id, employee first name, employee’s last name and their department name for those entries employee which belongs to at least one department
select distinct(a.employee_id) ,count(a.department_id), first_name , last_name , department_name from employees a join departments b 
using(department_id) group by employee_id having count(a.department_id) >=1;

#2.	Get the employee name and their manager name
select a.first_name,b.first_name from employees as a join employees as b on a.employee_id=b.manager_id;

#3.	get employee id,  first name, last name and their department name for all the employees regardless of whether they belong to any department or not
select a.employee_id  first_name , last_name ,department_id, department_name from employees a left join departments b using(department_id);
 
#4.	get all the departments name and employee id,  first name, and last name of all the employees belonging to the department regardless of whether a department have employees or not
select a.employee_id  first_name , last_name , department_name from employees a right join departments b using(department_id); 
#5.	Write a query in SQL to display the first and last name, department, city, and state province for each employee.
select * from 
(select first_name , last_name  from employees)as gg;
#6.	Write a query to find the first name, last name, and salary of all employees to add sequential integer number to each row.
select first_name , salary, row_number() over() from employees;
#7.	Write a query to find the employees whose have the highest salary in their departments
select first_name , last_name ,department_id, max(salary) from employees group by department_id order by max(salary);
#8.	Write a query to returns the employee’s salary and also the average salary of the employee’s department

select  first_name , last_name ,salary, avg(salary) over(partition by department_id)avg_sal_department from employees;
select * from employees;
#9.	Write a query to display row data preceding the current row department wise
select *, lag(department_id) over(range between unbounded preceding and current row ) from employees;
#10.	Write a Query to calculate the cumulative distribution of Salary in the employees table.
select *, cume_dist() over( order by salary) from employees;


