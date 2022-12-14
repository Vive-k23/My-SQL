#Section B --> Know the business 			

#1.	Arrange the product id, product name based on high demand by the customer.
select id ,total_quantity , productname from
(select id, sum(Quantity)total_quantity from orderitem group by id) as gg join product using(id) order by total_quantity desc;
#2.	Display the number of orders delivered every year.
select count(id) , year(orderdate) from orders group by year(orderdate) ;
#3.	Calculate year-wise total revenue.
select sum(TotalAmount) , year(orderdate) from orders group by year(orderdate) ;
#4.	Display total amount ordered by each customer from high to low.
select sum(TotalAmount) , customerid from orders group by customerid order by  sum(TotalAmount) desc;
#5.	A sales and marketing department of this company wants to find out how frequently customer have business with them. List the current and previous order amount for each customer.
select customerid ,ordernumber ,TotalAmount, lag(TotalAmount) over(partition by customerid)as previous_pmt_order from orders ;
#6.	Find out top 3 suppliers in terms of revenue generated by their products.
select productid , total_revenue ,supplierid from
(select  productid ,(unitprice*quantity)total_revenue from orderitem)as gg join product b on gg.ProductId=b.id group by productId order by total_revenue desc limit 3;

# Section C --> Business Analysis 			

#1.	Display all the product details with the ordered quantity size as 1.
select * from product where id in
 (select ProductId from orderitem where quantity=1);

#2.	Display the compan(y)ies which supplies products whose cost is above 100.
select companyname from supplier where id in
(select productid from orderitem where UnitPrice>100);

#3.	Create a combined list to display customers and supplier list as per the below format.

select 'customer' as type, FirstName, city , country , phone from customer
union
select ' supplier' as type ,contactname, city , country , phone from supplier;

# Section D --> Challenge 					

#1.	Company sells the product at different discounted rates. Refer actual product price in product table and selling price in the order item table. Write a query to find out total amount saved in each order then display the orders from highest to lowest amount saved. 
select * , (sp-cp) from
(select orderid , (a.unitprice* b.quantity)cp ,  (b.unitprice* b.quantity)sp from product a join orderitem b using(id)) as gg order by (sp-cp) desc ;
#2.	Mr. Kavin want to become a supplier. He got the database of "Richard's Supply" for reference. Help him to pick: few products that he should choose based on demand.
select productid , sum(quantity)most_demanded from orderitem group by productid order by most_demanded desc limit 5;


#3.	Every supplier supplies specific products to the customers. Create a view of suppliers and total sales made by their products  and write a query on this view to find out top 2 suppliers(using windows function RANK () ) in each country by total sales done by the product
create view  suppliers as select * from
(select *, rank() over(partition by country order by total_sales desc)rank1 from
(select productid , productname, sum(a.unitprice*Quantity)total_sales , contactname , country from orderitem a join product b on 
a.ProductId=b.id join supplier c on b.SupplierId=c.id group by productid ) as tt ) as gg having rank1 between 1 and 2 ;

select * from suppliers;

