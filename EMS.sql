CREATE DATABASE EMS;
SHOW DATABASES;
USE EMS;


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) 
    REFERENCES departments(department_id)
);

INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date) 
VALUES	(1, 'John', 'Doe', 1, '2023-07-15'),
		(2, 'Jane', 'Smith', 2, '2022-08-20'),
		(3, 'Emily', 'Jones', 3, '2023-02-12'),
		(4, 'Michael', 'Brown', 1, '2021-11-05'),
		(5, 'Sarah', 'Davis', 2, '2023-08-30');
SELECT * FROM employees;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name) 
VALUES  (1, 'Engineering'),
		(2, 'Marketing'),
		(3, 'Sales');
SELECT * FROM departments;

CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (employee_id, from_date),
    FOREIGN KEY (employee_id) 
    REFERENCES employees(employee_id)
);

INSERT INTO salaries (employee_id, salary, from_date, to_date) 
VALUES  (1, 70000.00, '2023-07-15', NULL),
		(2, 65000.00, '2022-08-20', NULL),
		(3, 80000.00, '2023-02-12', NULL),
		(4, 60000.00, '2021-11-05', NULL),
		(5, 72000.00, '2023-03-30', NULL);

SELECT * FROM salaries;

-- SQL Queries:-

-- Query to Find All Employees Hired in the Last Year

-- SELECT first_name, last_name, hire_date FROM employees WHERE hire_date >= DATEADD(year, -1, GETDATE());
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);


-- Query to Calculate the Total Salary Expenditure for Each Department

SELECT d.department_name, SUM(s.salary) AS total_salary_expenditure
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- Query to Find the Top 5 Highest-Paid Employees Along with Their Department Names

SELECT e.first_name, e.last_name, d.department_name, MAX(s.salary) AS highest_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
ORDER BY highest_salary DESC LIMIT 5;




