
create database TechShop;
use TechShop;
create Table Customers(
  CustomerID int Primary Key NOT NULL,FirstName varchar(50),LastName varchar(50),
 Email varchar(50),Phone varchar(50),Address varchar(50)
 );

create Table Products(
  ProductID int Primary Key NOT NULL,ProductName varchar(50),Description varchar(50),
  Price INT);

create table Orders(OrderID int Primary Key NOT NULL,CustomerID int NOT NULL,
OrderDate DATE,TotalAmount int,
 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) );

create table OrderDetails(
   OrderDetailID INT Primary Key,OrderID INT,ProductID INT,
    Quantity INT,FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

create table Inventory(
  InventoryID INT Primary Key NOT NULL,ProductID INT,QuantityInStock INT,LastStockUpdate DATE,
  FOREIGN KEY(ProductID) REFERENCES Products(ProductID));
 
 INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES 
(1, 'Rahul', 'Kumar', 'rahul@gmail.com', '9840843210', '13A,45 st, Chennai'),
(2, 'John', 'Smith', 'smith@gmail.com', '9806751234', '7B,54 st, Chennai'),
(3, 'Sam', 'Curan', 'samcuran@gmail.com', '9876534567', '15,JB st, Chennai'),
(4, 'Priscila', 'Peniel', 'priscila@gmail.com', '9876547890', '2A,3rd Avenue,Chennai'),
(5, 'Priya', 'Dharshini', 'priya@gmail.com', '9946167851', '3A,west cross st, Chennai'),
(6, 'Nivetha', 'Ravi', 'nivetha@example.com', '8838053346', '1B,5th avenue Coimbatore'),
(7, 'Lakshmi', 'Reddy', 'lakshmi@gmail.com', '8838052341', '9A,12th avenue Coimbatore'),
(8, 'Adhi', 'Balaji', 'adhi@gmail.com', '8838057653', '11A,7th avenue Coimbatore'),
(9, 'Nithya', 'Priya', 'nithya@gmail.com', '8838057981', '12B,8th avenue Coimbatore'),
(10, 'Rohini', 'Raj', 'rohini@gmail.com', '8838057845', '13B,45th street Coimbatore');

INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES 
(1, 'Smartphone', 'Android phone with foldable model', 40000),
(2, 'Laptop', 'High-performance laptop with 16GB', 75000),
(3, 'Airpods', 'Wireless noise-canceling airpods', 15000),
(4, 'Smartwatch', 'Water Proof smartwatch', 25000),
(5, 'Tablet', '10-inch Android tablet', 40000),
(6, 'Camera', 'High Tech camera', 50000),
(7, 'Monitor', '27-inch 4K Monitor', 35000),
(8, 'Printer', 'Laser Printer', 45000),
(9, 'Keyboard', 'Mechanical keyboard', 4000),
(10, 'Mouse', 'Wireless ergonomic mouse', 2000);

-- Inserting into Orders Table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
(1, 1, '2025-03-11', 70000),
(2, 2, '2025-03-12', 45000),
(3, 3, '2025-03-13', 25000),
(4, 4, '2025-03-14', 30000),
(5, 5, '2025-03-15', 40000),
(6, 6, '2025-03-16', 60000),
(7, 7, '2025-03-17', 35000),
(8, 8, '2025-03-18', 45000),
(9, 9, '2025-03-19', 10000),
(10, 10, '2025-03-20', 15000);

-- Inserting into OrderDetails Table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES 
(1, 1, 1, 5),
(2, 2, 2, 10),
(3, 3, 3, 5),
(4, 4, 4, 3),
(5, 5, 5, 8),
(6, 6, 6, 1),
(7, 7, 7, 2),
(8, 8, 8, 4),
(9, 9, 9, 2),
(10, 10, 10, 3);

-- Inserting into Inventory Table
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES 
(1, 1, 25, '2025-03-02'),
(2, 2, 50, '2025-03-03'),
(3, 3, 55, '2025-03-04'),
(4, 4, 20, '2025-03-05'),
(5, 5, 40, '2025-03-06'),
(6, 6, 30, '2025-03-07'),
(7, 7, 45, '2025-03-08'),
(8, 8, 60, '2025-03-09'),
(9, 9, 100, '2025-03-10'),
(10, 10, 150, '2025-03-11');


select * from Customers;

select * from Products;

select * from Orders;

select * from OrderDetails;

select * from Inventory;

--1. Write an SQL query to retrieve the names and emails of all customers.
Select CONCAT(FirstName, ' ', LastName) AS Name, Email FROM Customers;
--2. Write an SQL query to list all orders with their order dates and corresponding customer names.
Select OrderID, OrderDate, (SELECT FirstName + ' ' + LastName From Customers 
WHERE Customers.CustomerID = Orders.CustomerID) AS CustomerName From Orders;

--3.Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
insert INTO Customers (CustomerID ,FirstName, LastName, Email, Phone, Address) VALUES (11,'Sakthi', 'Priya', 'sakthi@gmail.com', '9840876523', '11,East road,Chennai');

select * from Customers;

--Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.

UPDATE Products SET Price = Price+(Price * 0.10) ;

select * from Products;

--5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.

delete from OrderDetails WHERE OrderID = 1;
delete from Orders WHERE OrderID = 1;
--6.Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
INSERT INTO Orders (OrderID,CustomerID, OrderDate, TotalAmount) VALUES (11,11, '2025-03-21', 35000);

--7. Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
update Customers SET Email = 'john21@gmail.com', Address = '18,9th cross st, Chennai' WHERE CustomerID = 2;

select * from Customers;
--8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table
update Orders SET TotalAmount = (SELECT SUM(o.Quantity * p.Price) 
    FROM OrderDetails o
	JOIN Products p ON o.ProductID = p.ProductID where o.OrderID = Orders.OrderID
);
select * from Orders

--9. Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
delete from OrderDetails where OrderID IN (select OrderID from Orders where CustomerID = 3);

delete from Orders where CustomerID = 3;

select * from Orders;

--10. Write an SQL query to insert a new electronic gadget product into the "Products" table,including product name, category, price, and any other relevant details.
INSERT INTO Products (ProductID,ProductName, Description, Price)VALUES (11,'Projector',  'Latest digital Light Processing', 150000);
select * from Products;
--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
ALTER TABLE Orders ADD Status VARCHAR(20);
update Orders 
SET Status = 
    CASE 
        WHEN OrderId IN (2, 4, 6, 8, 9) THEN 'Pending'
        WHEN OrderId IN (3, 5, 7, 10,11) THEN 'Shipped'
    END
WHERE OrderId BETWEEN 1 AND 11;

select * from Orders;


--12. Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.

ALTER TABLE Customers ADD TotalOrders INT default 0;
update Customers SET TotalOrders = ( Select COUNT(*) from Orders where Orders.CustomerID = Customers.CustomerID
);
select * from Customers
