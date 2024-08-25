CREATE TABLE newEmployees AS SELECT * FROM employees; 
 
Now execute the following command. 
 
SET AUTOCOMMIT OFF; 

INSERT ALL
INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle) VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', 1, NULL, 'Sales Rep')
INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle) VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', 4, NULL, 'Sales Rep')
INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle) VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', 2, NULL, 'Sales Rep')
INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle) VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', 3, NULL, 'Sales Rep')
INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle) VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', 1, NULL, 'Sales Rep')
SELECT * FROM dual;


// question 1
INSERT INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle)
VALUES
    (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', 1, NULL, 'Sales Rep'),
    (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', 4, NULL, 'Sales Rep'),
    (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', 2, NULL, 'Sales Rep'),
    (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', 3, NULL, 'Sales Rep'),
    (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', 1, NULL, 'Sales Rep');

// question 2
SELECT * FROM newEmployees;
SELECT COUNT(*) AS row_count FROM newEmployees;

// question 3
ROLLBACK;
SELECT * FROM newEmployees;

// question 4
INSERT INTO newEmployees (employeeNumber, lastname, firstname, extension, email, OfficeCode, reportsTo, jobTitle)
VALUES
    (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', 1, NULL, 'Sales Rep'),
    (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', 4, NULL, 'Sales Rep'),
    (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', 2, NULL, 'Sales Rep'),
    (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', 3, NULL, 'Sales Rep'),
    (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', 1, NULL, 'Sales Rep');
    
COMMIT;

SELECT * FROM newEmployees;


// Question 5
ROLLBACK;
SELECT * FROM newEmployees;

// Question 6 
UPDATE newEmployees
SET jobTitle = 'unknown';

COMMIT;

// Question 7
ROLLBACK;

SELECT * FROM newEmployees WHERE jobTitle = 'unknown';

