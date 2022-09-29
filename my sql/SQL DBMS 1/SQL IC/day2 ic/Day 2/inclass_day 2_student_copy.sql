-- --------------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.
-- --------------------------------------------------------

# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.
 use bank;
 select * from cricket_1;
  select * from cricket_1;
 select Player_Id ,Player_Name from cricket_1 union select player_id, player_name from cricket_2;
 select player_Id,player_Name,Runs from cricket_1 union select player_id,player_Name,Runs from cricket_2;
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  --scored runs more than 50
select Player_Id ,Player_Name ,runs from cricket_1 where runs>50;
select player_Id,Runs,player_Name from cricket_1 where Runs>50;

# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.
select * from cricket_1 where Player_Name like 'y%v';
select player_Name from cricket_1 where player_Name like 'y%v';
# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.

 select player_Name from cricket_1 where player_Name not like '%t';
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------

# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio 
# of popularity to charisma .(Hint :- Popularity divide by Charisma)
use bank;
alter table cric_combined add column pc1_ratio decimal(10,2);
alter table cric_combined add PC_ratio decimal(10,2);
select * from cric_combined;
update cric_combined set pc1_ratio=Popularity/Charisma;
select * from cric_combined;
# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.
select Player_Name from cric_combined order by PC_ratio desc limit 5;
select * from cric_combined order by PC_ratio desc limit 5;
# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.

select player_ID,player_Name from cric_combined where player_Name like '%D%';
# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.
select player_ID,PC_ratio from cric_combined where PC_ratio between 0.12 and 0.25;
-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.

 select player_ID,player_Name from new_cricket where Charisma is null;
# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.
select Charisma , ifnull(Charisma,0) from new_cricket;
 select Charisma, ifnull(Charisma,0) from new_cricket;
# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).

 select player_Id,substr(Player_Id,3,1) from new_cricket;
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.
select player_ID,player_Name,Charisma from new_cricket where Charisma >25;
-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------

# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
# for those paymentmethod is through Electronic check mode.

select floor(MonthlyServiceCharges),ceiling(TotalAmount) from churn_details;
# Q14. Rename the table churn1 to “Churn_Details”.
rename table churn1 to Churn_Details;
desc Churn_Details;
# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.
alter table Churn_Details add new_amount decimal(10,2);
select * from Churn_Details;
update Churn_Details set new_amount=TotalAmount+MonthlyServiceCharges;
select * from Churn_Details;
# Q16. Rename column new_Amount to Amount.
alter table Churn_Details rename column new_amount to amount;
select * from Churn_Details;
# Q17. Drop the column “Amount” from the table “Churn_Details”.
alter table Churn_Details drop Amount;
select * from Churn_Details;

# Q18. Write a query to extract the customerID, InternetConnection and gender 
# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
# at the second position.
select customerID,InternetConnection,gender from Churn_Details where substr(InternetConnection,2,1)='i';


# Q19. Find the records where the tenure is 6x, where x is any number.

select tenure from churn_details where tenure like '6_';
# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.
select upper(Player_Name),ifnull(Charisma,0) from new_cricket
order by Player_Name asc;