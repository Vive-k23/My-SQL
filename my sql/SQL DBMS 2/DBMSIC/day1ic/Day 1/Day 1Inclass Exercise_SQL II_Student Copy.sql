# Dataset used: titanic_ds.csv
# Use subqueries for every question

#Q1. Display the first_name, last_name, passenger_no , fare of the passenger who paid less than the  maximum fare. (20 Row)
select first_name,last_name,Passenger_No from titanic_ds where fare<
(select max(fare) from titanic_ds);
#Q2. Retrieve the first_name, last_name and fare details of those passengers who paid fare greater than average fare. (11 Rows)
select first_name,last_name,Passenger_No from titanic_ds where fare>
(select avg(fare) from titanic_ds);
#Q3. Display the first_name ,sex, age, fare and deck_number of the passenger equals to passenger number 7 but exclude passenger number 7.(3 Rows)
 select first_name,sex,age,fare,DECK_NUMBER from titanic_ds where DECK_NUMBER=
 (select deck_number from titanic_ds where Passenger_No=7) and Passenger_No!=7;
#Q4. Display first_name,embark_town where deck is equals to the deck of embark town ends with word 'town' (7 Rows)
select first_name,last_name,embark_town from titanic_ds where deck in
(select deck from titanic_ds where embark_town  like '%town%');
# Dataset used: youtube_11.csv

#Q5. Display the video Id and the number of likes of the video that has got less likes than maximum likes(10 Rows)
select video_id , likes from youtube_11 where likes<
(select max(likes) from youtube_11);
#Q6. Write a query to print video_id and channel_title where trending_date is equals to the trending_date of  category_id 1(5 Rows)
select video_id, channel_title from youtube_11 where Trending_Date=
(select trending_date from youtube_11 where Category_id=1);
#Q7. Write a query to display the publish date, trending date ,views and description where views are more than views of Channel 'vox'.(7 Rows))
select publish_date , trending_date , views, description from youtube_11 where views>
(select views from youtube_11 where Channel_Title='vox');
#Q8. Write a query to display the channel_title, publish_date and the trending_date having category id in between 9 to Maximum category id .
# Do not use Max function(3 Rows)
select channel_title, publish_date,trending_date from youtube_11 where Trending_Date in
(select trending_date from youtube_11 where Category_id between 9 and 12);
#Q9. Write a query to display channel_title, video_id and number of view of the video that has received more than  mininum views. (10 Rows)
select channel_title , video_id, views from youtube_11 where views>
(select min(views) from youtube_11);
# Database used: db1 (db1.sql file provided)

#Q10. Get those order details whose amount is greater than 100,000 and got cancelled(1 Row))
select * from payments where amount>100000 and customerNumber in 
(select customerNumber from orders where status ='cancelled') group by customerNumber;


#Q11. Get employee details who shipped an order within a time span of two days from order date (15 Rows)
select * from employees where EmployeeNumber in(
(select salesRepEmployeeNumber from customers where customernumber in
(select customernumber from orders where shippedDate-orderdate<3)));
#Q12. Get product name , product line , product vendor of products that got cancelled(53 Rows)
select productName , productLine, productVendor from products where productCode in(
select productCode from orderdetails  where orderNumber in(
 select ordernumber from orders where status='cancelled'));
#Q13. Get customer full name along with phone number ,address , state, country, who's order was resolved(4 Rows)
 select * from customers where customerNumber in
 (select customernumber from orders where status='resolved');
#Q14. Display those customers who ordered product of price greater than average price of all products(98 Rows)
select * from customers where customerNumber in(
select customernumber from payments where amount>
(select max(msrp) from products)); 
#Q15. Get office deatils of employees who work in the same city where their customers reside(5 Rows)
select  * from employees where officeCode in(
select officecode from offices where city in
(select city from customers)) group by officeCode;
