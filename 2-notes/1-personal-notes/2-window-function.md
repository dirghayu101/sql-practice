# Window Function

- So to try out window function, I have created a local PSQL environment. Let's try out different scripts and observe the results.
 Checkout `../scripts/1-init.sql` for the local DB.

- I will be commenting my observations in the comments of these sql statements after running them:

 ```sql
 SELECT * FROM employee;
 SELECT * FROM department;
 
-- Get max salary and the employee's name earning the max_salary
SELECT first_name || ' ' || last_name AS empName,
MAX(salary) AS maxSalary
FROM employee
GROUP BY first_name || ' ' || last_name;
-- Since I am using MAX(), I have to use group by if there is any other attribute. This works, but it just orders employee based on their salary, and returns multiple employee. Not helpful.
-- Alternative to above big query:
SELECT first_name || ' ' || last_name AS empName,
    salary
FROM employee
ORDER BY salary desc;

-- Get max salary in each department.
SELECT d.dept_name,
MAX(salary) 
FROM employee e
    INNER JOIN department d ON e.dept_num = d.dept_num
GROUP BY d.dept_name;
;

-- How would you show the employee name as well in above case?
-- If you include the employee name, you will have to put it in group by as well, which would not give you the intended result.

-- over()
 ```

- So first of all we have aggregate functions, which include:
  - MIN()
  - MAX()
  - COUNT()
  - SUM()
  - AVG()
You use these functions with group by, but there is a rule which even profs talked about.
If you are using these function with Select and you introduce any other attribute, you have to put those attribute in GROUP BY clause. Or you can only use these functions by themselves.
- One of the reason behind this rule is these aggregate functions return a scalar value (refer professor's notes), which is a single value and if you have multiple attributes it kinda create a contradiction.
  - On a side note, type of values returned by a function are: Scalar, List and Table.
- Now to overcome this limitation of aggregate function we use window function.

```sql
-- Over in english literally means on top of.
SELECT e.*,
MAX(salary) OVER()
FROM employee e;
-- The query will return employee table with MAX salary in each row.

-- We will specify on top of what aggregate method MAX() will be executed.
SELECT e.*,
MAX(salary) OVER( PARTITION BY e.dept_num )
FROM employee e;
-- So we are partitioning the table based on dept_num and then applying aggregate method MAX on top of it. 
```

- So there are several functions that we can use with OVER to meet different use case/requirements.
  - Some of the commonly used ones are: row_number, rank, dense_rank, lead and lag.
  - The tutorial I am watching is specific to PSQL so there might be alternative to these methods or something with different syntax in oracle.

```sql
-- To assign row_number to every column.
SELECT e.*,
ROW_NUMBER() OVER() AS row_num
FROM employee e;

-- To assign row_number based on department.
SELECT e.*,
ROW_NUMBER() OVER( PARTITION BY e.dept_num ) AS row_num
FROM employee e;

-- To get count of employees in each department
-- Without windows
SELECT dept_num,
COUNT(emp_id) AS num_employees
FROM employee
GROUP BY dept_num;
-- With windows I realized is less optimal approach, but still let's say we want to print other related employee details alongside.
SELECT e.*,
COUNT(ROW_NUMBER() OVER( PARTITION BY e.dept_num )) OVER( PARTITION BY e.dept_num ) AS total_emp_dept
FROM employee e;
-- The above query doesn't work as window function cannot be nested.

-- Fetch the first employees in each department with department name who joined the company. Assume that employee with lower value of emp_id attribute joined the company earlier.
SELECT emp_id,
    first_name || ' ' || last_name AS emp_name,
    d.dept_name,
    ROW_NUMBER() OVER( PARTITION BY e.dept_num ORDER BY emp_id) AS rn
FROM employee e
    INNER JOIN department d ON e.dept_num = d.dept_num
WHERE rn = 1;
-- I wrote the above query initially and it didn't work because of order of execution. I am leaving it here for reference.

-- Corrected one for the above.
SELECT *
FROM (
    SELECT emp_id,
        first_name || ' ' || last_name AS emp_name,
        d.dept_name,
        ROW_NUMBER() OVER( PARTITION BY e.dept_num ORDER BY emp_id) AS rn
    FROM employee e
        INNER JOIN department d ON e.dept_num = d.dept_num
) sub
WHERE sub.rn = 1;
```

- Rank() is pretty useful. To test it out I updated my employee table and inserted new values.

```sql
SELECT * FROM employee;

SELECT emp_id,
    first_name || ' ' || last_name AS emp_name,
    RANK() OVER(PARTITION BY dept_num ORDER BY salary DESC) AS ranks
FROM employee;
```

- So in the above rank method result, I observed that if two employees have same salary they are given the same rank, but the employee following them gets sequential rank.
  - Example if X's and Y's salary is 100 and Z's salary is 90, the rank structure will be:
        X - 1
        Y - 1
        Z - 3

- In case of dense rank the same example rank will be:
    X - 1
    Y - 1
    Z - 2

```sql
SELECT emp_id,
    first_name || ' ' || last_name AS emp_name,
    DENSE_RANK() OVER(PARTITION BY dept_num ORDER BY salary DESC) AS ranks
FROM employee;
```

- LAG() and LEAD() - Checkout docs, I don't think I would be using it so I am not typing it here.
