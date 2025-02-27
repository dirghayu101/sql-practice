/*
Question Link: https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true

You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.
*/

-- Solution 1: Using Subqueries.
SELECT 
    CASE 
        WHEN sq.grade >= 8 THEN sq.name
        ELSE NULL
    END as name,
    sq.grade,
    sq.marks
FROM (
    SELECT
        s.name,
        (SELECT grade FROM Grades g WHERE s.marks BETWEEN g.min_mark AND g.max_mark) as grade,
        s.marks
    FROM Students s
) sq
ORDER BY sq.grade DESC, sq.name ASC, sq.marks ASC;


-- Solution 2: Using JOIN.
SELECT 
    CASE 
        WHEN g.grade >= 8 THEN s.name
        ELSE NULL
    END as name,
    g.grade,
    s.marks
FROM Students s JOIN Grades g 
ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, s.name, s.marks;
