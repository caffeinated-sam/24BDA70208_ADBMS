CREATE TABLE customer_master
(
    customer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    city VARCHAR(30)
);

CREATE TABLE product_catalog
(
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL
);

CREATE TABLE sales_orders
(
    order_id SERIAL PRIMARY KEY,
    product_id VARCHAR(5)
        REFERENCES product_catalog(product_id),

    quantity INT NOT NULL,

    customer_id VARCHAR(5)
        REFERENCES customer_master(customer_id),

    discount_percent NUMERIC(5,2),

    order_date DATE NOT NULL
);

INSERT INTO customer_master
(customer_id, full_name, city)
VALUES
('C1', 'Amit Sharma', 'Delhi'),
('C2', 'Priya Verma', 'Mumbai'),
('C3', 'Ravi Kumar', 'Bangalore'),
('C4', 'Neha Singh', 'Kolkata'),
('C5', 'Arjun Mehta', 'Hyderabad');

INSERT INTO product_catalog
(product_id, product_name, unit_price)
VALUES
('P1', 'Smartphone X100', 25000),
('P2', 'Laptop Pro 15', 65000),
('P3', 'Wireless Earbuds', 5000),
('P4', 'Smartwatch Fit', 30000),
('P5', 'Gaming Console', 45000);


INSERT INTO sales_orders
(product_id, quantity, customer_id, discount_percent, order_date)
VALUES
('P1', 2, 'C1', 5, '2025-09-01'),
('P2', 1, 'C2', 10, '2025-09-02'),
('P3', 3, 'C3', 0, '2025-09-03'),
('P4', 1, 'C4', 8, '2025-09-04'),
('P5', 1, 'C5', 12, '2025-09-05'),
('P1', 1, 'C2', 5, '2025-09-06'),
('P3', 2, 'C1', 0, '2025-09-07');



CREATE OR REPLACE VIEW vw_sales_report as
select   t.order_id, cc.full_name,t.quantity,  t.final_am as final_amount
FROM (
		select so.discount_percent, so.product_id, so.customer_id,so.order_id, so.quantity, (
			(pc.unit_price * so.quantity * so.discount_percent )/100
			) as final_am
	FROM sales_orders as so
	JOIN product_catalog as pc
	ON so.product_id = pc.product_id
) t
JOIN customer_master as cc
ON cc.customer_id =t.customer_id

SELECT * from vw_sales_report

CREATE USER Exp_8_user with PASSWORD '1234';
GRANT SELECT ON vw_sales_report TO Exp_8_user;