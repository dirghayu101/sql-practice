-- Question Link: https://datalemur.com/questions/matching-skills

-- My Brute Force
SELECT c1.candidate_id as candidate_id 
FROM candidates c1
JOIN candidates c2 ON lower(c2.skill) = 'python' 
  AND c1.candidate_id = c2.candidate_id
JOIN candidates c3 ON lower(c3.skill) = 'tableau'
  AND c3.candidate_id = c1.candidate_id
JOIN candidates c4 ON lower(c4.skill) = 'postgresql'
  AND c4.candidate_id = c1.candidate_id
GROUP BY c1.candidate_id;


-- Good solution 1.
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

-- Good solution 2.
SELECT candidate_id FROM candidates WHERE skill = 'Python'
INTERSECT 
SELECT candidate_id FROM candidates WHERE skill = 'Tableau'
INTERSECT  
SELECT candidate_id FROM candidates WHERE skill = 'PostgreSQL'
ORDER BY 1;

