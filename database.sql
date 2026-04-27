CREATE DATABASE MiniAmazon;
USE MiniAmazon;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    address TEXT,
    phone VARCHAR(15)
);
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    stock INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
ALTER TABLE Products
MODIFY name VARCHAR(100) NOT NULL;
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
ALTER TABLE Cart
RENAME TO Shopping_Cart;
ALTER TABLE Orders
ADD delivery_date DATE,
ADD order_status VARCHAR(50) DEFAULT 'Processing';
INSERT INTO Categories (category_name) VALUES 
('Electronics'), ('Clothing'), ('Books');
INSERT INTO Users (name, email, password, address, phone) VALUES
('Srijita', 'srijita@gmail.com', '1234', 'West Bengal', '9876543210');
INSERT INTO Products (name, description, price, stock, category_id) VALUES
('Laptop', 'Gaming Laptop', 70000, 10, 1),
('T-Shirt', 'Cotton T-Shirt', 500, 50, 2),
('Book', 'Data Structures', 300, 100, 3);
INSERT INTO Users (name, email, password, address, phone) VALUES
('Rahul', 'rahul@gmail.com', '1234', 'Delhi', '9876500000'),
('Ananya', 'ananya@gmail.com', '1234', 'Mumbai', '9123456780');
INSERT INTO Products (name, description, price, stock, category_id) VALUES
('Headphones', 'Wireless Headphones', 2000, 20, 1),
('Jeans', 'Denim Jeans', 1500, 30, 2);
INSERT INTO Shopping_Cart (user_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1);
INSERT INTO Orders (user_id, total_amount, status) VALUES
(1, 70000, 'Placed'),
(2, 1000, 'Delivered');
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 70000),
(2, 2, 2, 500);
INSERT INTO Payments (order_id, payment_method, payment_status) VALUES
(1, 'Credit Card', 'Success'),
(2, 'UPI', 'Success');
INSERT INTO Reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Excellent product!'),
(2, 2, 4, 'Good quality'),
(3, 3, 3, 'Average');
ALTER TABLE Products
ADD CONSTRAINT chk_price CHECK (price > 0);
UPDATE Orders
SET delivery_date = '2026-05-02', order_status = 'Delivered'
WHERE order_id = 2;
ALTER TABLE Products
ADD brand VARCHAR(100),
ADD avg_rating DECIMAL(2,1) DEFAULT 0;
UPDATE Products SET brand='HP', avg_rating=4.5 WHERE product_id=1;
UPDATE Products SET brand='Zara', avg_rating=4.0 WHERE product_id=2;
UPDATE Products SET brand='Pearson', avg_rating=3.8 WHERE product_id=3;
ALTER TABLE Payments
ADD amount DECIMAL(10,2);
UPDATE Payments SET amount=70000 WHERE payment_id=1;
UPDATE Payments SET amount=1000 WHERE payment_id=2;
ALTER TABLE Products
ADD stock_status VARCHAR(20);
UPDATE Products SET stock_status='In Stock' WHERE stock > 0;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Payments;
SELECT name, brand, price, avg_rating 
FROM Products;
SELECT order_id, user_id, order_status, delivery_date 
FROM Orders;
SELECT payment_id, order_id, payment_method, amount 
FROM Payments;
ALTER TABLE Users
ADD user_type VARCHAR(20);
UPDATE Users SET user_type='Admin' WHERE user_id=1;
UPDATE Users SET user_type='Customer' WHERE user_id=2;
UPDATE Users SET user_type='Customer' WHERE user_id=3;
SELECT name, email, user_type 
FROM Users;
SELECT u.name AS customer, p.name AS product, 
       o.order_status, pay.amount
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN Payments pay ON o.order_id = pay.order_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;