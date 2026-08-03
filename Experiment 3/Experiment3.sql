-- Part A
CREATE TABLE Employee
(
    EID INT PRIMARY KEY,
    DEPT VARCHAR(10),
    SCORES DECIMAL(5,2)
);

INSERT INTO Employee (EID, DEPT, SCORES)
VALUES
(1, 'D1', 1.00),
(2, 'D1', 5.28),
(3, 'D1', 4.00),
(4, 'D2', 8.00),
(5, 'D1', 2.50),
(6, 'D2', 7.00),
(7, 'D3', 9.00),
(8, 'D4', 10.20);


Update  Employee e
set scores = t.max_score
FROM (
Select dept, max(scores) as max_score
FROM EMPLOYEE
group by dept
) t
WHERE e.dept = t.dept

-- to view the table
Select * from employee
ORDER BY dept;

--- Part A END




--- Part B Start
-- A company maintains records of products sold by different salespersons. The management wants to prepare a sales 
-- performance report by identifying the salesperson(s) who generated the highest overall sales revenue. 
-- If multiple salespersons have the same highest total sales amount, all of them must be included in the final report. 
-- Return the seller ID(s) satisfying this condition.


CREATE TABLE SalesPerson
(
    seller_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission INT
);

CREATE TABLE Company
(
    com_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    order_date DATE,
    com_id INT,
    seller_id INT,
    amount INT,
    FOREIGN KEY (com_id)
        REFERENCES Company(com_id),
    FOREIGN KEY (seller_id)
        REFERENCES SalesPerson(seller_id)
);

INSERT INTO SalesPerson
VALUES
(1,'John','New York',15),
(2,'Amy','Los Angeles',13),
(3,'Mark','Chicago',12),
(4,'Pam','Boston',15);

INSERT INTO Company
VALUES
(1,'RED','Boston'),
(2,'ORANGE','New York'),
(3,'YELLOW','Boston'),
(4,'GREEN','Austin');

INSERT INTO Orders
VALUES
(1,'2024-01-10',1,1,1200),
(2,'2024-01-12',2,1,800),
(3,'2024-01-15',3,2,2500),
(4,'2024-01-18',1,3,1500),
(5,'2024-01-22',4,2,700),
(6,'2024-01-25',2,3,2000),
(7,'2024-01-28',3,4,3000),
(8,'2024-01-30',4,4,200);

SELECT * FROM Orders

SELECT * FROM Company

Select * from Salesperson;

SELECT Seller_id
FROM Orders
GROUP BY seller_id
HAVING SUM(amount) = (
SELECT MAX(am) as max_am
FROM (
SELECT seller_id, SUM(amount) as am 
FROM Orders as o
group by seller_id
) t 
) 

-- PART B END


-- PART C START
CREATE TABLE Department
(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Department (id, name)
VALUES
(1, 'IT'),
(2, 'Sales');


CREATE TABLE Employee
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId)
    REFERENCES Department(id)
);

INSERT INTO Employee (id, name, salary, departmentId)
VALUES
(1, 'Joe',   85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam',   60000, 2),
(4, 'Max',   90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will',  70000, 1);


SELECT
    d.name AS dept,
    e.name AS employee,
    e.salary
FROM Employee AS e
JOIN Department AS d
    ON e.departmentid = d.id
WHERE (
    SELECT COUNT(DISTINCT e2.salary)
    FROM Employee AS e2
    WHERE e2.departmentid = e.departmentid
      AND e2.salary > e.salary
) < 3
ORDER BY e.salary DESC;