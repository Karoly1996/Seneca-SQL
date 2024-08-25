-- Question 1
SELECT
  'Total number of customers and employees: ' || 
  TO_CHAR(SUM(cnt)) AS Report
FROM (
  SELECT COUNT(*) AS cnt FROM customers
  UNION ALL
  SELECT COUNT(*) FROM employees
);


-- Question 2
SELECT COUNT(*) AS "Number of Customers"
FROM Customers
MINUS
SELECT COUNT(*) AS "Number of Customers"
FROM Orders;

-- Question 3
SELECT
  'Number of customers with orders: ' || TO_CHAR(COUNT(DISTINCT customer_id)) AS Report
FROM orders
UNION ALL
SELECT
  'Number of sales persons: ' || TO_CHAR(COUNT(DISTINCT salesman_id))
FROM orders;

-- Question 4
COLUMN first_name FORMAT A15;
COLUMN "First Letter of Last Name" FORMAT A15;
SELECT
    first_name,
    SUBSTR(last_name, 1, 1) AS "First Letter of Last Name"
FROM contacts
INTERSECT
SELECT
    first_name,
    SUBSTR(last_name, 1, 1) AS "First Letter of Last Name"
FROM employees;


-- question 5 

SELECT location_id,
       CASE 
           WHEN warehouse_id IS NULL THEN 'NULL'
           ELSE TO_CHAR(warehouse_id)
       END AS warehouse_id
FROM (
    SELECT l.location_id, w.warehouse_id
    FROM locations l, warehouses w
    WHERE l.location_id = w.location_id
    UNION ALL
    SELECT l.location_id, NULL AS warehouse_id
    FROM locations l
    WHERE NOT EXISTS (
        SELECT 1
        FROM warehouses w
        WHERE l.location_id = w.location_id
    )
)
ORDER BY warehouse_id NULLS LAST, location_id;







