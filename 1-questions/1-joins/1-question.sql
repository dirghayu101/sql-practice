/*
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.


Question Link: https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true
*/

SELECT 
    co.continent,
    FLOOR(AVG(ci.population))
FROM city ci JOIN country co ON ci.CountryCode = co.code
GROUP BY co.continent
ORDER BY co.continent;