CREATE SCHEMA IF NOT EXISTS Video_Games;
USE Video_Games;
SELECT * FROM Video_Games_Sales;
SELECT * FROM play_store;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.

select name,platform,round(sum(na_sales),3) as total from video_games_sales group by platform;
select name , platform , sum(na_sales) over( partition by platform order by platform ) from video_games_sales;


# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales
#,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.

/*select name,platform,genre,sum(na_sales) over (partition by genre) as genre_sales ,sum(global_sales) over( partition by platform) as platform_sales,sum(global_sales) over ()
 as total_sales from video_games_sales ;*/



# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.

select *, row_number() over(partition by platform order by year_of_release desc) from video_games_sales;
# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). 
#Also arrange the result in the descending order by year of release.
   
   select *,avg(global_sales) over(partition by year_of_release) from video_games_sales order by year_of_release desc;

# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 

select name, platform ,dense_rank() over(partition by publisher order by critic_score ) as frank from video_games_sales;


------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date

# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.


-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.
