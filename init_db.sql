CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    cost_price DECIMAL(10, 2),
    sale_price DECIMAL(10, 2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    country VARCHAR(50),
    segment VARCHAR(20)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers (customer_id),
    product_id INT REFERENCES products (product_id),
    order_date DATE,
    quantity INT
);

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_id INT REFERENCES orders (order_id),
    return_reason VARCHAR(255)
);

INSERT INTO products
VALUES (101, 'Malmo Sofa', 'Furniture', 400.00, 850.00 );

INSERT INTO products
VALUES ( 102, 'Oslo Lamp', 'Lighting', 25.00, 75.00 );

INSERT INTO products
VALUES ( 103, 'Wool Blanket', 'Decor',15.00, 45.00);

INSERT INTO customers 
VALUES (1, 'Lukas', 'Germany', 'B2C');

INSERT INTO customers 
VALUES (2, 'Emma', 'Sweden', 'B2C');

INSERT INTO orders 
VALUES (5001, 1, 101, '2026-02-01', 1);

INSERT INTO orders 
VALUES (5002, 2, 102, '2026-02-02', 2);

ALTER TABLE customers ADD COLUMN second_name VARCHAR(50);

UPDATE customers SET second_name = 'McDonald' WHERE customer_id = 1;

UPDATE customers SET second_name = 'Bond' WHERE customer_id = 2;

ALTER TABLE products
ADD COLUMN auto_margin DECIMAL(10, 2) 
GENERATED ALWAYS AS (sale_price - cost_price) STORED;

ALTER TABLE products
ADD COLUMN margin_percent numeric 
GENERATED ALWAYS AS (ROUND(((sale_price - cost_price) / sale_price ) * 100, 2 )
        ) STORED;

UPDATE products SET sale_price = 80 WHERE product_id = 102;

/* Added data for returns and new sales*/

INSERT INTO returns (return_id, order_id, return_reason)
VALUES 
(901, 5002, 'Wrong color'),
(902, 5002, 'Damaged during transport'),
(903, 5003, 'Damaged during transport');

/INSERT INTO customers (customer_id, first_name, country , segment, second_name)
VALUES
(3, 'Rachel', 'Germany', 'B2C', 'Green'),
(4, 'Phybie', 'France', 'B2C', 'Bufe'),
(5, 'Monica', 'Sweden', 'B2C', 'Gilmore');

INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity)
VALUES
(5003, 3, 103, '2026-03-02', 1),
(5004, 4, 102, '2026-03-02', 2),
(5005, 5, 101, '2026-03-02', 1);

ALTER TABLE products ADD COLUMN initial_stock INT;

UPDATE products SET initial_stock = 50 WHERE product_id = 101; 
UPDATE products SET initial_stock = 200 WHERE product_id = 102; 
UPDATE products SET initial_stock = 150 WHERE product_id = 103;

CREATE SEQUENCE orders_order_id_seq;
ALTER TABLE orders 
ALTER COLUMN order_id SET DEFAULT nextval('orders_order_id_seq');
ALTER SEQUENCE orders_order_id_seq OWNED BY orders.order_id;
SELECT setval('orders_order_id_seq', 5005);

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES

(1, 101, '2026-02-01', 2),
(2, 101, '2026-02-05', 1),
(3, 101, '2026-02-10', 3),
(4, 101, '2026-02-15', 2),
(5, 101, '2026-02-20', 1),
(1, 101, '2026-02-22', 2),
(2, 101, '2026-02-25', 1),
(3, 101, '2026-02-28', 1),

(4, 103, '2026-02-03', 5),
(5, 103, '2026-02-08', 3),
(1, 103, '2026-02-12', 4),
(2, 103, '2026-02-18', 6),
(3, 103, '2026-02-21', 2),

(4, 102, '2026-02-02', 2),
(5, 102, '2026-02-07', 1),
(1, 102, '2026-02-26', 1);

INSERT INTO products (product_id, product_name, category, cost_price, sale_price, initial_stock) VALUES

(104, 'Stockholm Chair', 'Furniture', 150.00, 320.00, 100),
(105, 'Fjord Mirror', 'Decor', 40.00, 95.00, 80),
(106, 'Danish Shelf', 'Furniture', 80.00, 180.00, 60),
(107, 'Lumi Candle', 'Decor', 5.00, 15.00, 500),
(108, 'Art Poster', 'Decor', 10.00, 35.00, 300);

INSERT INTO returns (return_id, order_id, return_reason) VALUES
(904, 5002, 'Defective'), 
(905, 5006, 'Defective');

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES

(1, 101, '2026-03-01', 3), 
(2, 101, '2026-03-05', 2), 
(3, 104, '2026-03-07', 5),
(4, 101, '2026-03-10', 2), 
(5, 104, '2026-03-12', 3), 
(1, 101, '2026-03-15', 1),

(2, 103, '2026-03-02', 10), 
(3, 106, '2026-03-04', 4), 
(4, 105, '2026-03-06', 6),
(5, 103, '2026-03-08', 8), 
(1, 106, '2026-03-11', 5), 
(2, 105, '2026-03-14', 4),

(3, 107, '2026-03-01', 50), 
(4, 107, '2026-03-03', 30), 
(5, 108, '2026-03-05', 15),
(1, 107, '2026-03-07', 40), 
(2, 108, '2026-03-09', 10), 
(3, 102, '2026-03-12', 1);
