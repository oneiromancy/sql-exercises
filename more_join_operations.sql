-- Section: More JOIN operations

-- 1962 movies
-- Question 1: List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie
    WHERE yr = 1962;

-- When was Citizen Kane released?
-- Question 2: Give year of 'Citizen Kane'
SELECT yr FROM movie 
    WHERE title = 'Citizen Kane';

-- Star Trek movies
/* Question 3: List all of the Star Trek movies, include the id, title and yr 
(all of these movies include the words Star Trek in the title). Order results by year. */
SELECT id, title, yr FROM movie 
    WHERE title LIKE '%Star Trek%';

-- id for actor Glenn Close
-- Question 4: What id number does the actor 'Glenn Close' have?
SELECT id FROM actor 
    WHERE name = 'Glenn Close';

-- id for Casablanca
-- Question 5: What is the id of the film 'Casablanca'
SELECT id FROM movie 
    WHERE title = 'Casablanca';

-- Cast list for Casablanca
-- Question 6: Obtain the cast list for 'Casablanca'
SELECT name FROM actor 
    WHERE id IN (SELECT actorid FROM casting 
    WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca'));

-- Alien cast list
-- Question 7: Obtain the cast list for the film 'Alien'
SELECT name FROM actor 
    WHERE id IN (SELECT actorid FROM casting 
    WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien'));

-- Harrison Ford movies
-- Question 8: List the films in which 'Harrison Ford' has appeared
SELECT movie.title from actor 
    JOIN casting ON casting.actorid = actor.id
    JOIN movie ON movie.id = casting.movieid
    WHERE actor.name = 'Harrison Ford';

-- Harrison Ford as a supporting actor
-- Question 9: List the films where 'Harrison Ford' has appeared - but not in the starring role
SELECT movie.title from actor 
    JOIN casting ON casting.actorid = actor.id
    JOIN movie ON movie.id = casting.movieid
    WHERE actor.name = 'Harrison Ford' AND casting.ord > 1;

-- Lead actors in 1962 movies
-- Question 10: List the films together with the leading star for all 1962 films
SELECT movie.title, actor.name from actor 
    JOIN casting ON casting.actorid = actor.id
    JOIN movie ON movie.id = casting.movieid
    WHERE movie.yr = 1962 AND casting.ord = 1;

-- Subsection: harder questions

-- Busy years for John Travolta
/* Question 11: Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year 
for any year in which he made more than 2 movies */
SELECT yr,COUNT(title) 
    FROM movie JOIN casting ON movie.id=movieid
    JOIN actor   ON actorid=actor.id
    where name='John Travolta'
    GROUP BY yr
    HAVING COUNT(title)=(SELECT MAX(c) FROM
    (SELECT yr,COUNT(title) AS c FROM
    movie JOIN casting ON movie.id=movieid
            JOIN actor   ON actorid=actor.id
    where name='John Travolta'
    GROUP BY yr) AS t
    );

-- Lead actor in Julie Andrews movies
-- Question 12: List the film title and the leading actor for all of the films 'Julie Andrews' played in
SELECT movie.title, actor.name
    FROM casting JOIN movie ON movie.id = casting.movieid
    JOIN actor ON actor.id = casting.actorid
    WHERE casting.movieid IN 
    (SELECT casting.movieid FROM casting JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Julie Andrews') 
    AND casting.ord = 1;

-- Actors with 30 leading roles
-- Question 13: Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles
SELECT actor.name FROM actor
    JOIN casting ON casting.actorid = actor.id
    WHERE ord = 1
    GROUP BY actor.name HAVING COUNT(casting.ord) >= 30
    ORDER BY actor.name;

-- Question 14: List the films released in the year 1978 ordered by the number of actors in the cast, then by title
SELECT movie.title, COUNT(casting.actorid) 
    FROM movie JOIN casting ON casting.movieid = movie.id
    WHERE movie.yr = 1978
    GROUP BY movie.title
    ORDER BY COUNT(casting.actorid) DESC, movie.title;

-- Question 15: List all the people who have worked with 'Art Garfunkel'
SELECT actor.name
    FROM casting JOIN actor ON actor.id = casting.actorid
    WHERE casting.movieid IN 
    (SELECT casting.movieid FROM casting JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Art Garfunkel') 
    AND actor.name <> 'Art Garfunkel';