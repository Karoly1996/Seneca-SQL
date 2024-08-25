Lab 3 SIMPLE SELECT;

//Question 1
SELECT * FROM offices;

//Question 2
SELECT employeenumber
FROM employees
WHERE officecode = 1;

//Question 3
SELECT customernumber, customername, contactfirstname, contactlastname, phone
FROM customers
WHERE upper(city) = 'PARIS';

//Question 4
SELECT customernumber,
customername,
contactlastname||', '||contactfirstname AS contact,
phone
FROM customers
WHERE UPPER(country) = 'CANADA';

//Question 5
SELECT DISTINCT customernumber
FROM payments;

//Question 6
SELECT customernumber, checknumber, amount
FROM payments
WHERE amount NOT BETWEEN 30000 AND 65000
ORDER BY amount DESC;

//Question 7
SELECT productcode, productname, buyprice, msrp, msrp - buyprice AS markup,
ROUND (100 * (msrp - buyprice) / buyprice,1) AS percmarkup
FROM products; 

//Question 8
SELECT *  FROM products 
WHERE UPPER(productname) LIKE '%CO%';

//Question 9
SELECT * FROM customers
WHERE UPPER(contactfirstname) LIKE 'S%E%';


