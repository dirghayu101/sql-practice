-- Question Link: https://datalemur.com/questions/laptop-mobile-viewership


-- Solution 1:
SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views, 
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views 
FROM viewership;

-- Solution 2:
SELECT 
  COUNT(*) FILTER (WHERE device_type = 'laptop') AS laptop_views,
  COUNT(*) FILTER (WHERE device_type IN ('tablet', 'phone'))  AS mobile_views 
FROM viewership;

-- Solution 3: using subqueries
SELECT laptop_views, mobile_views
FROM ( SELECT
  (
    SELECT COUNT(device_type)
    FROM viewership
    WHERE device_type IN ('phone', 'tablet')
  ) AS mobile_views,
  (
    SELECT COUNT(device_type)
    FROM viewership
    WHERE device_type IN ('laptop')
  ) AS laptop_views
) t