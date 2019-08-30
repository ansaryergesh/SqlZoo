--1.Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

--2.Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game where id=1012 

--3.Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player,teamid,stadium,mdate from game JOIN goal ON (id=matchid)
where teamid = 'GER'

--4.Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1,team2, player from game JOIN  goal ON (id=matchid) 
where player LIKE 'Mario%'

--5.Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid = id)
 WHERE gtime<=10

--6.List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname from game JOIN eteam ON (team1 = eteam.id) 
where coach = 'Fernando Santos'

--7.List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player FROM goal JOIN game ON (matchid = id) 
where stadium ='National Stadium, Warsaw'

--8.Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player from goal JOIN game ON (matchid = id)
WHERE (team2 = 'GER' or team1 = 'GER') and teamid != 'GER'

--9.Show teamname and the total number of goals scored.
SELECT teamname, COUNT(*) totalGoal
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname

--10.Show the stadium and the number of goals scored in each stadium.
SELECT stadium,count(*) TotalGoal
  FROM game JOIN goal ON id=matchid
GROUP BY stadium

--11.For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid,mdate, COUNT(*) Total
FROM game JOIN goal ON matchid = id
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate

--12.For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid,mdate, COUNT(*) FROM game JOIN goal ON (id=matchid)
where teamid = 'GER' GROUP BY matchid,mdate

--13.Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. 
--You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2. 
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY  mdate,team1, team2 
  ORDER BY mdate, matchid, team1,team2
