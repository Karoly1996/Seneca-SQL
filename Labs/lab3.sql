-- lab 3

-- question 1
   
COLUMN last_name FORMAT A15;
COLUMN hire_date FORMAT A15;
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('2016-08-31', 'YYYY-MM-DD')
AND hire_date < (SELECT hire_date
                 FROM employees
                 WHERE employee_id = 46
                )
ORDER BY hire_date, employee_id;

-- Question 2
COLUMN name FORMAT A23;
SELECT
  c.name AS NAME,
  c.credit_limit AS CREDIT_LIMIT
FROM
  customers c
WHERE
  c.credit_limit = ROUND((SELECT AVG(credit_limit) FROM customers), -2)
ORDER BY
  c.customer_id;

-- Question 3
COLUMN product_name FORMAT A30;
SELECT category_id, product_id, product_name, list_price
FROM products
WHERE (category_id,list_price) IN (SELECT category_id, MIN(list_price)
                    FROM products
                    GROUP BY category_id)
ORDER BY category_id, product_id;

-- quesiton 4
SELECT
  pc.category_id,
  pc.category_name,
  p.product_name,
  p.list_price
FROM
  products p
  JOIN product_categories pc ON p.category_id = pc.category_id
WHERE
  p.list_price = (SELECT MAX(list_price) FROM products);
  
  -- QUESTION 5
select product_name, list_price
from products
where category_id = 1 
  and list_price <  (select max(min(list_price))
                          from products
                      group by category_id)
order by list_price desc, product_id;


SELECT product_name, list_price
FROM products
WHERE category_id = 1 
  AND list_price < ANY (SELECT max(min(list_price))
                       FROM products
                       GROUP BY category_id)
ORDER BY list_price DESC, product_id;

-- question 6
SELECT
    category_id,
    min(list_price) AS "least price"
FROM
    products
HAVING max(list_price) = (SELECT max(list_price)
                            FROM products)
GROUP BY category_id;


