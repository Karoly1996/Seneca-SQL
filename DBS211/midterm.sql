--EXTRACT--
SELECT First_name, last_name
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1998



