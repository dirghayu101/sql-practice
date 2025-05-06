-- Question Link: https://datalemur.com/questions/sql-page-with-no-likes

-- My Brute Force Approach
SELECT page_id 
FROM pages
WHERE page_id NOT IN (
  SELECT page_id 
  FROM page_likes
  GROUP BY page_id
)
ORDER BY page_id ASC;


-- Approach 1
-- Using Except Operator: The SQL EXCEPT operator is used to return the rows from the first SELECT statement that are not present in the second SELECT statement.
SELECT page_id FROM pages
except 
SELECT page_id FROM page_likes;

-- Approach 2
-- Using left outer join
SELECT pages.page_id
FROM pages
LEFT OUTER JOIN page_likes AS likes
  ON pages.page_id = likes.page_id
WHERE likes.page_id IS NULL;
