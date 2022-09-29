
###################### Use 'account_details' table from in-class exercise for below questions

# Q.1 Kim wants to pay Jeff 550 dollars after they both had lunch together. At the same time, GL NEWSLETTER is going to deduct 
# 150 dollars from Jeff's bank account as annual subscription. Write a query such that GL NEWSLETTER should be able to deduct the amount once Kim transfers 
# the amount to Jeff's account
# Solution: 
-- user1
use bank_details;
set autocommit=0;
set transaction isolation level read committed;
start transaction;
update acoount_details set balance= balance-550 where first_name='kim';
update account_details set balance= balance+550 where first_nmae='jeff';
commit;
-- gl newslater
use bank_details;
set autocommit=0;
set transaction isolation level read committed;
start transaction;
update acoount_details set balance= balance-150 where first_name='kim';
commit;


######################################################################################################################################
# Create table:
CREATE TABLE BANK_ACCOUNT ( Customer_id INT, 		   			  
							Account_Number VARCHAR(19),
							Account_type VARCHAR(25),
							Balance_amount INT ,
                            Account_status VARCHAR(10), 
                            Relationship_type varchar(1), 
                            Primary Key (Customer_id,account_type));
                            
# Insert records:
INSERT INTO BANK_ACCOUNT  VALUES (123001, "4000-1956-3456",  "SAVINGS"            , 200000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO BANK_ACCOUNT  VALUES (123002, "4000-1956-2001",  "SAVINGS"            , 400000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123003, "4000-1956-2900",  "SAVINGS"            ,750000,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "4000-1956-3401",  "SAVINGS"            , 655000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123005, "4000-1956-5102",  "SAVINGS"            , 300000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123006, "4000-1956-5698",  "SAVINGS"            , 455000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "5000-1700-9800",  "SAVINGS"            , 355000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "9000-1700-7777-4321",  "CREDITCARD"    ,0      ,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123008, "5000-1700-7755",  "SAVINGS"            ,NULL   ,"INACTIVE","P"); 

select * from bank_account; 

# Q.2 Write a lock query such that whenever an User X perform trasaction customer_id 123001 in table bank_account, it should only allow other users
# to read the table and not perfrom any transaction till the lock is released by User X
# Solution:
-- user x
use inclass2;
set autocommit=0;
start transaction;
select * from bank_account;
lock table bank_account read;
update bank_account set account_type='savings' where customer_id=123001; 
unlock tables;
commit;


-- user y
use inclass2;
set autocommit=0;
start transaction;
select * from bank_account;
update bank_account set account_type='savings' where customer_id=123001; 
commit;

############################################################################################################################################
# Q.3 A customer approaches a bank and wishes to open a new account. Unknonwingly two bankers try to perform same entries in the bank_account table
#Table: Bank_account
#customer_id : 123009
#Account_number : '5000-1700-9800'
#Account_type: 'SAVINGS'
#balance: 20000
#status: 'ACTIVE'
#relationship: 'P'
#How the avoid duplicate entry into the table when two users try to insert the same record at a time.
#Solution:	
use inclass2;
set autocommit=0;
start transaction;
select * from bank_account;
lock table bank_account write;
insert into bank_account values(123009 , '5000-1700-9800', 20000,  'SAVINGS' , 'P');
commit;

-- user2
use inclass2;
set autocommit=0;
start transaction;
select * from bank_account;
insert into bank_account values(123009 , '5000-1700-9800', 20000,  'SAVINGS' , 'P');
commit;
#############################################################################################################################################
-- ----------------------------------------------------
# Datset Used: admission_predict.csv
-- ----------------------------------------------------
# Q.4 A university is looking for candidates with GRE score between 330 and 340. Also they should be proficient in english 
#i.e. their Toefl score should not be less than 115. Create a view for this university.
#Solution:	
create view  university1 as select `gre score`, `TOEFL Score`  from admission_predict where `gre score` between 330 and 340 and `TOEFL Score`>115;
select * from university1;



# Q.5 Create a view of the candidates with the CGPA greater than the average CGPA.
#Solution:	
create view university2 as select *,avg(cgpa)  from admission_predict group by `gre score`  having cgpa>avg(cgpa);
select* from university2;
    
 #############################################################################################################################################
 
-- -------------------------------------------------------------------------------------
# Datsets Used: world_cup_2015.csv and world_cup_2016.csv 
-- -------------------------------------------------------------------------------------
# Q.6 Create a view "team_1516" of the players who played in world cup 2015 as well as in world cup 2016.
#Solution:	
create view team1516 as select a.Player_Name from world_cup_2015 a join world_cup_2016 b using(player_id);
select * from team1516;

create view team1516 as select player_id, player_name from world_cup_2015 where Player_Id in(select player_id  from world_cup_2016);
select * from team1516;
# Q.7 Create a view "All_From_15" that contains all the players who played in world cup 2015 but not in the year 2016Along with those players who played in both the world cup matches.
#Solution:	

create view all_form_15 as select * from world_cup_2015;
select * from all_form_15;


# Q.8 Create a view "All_From_16" that contains all the players who played in world cup 2016 but not in the year 2015 Along with those players who played in both the world cup matches.
#Solution:
create view all_form_16 as select * from world_cup_2016;
select * from all_form_16;


# Q.9 Drop multiple views "all_from_16", "all_from_15", "players_ranked"
#Solution:
drop view all_form_15, all_form_16;


