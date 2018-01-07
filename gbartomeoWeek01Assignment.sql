/*
Question 1: Which destination in the flights database is the furthest distance away, based on information in the flights table.
Answer: HNL; 4983 miles away.
*/

SELECT
origin,
dest,
distance,
CONCAT('The airport furthest distance away is ', dest, ' with a distance of ', distance, ' miles.') AS TheAnswer
FROM flights
ORDER BY distance DESC
LIMIT 1;

/*
Question 2: What are the different numbers of engines in the planes table? For each number of engines, which aircraft have
the most number of seats?
Answer: There are one, two, three, and four engines in the planes table. When it comes to the most seats, there's
- One Engine: The DEHAVILLAND OTTER DHC-3 with 16 seats
- Two Engines: The BOEING 777-200, 777-222, 777-224, and the 777-232 with 400 seats
- Three Engines: The AIRBUS A330-223 with 379 seats
- Four Engines: The BOEING 747-451 with 450 seats
*/

SELECT
DISTINCT
engines
FROM planes
ORDER BY engines ASC;

SELECT
DISTINCTROW
maxseats.engines,
maxseats.manufacturer,
maxseats.model,
maxseats.seats
FROM planes maxseats
LEFT JOIN planes distinct_engines
on maxseats.engines = distinct_engines.engines AND maxseats.seats < distinct_engines.seats
WHERE distinct_engines.seats IS NULL
ORDER BY engines ASC, model ASC;

/*
Question 3: Show the total number of flights.
*/

SELECT
COUNT(*) AS 'Total Number of Flights'
FROM flights;

/*
Question 4: Show the total number of flights by airline (carrier).
*/

SELECT
carrier,
COUNT(*) AS 'Total Number of Flights'
FROM flights
GROUP BY carrier;

/*
Question 5: Show all of the airlines, ordered by number of flights in descending order
*/

SELECT
carrier,
COUNT(*) AS TotalFlights
FROM flights
GROUP BY carrier
ORDER BY TotalFlights DESC;

/*
Question 6: Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
*/

SELECT
carrier,
COUNT(*) AS TotalFlights
FROM flights
GROUP BY carrier
ORDER BY TotalFlights DESC
LIMIT 5;

/*
Question 7: Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of
flights in descending order.
*/

SELECT
carrier,
COUNT(*) AS TotalFlights
FROM flights
WHERE distance >= 1000
GROUP BY carrier
ORDER BY TotalFlights DESC
LIMIT 5;

/*
Question 8: Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and
write down both the question, and the query that answers the question.
Answer: What is the average amount of time each plane of the top three most frequently flown has spent in the air?
*/

SELECT
tailnum,
COUNT(tailnum) AS times_flown,
AVG(air_time) AS time_in_air
FROM flights
GROUP BY tailnum
ORDER BY times_flown DESC
LIMIT 3;