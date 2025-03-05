/*
Question Link: https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true

You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
*/


-- My solution:
SELECT s.name
FROM friends f
    INNER JOIN packages p
    ON f.id = p.id
    INNER JOIN packages pFriend
    ON f.friend_id = pFriend.id
    INNER JOIN Students s
    ON f.id = s.id
WHERE pFriend.salary > p.salary
ORDER BY pFriend.salary;