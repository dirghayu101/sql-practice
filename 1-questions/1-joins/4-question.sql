/*
Question Link: https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true
Write a query to print the 
    - contest_id, hacker_id, name, the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id.
*/

-- Brute force:
SELECT cont.contest_id AS contest_id,
    cont.hacker_id AS hacker_id,
    cont.name AS name,
    SUM(subStat.total_submissions) AS total_submissions,
    SUM(subStat.total_accepted_submissions) AS total_accepted_submissions,
    SUM(vs.total_views) AS total_views,
    SUM(vs.total_unique_views) AS total_unique_views
FROM Challenges cha
    LEFT JOIN  
    (
        SELECT challenge_id,
            SUM(total_views) AS total_views,
            SUM(total_unique_views) AS total_unique_views
        FROM View_Stats
        GROUP BY challenge_id
    ) vs
    ON vs.challenge_id = cha.challenge_id
    LEFT JOIN  
    (
        SELECT challenge_id,
            SUM(total_submissions) AS total_submissions,
            SUM(total_accepted_submissions) AS total_accepted_submissions
        FROM Submission_Stats
        GROUP BY challenge_id
    ) subStat
    ON subStat.challenge_id = cha.challenge_id
    LEFT JOIN Colleges col
    ON col.college_id = cha.college_id
    LEFT JOIN Contests cont
    ON cont.contest_id = col.contest_id
GROUP BY cont.contest_id,
    cont.hacker_id,
    cont.name
HAVING SUM(subStat.total_submissions) <> 0
    AND SUM(subStat.total_accepted_submissions) <> 0
    AND SUM(vs.total_views) <> 0
    AND SUM(vs.total_unique_views) <> 0
ORDER BY cont.contest_id;