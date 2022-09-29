use inclass;

-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------

SELECT * FROM wine;

# Q1. Rank the winery according to the quality of the wine (points).-- Should use dense rank
	select *,dense_rank() over(order by points) from wine;
# Q2. Give a dense rank to the wine varities on the basis of the price.
select *,dense_rank() over(partition by variety order by  price desc) from wine;
# Q3. Use aggregate window functions to find the average of points for each row within its partition (country). 
-- -- Also arrange the result in the descending order by country.
select*, avg(points) over(partition by country order by country desc) from wine;
-----------------------------------------------------------------
# Dataset Used: students.csv
-- ---------------regions-----------------------------------------------

# Q4. Rank the students on the basis of their marks subjectwise.
select*,rank() over(partition by subject order by marks desc) from students;
# Q5. Provide the new roll numbers to the students on the basis of their names alphabetically.
select *,dense_rank() over(order by name)roll_no from students;
# Q6. Use the aggregate window functions to display the sum of marks in each row within its partition (Subject).
select *,sum(marks) over(partition by subject)total_marks_by_sub from students;
# Q7. Display the records from the students table where partition should be done 
-- on subjects and use sum as a window function on marks, 
-- -- arrange the rows in unbounded preceding manner.
select *,sum(marks) over(partition by subject rows unbounded preceding )total_marks_by_sub from students;
# Q8. Find the dense rank of the students on the basis of their marks subjectwise. Store the result in a new table 'Students_Ranked'
create table student_ranked as(select*,dense_rank() over(partition by subject order by marks desc)students_ranked from students);
select * from student_ranked;
-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
# Q9. Show day, number of users and the number of users the next day (for all days when the website was used)
select day,no_users,lead(no_users) over(partition by website_id) from website_stats;
# Q10. Display the difference in ad_clicks between the current day and the next day for the website 'Olympus'
select website_id, ad_clicks-lead(ad_clicks,1) over() from website_stats where website_id=(
select id from web where name='olympus');

# Q11. Write a query that displays the statistics for website_id = 3 such that for each row, show the day, the number of users and the smallest number of users ever.
with sql1 as(select * from website_stats where website_id= 3)
select day,no_users,min(no_users) over() from sql1;

# Q12. Write a query that displays name of the website and it's launch date. The query should also display the date of recently launched website in the third column.
select id,name,launch_date,max(str_to_date(launch_date, "%d-%m-%Y")) over() from web;



-----------------------------------------------------------------
# Dataset Used: play_store.csv and sale.csv
-----------------------------------------------------------------
# Q13. Write a query thats orders games in the play store into three buckets as per editor ratings received  
select*,ntile(3) over(partition  by editor_rating) from play_store;
# Q14. Write a query that displays the name of the game, the price, the sale date and the 4th column should display 
# the sales consecutive number i.e. ranking of game as per the sale took place, so that the latest game sold gets number 1. Order the result by editor's rating of the game
select id, name, price, date, editor_rating, dense_rank() over(order by str_to_date(date,'%d-%m-%Y')) as sold_date from play_store a join sale b using(id)
 order by editor_rating desc;
# Q15. Write a query to display games which were both recently released and recently updated. For each game, show name, 
#date of release and last update date, as well as their rank
#Hint: use ROW_NUMBER(), sort by release date and then by update date, both in the descending order
select name,released,updated,row_number() over() from play_store order by str_to_date(released,'%d-%m-%Y')desc, str_to_date(updated,'%d-%m-%Y')desc;
-----------------------------------------------------------------
# Dataset Used: movies.csv, customers.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q16. Write a query that displays basic movie informations as well as the previous rating provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.
select *,lag(rating) over(partition by movie_id) from movies join ratings using(id) order by customer_id ;
# Q17. For each movie, show the following information: title, genre, average user rating for that movie 
# and its rank in the respective genre based on that average rating in descending order (so that the best movies will be shown first).
select title, genre ,avg(editor_rating) over(partition by genre)avg_ratings , dense_rank()
 over(partition by genre order by editor_rating desc) from movies order by avg_ratings desc;
# Q18. For each rental date, show the rental_date, the sum of payment amounts (column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between these two values.
with sql1 as(select rental_date,sum(payment_amount) over(partition by str_to_date(rental_date,"%d-%m-%Y")) as payment_amt from rent)
select *, lag(payment_amt) over() lag_pmt, payment_amt - lag(payment_amt) over() as difference from sql1 