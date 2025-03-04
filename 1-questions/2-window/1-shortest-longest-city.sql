/*
Question Link: https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true

Query the shortest and longest city names from the STATION table.
If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.


The STATION table is described as follows:
  +-----------------+------------------+------------------+
  | Field           | Type             |
  +-----------------+------------------+------------------+
  | ID              | NUMBER           |
  | CITY            | VARCHAR(21)      | 
  | STATE           | VARCHAR(2)       |
  | LAT_N           | NUMBER           |
  | LONG_W          | NUMBER           |
*/

-- My brute force solution using window function
-- Longest city name
SELECT 
    largestCity.city,
    largestCity.cityLength
FROM (
    SELECT 
        s.city,
        LENGTH(s.city) AS cityLength,
        ROW_NUMBER() OVER(ORDER BY LENGTH(s.city) DESC, s.city ASC) AS rn
    FROM Station s
) largestCity
WHERE largestCity.rn = 1;

-- Shortest city name
SELECT 
    smallestCity.city,
    smallestCity.cityLength
FROM (
    SELECT 
        city,
        LENGTH(s.city) AS cityLength,
        ROW_NUMBER() OVER(ORDER BY LENGTH(s.city) ASC, s.city ASC) AS rn
    FROM Station s
) smallestCity
WHERE smallestCity.rn = 1;

-- The solution could be simpler but since I was doing it in oracle, I had to use window function
-- The solution could be simpler in MySQL
SELECT 
    city, LENGTH(city)
FROM Station
ORDER BY LENGTH(city) ASC, city ASC
LIMIT 1;

-- There is a limit clause in oracle but it was not available in the oracle version of hackerrank.

-- In the discussion, I found a simpler solution using ROWNUM.
SELECT *
FROM
    (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY), CITY)
WHERE ROWNUM = 1
UNION
SELECT *
FROM
    (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY) DESC, CITY)
WHERE ROWNUM = 1;
-- ROWNUM is a pseudocolumn that numbers each row returned by a query.