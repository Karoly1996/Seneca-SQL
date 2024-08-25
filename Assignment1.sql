-- Assignment 1 Group Work

-- Question 1 

SELECT employee_id, last_name, hire_date
FROM employees
WHERE EXTRACT(DAY FROM hire_date) <= 
    CASE 
        WHEN EXTRACT(DAY FROM LAST_DAY(hire_date)) = 28 THEN 14
        WHEN EXTRACT(DAY FROM LAST_DAY(hire_date)) IN (29, 30) THEN 15
        ELSE 16
    END
AND TO_CHAR(hire_date, 'MM') > '06' 
ORDER BY employee_id;
COLUMN LAST_NAME FORMAT A15;

-- question 2

SELECT DISTINCT m1.manager_id
FROM employees m1
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.manager_id = m1.employee_id
)
ORDER BY m1.manager_id;

-- Question 3

SELECT DISTINCT o1.customer_id, oi1.product_id
FROM orders o1
JOIN order_items oi1 ON o1.order_id = oi1.order_id
JOIN orders o2 ON o1.customer_id = o2.customer_id
JOIN order_items oi2 ON o2.order_id = oi2.order_id
WHERE oi1.product_id = oi2.product_id
AND o1.order_date = o2.order_date + 100 
ORDER BY o1.customer_id;

-- quesiton 4

SELECT product_id AS "Product ID", TRUNC(order_date) AS "Order Date", COUNT(*) AS "Number of orders"
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM order_date) = 2016
GROUP BY product_id, TRUNC(order_date)
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY "Order Date", product_id;
COLUMN order_date FORMAT A20;

-- question 5

SELECT c.customer_id, c.name AS customer_name
FROM customers c
JOIN (
    SELECT o.customer_id, pc.category_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_categories pc ON p.category_id = pc.category_id
    GROUP BY o.customer_id, pc.category_id
    HAVING COUNT(DISTINCT p.product_id) > 6
) preferred_categories ON c.customer_id = preferred_categories.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(*) = 3
ORDER BY c.customer_id;
COLUMN name FORMAT A20;

-- question 6

(I DONT KNOW)


-- question 7

SELECT e.first_name
FROM employees e
LEFT JOIN contacts c ON e.first_name = c.first_name
WHERE e.first_name LIKE 'B%'
AND c.first_name IS NULL
ORDER BY e.first_name;
COLUMN employees FORMAT A20;

-- question 8 

SELECT 
    EXTRACT(MONTH FROM o.order_date) AS "Month Number",
    TO_CHAR(o.order_date, 'Month') AS "Month",
    EXTRACT(YEAR FROM o.order_date) AS "Year",
    COUNT(o.order_id) AS "Total Number of Orders",
    SUM(oi.quantity * oi.unit_price) AS "Sales Amount"
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
WHERE 
    EXTRACT(YEAR FROM o.order_date) = 2016
GROUP BY 
    EXTRACT(MONTH FROM o.order_date),
    TO_CHAR(o.order_date, 'Month'),
    EXTRACT(YEAR FROM o.order_date)
ORDER BY 
    EXTRACT(MONTH FROM o.order_date);
    
-- question 9 

WITH MonthlyAvg AS (
    SELECT 
        EXTRACT(MONTH FROM o.order_date) AS Month_Number,
        TO_CHAR(o.order_date, 'Month') AS Month_Name,
        ROUND(AVG(oi.quantity * oi.unit_price), 2) AS Avg_Sales_Amount
    FROM 
        orders o
        JOIN order_items oi ON o.order_id = oi.order_id
    WHERE 
        EXTRACT(YEAR FROM o.order_date) = 2016
    GROUP BY 
        EXTRACT(MONTH FROM o.order_date), TO_CHAR(o.order_date, 'Month')
),
YearlyAvg AS (
    SELECT 
        ROUND(AVG(oi.quantity * oi.unit_price), 2) AS Avg_Sales_Amount_Year
    FROM 
        orders o
        JOIN order_items oi ON o.order_id = oi.order_id
    WHERE 
        EXTRACT(YEAR FROM o.order_date) = 2016
)
SELECT 
    m.Month_Number,
    m.Month_Name,
    m.Avg_Sales_Amount
FROM 
    MonthlyAvg m
    CROSS JOIN YearlyAvg y
WHERE 
    m.Avg_Sales_Amount > y.Avg_Sales_Amount_Year
ORDER BY 
    m.Month_Number;





