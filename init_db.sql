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

INSERT INTO
    products
VALUES (
        101,
        'Malmo Sofa',
        'Furniture',
        400.00,
        850.00
    );

INSERT INTO
    products
VALUES (
        102,
        'Oslo Lamp',
        'Lighting',
        25.00,
        75.00
    );

INSERT INTO
    products
VALUES (
        103,
        'Wool Blanket',
        'Decor',
        15.00,
        45.00
    );

INSERT INTO customers VALUES (1, 'Lukas', 'Germany', 'B2C');

INSERT INTO customers VALUES (2, 'Emma', 'Sweden', 'B2C');

INSERT INTO orders VALUES (5001, 1, 101, '2026-02-01', 1);

INSERT INTO orders VALUES (5002, 2, 102, '2026-02-02', 2);

ALTER TABLE customers ADD COLUMN second_name VARCHAR(50);

UPDATE customers SET second_name = 'McDonald' WHERE customer_id = 1;

UPDATE customers SET second_name = 'Bond' WHERE customer_id = 2;

ALTER TABLE products
ADD COLUMN auto_margin DECIMAL(10, 2) GENERATED ALWAYS AS (sale_price - cost_price) STORED;

ALTER TABLE products
ADD COLUMN margin_percent numeric GENERATED ALWAYS AS (
    ROUND(
        (
            (sale_price - cost_price) / sale_price
        ) * 100,
        2
    )
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