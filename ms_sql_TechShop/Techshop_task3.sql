use TechShop;
--Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:  
--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., 
--customer name) for each order. 

select O.OrderID, C.CustomerID,CONCAT( C.FirstName,' ',C.LastName) as Name, C.Email, C.Phone, C.Address, O.OrderDate, O.TotalAmount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;


--2. Write an SQL query to find the total revenue generated by each electronic gadget product. 
--Include the product name and the total revenue. 

SELECT P.ProductName,SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY ProductName
ORDER BY TotalRevenue DESC;


--3. Write an SQL query to list all customers who have made at least one purchase. Include their 
--names and contact information. 

select DISTINCT C.CustomerID, CONCAT( C.FirstName,' ',C.LastName) as Name, C.Email, C.Phone, C.Address
from Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest 
--total quantity ordered. Include the product name and the total quantity ordered. 

SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantityOrdered DESC

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories. 
Alter table Products add Category varchar(50);

update Products SET Category = 'Electronics' WHERE ProductID IN (1, 2, 3, 4, 6, 7, 8, 10);
update Products SET Category = 'Furniture' WHERE ProductID IN (5, 9);

select ProductName, Category from Products WHERE Category = 'Electronics';

--6. Write an SQL query to calculate the average order value for each customer. Include the 
--customer's name and their average order value. 

select C.CustomerID, C.FirstName, C.LastName, AVG(O.TotalAmount) AS AvgOrderValue
from Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName


--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, 
--customer information, and the total revenue. 
select TOP 1 O.OrderID, C.CustomerID, CONCAT( C.FirstName,' ',C.LastName) as Name, O.TotalAmount
from Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.TotalAmount DESC

--8. Write an SQL query to list electronic gadgets and the number of times each product has been 
--ordered. 
select P.ProductName, COUNT(OD.OrderID) AS NumberOfOrders from OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY NumberOfOrders DESC;


--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. 
--Allow users to input the product name as a parameter. 
select DISTINCT C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone, C.Address
from Customers C JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
where P.ProductName = 'Laptop';  

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a 
--specific time period. Allow users to input the start and end dates as parameters.
select SUM(O.TotalAmount) AS TotalRevenue
from Orders O
where O.OrderDate BETWEEN '2025-03-12' AND '2025-03-19';  
