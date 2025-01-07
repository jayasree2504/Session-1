create database assignment3;
use assignment3;
-- DATABASE SCHEMA

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

-- Create categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- DATA POPULATION

-- Insert sample categories
INSERT INTO categories (category_name) VALUES
('laptops'),
('smartphones'),
('tablets'),
('accessories'),
('wearables');

-- Insert sample products
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
('laptop model a', 'high performance laptop', 1200.00, 50, 1),
('smartphone model x', 'latest smartphone', 800.00, 30, 2),
('tablet model t', 'lightweight tablet', 600.00, 20, 3),
('wireless mouse', 'ergonomic mouse', 25.00, 100, 4),
('smartwatch', 'fitness tracking watch', 200.00, 15, 5),
('laptop model b', 'budget-friendly laptop', 700.00, 40, 1),
('smartphone model y', 'mid-range smartphone', 500.00, 25, 2),
('tablet model s', 'large screen tablet', 900.00, 9, 3),
('headphones', 'noise-cancelling headphones', 150.00, 60, 4),
('fitness band', 'basic fitness tracker', 50.00, 80, 5);

-- Insert sample customers
INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('john', 'doe', 'john.doe@example.com', '1234567890', '123 main st'),
('jane', 'smith', 'jane.smith@example.com', '2345678901', '456 elm st'),
('alice', 'johnson', 'alice.johnson@example.com', '3456789012', '789 oak st'),
('bob', 'brown', 'bob.brown@example.com', '4567890123', '321 pine st'),
('charlie', 'white', 'charlie.white@example.com', '5678901234', '654 maple st'),
('dave', 'lee', 'dave.lee@example.com', '6789012345', '987 birch st'),
('emma', 'jones', 'emma.jones@example.com', '7890123456', '159 cedar st'),
('oliver', 'taylor', 'oliver.taylor@example.com', '8901234567', '753 spruce st');

-- Insert sample orders
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2025-01-01'),
(2, '2025-01-02'),
(3, '2025-01-03'),
(4, '2025-01-04'),
(5, '2025-01-05'),
(6, '2025-01-06'),
(7, '2025-01-07'),
(8, '2025-01-08'),
(1, '2025-01-09'),
(2, '2025-01-10'),
(3, '2025-01-11'),
(4, '2025-01-12');

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 3),
(3, 5, 2),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(5, 9, 2),
(5, 10, 4),
(6, 1, 1),
(7, 2, 2),
(8, 3, 3),
(9, 4, 5),
(10, 5, 1),
(11, 6, 2),
(12, 7, 1);

-- QUERIES

-- 1. Find top 3 customers by order value
SELECT c.first_name, c.last_name, SUM(oi.quantity * p.price) AS total_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_value DESC
LIMIT 3;

-- 2. List products with low stock (below 10)
SELECT product_name, stock
FROM products
WHERE stock < 10;

-- 3. Calculate revenue by category
SELECT cat.category_name, SUM(oi.quantity * p.price) AS total_revenue
FROM categories cat
JOIN products p ON cat.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY cat.category_name
ORDER BY total_revenue DESC;

-- 4. Show orders with their items and total amount
SELECT o.order_id, c.first_name, c.last_name, SUM(oi.quantity * p.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id, c.first_name, c.last_name;

-- ADVANCED TASKS

-- Create view for order summary
CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * p.price) AS total_amount,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id, customer_name, o.order_date;

-- Write a stored procedure to update stock levels
DELIMITER //
CREATE PROCEDURE update_stock (IN prod_id INT, IN qty INT)
BEGIN
    UPDATE products
    SET stock = stock - qty
    WHERE product_id = prod_id AND stock >= qty;
END //
DELIMITER ;

-- Create triggers
-- Trigger to call procedure on insertion of order_item
DELIMITER //
CREATE TRIGGER after_insert_order_item
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    CALL update_stock(NEW.product_id, NEW.quantity);
END //
DELIMITER ;

-- Trigger to call procedure on deletion of order_item
DELIMITER //
CREATE TRIGGER after_delete_order_item
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock + OLD.quantity
    WHERE product_id = OLD.product_id;
END //
DELIMITER ;

