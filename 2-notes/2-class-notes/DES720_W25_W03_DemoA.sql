/* ----------------------------
Title:  DES720 - Week 3 Demo A
Author: Clint MacDonald
Date:   Jan 21, 2025
Purpose:Multi-Table SELECT statements
------------------------------- */

-- Joins will include more than one table in the FROM clause

-- history
-- version: ANSI89

-- example: list all employees and the department they are in...

SELECT
    employee_id,
    first_name,
    last_name,
    department_name,
    e.department_id,
    d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id OR e.department_id IS NULL;

-- this is completely unacceptable...

-- ansi92
SELECT
    employee_id,
    first_name,
    last_name,
    department_name,
    e.department_id,
    d.department_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;

-- There are 4 main join types
-- 1) INNER JOIN - ONLY shows records that exactly match the ON clause
-- 2) OUTER JOIN
        -- LEFT
        -- RIGHT
        -- FULL
        
-- repeat the previous question but ensure that ALL employees are included
--    even if they are not in a department
SELECT
    employee_id,
    first_name,
    last_name,
    department_name,
    e.department_id,
    d.department_id
FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- is the exact same as
SELECT
    employee_id,
    first_name,
    last_name,
    department_name,
    e.department_id,
    d.department_id
FROM departments d RIGHT OUTER JOIN employees e
    ON e.department_id = d.department_id;

-- same question but show ALL employees and ALL departments
SELECT
    employee_id,
    first_name,
    last_name,
    department_name,
    e.department_id,
    d.department_id
FROM departments d FULL OUTER JOIN employees e
    ON e.department_id = d.department_id;
    
    
-- List ALL employees who work in Seattle?
SELECT 
    employee_id,
    first_name,
    last_name,
    city
FROM 
    employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
WHERE UPPER(city) = 'SEATTLE'
ORDER BY 
    last_name, 
    first_name;

-- if we want Kimberley Grant included
SELECT 
    employee_id,
    first_name,
    last_name,
    city
FROM 
    employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    LEFT JOIN locations l ON d.location_id = l.location_id
WHERE UPPER(city) = 'SEATTLE' OR d.department_id IS NULL
ORDER BY 
    last_name, 
    first_name;

-- is the same as ...

SELECT 
    employee_id,
    first_name,
    last_name,
    city
FROM 
    locations l
    INNER JOIN departments d ON d.location_id = l.location_id 
    RIGHT JOIN employees e ON e.department_id = d.department_id
WHERE UPPER(city) = 'SEATTLE' OR d.department_id IS NULL
ORDER BY 
    last_name, 
    first_name;

-- INVERSE JOINS
-- list all employees not assigned to a department or a department that does not exist
SELECT * FROM employees WHERE department_id IS NULL; -- not assigned

SELECT *
FROM employees e 
    LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;


-- list all employees not linked to a country
SELECT 
    employee_id,
    first_name,
    last_name
FROM 
    employees e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    LEFT OUTER JOIN locations l ON l.location_id = d.location_id
    LEFT OUTER JOIN countries c ON l.country_id = c.country_id
WHERE c.country_id IS NULL
ORDER BY last_name;


