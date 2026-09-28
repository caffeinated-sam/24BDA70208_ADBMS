DROP TABLE IF EXISTS category_master CASCADE;
DROP TABLE IF EXISTS product_master CASCADE;
DROP TABLE IF EXISTS customer_master CASCADE;
DROP TABLE IF EXISTS order_details CASCADE;

CREATE TABLE category_master (
    category_id VARCHAR(5) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE product_master (
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category_id VARCHAR(5)
        REFERENCES category_master(category_id)
);

CREATE TABLE customer_master (
    customer_id VARCHAR(5) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

CREATE TABLE order_details (
    order_id VARCHAR(5) NOT NULL,
    customer_id VARCHAR(5)
        REFERENCES customer_master(customer_id),
    product_id VARCHAR(5)
        REFERENCES product_master(product_id),
    quantity INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL
);


INSERT INTO category_master
(category_id, category_name)
VALUES
('C1', 'Electronics'),
('C2', 'Clothing'),
('C3', 'Books');

INSERT INTO product_master
(product_id, product_name, category_id)
VALUES
('P101', 'Laptop', 'C1'),
('P102', 'Headphones', 'C1'),
('P201', 'Jacket', 'C2'),
('P202', 'Shoes', 'C2'),
('P301', 'SQL Book', 'C3');

INSERT INTO customer_master
(customer_id, customer_name)
VALUES
('U1', 'Aman'),
('U2', 'Priya'),
('U3', 'Rahul'),
('U4', 'Simran');

INSERT INTO order_details
(order_id, customer_id, product_id, quantity, unit_price)
VALUES
('O101', 'U1', 'P101', 1, 5000),
('O102', 'U2', 'P102', 2, 1000),
('O103', 'U1', 'P201', 1, 3000),
('O104', 'U3', 'P202', 2, 2000),
('O105', 'U4', 'P301', 3, 500),
('O106', 'U2', 'P101', 1, 5000),
('O107', 'U3', 'P201', 1, 3000),
('O108', 'U4', 'P102', 1, 1000);

DROP MATERIALIZED VIEW mw_category_report

EXPLAIN ANALYZE 
CREATE MATERIALIZED VIEW mw_category_report
AS
select cm.category_id as CatID, 
		cm.category_name as CatName,
		SUM(od.quantity) as TOTAL_PRODUCT,
		COUNT(DISTINCT od.order_id) as TOTAL_ORDERS,
		COUNT(DISTINCT od.customer_id) as Unique_Customer,
		SUM(od.quantity * od.unit_price) as TOTAL_REVENUE,
		ROUND( SUM(od.quantity * od.unit_price)/COUNT(DISTINCT od.order_id) ,2) as AVG_REVENUE,
		(CASE WHEN SUM(od.quantity * od.unit_price) >= 10000 THEN 'Excellent'
		WHEN SUM(od.quantity * od.unit_price) >= 6000 THEN 'Good'
		WHEN SUM(od.quantity * od.unit_price) >= 3000 THEN 'Average'
		ELSE 'Low' END) as Category_performance
from Order_details as od
JOIN product_master as pm
ON od.product_id = pm.product_id
JOIN category_master as cm
ON cm.category_id = pm.category_id
GROUP BY cm.category_id, cm.category_name

SELECT * FROM mw_category_report

