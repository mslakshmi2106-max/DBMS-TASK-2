CREATE DATABASE IF NOT EXISTS ProductCategoryDB;
USE ProductCategoryDB;

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL UNIQUE,
    Category_ID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    CONSTRAINT fk_product_category
        FOREIGN KEY (Category_ID)
        REFERENCES Category(Category_ID)
);

INSERT INTO Category (Category_ID, Category_Name, Description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Home Appliances', 'Appliances used at home'),
(3, 'Stationery', 'Writing and office supplies');


INSERT INTO Product
(Product_ID, Product_Name, Category_ID, Price, Stock_Quantity) VALUES
(101, 'Wireless Mouse', 1, 799.00, 50),
(102, 'Mechanical Keyboard', 1, 2499.00, 30),
(103, 'USB-C Charger', 1, 1299.00, 45),
(104, 'Bluetooth Speaker', 1, 1999.00, 25),
(105, 'Webcam', 1, 1599.00, 20),
(106, 'Power Bank', 1, 999.00, 40),
(107, 'Electric Kettle', 2, 1799.00, 15),
(108, 'Mixer Grinder', 2, 3499.00, 10),
(109, 'Table Fan', 2, 2299.00, 18),
(110, 'Notebook', 3, 120.00, 100),
(111, 'Ball Pen Pack', 3, 80.00, 150),
(112, 'A4 Paper Pack', 3, 350.00, 60);

INSERT INTO Product
(Product_ID, Product_Name, Category_ID, Price, Stock_Quantity)
VALUES (113, 'HDMI Cable', 1, 599.00, 35);

SELECT * FROM Product;

UPDATE Product
SET Price = 699.00, Stock_Quantity = 40
WHERE Product_ID = 113;

DELETE FROM Product
WHERE Product_ID = 113;

SELECT
    c.Category_Name,
    p.Product_ID,
    p.Product_Name,
    p.Price,
    p.Stock_Quantity
FROM Category c
JOIN Product p ON c.Category_ID = p.Category_ID
ORDER BY c.Category_Name, p.Product_Name;

SELECT
    c.Category_Name,
    COUNT(p.Product_ID) AS Product_Count
FROM Category c
LEFT JOIN Product p ON c.Category_ID = p.Category_ID
GROUP BY c.Category_ID, c.Category_Name
ORDER BY c.Category_ID;


SELECT Product_ID, Product_Name, Price
FROM Product
WHERE Price = (SELECT MAX(Price) FROM Product);

SELECT
    c.Category_Name,
    COUNT(p.Product_ID) AS Product_Count
FROM Category c
JOIN Product p ON c.Category_ID = p.Category_ID
GROUP BY c.Category_ID, c.Category_Name
HAVING COUNT(p.Product_ID) > 5;

SELECT ROUND(AVG(Price), 2) AS Average_Product_Price
FROM Product;

SELECT
    c.Category_Name,
    ROUND(AVG(p.Price), 2) AS Average_Price
FROM Category c
JOIN Product p ON c.Category_ID = p.Category_ID
GROUP BY c.Category_ID, c.Category_Name;
