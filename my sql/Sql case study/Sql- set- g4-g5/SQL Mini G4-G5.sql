#Datasets Used: Churn1.csv
#1.	Convert all decimal values in MonthlyServiceCharges to the smallest integer value that is greater than or equal to number.
select * from churn1;
select * , floor(MonthlyServiceCharges ) from churn1;
#2.	Convert SeniorCitizen (1 and 0) values to true and  false respectively.
select *, if(SeniorCitizen=1,'True','False')seniorcitizens from churn1;
#3.	Get the count of males and females respectively.
select gender,count(gender) from churn1 group by gender;
#Datasets Used: Names_Sub.csv
#1.	Get names and number of characters in the name string where the number of characters in the name is an even number.

#2.	Which is the most unique name used in Canada? 
#Datasets Used: products_u.csv, purchase_u.csv, user_data_u.csv
#Create a database : blackfridaysales
#1.	What is the product id of the most expensive product purchased by the user? 
select * from products_u;
select * from purchase_u;
select * from user_data_u;

select product_id ,max(purchase) from purchase_u;
#2.	Extract rows having null values in the product category 2 column. Replace the empty strings with NULL.
select * from products_u where Product_Category_2 is null;

#3.	People from which city category spent more during Black Friday Sales?
select  City_Category, sum(Purchase) from user_data_u a join purchase_u b using(user_id) group by City_Category order by  sum(Purchase) desc limit 1;
#4.	Categorize the users like; 
# Total purchase of users > 200000  : Platinum Members
# Total purchase of users in the range (50000, 200000)  : Gold Members
# Total purchase of users < 50000  : Casual Members
# Also sort the users in descending order according to their total purchases. ***
select * ,sum(purchase), if(sum(Purchase)>200000, 'platinum members',if(sum(purchase) between 50000 and 200000, 'gold members','casual members'))cust_type
from purchase_u group by User_ID;
#5.	If the marital status is 0 then show 'Single' else show 'Married' in a new column. Group the rows by user id. People from which age group spent more during the black friday sales?
select * from
(select a.user_id , if(marital_status=0,'single','married'),age , sum(purchase)sum2 from user_data_u a join purchase_u b
 using(user_id) group by User_ID) as tt group by age order by sum2 desc;


#Datasets Used: HR Schema

#6.	Write a Query to find the last day of the most recent job of every employee.

select employee_id,max(start_date), end_date from job_history group by employee_id;

#7.	Write a Query to find the maximum salary of the most recent job that every employee holds. 
select a.employee_id, max(start_date) , max(salary) from employees a join job_history b using(employee_id) group by employee_id order by max(salary) desc;
#8.	Write a Query to List the first designation and next promoted designation of all the employees in the company.

select a.employee_id,a.first_name,b.job_id,lead(b.job_id) over(partition by employee_id ) as nxt from employees as a join job_history as b using(employee_id);

#9.	Write a Query to calculate the cumulative distribution of Salary in the employees table.
select *, cume_dist() over(order by salary) from employees;
#10.	Write a Query to find the maximum salary of the most recent job that every employee holds. 

select a.employee_id,a.first_name,b.job_id,lead(b.job_id) over(partition by employee_id ) as nxt from employees as a join job_history as b using(employee_id);
