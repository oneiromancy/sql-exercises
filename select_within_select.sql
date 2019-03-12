-- Section: SELECT within SELECT

-- Bigger than Russia
-- Question 1: List each country name where the population is larger than that of 'Russia'
SELECT name FROM world
    WHERE population > (SELECT population FROM world WHERE name = 'Russia');

-- Richer than UK
-- Question 2: Show the countries in Europe with a per capita GDP greater than 'United Kingdom'
SELECT name FROM world
    WHERE continent = 'Europe' AND 
    gdp/population > (SELECT gdp/population from world WHERE name = 'United Kingdom');

-- Neighbours of Argentina and Australia
/* Question 3: List the name and continent of countries in the continents containing either Argentina 
or Australia. Order by name of the country */
SELECT name, continent FROM world
    WHERE continent IN (SELECT continent FROM world WHERE name = 'Argentina' OR name = 'Australia')
    ORDER BY name;

-- Between Canada and Poland
/* Question 4: Which country has a population that is more than Canada but less than Poland? 
Show the name and the population */
SELECT name, population FROM world 
    WHERE population BETWEEN (SELECT population FROM world WHERE name = 'Canada') AND 
    (SELECT population FROM world WHERE name = 'Poland') AND 
    name NOT IN ('Canada', 'Poland');

-- Percentages of Germany
/* Question 5: Show the name and the population of each country in Europe. Show the population as a 
percentage of the population of Germany */
SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')), '%') AS population_ratio
    FROM world 
    WHERE continent = 'Europe';

-- Bigger than every country in Europe
/* Question 6: Which countries have a GDP greater than every country in Europe? [Give the name only.] 
(Some countries may have NULL gdp values) */
SELECT name FROM world 
    WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp IS NOT NULL);

-- Largest in each continent
--  Question 7: Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
    WHERE area >= ALL(SELECT area FROM world y WHERE y.continent = x.continent AND area > 0);

-- First country of each continent (alphabetically)
-- Question 8: List each continent and the name of the country that comes first alphabetically
SELECT continent, name FROM world x 
    WHERE name = (SELECT name FROM world y WHERE x.continent = y.continent ORDER BY name LIMIT 1);

-- Difficult Questions That Utilize Techniques Not Covered In Prior Sections
/* Question 9: Find the continents where all countries have a population <= 25000000. 
Then find the names of the countries associated with these continents. Show name, continent and population */
SELECT name, continent, population FROM world x
    WHERE 25000000 >= ALL(SELECT population FROM world y WHERE x.continent = y.continent);

/* Question 10: Some countries have populations more than three times that of any of 
their neighbours (in the same continent). Give the countries and continents */
SELECT  name, continent FROM world x 
    WHERE population/3 >= ALL(SELECT population FROM world y WHERE y.continent = x.continent AND y.name != x.name);
