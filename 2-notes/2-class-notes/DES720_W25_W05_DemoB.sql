-- ---------------------------
-- DES720 - Week 5 Part B
-- Clint MacDonald
-- Feb. 4, 2025
-- SET OPERATORS
-- ---------------------------

/*
Let U - Universe (represents all possible values)

Let U = all integers from 1 to 10
U = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
Let A = { 1, 2, 5, 8, 9 }
Let B = { 2, 4, 6, 8, 10 }

we obviously know that { 3, 7 } are not in A nor B

A U B = A Union B = { 1, 2, 4, 5, 6, 8, 9, 10 }
A U B = A Union ALL B = { 1,2,2,4,5,6,8,8,9,10 }
A INT B = A INTERCEPT B = { 2, 8 }
A - B = A MINUS B = { 1, 5, 9 }

In SQL there are 4 set operators
- UNION
- UNION ALL
- INTERSECT
- MINUS ( in SQL Server use SUBTRACT )
*/


-- EXAMPLES
-- List all the players whose first name starts with A
SELECT
    firstname,
    lastname
FROM players
WHERE UPPER(firstname) LIKE 'A%';
-- 56 results

-- List all the players whose last name starts with H
SELECT
    firstname,
    lastname
FROM players
WHERE UPPER(lastname) LIKE 'H%';
-- 31 results

-- but what about both
SELECT
    firstname,
    lastname
FROM players
WHERE 
    UPPER(firstname) LIKE 'A%'
    AND UPPER(lastname) LIKE 'H%';

-- using Set operators
SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(firstname) LIKE 'A%'
UNION
SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(lastname) LIKE 'H%';

-- UNION eliminates duplicates which results in resorting
-- UNION ALL simply pastes one table under the other


SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(firstname) LIKE 'A%'
INTERSECT
SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(lastname) LIKE 'H%';

-- INTERSECT keeps only the duplicates, again resulting in re-sorting

SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(firstname) LIKE 'A%'
MINUS
SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(lastname) LIKE 'H%';
-- 50 results


-- ORDER BY with Set Operators
SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(firstname) LIKE 'A%'
UNION ALL
SELECT
    playerID,
    firstname,
    lastname
FROM players
WHERE UPPER(lastname) LIKE 'H%'

ORDER BY firstname;

-- what is actually happening

SELECT * FROM (
    SELECT
        playerID,
        firstname,
        lastname
    FROM players
    WHERE UPPER(firstname) LIKE 'A%'
    UNION ALL
    SELECT
        playerID,
        firstname,
        lastname
    FROM players
    WHERE UPPER(lastname) LIKE 'H%')
ORDER BY firstname;

-- sort all A's first, but sub-sorted by last_name
-- then H's, sub-sorted by last_name
SELECT * FROM (
    SELECT
        playerID,
        firstname,
        lastname,
        1 AS sortby
    FROM players
    WHERE UPPER(firstname) LIKE 'A%'
    UNION ALL
    SELECT
        playerID,
        firstname,
        lastname,
        2
    FROM players
    WHERE UPPER(lastname) LIKE 'H%')
ORDER BY sortBy, lastname;

-- list all players whose first name starts with A, F, or R
-- but show the F first, then A, then R
-- within each one further sort alphabetically.
SELECT * FROM (
    SELECT playerid, firstname, lastname, 1 AS sortBy
    FROM players 
    WHERE UPPER(firstname) LIKE 'F%'
        UNION ALL
    SELECT playerid, firstname, lastname, 2
    FROM players 
    WHERE UPPER(firstname) LIKE 'A%'
        UNION ALL
    SELECT playerid, firstname, lastname, 3
    FROM players 
    WHERE UPPER(firstname) LIKE 'R%')

ORDER BY sortBy, firstname;

-- ----
SELECT 
    playerid,
    firstname,
    lastname,
    CASE 
        WHEN UPPER(firstname) LIKE 'F%' THEN 1
        WHEN UPPER(firstname) LIKE 'A%' THEN 2
        WHEN UPPER(firstname) LIKE 'R%' THEN 3
        END AS sorter
FROM players
WHERE
    UPPER(firstname) LIKE 'F%'
    OR UPPER(firstname) LIKE 'A%'
    OR UPPER(firstname) LIKE 'R%'
ORDER BY
    sorter, firstname;

-- 3rd way
SELECT 
    playerid,
    firstname,
    lastname
FROM players
WHERE
    UPPER(firstname) LIKE 'F%'
    OR UPPER(firstname) LIKE 'A%'
    OR UPPER(firstname) LIKE 'R%'
ORDER BY
    CASE 
        WHEN UPPER(firstname) LIKE 'F%' THEN 1
        WHEN UPPER(firstname) LIKE 'A%' THEN 2
        WHEN UPPER(firstname) LIKE 'R%' THEN 3
        END,
    firstname;
