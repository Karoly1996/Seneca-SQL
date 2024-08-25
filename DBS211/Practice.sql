Create a query that shows employee number, first name, last name, city, 
phone number and postal code for all employees with an office in France.

SELECT employeeNumber, firstname, lastname, city, phone, postalcode 
FROM employees INNER JOIN offices
ON employees.officecode = offices.officecode
WHERE country = 'France';


________
Create a query that displays all payments made by customers from Canada that has the following properties.  
Sort the output by Customer Number ascending order.  
Only display the Customer Number, Customer Name, Payment Date and Amount.   
Make sure the date is displayed clearly to know what date it is. (i.e. what date is 02-04-19??? – Feb 4, 2019, April 2, 2019, April 19, 2002, ….). I would like it displayed something like December 18, 2003.
Hint: Use the to_char function to convert the date display. Here is a link https://www.techonthenet.com/oracle/functions/to_char.php

SELECT
customers.customerNumber,
customers.customerName,
TO_CHAR(payments.paymentDate, 'MON DD, YYYY'),
payments.amount
FROM customers LEFT JOIN payments
ON customers.customerNumber = payments.customerNumber
ORDER BY customerNumber ASC;


_______

SELECT movieTitle, ratingCode
FROM movie INNER JOIN Rating
ON movie.ratingID = rating.ratingID
WHERE ratingCode LIKE 'PG-13';

SELECT ratingCode
FROM rating LEFT JOIN movie
ON rating.ratingid = movie.ratingid
WHERE movie.movieID IS NULL;

SELECT movieTitle
FROM movie INNER JOIN ActorDetail
ON movie.movieID = ActorDetail.MovieID
INNER JOIN Actor ON Actordetail.actorID LIKE Actor.ActorID
WHERE actor.actorFname = 'tom', actor.actorLname LIKE 'hanks';

SELECT first name || '' || last name AS 'Teacher', title AS "Subject"
FROM Teachers t1 INNER JOIN Subject/teacher t2
ON t1.teacher id = t2.teacher id 
INNER JOIN Subjects t3
ON t2.subject id = t3.subject id;

SELECT first_name || '' || last_name AS "Teacher", subject_id 
FROM Teachers LEFT JOIN 


CREATE TABLE practice (
    studentID VARCHAR2(50) PIM