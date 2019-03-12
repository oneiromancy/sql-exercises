-- Section: The JOIN operation

/* Question 1: Modify it to show the matchid and player name for all goals scored by Germany. 
To identify German players, check for: teamid = 'GER' */
SELECT matchid, player FROM goal 
    WHERE teamid = 'GER';

-- Question 2: Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2 FROM game 
    WHERE id = 1012;

-- Question 3: Modify it to show the player, teamid, stadium and mdate for every German goal
SELECT player,teamid, stadium, mdate 
    FROM game JOIN goal ON game.id = goal.matchid
    WHERE goal.teamid = 'GER';

-- Question 4: Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player 
    FROM game JOIN goal ON game.id = goal.matchid
    WHERE goal.player LIKE 'Mario%';

-- Question 5: Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime 
    FROM goal JOIN eteam ON teamid = id
    WHERE gtime<=10;

-- Question 6: List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
SELECT game.mdate, eteam.teamname 
    FROM game JOIN eteam ON team1 = eteam.id 
    WHERE eteam.coach = 'Fernando Santos';

-- Question 7: List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player 
    FROM game JOIN goal ON (goal.matchid = game.id)
    WHERE game.stadium = 'National Stadium, Warsaw';

-- Question 8: Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player 
    FROM game JOIN goal ON goal.matchid = game.id 
    WHERE (game.team1='GER' OR game.team2 = 'GER') AND goal.teamid <> 'GER';

-- Question 9: Show teamname and the total number of goals scored
SELECT eteam.teamname, COUNT(goal.gtime)
    FROM eteam JOIN goal ON eteam.id = goal.teamid
    GROUP BY eteam.teamname;

-- Question 10: Show the stadium and the number of goals scored in each stadium
SELECT game.stadium, COUNT(goal.gtime)
    FROM game JOIN goal ON game.id = goal.matchid
    GROUP BY game.stadium;

-- Question 11: For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT game.id, game.mdate, COUNT(*) 
    FROM game JOIN goal ON goal.matchid = game.id 
    WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
    GROUP BY game.id, game.mdate;

-- Question 12: For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT game.id, game.mdate, COUNT(*)
    FROM game JOIN goal ON game.id = goal.matchid
    WHERE goal.teamid = 'GER'
    GROUP BY game.id, game.mdate;

/* Question 13: List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not 
been explained in any previous exercisesSort your result by mdate, matchid, team1 and team2 */
SELECT game.mdate, 
       game.team1, 
       SUM(
         CASE WHEN goal.teamid = game.team1
           THEN 1
           ELSE 0
         END
       ) AS score1,
       game.team2,
       SUM(
         CASE WHEN goal.teamid = game.team2
           THEN 1
           ELSE 0
       END) AS score2

    FROM game LEFT JOIN goal ON game.id = goal.matchid
    GROUP BY game.id, game.mdate, game.team1, game.team2
    ORDER BY game.mdate, game.id, game.team1, game.team2;
