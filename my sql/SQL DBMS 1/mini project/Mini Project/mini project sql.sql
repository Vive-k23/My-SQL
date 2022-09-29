use ipl;
 # 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
 select bidder_id, n/np*100 as win_percentage,bidder_name from (select bidder_id,count(bid_status)  n from ipl_bidding_details ib 
 where BID_STATUS='won' group by bidder_id) tt join
(select bidder_id,count(bid_status)as np from ipl_bidding_details ib group by bidder_id) tr using(bidder_id) join ipl_bidder_details
using(bidder_id)
order by win_percentage desc;
 
# 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
select i.stadium_id, stadium_name, city, count(STATUS)no_of_match from ipl_match_schedule ims join ipl_stadium i using(stadium_id)
 where status='completed' group by STADIUM_ID;
# 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
select yy.match_id,z*100/y as percent_win,l.stadium_name from (select  stadium_id,match_id,count(match_id) as y from ipl_match_schedule i join ipl_match j using(match_id) 
group by stadium_id ) as yy join (select match_id,count(match_id) as z from ipl_match_schedule i join ipl_match j using(match_id)
 where match_winner=TOSS_WINNER group by STADIUM_ID) tt join ipl_stadium l using(stadium_id)  group by STADIUM_ID;

 

# 4.	Show the total bids along with bid team and team name.
select bid_team, stadium_id, STADIUM_NAME, count(bid_status) from ipl_bidding_details ib
join ipl_match_schedule using(schedule_id) join ipl_stadium using(stadium_id) group by BID_TEAM;
# 5.	Show the team id who won the match as per the win details.
select WIN_DETAILS, MATCH_WINNER from ipl_match join ipl_match_schedule using(match_id) join ipl_team_standings
 using(TOURNMT_ID) group by WIN_DETAILS;
# 6.	Display total matches played, total matches won and total matches lost by team along with its team name.
select sum(matches_played), sum(matches_won), sum(matches_lost), team_name from ipl_team_standings 
join ipl_team using(team_id) group by team_id;
# 7.	Display the bowlers for Mumbai Indians team.
select player_name, player_role from ipl_team join ipl_team_players using(team_id) join ipl_player using(player_id) 
where PLAYER_ROLE='bowler'and TEAM_NAME='Mumbai Indians';
# 8.	How many all-rounders are there in each team, Display the teams with more than 4 
#all-rounder in descending order.
select count(player_role)all_rounder, team_name from ipl_team join ipl_team_players using(team_id) join ipl_player using(player_id)
where PLAYER_ROLE='All-Rounder'group by team_id having all_rounder > 4 order by all_rounder desc;
