# Pre-Requisites:
# Step 1 : Create table as below.

Create table Bank_Inventory_pricing ( Product CHAR(15) , Quantity INT, Price  Real ,
purchase_cost Decimal(6,2), Estimated_sale_price  Float,
Month int) ;

# Step2: 
# Insert records for above 
 Insert into Bank_Inventory_pricing values ( 'PayCard'   , 2 , 300.45, 8000.87, 9000.56, 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'PayCard'   , 2 , 800.45, 5000.80, 8700.56, 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'PayCard'   , 2 , 500.45, 6000.47, 7400.56, 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'PayPoints' , 4 , 390.87, 7000.67, 6700.56, 2)  ;
 Insert into Bank_Inventory_pricing values ( 'SmartPay' , 5  , 290.69, 5600.77, 3200.12 , 1)  ;
 Insert into Bank_Inventory_pricing values ( 'MaxGain',  3 , NULL, 4600.67, 3233.11 , 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'MaxGain',  6 , 220.39, 4690.67, NULL , 2 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 7 , 290.30, NULL, 3200.13 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 6 , 560.30, NULL, 4200.13 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 6 , NULL, 2600.77, 3200.13 ,2 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 9 , NULL, 5400.71, 9200.13 ,3 ) ;
 Insert into Bank_Inventory_pricing values ( 'SmartSav',   3 , 250.89, 5900.97, NULL ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SmartSav',   3 , 250.89, 5900.97, 8999.34 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SmartSav',   3 , 250.89, NULL , 5610.82 , 2 ) ;
 Insert into Bank_Inventory_pricing values ( 'EasyCash',   3 , 250.89, NULL, 5610.82 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'EasyCash',   3 , 250.89, NULL, 5610.82 , 2 ) ;
 Insert into Bank_Inventory_pricing values ( 'EasyCash',   3 , 250.89, NULL, 5610.82 , 3 ) ;
 Insert into Bank_Inventory_pricing values ( 'BusiCard'  ,  1, 3000.99 , NULL, 3500, 3) ; 
 Insert into Bank_Inventory_pricing values ( 'BusiCard'  ,  1, 4000.99 , NULL, 3500, 2) ; 

# Create table
Create table Bank_branch_PL
(Branch   varchar(15),
  Banker   Int,
  Product varchar(15) ,
  Cost  Int,
  revenue Int,
  Estimated_profit Int,   
  month  Int);
Insert into Bank_branch_PL values ( 'Delhi', 99101, 'SuperSave', 30060070, 50060070,  20050070, 1 ) ;
Insert into Bank_branch_PL values ( 'Delhi', 99101, 'SmartSav',   45060070, 57060070, 30050070, 2) ;
Insert into Bank_branch_PL values ( 'Delhi', 99101, 'EasyCash',   66660070, 50090090, 10050077, 3) ;
Insert into Bank_branch_PL values ( 'Hyd', 99101, 'SmartSav',   66660070, 79090090, 10050077, 3) ;
Insert into Bank_branch_PL values ( 'Banglr', 77301, 'EasyCash',   55560070, 61090090, 9950077, 3) ;
Insert into Bank_branch_PL values ( 'Banglr', 77301, 'SmartSav',   54460090, 53090080, 19950077, 3) ;
Insert into Bank_branch_PL values ( 'Hyd', 77301, 'SmartSav',   53060090, 63090080, 29950077, 3) ;
Insert into Bank_branch_PL values ( 'Hyd', 88201, 'BusiCard',  	40030070, 60070080, 10050070,1) ;
Insert into Bank_branch_PL values ( 'Hyd', 88201, 'BusiCard',  	70030070, 60070080, 25060070,1) ;
Insert into Bank_branch_PL values ( 'Hyd', 88201, 'SmartSav', 	40054070, 60070080, 20050070, 2) ;
Insert into Bank_branch_PL values ( 'Banglr', 99101, 'SmartSav',   88660070, 79090090, 10050077, 3) ;


############################################ Questions ############################################
use bank;
# Question 1:
# 1)  For every branch find the sum of calculated profit after ignoring the loss.   
/* Solution */
select Branch,sum(revenue)-sum(Cost) as cal_profit from bank_branch_pl group by Branch having cal_profit>0;
# Question 2:
# 2)  Find the average Estimated_ sale_price for each product  
/* Solution */
select product,avg(Estimated_sale_price)avg_sale_price from Bank_Inventory_pricing group by product;
# Question 3:
# 3)  Find the  month wise total quantity of each product
/* Solution */
select Month,product, sum(Quantity)TQ from Bank_Inventory_pricing group by product;
# Question 4:
# 4)  Find the maximum profit(Estimated_sale_price-Purchase_cost) for each product (Hint: Do not display loss).
/* Solution */
select product,max(Estimated_sale_price)-max(Purchase_cost)as max_profit from Bank_Inventory_pricing
 group by product having max_profit>0;
# Question 5:
# 5)  Find the minimum revenue for each banker if estimated_profit is greater than 20000000.
/* Solution */
select banker,Estimated_profit,min(revenue)min_rev from bank_branch_pl group by banker having Estimated_profit>20000000;
/* Pre-requisite */
## Use tables Bank_Inventory_pricing, Bank_branch_PL from Online_Day5_InClass to solve following queries

# Question 6:
# 6) Display the products and month where the total Quantity in Bank Inventory was more than 6.  
select Product,Month, sum(Quantity)TQ from Bank_Inventory_pricing group by product,month having TQ>6;

# Question 7:
# 7) IF Real profit is calculated as : 		Real Profit = revenue - cost  
	-- Find the branches for which branch level real profit is more than the estimated_profit.
select Branch,sum(revenue)-sum(Cost)Real_profit,sum(Estimated_profit)sum_est from bank_branch_pl
group by branch having Real_profit<sum_est;
# Question 8:
# 8) IF Real profit is calculated as : 		Real  Profit = revenue - cost  
	-- Display the name of the branch its total estimated profit, real profit after ignoring the loss.
select branch,Estimated_profit,sum(revenue)-sum(Cost)as Real_profit,sum(Estimated_profit)sum_est from bank_branch_pl 
group by branch having Real_profit>0;
# Question 9:
# 9)  Display the names of the product, banker and the branch that has incurred a loss. 
# Note : revenue - cost  is Loss if its value is -ve. 
select product,branch,banker,sum(revenue)-sum(Cost)as loss from bank_branch_pl group by Revenue having loss<0;
# Question 10:
# 10)  Display the name of the branch and product that has earned the least profit.
select branch,product,min(revenue-Cost)as Real_profit from bank_branch_pl group by Revenue having Real_profit>0;
# Question 11:
# 11)  Calculate the branch and product level total calculated profit where the calculated profit is more than the estimated profit after ignoring losses.
select Branch,product,revenue-Cost as cal_profit,Estimated_profit as sum_est from bank_branch_pl
group by Product  having cal_profit>sum_est ;
# Question 12:
# 12)  Display the names of the products whose calculated profits are almost equal to the estimated profit with a minimum difference of 10%.
select Branch,product,Estimated_profit,sum(revenue)-sum(Cost) as cal_profit,sum(Estimated_profit)sum_est from bank_branch_pl 
group by product having cal_profit*1.1>=0.9*sum_est;
# Question 13:
# 13) Display the name of the branch and products whose calculated profit exceeds the estimated profit even if the cost of product is reduced by 30%.
select Branch,product,Estimated_profit,sum(revenue)-sum(.7*Cost) as cal_profit,sum(Estimated_profit) from bank_branch_pl
group by Product having cal_profit>sum(Estimated_profit);

