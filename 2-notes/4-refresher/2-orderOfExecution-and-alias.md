# Order of Execution and Alias

## Query

```sql
SELECT tweet_bucket,
  COUNT(user_id) as users_num
FROM (
  SELECT user_id, 
   COUNT(tweet_id) as tweet_bucket
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
)
GROUP BY tweet_bucket;
```

## Issue

- Gives error: subquery in FROM must have an alias.
- Why does a subquery needs alias? SQL is a declarative language — the query planner needs to know:
  - What the source of the data is
  - How to refer to its fields
  - What scope or namespace it's in.
- You gave me a table but didn’t name it — how should I refer to its columns or resolve potential conflicts?

## Order of Execution

- This is the order of execution of an SQL query:
  1. FROM
  2. WHERE
  3. GROUP BY
  4. HAVING
  5. SELECT
  6. ORDER BY
  7. LIMIT
- Where can you use aliases in above?
  1. FROM  --> No.
  2. WHERE --> No.
  3. GROUP BY --> No.
  4. HAVING --> Only in selective DBs. Postgres allows it.
  5. SELECT --> you declare it here.
  6. ORDER BY --> Yes.
  7. LIMIT --> Yes.
