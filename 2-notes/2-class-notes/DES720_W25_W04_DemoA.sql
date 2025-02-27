-- ******************************
-- DES720 - Week 4
-- Jan 28, 2025
-- Clint MacDonald
-- Grouping and Aggregate Functions
-- ******************************

-- aggregate functions are often referred to as multi-line functions

-- there are 7 aggregate functions
/*
SUM     - summation
COUNT   - how many
AVG     - average
MIN     - minimum
MAX     - maximum
STDDEV  - standard deviation
VAR     - variance
*/

-- ORDER OF EXECUTION
/*
1) FROM (data source, includes JOIN)
2) WHERE (filter out unwanted data)
3) GROUP BY
4) HAVING (filter, same as WHERE, but completed after Grouping)
5) SELECT (executes as a loop, one resultant row at a time)
6) ORDER BY
*/

-- Examples
-- How many countries are in the database?
SELECT * FROM countries;
-- using a function, to put the answer in the output
SELECT COUNT(*) AS numCountries
FROM countries;
-- a little inefficient
SELECT COUNT(country_id) AS numCountries
FROM countries;

-- but this has limitations

-- example: how many countries in each region?
SELECT
    region_id,
    COUNT(country_id) AS numCountries
FROM countries
GROUP BY region_id
ORDER BY numCountries DESC;

-- same question but only show those regions with more than 6 countries

SELECT
    region_id,
    COUNT(country_id) AS numCountries
FROM countries
GROUP BY region_id
HAVING COUNT(country_id) > 6
ORDER BY numCountries DESC;

-- Filters
-- any filter that involves one of the 7 aggregate functions
--      is in HAVING
-- ALL other filters are in WHERE

-- example: corporate budgets
-- How much salary is paid out by each department each month
SELECT
    d.department_id,
    department_name,
    SUM(salary) AS totSalary,
    COUNT(employee_id) AS numEmps
FROM employees e
    FULL JOIN departments d ON e.department_id = d.department_id
GROUP BY 
    d.department_id, 
    department_name
ORDER BY totSalary DESC;

-- Clint's Law
-- Any field included in the SELECT clause that is NOT part of 
-- an aggregate function or a sub-query MUST be included in the GROUP BY clause.


-- Example: How many employees work in each country?
SELECT
    c.country_id,
    country_name,
    COUNT(employee_id) AS numEmps
FROM 
    employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    LEFT JOIN locations l ON l.location_id = d.location_id
    LEFT JOIN countries c ON l.country_id = c.country_id
GROUP BY
    c.country_id, 
    country_name
ORDER BY country_name;

-- How many different cities does FedEx deliver to
SELECT COUNT(city) AS numCities
FROM orders;
-- the above returns the number of ORDERS, not unique cities
SELECT COUNT(DISTINCT city) AS numCities
FROM orders;

-- GROUPING with NULLs
-- Example: What is the average commission_pct?
SELECT
    AVG(commission_pct) AS avgComm,
    SUM(commission_pct) AS sumComm,
    COUNT(commission_pct) AS countComm,
    SUM(commission_pct) / COUNT(commission_pct) AS avgComm2,
    AVG(NVL(commission_pct,0)) AS avgCommNoNulls
FROM employees;

-- How many departments have employees?
SELECT
    COUNT(DISTINCT NVL(department_id,-99)) AS numDepts
FROM employees
-- the above includes the <null> department

-- Other Functions
-- Produce a SINGLE statement that returns a SINGLE row of data
-- and shows the min, max, and avg annual salary for ALL employees
SELECT
    MIN(salary * 12) AS minSal,
    MAX(salary * 12) AS maxSal,
    AVG(salary * 12) AS avgSal
FROM employees;


-- How many departments DO NOT have employees?
SELECT COUNT(d.department_id) AS numDepts
FROM departments d 
    LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

-- Total departments - dept with employees

-- total depts
SELECT COUNT(department_id) FROM departments;

-- tot dept with emps
SELECT
    COUNT(DISTINCT department_id) AS numDepts
FROM employees

SELECT (
    (SELECT COUNT(department_id) FROM departments)
    -
    (SELECT COUNT(DISTINCT department_id) AS numDepts
        FROM employees)
    ) AS numDepts
FROM dual;


-- DUAL table
SELECT * FROM dual;

SELECT sysdate FROM dual;

-- SQL Server
SELECT getDate();

-- multiple grouping
-- How many students are wearing a black shirt and glasses

GROUP BY shirt_colour, glasses
GROUP BY glasses, shirt_colour
GROUP BY PK


