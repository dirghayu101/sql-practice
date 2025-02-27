/* ----------------------------
Title:  DES720 - Week 2 Demo A
Author: Clint MacDonald
Date:   Jan 14, 2025
Purpose:Learning basic SQL for the first time
------------------------------- */

-- single line comment

-- SQL - Structured Query Language
-- Query - Question - language based on asking business questions of the data to
--                    extract information

-- There are 3 sub-languages and one procedural language
-- DML - Data Manipulation Language    - About the data (rows of the tables)
-- DDL - Data Definition Language      - About the structure (columns) 
-- TCL - Transaction Control Language

-- DML 

-- CRUD
-- Create, Read, Update, Delete
-- INSERT, SELECT, UPDATE, DELETE

-- SELECT - read only

SELECT * FROM employees;

-- * - means ALL columns
-- how do we know ALL rows will be shown?
--       there is no WHERE clause

-- Show a list of employees

SELECT
    employee_id,
    first_name,
    last_name,
    phone_number,
    email
FROM employees
ORDER BY
    last_name,
    first_name;
    
-- WHERE
SELECT
    employee_id,
    first_name,
    last_name,
    phone_number,
    email
FROM employees
WHERE employee_id > 150
ORDER BY
    last_name,
    first_name;

-- ORDER BY
    -- alphabetically
    -- numerically
    -- chronologically

-- ----------------------------------
-- BASIC SELECT STATEMENT

-- SELECT
-- FROM
-- WHERE
-- ORDER BY
-- Must be presented in this order

-- ----------------------------------
-- Calculated fields

SELECT 
    employee_id,
    first_name || ' ' || last_name AS full_name
FROM employees
ORDER BY last_name;

-- Math calculations
-- What would the salaries look like if we gave everyone a 5% raise.  
-- Show the difference
SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary AS oldSalary,
    salary * 1.05 AS newSalary,  -- salary + salary * 0.05
    salary * 0.05 AS salDifference
FROM employees
ORDER BY 
    salary DESC;
    
-- aliases
-- 2 kinds of aliases
    -- field aliases,
    -- table alias


SELECT
    e.employee_id,
    first_name,
    e.last_name,
    first_name || ' ' || last_name AS full_name,
    phone_number,
    email,
    salary AS oldSalary
FROM employees e
WHERE salary > 10000
ORDER BY
    oldSalary,
    e.last_name,
    first_name;

-- ORDER OF EXECUTION
-- 1) FROM    -- table aliases created here
-- 2) WHERE 
-- 3) SELECT  -- field aliases created here  -- runs as a loop 
-- 4) ORDER BY


-- multiple where clauses
-- show all employees where monthly salary is between 7000 and 11000
SELECT
    e.employee_id,
    first_name || ' ' || last_name AS full_name,
    salary
FROM employees e
WHERE 
    salary >= 7000
    AND salary <= 11000
ORDER BY
    salary,
    e.last_name,
    first_name;

-- alternatively
SELECT
    e.employee_id,
    first_name || ' ' || last_name AS full_name,
    salary
FROM employees e
WHERE 
    salary BETWEEN 7000 AND 11000
ORDER BY
    salary,
    e.last_name,
    first_name;
    
-- list all employees who earn exactly 7000, 8600, or 10500
SELECT
    e.employee_id,
    first_name || ' ' || last_name AS full_name,
    salary
FROM employees e
WHERE 
    salary IN (7000, 8600, 10500)
ORDER BY
    salary,
    e.last_name,
    first_name;
    
-- list all employees whos first name starts with 'S'
SELECT
    employee_id,
    first_name,
    last_name
FROM employees
WHERE UPPER(first_name) LIKE 'B%';

-- ends with
SELECT
    employee_id,
    first_name,
    last_name
FROM employees
WHERE UPPER(first_name) LIKE '%E';

-- contains
SELECT
    employee_id,
    first_name,
    last_name
FROM employees
WHERE UPPER(first_name) LIKE '%EL%';

-- contains an e and an i in that order
SELECT
    employee_id,
    first_name,
    last_name
FROM employees
WHERE UPPER(first_name) LIKE '%E%I%';

-- Dates
SELECT hire_date
FROM employees;

SELECT TO_CHAR(hire_date, 'MONTH dd, yyyy')
FROM employees;

-- show all employees hired after May 6th, 2013
SELECT TO_CHAR(hire_date, 'MONTH dd, yyyy') AS hireDate
FROM employees
WHERE hire_date > TO_DATE('05/06/2013','mm/dd/yyyy')
ORDER BY hire_date DESC;

-- show all employees hired in 2013
SELECT TO_CHAR(hire_date, 'MONTH dd, yyyy') AS hireDate
FROM employees
WHERE 
    hire_date >= TO_DATE('01/01/2013','mm/dd/yyyy')
    AND hire_date < TO_DATE('01/01/2014','mm/dd/yyyy')
ORDER BY hire_date DESC;
-- or better
SELECT TO_CHAR(hire_date, 'MONTH dd, yyyy') AS hireDate
FROM employees
WHERE 
    EXTRACT(year FROM hire_date) = 2014
ORDER BY hire_date DESC;

-- all people hired in October
SELECT TO_CHAR(hire_date, 'MONTH dd, yyyy') AS hireDate
FROM employees
WHERE 
    EXTRACT(month FROM hire_date) = 10
ORDER BY hire_date DESC;

-- --------------------------------------
-- Thursday Demo Part

-- User Input or Parameters

-- List all employees whose first name starts with S
SELECT
    employee_id,
    first_name,
    last_name
FROM employees
WHERE UPPER(first_name) LIKE 'S%'
ORDER BY first_name;
-- alter this to make the S a parameter
SELECT
    employee_id,
    first_name,
    last_name
FROM employees
WHERE UPPER(first_name) LIKE TRIM(UPPER('&letter')) || '%'
ORDER BY first_name;

-- ------------------------
-- working with nulls

-- what is a null?
-- in database null represents the unknown

-- select all employees not currently assigned to a department
SELECT *
FROM employees
WHERE department_id IS NOT null;

SELECT * 
FROM employees 
WHERE commission_pct >= 0;

SELECT COUNT(DISTINCT NVL(department_id,0))
FROM employees;

SELECT COUNT(DISTINCT NVL2(department_id,1,0))
FROM employees;







