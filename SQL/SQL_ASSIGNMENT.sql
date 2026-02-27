-- Question 1--
use world;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    course VARCHAR(50)
);

INSERT INTO Students (student_id, name, age, course) VALUES
-- (1, 'Vishakha', 21, 'Data Science'),--
(2, 'Amit', 22, 'Computer Science'),
(3, 'Riya', 20, 'Data Science'),
(4, 'Karan', 23, 'Information Technology'),
(5, 'Sneha', 21, 'Computer Science'),
(6, 'Rahul', 24, 'Data Science'),
(7, 'Meena', 22, 'Information Technology'),
(8, 'Arjun', 20, 'Computer Science'),
(9, 'Pooja', 23, 'Data Science'),
(10, 'Nikhil', 21, 'Information Technology');

SELECT * FROM Students;

-- Question 4--
-- Scenario: Find students whose age is greater than the average age.--
WITH AvgAge AS (
    SELECT AVG(age) AS average_age
    FROM Students
)
SELECT name, age
FROM Students, AvgAge
WHERE Students.age > AvgAge.average_age;


-- Question6 --
CREATE DATABASE ECommerceDB;
USE ECommerceDB;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');


INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');



INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);



SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
-- Question 7 --

SELECT 
    Customers.CustomerName,
    Customers.Email,
    COUNT(Orders.OrderID) AS TotalNumberOfOrders
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName, Customers.Email
ORDER BY Customers.CustomerName;
-- Question 8 --

SELECT 
    Products.ProductName,
    Products.Price,
    Products.StockQuantity,
    Categories.CategoryName
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
ORDER BY Categories.CategoryName, Products.ProductName;

-- Question 9 --
WITH RankedProducts AS (
    SELECT 
        Categories.CategoryName,
        Products.ProductName,
        Products.Price,
        ROW_NUMBER() OVER (
            PARTITION BY Categories.CategoryID
            ORDER BY Products.Price DESC
        ) AS PriceRank
    FROM Products
    INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
)

SELECT 
    CategoryName,
    ProductName,
    Price
FROM RankedProducts
WHERE PriceRank <= 2
ORDER BY CategoryName, Price DESC;
-- Question 10 --

CREATE DATABASE SakilaLite;
USE SakilaLite;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(50)
);
CREATE TABLE Films (
    film_id INT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(50)
);
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    film_id INT,
    store_id INT,
    FOREIGN KEY (film_id) REFERENCES Films(film_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
CREATE TABLE Rentals (
    rental_id INT PRIMARY KEY,
    inventory_id INT,
    customer_id INT,
    rental_date DATE,
    return_date DATE,
    amount DECIMAL(8,2),
    FOREIGN KEY (inventory_id) REFERENCES Inventory(inventory_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Customers VALUES
(1,'Alice','Sharma','alice@mail.com'),
(2,'Bob','Patel','bob@mail.com'),
(3,'Charlie','Mehta','charlie@mail.com'),
(4,'Diana','Kapoor','diana@mail.com'),
(5,'Ethan','Rao','ethan@mail.com');

INSERT INTO Stores VALUES
(1,'Store A'),
(2,'Store B');

INSERT INTO Films VALUES
(101,'Avengers','Action'),
(102,'Inception','Sci-Fi'),
(103,'Frozen','Animation'),
(104,'Joker','Drama'),
(105,'Toy Story','Animation'),
(106,'Batman','Action');

INSERT INTO Inventory VALUES
(1,101,1),
(2,102,1),
(3,103,1),
(4,104,2),
(5,105,2),
(6,106,2);

INSERT INTO Rentals VALUES
(1,1,1,'2023-01-10','2023-01-12',5.99),
(2,2,2,'2023-02-05','2023-02-07',4.99),
(3,3,1,'2023-03-01','2023-03-03',3.99),
(4,4,3,'2023-04-15','2023-04-18',6.99),
(5,5,1,'2023-05-10','2023-05-12',4.99),
(6,6,2,'2023-06-20','2023-06-22',5.99),
(7,1,1,'2023-07-11','2023-07-13',5.99),
(8,2,1,'2023-08-01','2023-08-03',4.99),
(9,3,4,'2023-09-09','2023-09-10',3.99),
(10,4,1,'2023-10-02','2023-10-05',6.99);



-- quesry 1--
SELECT 
    CONCAT(first_name,' ',last_name) AS CustomerName,
    email,
    SUM(amount) AS TotalSpent
FROM Customers
JOIN Rentals USING(customer_id)
GROUP BY customer_id
ORDER BY TotalSpent DESC
LIMIT 5;
-- quesry 2--
SELECT 
    Films.category,
    COUNT(*) AS RentalCount
FROM Rentals
JOIN Inventory USING(inventory_id)
JOIN Films USING(film_id)
GROUP BY Films.category
ORDER BY RentalCount DESC
LIMIT 3;
-- quesry 3--
SELECT 
    store_id,
    COUNT(*) AS TotalFilms,
    SUM(CASE WHEN Rentals.rental_id IS NULL THEN 1 ELSE 0 END) AS NeverRented
FROM Inventory
LEFT JOIN Rentals USING(inventory_id)
GROUP BY store_id;
-- quesry 4--
SELECT 
    MONTH(rental_date) AS Month,
    SUM(amount) AS MonthlyRevenue
FROM Rentals
WHERE YEAR(rental_date) = 2023
GROUP BY MONTH(rental_date)
ORDER BY Month;

-- quesry 5--

SELECT 
    customer_id,
    COUNT(*) AS RentalCount
FROM Rentals
WHERE rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY customer_id
HAVING COUNT(*) > 10;








