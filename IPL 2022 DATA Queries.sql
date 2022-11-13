select * from IPL_Ball_by_Ball_2022$

select * from IPL_Matches_2022$

select distinct venue from IPL_Matches_2022$;

-- Most_Matches_Winning Team while Batting first

select WinningTeam, count(WinningTeam) Most_Wins from IPL_Matches_2022$
where TossDecision = 'bat'
group by WinningTeam
order by Most_Wins;

-- Most_Matches_Winning Team while Bowling first

select WinningTeam, count(WinningTeam) Most_Wins from IPL_Matches_2022$
where TossDecision = 'field'
group by WinningTeam
order by Most_Wins desc;

-- Most_Matches_Winning Team

select WinningTeam, count(WinningTeam) Most_Wins from IPL_Matches_2022$
group by WinningTeam
order by Most_Wins desc;

-- Runs Scored by JC Buttler and SV Samson

select batter, sum(batsman_run) Most_Runs from IPL_Ball_by_Ball_2022$
where batter in ('JC Buttler', 'SV Samson')
group by batter

-- Top 10 Most Runs scored Batsman

select top(10) batter, sum(batsman_run) Most_Runs from IPL_Ball_by_Ball_2022$
group by batter
order by Most_Runs desc;

-- Top 10 Most Sixes hit by Batsman

select top(10) batter, count(batsman_run) Most_Sixes from IPL_Ball_by_Ball_2022$
where batsman_run = 6
group by batter
order by Most_Sixes desc;

-- Top 10 Most Fours scored Batsman

select top(10) batter, count(batsman_run) Most_Fours from IPL_Ball_by_Ball_2022$
where batsman_run = 4
group by batter
order by Most_Fours desc;

-- Top 10 Most Wikets taken by Bowler

select top(10) bowler, count(isWicketDelivery) Most_Wickets from IPL_Ball_by_Ball_2022$
where isWicketDelivery = 1
group by bowler
order by Most_Wickets desc;

-- Top 10 Most dot balls bowled by bowler
select top(10) bowler, count(batsman_run) Most_dot_Balls from IPL_Ball_by_Ball_2022$
where batsman_run = 0
group by bowler
order by Most_dot_Balls desc;

-- Top 10 Most Wikets taken by Bowler when wicket = bowled
select bowler, count(kind) Most_Bowler_bowled from IPL_Ball_by_Ball_2022$
where kind = 'bowled'
group by bowler
order by Most_Bowler_bowled desc;

-- Top 10 teams won HIGH margin runs

select top(10) Date, WinningTeam, , Margin, TossDecision, TossWinner, Player_of_Match from IPL_Matches_2022$
where Margin > 0 and WonBy = 'Runs'
order by Margin desc

-- Top 5 teams won BY LOW margin runs

select top(5) Date, WinningTeam, TossDecision, TossWinner, Margin, Player_of_Match from IPL_Matches_2022$
where Margin > 0 and WonBy = 'Runs'
order by Margin

-- Top 10 teams won BY HIGHEST WICKETS (Margin)

select top(10) WinningTeam, TossDecision, TossWinner, Margin, Player_of_Match, Date from IPL_Matches_2022$
where WonBy = 'Wickets'
order by Margin desc

-- IPL matches held on date 23-04-2022

select * from IPL_Matches_2022$
where date = '2022-04-23';

-- Top 5 Players with BestPlayeroftheMatch award

select top(5) Player_of_Match, count(Player_of_Match) BestPlayeroftheMatch from IPL_Matches_2022$
group by Player_of_Match
order by BestPlayeroftheMatch desc;

-- Top 10 Players conceded with Most_Extra_Runs

select top(10) bowler, sum(extras_run) Most_Extra_Runs from IPL_Ball_by_Ball_2022$
group by bowler
order by Most_Extra_Runs desc

-- Top 10 Players conceded with Most_wide_Runs
select top(10) bowler, sum(extras_run) Most_wides from IPL_Ball_by_Ball_2022$
where extra_type = 'wides'
group by bowler
order by Most_wides desc;

select * from IPL_Ball_by_Ball_2022$

-- Best_Batting_Strike_Rate

select top(10) batter, round((sum(batsman_run) / count(ballnumber))*100, 2) Best_Batting_Strike_Rate from IPL_Ball_by_Ball_2022$ 
group by batter
order by Best_Batting_Strike_Rate desc;

-- Best_Bowling_Economy

select bowler, sum(total_run) Bowler_given_runs , (count(overs) / 6)  oversbowled, 
round(sum(total_run)  / (count(overs) / 6), 2) Best_Bowling_Economy from IPL_Ball_by_Ball_2022$
group by bowler;

-- Top 10 players with Most_Catches_Taken

select top (10) fielders_involved ,count(fielders_involved) Most_Catches_Taken from IPL_Ball_by_Ball_2022$
where kind = 'caught' and fielders_involved != 'NA'
group by fielders_involved
order by Most_Catches_Taken desc;

select * from IPL_Ball_by_Ball_2022$

-- Joining the IPL Ball by ball and Matches Tables

select * from IPL_Matches_2022$ m
join IPL_Ball_by_Ball_2022$ b
on m.ID = b.ID
where m.ID = 1304099;

-- Runs scored by batsman for match ID 1312200

select b.batter, sum(b.batsman_run) RunsByBatsman from IPL_Matches_2022$ m
join IPL_Ball_by_Ball_2022$ b
on m.ID = b.ID
where m.ID = 1312200
group by b.batter
order by RunsByBatsman desc;

-- Wickets taken by Bowlwers for match ID 1312200

select b.bowler, count(b.isWicketDelivery) Wickets from IPL_Matches_2022$ m
join IPL_Ball_by_Ball_2022$ b
on m.ID = b.ID
where m.ID = 1312200 and b.isWicketDelivery = 1
group by b.bowler
order by Wickets desc;

select * from IPL_Matches_2022$

-- Best Batting Average

select batter, sum(batsman_run), count(isWicketDelivery), (sum(batsman_run) / count(isWicketDelivery)) Best_Batting_Average from IPL_Ball_by_Ball_2022$
where isWicketDelivery = 1
group by batter
order by Best_Batting_Average desc;

-- Creating a VIEW of MostWickets

create view MostWickets as
select batter, count(isWicketDelivery) Most_Wickets from IPL_Ball_by_Ball_2022$
where isWicketDelivery = 1
group by batter;

-- MostRunsByBatsman for all Matches

select b.batter, sum(b.batsman_run) MostRunsByBatsman from IPL_Matches_2022$ m
join IPL_Ball_by_Ball_2022$ b
on m.ID = b.ID
group by b.batter
order by MostRunsByBatsman desc;

-- MostWickets taken by Bowlers for all Matches

select b.bowler, count(b.isWicketDelivery) Wickets from IPL_Matches_2022$ m
join IPL_Ball_by_Ball_2022$ b
on m.ID = b.ID
where b.isWicketDelivery = 1
group by b.bowler
order by Wickets desc;

