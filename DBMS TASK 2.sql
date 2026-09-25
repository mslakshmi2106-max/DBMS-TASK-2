DROP DATABASE IF EXISTS SellerInventoryDB;

CREATE DATABASE SellerInventoryDB;

USE SellerInventoryDB;

CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    Address VARCHAR(200) NOT NULL
);


CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Seller_ID INT,
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);

CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT,
    Seller_ID INT,
    Stock_Quantity INT CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) NOT NULL,
    Last_Updated DATE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);

INSERT INTO Seller VALUES
(1,'Subbu lakshmi','lakshmi@gmail.com','8190849810','Thoothukudi'),
(2,'manikandan','manikandan@gmail.com','6383430454','Tirunelveli'),
(3,'Sandhiya','sandhiya@gmail.com','9876543212','Coimbatore');

INSERT INTO Product VALUES
(1001,'Laptop',50000,1),
(1002,'Mobile',20000,1),
(1003,'Headphone',2000,2),
(1004,'Keyboard',1500,3);

INSERT INTO Inventory VALUES
(1,1001,1,25,'Available','2026-09-20'),
(2,1002,1,8,'Low Stock','2026-09-20'),
(3,1003,2,0,'Out of Stock','2026-09-20'),
(4,1004,3,50,'Available','2026-09-20');

INSERT INTO Seller
VALUES
(4,'Krishna','krish@gmail.com','9876543213','Trichy');

INSERT INTO Product
VALUES
(1005,'Mouse',800,4);

SELECT s.Seller_Name, p.Product_Name
FROM Seller s
JOIN Product p
ON s.Seller_ID = p.Seller_ID;

SELECT s.Seller_Name,
       COUNT(p.Product_ID) AS Product_Count
FROM Seller s
LEFT JOIN Product p
ON s.Seller_ID = p.Seller_ID
GROUP BY s.Seller_Name;

UPDATE Seller
SET Address = 'Salem'
WHERE Seller_ID = 4;

SELECT *
FROM Inventory
WHERE Stock_Quantity > 0;

SELECT *
FROM Inventory
WHERE Stock_Quantity = 0;

SELECT *
FROM Inventory
WHERE Stock_Quantity < 10;

UPDATE Inventory
SET Stock_Quantity = 15
WHERE Inventory_ID = 2;

DELETE FROM Inventory
WHERE Stock_Status = 'Out of Stock';

SELECT s.Seller_Name, p.Product_Name
FROM Seller s
JOIN Product p
ON s.Seller_ID = p.Seller_ID;

SELECT Product_ID,
       Stock_Quantity,
       Stock_Status
FROM Inventory;

SELECT COUNT(*) AS Total_Available_Products
FROM Inventory
WHERE Stock_Quantity > 0;

SELECT Product_ID
FROM Inventory
WHERE Stock_Quantity = 0;

SELECT *
FROM Inventory
ORDER BY Stock_Quantity DESC
LIMIT 1;

SELECT AVG(Stock_Quantity) AS Average_Stock
FROM Inventory;