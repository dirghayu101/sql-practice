-- ---------------------------
-- DES720 - Week 5 Part A
-- Clint MacDonald
-- Feb. 4, 2025
-- Sub-Queries (Sub-Selects)
-- ---------------------------

-- 3 Types of Select Queries (read-only)
-- TABULAR  - returns a table with unknown rows and columns
-- LIST     - single column, unknwon rows (advanced 2 columns)
-- SCALAR   - a single value (one row, one column, GUARANTEED)

-- Why do we need to know this?
/*
    in any programming or math - RHS of an '=' MUST be scalar
    WHERE a = b -> b is a scalar
    WHERE a = b > 24 OR c < 36 - still scalar because evaluates to T or F
    
    anything inside IN(), ANY(), or ALL() must be a list
    
    any datasource is always a table!
*/

-- EXAMPLES

-- List all the employees who work in Seattle!  (NO JOINS)

-- with JOINS
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

-- Without JOINS
SELECT location_id
FROM locations
WHERE UPPER(city) = 'SEATTLE';
-- note this is NOT a scalar

SELECT department_id
FROM departments
WHERE location_id = 1700;

SELECT employee_id
FROM employees
WHERE department_id IN(10, 90, 110, 190);

-- combine them
SELECT department_id
FROM departments
WHERE location_id = (
    SELECT location_id
    FROM locations
    WHERE UPPER(city) = 'SEATTLE'
    );
-- combine more....

SELECT employee_id
FROM employees
WHERE department_id IN(
    SELECT department_id
    FROM departments
    WHERE location_id IN (
        SELECT location_id
        FROM locations
        WHERE UPPER(city) = 'SEATTLE'
        )
)
ORDER BY employee_id;

-- Using the Sportleagues database
SELECT * FROM players;

-- Who scored the most goals in a single game?  NO JOINS
SELECT MAX(numGoals)
FROM goalscorers;

-- who did this
SELECT playerID 
FROM goalscorers
WHERE numGoals = (
    SELECT MAX(numGoals)
    FROM goalscorers
);

SELECT
    firstname,
    lastname
FROM players
WHERE playerID IN (
    SELECT playerID 
    FROM goalscorers
    WHERE numGoals = (
        SELECT MAX(numGoals)
        FROM goalscorers
    )
);

-- so far we have done sub-selects only in WHERE clause

-- sub-selects in the SELECT clause

-- earlier of employees in seattle, but now include employee names and 
-- the name of the department
SELECT 
    employee_id,
    first_name,
    last_name,
    (
        SELECT department_name
        FROM departments 
        WHERE department_id = e.department_id
    ) AS deptName
FROM employees e
WHERE department_id IN(
    SELECT department_id
    FROM departments
    WHERE location_id IN (
        SELECT location_id
        FROM locations
        WHERE UPPER(city) = 'SEATTLE'
        )
)
ORDER BY employee_id;


-- sub-selects in the FROM Clause

-- if we start with this
CREATE OR REPLACE VIEW vwEmpDataSource AS
SELECT 
    employee_id,
    first_name,
    last_name,
    job_id,
    email,
    phone_number,
    department_name,
    city,
    country_name
FROM 
    employees e 
    LEFT JOIN departments d ON e.department_id = d.department_id
    LEFT JOIN locations l ON d.location_id = l.location_id
    LEFT JOIN countries c ON l.country_id = c.country_id;

-- so we could do this...
SELECT *
FROM ()
WHERE UPPER(city) = 'SEATTLE';

-- subbing in the sub-select
SELECT *
FROM (
    SELECT 
        employee_id,
        first_name,
        last_name,
        job_id,
        email,
        phone_number,
        department_name,
        city,
        country_name
    FROM 
        employees e 
        LEFT JOIN departments d ON e.department_id = d.department_id
        LEFT JOIN locations l ON d.location_id = l.location_id
        LEFT JOIN countries c ON l.country_id = c.country_id
)
WHERE UPPER(city) = 'SEATTLE';

-- using the View
SELECT *
FROM vwEmpDataSource
WHERE UPPER(city) = 'SEATTLE';











