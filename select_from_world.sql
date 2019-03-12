-- Select from world

-- Introduction
-- Question 1: Show the name, continent and population of all countries
SELECT name, continent, population FROM world;

-- Large Countries
-- Question 2: Show the name for the countries that have a population of at least 200 million
SELECT name FROM world
    WHERE population > 200000000;

-- Per capita GDP
-- Question 3: Give the name and the per capita GDP for those countries with a population of at least 200 million
SELECT name, gdp/population FROM world
    WHERE POPULATION >= 200000000;

-- South America In millions
/* Questino 4: Show the name and population in millions for the countries of the continent 'South America'
Divide the population by 1000000 to get population in millions */
SELECT name, population/1000000 from world
    WHERE continent = 'South America';

-- France, Germany, Italy
-- Question 5: Show the name and population for France, Germany, Italy
SELECT name, population FROM world
    WHERE name = 'France' or name = 'Germany' or name = 'Italy';

-- United
-- Question 6: Show the countries which have a name that includes the word 'United'
SELECT name from world WHERE name LIKE '%United%';

-- Two ways to be big
-- Question 7: Show the countries that are big by area or big by population. Show name, population and area
SELECT name, population, area FROM world
    WHERE area > 3000000 OR population > 250000000;

-- One or the other (but not both)
-- Question 8: Show the countries that are big by area or big by population but not both. Show name, population and area
SELECT name, population, area FROM world 
    WHERE area > 3000000 XOR population > 250000000;

-- Rounding
-- Question 9: For South America show population in millions and GDP in billions both to 2 decimal places
SELECT name, ROUND((population/1000000), 2), ROUND((gdp/1000000000), 2) FROM world 
    WHERE continent = 'South America';

-- Trilion dollar economies
-- Question 10: Show per-capita GDP for the trillion dollar countries to the nearest $1000
SELECT name, ROUND(gdp/population, -3) FROM world
    WHERE gdp >= 1000000000000;

-- Name and capital have the same length
-- Question 11: Show the name and capital where the name and the capital have the same number of characters
SELECT name, capital FROM world
    WHERE LENGTH(name) = LENGTH(capital);

-- Matching name and capital
-- Question 12: Show the name and the capital where the first letters of each match
SELECT name, capital FROM world
    WHERE LEFT(name,1) = LEFT(capital, 1) AND capital <> name;

-- All the vowels
-- Find the country that has all the vowels and no spaces in its name
SELECT name FROM world
    WHERE name LIKE '%a%' AND 
    name LIKE '%e%' AND 
    name LIKE '%i%' AND
    name LIKE '%o%' AND
    name LIKE '%u%' 
    AND name NOT LIKE '% %';