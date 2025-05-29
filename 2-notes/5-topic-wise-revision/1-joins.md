# Notes on join

Both of these will give the same result:

```sql
-- Case 1:
SELECT s.date, p.sales_person, p.team, s.amount
FROM shipments s
JOIN people p ON p.sp_id = s.sp_id 
WHERE p.sales_person = 'Barr Faughny';

-- Case 2:
SELECT s.date, p.sales_person, p.team, s.amount
FROM shipments s
JOIN people p ON p.sp_id = s.sp_id AND p.sales_person = 'Barr Faughny';
```

Another good example:

```sql
WITH febProducts AS (
    SELECT pr.products, s.amount, s.date
    FROM products pr LEFT JOIN shipment s 
    ON s.product_id = pr.product_id AND s.date = '2022-2-1'
)
SELECT product,
    SUM(amount) as "Sales",
    "Sales Status" = 
        CASE WHEN SUM(amount) > 0 THEN 'Shipped'
        ELSE 'Not Shipped'
    END
FROM febProducts
GROUP BY products;
```
