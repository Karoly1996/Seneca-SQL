-- lab2 

-- Question 1 --
SELECT
    o.order_id AS "Order ID",
    SUM(oi.quantity) AS "Total Quantity",
    SUM(oi.quantity * p.list_price) AS "Total Amount"
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
GROUP BY
    o.order_id
HAVING
    SUM(oi.quantity) > 1000
ORDER BY
    o.order_id;

-- question 2 -- 
SELECT
    c.customer_id AS "CUSTOMER_ID",
    c.name AS "NAME",
    NVL(COUNT(o.order_id), 0) AS "Number of Orders"
FROM
    customers c
LEFT JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    (SUBSTR(c.name, 1, 1) = 'C' AND SUBSTR(c.name, 2, 1) = 'e') OR (SUBSTR(c.name, 1, 1) = 'C' AND SUBSTR(c.name, 3, 1) = 'e')
GROUP BY
    c.customer_id, c.name
ORDER BY
    COUNT(o.order_id) DESC, c.customer_id;
COLUMN name FORMAT A20;

-- Question 3 -- 
SELECT
    pc.category_id AS "CATEGORY_ID",
    pc.category_name AS "CATEGORY_NAME",
    NVL(ROUND(AVG(p.list_price), 2), 0) AS "Average Price",
    NVL(COUNT(p.product_id), 0) AS "Number of Products"
FROM
    product_categories pc
LEFT JOIN
    products p ON pc.category_id = p.category_id
GROUP BY
    pc.category_id, pc.category_name
ORDER BY
    pc.category_id;
COLUMN category_name FORMAT A20;

-- Question 4 -- 
SELECT
    i.warehouse_id AS "WAREHOUSE_ID",
    COUNT(DISTINCT i.product_id) AS "Number of Different Products",
    SUM(i.quantity) AS "Quantity of all products"
FROM
    inventories i
GROUP BY
    i.warehouse_id
ORDER BY
    SUM(i.quantity) DESC, i.warehouse_id;
    
-- Question 5 -- 
SELECT
    r.region_id AS "REGION_ID",
    r.region_name AS "Region Name",
    COUNT(DISTINCT w.warehouse_id) AS "Number of Warehouses"
FROM
    regions r
LEFT JOIN
    countries c ON r.region_id = c.region_id
LEFT JOIN
    locations l ON c.country_id = l.country_id
LEFT JOIN
    warehouses w ON l.location_id = w.location_id
GROUP BY
    r.region_id, r.region_name
HAVING
    COUNT(DISTINCT w.warehouse_id) > 0
ORDER BY
    r.region_id;

    