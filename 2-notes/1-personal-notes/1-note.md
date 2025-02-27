### SQL functions:
- CEIL vs ROUND vs FLOOR
    - ROUND works mathematically, and CEIL and FLOOR work similar to how they work in JS.
    - ROUND is more complicated and can have more utilities. Checkout documentation, there are nuances to handling negative number and might come handy in those cases.


### JOIN condition using BETWEEN:
- This is pretty interesting, I am not used to this syntax yet so I am putting it on my notes:
    ```sql
    FROM Students s JOIN Grades g 
    ON s.marks BETWEEN g.min_mark AND g.max_mark
    ```

### Important observation:
```sql
SELECT 
    CASE 
        WHEN grade > 8 THEN s.name
        ELSE NULL
    END as name,
    (
        SELECT
            g.grade
        FROM Grades g
        WHERE s.marks BETWEEN g.min_mark AND g.max_mark
    ) as grade,
    s.marks
FROM Students s, Grades g
ORDER BY grade DESC, name ASC, s.marks ASC;
```
In the above SQL statement, I am trying to refer to the grade value in one column of select in another column and this is giving me error as it is not allowed. There are two fixes for this, which I found using chatGPT:
```sql
-- Fix 1:
SELECT 
    CASE 
        WHEN (SELECT g.grade FROM Grades g WHERE s.marks BETWEEN g.min_mark AND g.max_mark) > 8 
        THEN s.name
        ELSE NULL
    END AS name,
    (SELECT g.grade FROM Grades g WHERE s.marks BETWEEN g.min_mark AND g.max_mark) AS grade,
    s.marks
FROM Students s
ORDER BY grade DESC, name ASC, s.marks ASC;
```
More optimized:
```sql
-- Fix 2:
SELECT 
    CASE 
        WHEN subquery.grade >= 8 THEN subquery.name
        ELSE NULL
    END AS name,
    subquery.grade,
    subquery.marks
FROM (
    SELECT 
        s.name,
        s.marks,
        (SELECT g.grade FROM Grades g WHERE s.marks BETWEEN g.min_mark AND g.max_mark) AS grade
    FROM Students s
) AS subquery
ORDER BY subquery.grade DESC, name ASC, subquery.marks ASC;

```