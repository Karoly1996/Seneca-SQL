    Question 1
CREATE TABLE employee2 AS SELECT * FROM employees;
SELECT * FROM employee2;

    Question 2
INSERT INTO employee2

(
  employeeNumber,
  firstName,
  lastName,
  extension,
  email,
  officeCode,
  reportsTo,
  jobTitle
)
VALUES
(
  1705,
  'Jane',
  'Doe',
  '234',
  'jdoe@example.com',
  '5',
  1056,
  'Sales Rep'
);

    Question 3
UPDATE employee2
SET 
lastName = 'Karoly',
firstName = 'Nemeth'
WHERE employeeNumber = 1705;

    Question 4
ALTER TABLE employee2
ADD username VARCHAR2(50);

    Question 5
UPDATE employee2
SET username = LOWER(SUBSTR(firstName, 1 ,1) || lastName || employeeNumber);

    Question 6
DELETE FROM employee2
WHERE officeCode IN (3,4);