#section A --> Know your data                                  Time: 45 minRead the Section A --> Know your data                                  Time: 45 min
#1.	Read the data from all tables.
select * from customer;
select * from Orders;
select * from Supplier;
select * from Product;
select * from OrderItem;

#2.	Find the country wise count of customers.
select country, count(id) from customer group by country;
#3.	Display the products which are not discontinued.
select ProductName, isdiscontinued  from product where isdiscontinued=0;
#4.	Display the list of companies along with the product name that they are supplying.
select id, companyname , productname from
(select id, companyname from supplier) as tt join product using(id);
#5.	Display customer's information who stays in 'Mexico'
select * from customer where country='mexico';
#6.	Display the costliest item that is ordered by the customer.
select id, productname , max(unitprice) from product;

#7.	Display supplier id who owns highest number of products.
select supplierid , count(id) from product group by SupplierId order by count(id) desc limit 2;
#8.	Display month wise and year wise count of the orders placed.
select count(OrderNumber) ,month(orderdate) , year(orderdate) from orders group by month(orderdate) , year(orderdate);
#9.	Which country has maximum suppliers.
select id, count(SupplierId), country from
(select id , country  from supplier) as tt join product using(id) group by Country order by count(supplierid) desc limit 1;

#10.	Which customers did not place any order.

 select id, firstname, lastname from customer where id not in(select CustomerId from orders);
 
 
# Use the Classicmodels Schema to solve the below problems.


#1.	Using Classicmodels schema, Generate a report with all the order_number, status and the total sales. (orderdetails and orders)
select * from orderdetails;
select * from orders;
select ordernumber , status , (priceEach*quantityOrdered)totalsales from orderdetails a join orders b using(ordernumber);

#2.	Using Classicmodels schema, Generate a report with all the customers and their order details and products ordered. (customers,orders,orderdetails)
select * from customers;
select * from orderdetails;
select * from orders;

select a.customernumber , customername , b.ordernumber , status , productCode , quantityordered , priceeach from customers a join orders b using(customernumber)
join orderdetails c using(ordernumber);

# 3.	A Retail Store XYZ recently started up in the locality. After 3 months of running the store successfully, during analysis the store manager has observed that some products were unsold. The product was not sold even once to any customer. Retail store wants to release some offers on such products. Make a list of such products for the manager.(products and orderdetails)
select productCode , productname from products where productcode not in (select productcode from orderdetails);

select a.productCode , b.productCode, productname from products a left join orderdetails b on a.productCode=b.productCode where b.ordernumber is null;

# 4.	A Shopping ecommerce site recently performed a detailed analysis of the data. It needs a report on the list of inactive customers. The company is planning on releasing offers to convert the inactive customers into active.Make a list of such names.(customers,orders)
select customernumber, customername from customers where customernumber not in
(select customernumber from orders);

select  customernumber , customername from orders a right join customers b using(customernumber) where a.ordernumber is null;


#5.	Using Classicmodels schema, Generate a report with all the customers their ids, names and lifetime sales from the customer.(customer,payments)
select a.customernumber , customername , sum(amount) from customers  a join payments b using(customernumber) group by customerNumber;

# Use the Classicmodels Schema to solve the below problems on SubQueries.
#1.	A Retail Store XYZ recently started up in the locality. After 3 months of running the store successfully, during analysis the store manager has observed that some products were unsold. The product was not sold even once to any customer. Retail store wants to release some offers on such products. Make a list of such products for the manager. .(products and orderdetails)
select productCode , productname from products where productcode not in (select productcode from orderdetails);
#2.	A Shopping ecommerce site recently performed a detailed analysis of the data. It needs a report on the list of inactive customers. The company is planning on releasing offers to convert the inactive customers into active.Make a list of such names. (customers,orders)
select customernumber, customername from customers where customernumber not in
(select customernumber from orders);

#3.	Generate a list of top 10 customers who have done maximum payments to the store. (customer and payments)
select customernumber, customername ,sum(amount) from
(select customernumber, customername from customers) as tt join payments using(customernumber) group by customerNumber order by sum(amount) desc limit 10;
#4.	Generate a list of employees who had assisted the cutomers to place orders that were shipped within a span of 1 day of order getting placed.(employees, customers and orders)
select firstname, lastname, employeenumber from employees where employeeNumber in
(select salesRepEmployeeNumber from customers where customernumber in
(select customernumber from orders where shippedDate - orderDate<=1));

select a.customernumber, customername from orders a join customers b on a.customerNumber=b.customerNumber
 join employees c on b.salesRepEmployeeNumber=c.employeeNumber where shippedDate - orderDate<=1;
#5.	Generate a list of product lines which are always ordered in bulk of more than 50 nos. (productline, products)
select distinct productline from products where productCode in 
(select productcode from orderdetails where quantityOrdered>50);

#Use the Classicmodels Schema to solve the below problems on WindowFunctions.

#1.	For every customer, Get the details of all the orders placed by them and the date on which he/she had placed an order for the first time.
select customernumber , min(orderdate) over(partition by customernumber) from orders ;

#2.	For the list of products in the products table, get the Quantities ordered in each order and most recent order Quantity.
select productcode , ordernumber, productname, sum(quantityOrdered) over(partition by ordernumber order by orderdate desc)qantity from products a join orderdetails b
 using(productcode) join orders c using(ordernumber);
;
#3.	Get the details of the employees, the details of the customers to whom they have assisted in placing orders, along with the current orderDate and the next order placed. 

select employeenumber , firstname, lastname ,customerName, orderdate , lead(orderdate) over() from employees a join customers b
on a.employeenumber=b.salesRepEmployeeNumber join orders c on b.customerNumber=c.customerNumber;
#4.	Generate a list of customers along with the dates on which they have made payments, and the previous payment dates. Filter out such customers who have done consecutive payments within a span of 30 days.
select * from
(select customernumber, paymentdate , lag(paymentdate) over(partition by customernumber order by paymentdate desc)payment_date ,
 abs(datediff(paymentDate ,lag(paymentDate) over(partition by customernumber)))payment_less_30 from payments) as tt join
 customers using(customernumber) where payment_less_30<30;
 
#5.	Write a Query to list the order dates and the cumulative distribution of the order Quantities for the every date.
