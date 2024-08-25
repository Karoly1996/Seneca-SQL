Question 1
SELECT employees.employeenumber, employees.firstname,employees.lastname, offices.city, offices.phone, offices.postalcode
FROM employees
INNER JOIN offices  
ON employees.officecode = offices.officecode
WHERE UPPER(offices.country) = 'FRANCE';

Question 2
SELECT customernumber, customername, TO_CHAR (paymentdate, 'MON DD, YYYY') as paymentdate, amount
FROM customers INNER JOIN payments USING (customernumber)
WHERE UPPER(country) = 'CANADA'
ORDER BY customernumber;

Question 3
SELECT customernumber, customername
FROM customers LEFT JOIN payments USING (customernumber)
WHERE payments.amount IS NULL
AND UPPER(country) = 'USA'
ORDER BY customernumber;

Question 4
CREATE VIEW vwCustomerOrder AS 
SELECT customernumber, ordernumber, orderdate, productname, quantityordered, buyprice
FROM orders JOIN orderdetails USING (ordernumber) 
JOIN products ON orderdetails.productcode = products.productcode;
SELECT * FROM vwCustomerOrder;

Question 5
SELECT customernumber, ordernumber, orderlinenumber
FROM vwCustomerOrder 
JOIN orderdetails USING (ordernumber) 
WHERE customernumber = 124 
ORDER BY ordernumber, orderlinenumber;

question 6
SELECT c.customernumber, c.contactfirstname, c.contactlastname, c.phone, c.creditlimit 
FROM customers c 
LEFT JOIN orders b 
ON c.customernumber = b.customernumber
WHERE b.customernumber IS NULL;

question 7
CREATE VIEW vwEmployeeManager AS 
(SELECT empl.employeenumber ,empl.lastname, empl.firstname, empl.extension, empl.email, empl.officecode,empl.reportsto, empl.jobtitle,man.firstname AS "managerFirstName",man.lastname AS "managersLastName"
FROM employees empl 
LEFT JOIN  employees man
ON empl.reportsto = man.employeenumber); 

quesiton 8
ALTER VIEW vwEmployeeManager AS
SELECT emp.EmployeeID, emp.FirstName, emp.LastName, man.FirstName AS ManagerFirstName, man.LastName AS ManagerLastName
FROM Employees emp
JOIN Employees man ON emp.ManagerID = man.EmployeeID
WHERE emp.ManagerID IS NOT NULL;

question 9
DROP VIEW vwCustomerOrder; 
DROP VIEW vwEmployeeManager;