--Task 2
--1)Create a user-defined database named EmployeeRecords with specific file paths for the .mdf and .ldf files.

CREATE DATABASE EmployeeRecords; 

--2) Rename the EmployeeRecords database to HR_Database using T-SQL.

ALTER DATABASE EmployeeRecords MODIFY NAME = HR_Database;

--3)Drop the HR_Database safely, ensuring there are no active connections before deletion.

DROP DATABASE HR_Database;

CREATE DATABASE EmployeeRecords;

Use EmployeeRecords;

--4)Identify at least five commonly used data types in SQL Server and explain their use cases.

select COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH 
from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Customers';

-- 1.int - Stores whole numbers.
--2.VARCHAR(n)	Stores variable-length text and used for names, emails.
-- 3.DATE-	Stores date.

--5) Create a Customers table with appropriate columns (CustomerID, FullName, Email, Phone, DateJoined).

create table Customers (  CustomerID INT PRIMARY KEY,  FullName VARCHAR(40), Email VARCHAR(20), 
Phone VARCHAR(30),  DateJoined DATE );

--6)Modify the Customers table to add a new column Address.

alter table Customers  ADD Address VARCHAR(30);

--7)Rename the Customers table to ClientDetails.

EXEC sp_rename 'Customers', 'ClientDetails';

--8)Drop the ClientDetails table safely.

drop table ClientDetails;

--9)Insert five sample records into the Customers table.
create table Customers (  CustomerID INT PRIMARY KEY,  FullName VARCHAR(40), Email VARCHAR(20), 
Phone VARCHAR(30),  DateJoined DATE,Address varchar(30) );

INSERT INTO Customers (CustomerID, FullName, Email, Phone, DateJoined, Address)  
VALUES  
(1, 'Rahul Kumar', 'rahul@gmail.com', '9840843210', '2021-04-22', 'Chennai'),  
(2, 'John Smith', 'john.smith@gmail.com', '9806751234', '2021-03-13', 'New York'),  
(3, 'Sakthi Priya', 'sakthi@gmail.com', '8845078902', '2018-09-05', 'UK'),  
(4, 'Sri harini', 'harini@gmail.com', '9865743210', '2020-11-15', 'New York'),  
(5, 'Priya Dharshini', 'priya@gmail.com', '9946167851', '2019-05-25', 'Chicago');
select * from Customers;
--10)Update the email of a customer whose CustomerID = 3.
Update Customers set email='sakthi31@yahoo.com' where CustomerID=3;
select * from Customers;
--11)Delete a customer record where the CustomerID = 5.
delete from Customers where CustomerID=5;
--12)Demonstrate inserting multiple records in a single query for better efficiency.
INSERT INTO Customers (CustomerID, FullName, Email, Phone, DateJoined, Address)  
VALUES  
(6, 'Ravi kumar', 'ram@gmail.com', '8838074561', '2024-03-12', 'Chennai'),  
(7, 'Reshma Reddy', 'reshma@yahoo.com', '8838074561', '2019-12-20', 'Chicago');

--13)Retrieve and display only the FullName and Email of all customers.

select FullName,Email from Customers;

--14)Retrieve all customers who joined after 2020-01-01.
select * from Customers  WHERE DateJoined > '2020-01-01';

--15)Fetch all customers whose names start with 'J' using a LIKE query.
select * from Customers WHERE FullName LIKE 'J%';
--16)Retrieve customers where Phone is NULL (i.e., customers who haven't provided a phone number).
update Customers SET Phone = NULL where CustomerId = 2;

select * FROM Customers where Phone IS NULL;


--17)Filter customers using IN—Retrieve records where CustomerID is either 1, 3, or 7.

select * from Customers  where CustomerID IN (1, 3, 7);

--18)Use DISTINCT to list unique domain names from customer emails (e.g., gmail.com, yahoo.com).
select DISTINCT RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS Domain from Customers;

--19)Use AND and OR together—Retrieve customers who either live in 'New York' OR have joined before 2019-06-01.
select * from Customers  where Address = 'New York' OR DateJoined < '2019-06-01';

--20)Retrieve customers where DateJoined is BETWEEN 2018-01-01 AND 2023-12-31.
select * from Customers  where DateJoined BETWEEN '2018-01-01' AND '2023-12-31';

--21)Use column and table aliases to rename output fields while selecting.
select FullName AS Name, Email AS emp_email FROM Customers AS C;

--22)Demonstrate a query that filters using multiple conditions, such as WHERE Age > 25 AND City = 'Chicago'.

select * FROM Customers  where DateJoined > '2019-01-01' AND Address = 'Chicago';

--23)Execute and analyze filtering queries to optimize performance using EXPLAIN plans (if applicable).



