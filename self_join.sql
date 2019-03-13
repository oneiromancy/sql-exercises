-- Self join

-- Question 1: How many stops are in the database.

SELECT COUNT(*) AS number_stops FROM stops;

-- Question 2: Find the id value for the stop 'Craiglockhart'

SELECT id FROM stops 
    WHERE name = 'Craiglockhart';


-- Question 3: Give the id and the name for the stops on the '4' 'LRT' service.

SELECT stops.id, stops.name FROM stops 
    JOIN route ON route.stop = stops.id
    WHERE route.company = 'LRT' AND num = '4';

-- Routes and stops
/* Question 4: The query shown gives the number of routes that visit either London Road (149) 
or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes. */

SELECT company, num, COUNT(*)
    FROM route WHERE stop=149 OR stop=53
    GROUP BY company, num
    HAVING COUNT(*) = 2;

/* Question 5: Execute the self join shown and observe that b.stop gives all the places you can get to from 
Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart 
to London Road. */

SELECT a.company, a.num, a.stop, b.stop
    FROM route a JOIN route b ON
    (a.company=b.company AND a.num=b.num)
    WHERE a.stop=53 AND b.stop = 149;

/* Question 6: The query shown is similar to the previous one, however by joining two copies of the stops table 
we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' 
and 'London Road' are shown. */

SELECT a.company, a.num, stopa.name, stopb.name
    FROM route a JOIN route b ON
    (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON (a.stop=stopa.id)
    JOIN stops stopb ON (b.stop=stopb.id)
    WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';


-- Using a self join
-- Question 7: Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT DISTINCT route_a.company, route_a.num 
    FROM route route_a JOIN route route_b 
    ON (route_a.company, route_a.num) = (route_b.company, route_b.num)
    WHERE route_a.stop = 115 AND route_b.stop = 137;

-- Question 8: Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

SELECT DISTINCT route_a.company, route_a.num
    FROM route route_a JOIN route route_b
    ON (route_a.company, route_a.num) = (route_b.company, route_b.num)
    JOIN stops stop_a ON stop_a.id = route_a.stop 
    JOIN stops stop_b ON stop_b.id = route_b.stop
    WHERE stop_a.name = 'Craiglockhart' AND stop_b.name = 'Tollcross';

/* Question 9: Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, 
including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services. */

SELECT DISTINCT stop_b.name, route_b.company, route_b.num
    FROM route route_a JOIN route route_b
    ON (route_a.company, route_a.num) = (route_b.company, route_b.num)
    JOIN stops stop_a ON stop_a.id = route_a.stop
    JOIN stops stop_b ON stop_b.id = route_b.stop
    WHERE stop_a.name = 'Craiglockhart' AND route_a.company = 'LRT';

/* Question 10: Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus. */

SELECT route_a.num, route_a.company, stop_b.name,
    route_c.num, route_c.company
    FROM route route_a JOIN route route_b
    ON (route_a.company, route_a.num) = (route_b.company, route_b.num)
    JOIN route route_c JOIN route route_d ON (route_c.company, route_c.num) = (route_d.company, route_d.num)
    JOIN stops stop_a ON stop_a.id = route_a.stop
    JOIN stops stop_b ON stop_b.id = route_b.stop
    JOIN stops stop_c ON stop_c.id = route_c.stop
    JOIN stops stop_d ON stop_d.id = route_d.stop
    WHERE stop_a.name = 'Craiglockhart' AND stop_b.name = stop_c.name AND stop_d.name = 'Lochend';