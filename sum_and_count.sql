-- Section: SUM and COUNT

-- Total world population
-- Question 1: Show the total population of the world
SELECT SUM(population) FROM world;

-- List of continents
-- Question 2: List all the continents - just once each
SELECT DISTINCT continent from world;

-- GDP of Africa
-- Question 3: Give the total GDP of Africa
SELECT SUM(gdp) FROM world 
    WHERE continent = 'Africa';

-- Count the big countries
-- Question 4: How many countries have an area of at least 1000000
SELECT COUNT(name) from world 
    WHERE area >= 1000000;

-- Baltic states population
-- Question 5: What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population) FROM world 
    WHERE name in ('Estonia', 'Latvia', 'Lithuania');

-- Subsection: Using GROUP BY and HAVING

-- Counting the countries of each continent
-- Question 6: For each continent show the continent and number of countries
SELECT continent, COUNT(name) FROM world 
    GROUP BY continent;


-- Counting big countries in each continent
-- Question 7: For each continent show the continent and number of countries with populations of at least 10 million
SELECT continent, COUNT(name) FROM world
    WHERE population >= 10000000
    GROUP BY continent;

-- Counting big continents
-- Question 8: List the continents that have a total population of at least 100 million
SELECT continent from world
    GROUP BY continent
    HAVING SUM(population) >= 100000000;