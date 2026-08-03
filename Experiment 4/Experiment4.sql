-- PART A (i).
CREATE TABLE tbl_happiness
(
    sno INT PRIMARY KEY,
    rankings INT,
    country VARCHAR(50)
);

INSERT INTO tbl_happiness
VALUES
(1,1,'Finland'),
(2,2,'Denmark'),
(3,3,'Iceland'),
(4,4,'Israel'),
(5,5,'Netherlands'),
(6,6,'Sweden'),
(7,7,'Norway'),
(8,126,'India'),
(9,128,'Sri Lanka');

Select rankings, country
FROM (
	SELECT rankings, country, (
		CASE
			WHEN country = 'India' THEN 1
			WHEN country = 'Sri Lanka' THEN 2
			ELSE 3
		END
		) as ranks
	FROM tbl_happiness 
	ORDER BY ranks, rankings
)

-- END (i)

--- PART A (ii)
Select rankings, country
FROM (
	SELECT rankings, country, (
		CASE
			WHEN country = 'India' THEN 1
			WHEN country = 'Sri Lanka' THEN 2
			ELSE 3
		END
		) as ranks
	FROM tbl_happiness 
	ORDER BY ranks ASC, rankings DESC
)
-- END (ii)


-- PART B

CREATE TABLE Employees
(
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    reports_to INT,
    age INT
);

INSERT INTO Employees (employee_id, name, reports_to, age)
VALUES
(9,  'Hercy',   NULL, 43),
(6,  'Alice',   9,    41),
(4,  'Bob',     9,    36),
(2,  'Winston', NULL, 37);

select m.employee_id, m.name ,count(*), sum(e.age)/count(*) as average_age
from employees as e
JOIN employees as m
on e.reports_to = m.employee_id
group by m.employee_id, m.name
-- END