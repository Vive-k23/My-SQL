# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS Employee;
USE Employee;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;


#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.
select employee_id, first_name , last_name , salary from employee_details where salary>
(select avg(salary) from employee_details);

#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700
select first_name, last_name , department_id from employee_details where department_id in
(select department_id from department_details where LOCATION_ID=1700);

#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.

select employee_id , first_name, last_name, job_id , department_id from employee_details where department_id in
(select department_id from department_details where DEPARTMENT_NAME in('shipping','executive', 'finance'));
#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.
select employee_id , first_name, last_name, salary , phone_number , email from employee_details where job_id='st_clerk' and salary>any
(select salary from employee_details where JOB_ID='it_prog' );

#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.
select employee_id , first_name, last_name, salary , phone_number , email from employee_details where job_id='ac_accountant' and salary>all
(select salary from employee_details where JOB_ID='ad_vp');

#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees who have been recruited in the recent half timeline since the recruiting began. 
select employee_id , first_name , last_name,salary from employee_details where HIRE_DATE >
(select ((min(hire_date)/2 +max(hire_date)/2)) from employee_details); 
#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 
select employee_id , first_name, last_name, salary , phone_number , job_id from employee_details where department_id in
(select department_id from department_details where department_name like'%contracting%');

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department
select employee_id , first_name, last_name, salary , phone_number , job_id from employee_details where department_id in
(select department_id from department_details where department_name not like'%contracting%');


#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department
select employee_id , first_name, last_name, salary , HIRE_DATE, job_id, DEPARTMENT_ID from employee_details where (department_id, hire_date) in
(select department_id,min(hire_date) from employee_details group by department_id);


#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.
select employee_id , first_name, last_name, salary , job_id from employee_details where salary in
(select max(salary) from employee_details group by job_id);



