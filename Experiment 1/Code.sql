//Ans 1
SELECT 'LOW SALARY' AS CATEGORY , COUNT ( ACCOUNT_ID) AS ACCOUNT_COUNT
FROM ACCOUNTS
WHERE INCOME < 20000

UNION ALL

SELECT 'AVERAGE SALARY' AS CATEGORY , COUNT ( ACCOUNT_ID) AS
ACCOUNT_COUNT
FROM ACCOUNTS
WHERE INCOME >= 20000 AND INCOME <= 50000

UNION ALL

SELECT 'HIGH SALARY' AS CATEGORY , COUNT ( ACCOUNT_ID) AS ACCOUNT_COUNT
FROM ACCOUNTS
WHERE INCOME >50000;

//Ans 2
CREATE TABLE Departments (
dept_id INT PRIMARY KEY , dept_name VARCHAR (50)
);

CREATE TABLE Employees (
emp_id INT PRIMARY KEY , name VARCHAR (50),
dept_id  INT ,
FOREIGN KEY (dept_id)
REFERENCES Departments(dept_id)
);

CREATE TABLE Salaries (
emp_id  INT ,
salary NUMERIC (10 ,2), FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

INSERT  INTO  Departments  VALUES
(1 ,'HR'),
(2 ,'IT'),
(3 ,'Finance');

INSERT  INTO  Employees  VALUES
(101 ,'Alice',1),
(102 ,'Bob',2),
(103 ,'Charlie',1),
(104 ,'David',3);

INSERT INTO Salaries VALUES
(101 ,35000),
(102 ,60000),
(103 ,28000),
(104 ,45000);

SELECT
e.name , d.dept_name ,
s.salary

FROM Employees e

JOIN  Departments  d
ON e. dept_id=d.dept_id

JOIN Salaries s
ON  e.emp_id=s.emp_id;

UPDATE Salaries

SET salary=salary*1.10

WHERE emp_id IN
(
SELECT emp_id
FROM Employees
WHERE dept_id=
(
SELECT dept_id
FROM Departments
WHERE dept_name='HR'
)
);

DELETE FROM Salaries
WHERE  salary <30000;

SELECT
e.name ,
s.salary

FROM Employees e

JOIN Salaries s
ON  e.emp_id=s.emp_id

WHERE salary > (
SELECT AVG (salary) FROM Salaries
);

//Ans 3
SELECT

CONCAT_WS(', ',
t1.topping_name , t2.topping_name     , t3. topping_name) AS pizza ,

(t1. ingredient_cost+ t2. ingredient_cost+t3. ingredient_cost)  AS  total_cost

FROM pizza_toppings t1

JOIN pizza_toppings t2
ON  t1.topping_name <t2. topping_name

JOIN pizza_toppings t3
ON  t2.topping_name <t3. topping_name

ORDER BY total_cost DESC , pizza;

//Ans 4
SELECT DISTINCT

t1.user_id

FROM amazon_transactions t1 JOIN amazon_transactions t2 ON t1.user_id=t2.user_id
AND  t2.created_at >t1. created_at

AND       t2.created_at  <= t1. created_at+ INTERVAL '7 days'

ORDER BY user_id;
