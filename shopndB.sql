--Create tables for product categories, products, customers, orders, and order items
CREATE TABLE product_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(20)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--Insert sample data into the tables
INSERT INTO product_categories (category_id, category_name)
VALUES (1, 'Electronics'), (2, 'Clothing'), (3, 'Books');

INSERT INTO products (product_id, product_name, category_id, price)
VALUES (1, 'Smartphone', 1, 500.00), (2, 'Laptop', 1, 1000.00),
       (3, 'T-Shirt', 2, 20.00), (4, 'Jeans', 2, 50.00),
       (5, 'Novel', 3, 10.00), (6, 'Cookbook', 3, 15.00);

INSERT INTO customers (customer_id, first_name, last_name, email, phone)
VALUES (1, 'John', 'Doe', 'johndoe@email.com', '555-1234'),
       (2, 'Jane', 'Doe', 'janedoe@email.com', '555-5678');

INSERT INTO orders (order_id, customer_id, order_date, total_price)
VALUES (1, 1, '2022-03-01', 500.00), (2, 2, '2022-03-02', 30.00);

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 1, 500.00), (2, 3, 2, 40.00), (2, 5, 1, 10.00);

--Query to get the total revenue by category
SELECT pc.category_name, SUM(oi.price) AS revenue
FROM products p
JOIN product_categories pc ON p.category_id = pc.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY pc.category_name;

--Query to get the top-selling products
SELECT p.product_name, SUM(oi.quantity) AS total_sales
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;
