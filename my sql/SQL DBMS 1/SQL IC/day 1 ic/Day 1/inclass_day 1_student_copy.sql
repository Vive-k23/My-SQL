# Question 1:
# 1) Create a Database Bank.
create database bank;
use bank;


# Question 2:
# 2) Create a table with the name “Bank_Inventory” with the following columns
-- Product  with string data type and size 10 --
-- Quantity with numerical data type --
-- Price with data type that can handle all real numbers
-- purcahase_cost with data type which always shows two decimal values --
-- estimated_sale_price with data type float --


create table bank_inventory(
product varchar(10), quantity int , price real , purchase_cost decimal(10,2) , estimated_sale_price float);

-- drop table bank_inventry






# Question 3:
# 3) Display all column names and their datatype and size in Bank_Inventory.
desc bank_inventory;
# Question 4:
# 4) Insert the below two records into Bank_Inventory table .
-- 1st record with values --
			-- Product : PayCard
			-- Quantity: 2 
			-- price : 300.45 
			-- Puchase_cost : 8000.87
			-- estimated_sale_price: 9000.56 --
-- 2nd record with values --
			-- Product : PayPoints
			-- Quantity: 4
			-- price : 200.89 
			-- Puchase_cost : 7000.67
			-- estimated_sale_price: 6700.56
            
            
insert into bank_inventry values
('paycard','2','300.25','8000.87','9000.56'),('paypoints','4','200.89','7000.67','6700.56');
insert into bank_inventory values ('paycard','2','300.25','8000.87','9000.56'),('paypoints','4','200.89','7000.67','6700.56');
select * from bank_inventory;
# Question 5:
# 5) Add a column : Geo_Location to the existing Bank_Inventory table with data type varchar and size 20 .


alter table bank_inventory add geo_location varchar(20);
select * from bank_inventory;
# Question 6:a
# 6) What is the value of Geo_Location for product : ‘PayCard’?

select geo_location from bank_inventory where product='paycard';
# Question 7:
# 7) How many characters does the  Product : ‘PayCard’ store in the Bank_Inventory table.

select length('product');
# Question 8:
# a) Update the Geo_Location field from NULL to ‘Delhi-City’ 

update bank_inventry set geo_location='delhi-city';
update bank_inventory set geo_location ='delhi_city';
select * from bank_inventry;
# b) How many characters does the  Geo_Location field value ‘Delhi-City’ stores in the Bank_Inventory table

select length('delhi-city');
# Question 9:
# 9) update the Product field from CHAR to VARCHAR size 10 in Bank_Inventory 

alter table bank_inventry modify product char(10);
alter table bank_inventory modify product char(10);
desc bank_inventory;
# Question 10:
# 10) Reduce the size of the Product field from 10 to 6 and check if it is possible. 

alter table bank_inventry modify product char(6);
desc bank_inventry;
# Question 11:
# 11) Bank_inventory table consists of ‘PayCard’ product details .
-- For ‘PayCard’ product, Update the quantity from 2 to 10  

update bank_inventry set quantity=10
where product='paycard';
update bank_inventory set quantity=10 where product='paycard';
select *  from bank_inventory;
 # Question 12:
# 12) Create a table named as Bank_Holidays with below fields 
-- a) Holiday field which displays or accepts only date 
-- b) Start_time field which also displays or accepts date and time both.  
-- c) End_time field which also displays or accepts date and time along with the timezone also. 
create table bank_holidays(
holiday date , start_time datetime , end_time timestamp);

desc bank_holidays;
 # Question 13:
# 13) Step 1: Insert today’s date details in all fields of Bank_Holidays 
-- Step 2: After step1, perform the below 
-- Postpone Holiday to next day by updating the Holiday field 
insert into bank_holidays values(curdate(),current_time(),current_timestamp());
# Question 14:
# 14) Modify  the Start_time data with today's datetime in the Bank_Holidays table 
update bank_holidays set holiday =adddate(holiday,interval 1 day );
update bank_holidays set holiday= holiday+1;
select * from bank_holidays;


# Question 15:
# 15) Update the End_time with UTC time(GMT Time) in the Bank_Holidays table. 
update bank_holidays set end_time=utc_timestamp();
select * from bank_holidays;

# Question 16:
# 16) Select all columns from Bank_Inventory without mentioning any column name
select * from bank_inventory;
describe bank_inventory;
# Question 17:
# 17)  Display output of PRODUCT field as NEW_PRODUCT in  Bank_Inventory table 
alter table bank_inventry modify product varchar(20);
update bank_inventory set product='new_product' where product in('paycard','paypoints');
select * from bank_inventory;

# Question 18:
# 18)  Display only one record from bank_Inventory 

select * from bank_inventry where product='paycard';
# Question 19:
# 19) Modify  the End_time data with today's datetime in the Bank_Holidays table 


update bank_holidays set end_time=current_timestamp();
select * from bank_holidays;
# Question 20:
# 20) Display the first five rowss of the Geo_location field of Bank_Inventory.

select geo_location from  bank_inventory limit 5;