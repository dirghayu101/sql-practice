# Difference Between Where and Having Clause

- WHERE filters raw data before grouping:

```sql
SELECT user_id, COUNT(*) 
FROM tweets
WHERE tweet_date >= '2022-01-01'
GROUP BY user_id;
```

- HAVING filters data after grouping:

```sql
SELECT user_id, COUNT(*) AS tweet_count
FROM tweets
GROUP BY user_id
HAVING COUNT(*) > 10;
```
