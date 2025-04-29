-- Question Link: https://datalemur.com/questions/sql-histogram-tweets

-- My Brute Force Solution
SELECT tweet_bucket,
  COUNT(user_id) as users_num
FROM (
  SELECT user_id, 
   COUNT(tweet_id) as tweet_bucket
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
) AS helper
GROUP BY tweet_bucket;