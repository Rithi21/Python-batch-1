
--1) Write a query to list all system databases in SQL Server.
SELECT name FROM sys.databases ;

--2) Identify the physical database files (MDF, LDF) of a user-defined database named "SalesDB" using a SQL query.
create database SalesDB;
Use SalesDB;
SELECT name, physical_name FROM sys.master_files WHERE database_id = DB_ID('SalesDB');

--3) Create a user-defined database named "InventoryDB" with a primary data file of 5MB and a log file of 2MB.
Create Database InventoryDB
ON PRIMARY 
( 
    NAME = 'InventoryDB_Data', 
    FILENAME = 'D:\ms sql server\MSSQL16.SQLEXPRESS\MSSQL\DATA\InventoryDB_1.mdf',
    SIZE = 5
)
LOG ON 
( 
    NAME = 'InventoryDB_Log', 
    FILENAME = 'D:\ms sql server\MSSQL16.SQLEXPRESS\MSSQL\DATA\InventoryDB_1.ldf', 
    SIZE = 2
);


--4)  Rename the database "InventoryDB" to "StockDB" using a SQL query.
Use InventoryDB;
alter database InventoryDB MODIFY NAME = StockDB;

--5) Drop the database "StockDB" using a SQL query.
drop database StockDB;

--6) (2 Marks) Write a query to display all available data types in SQL Server.
select name AS DataType FROM sys.types;

--7) (2 Marks) Create a table "Products" with the following columns:
    --ProductID (Integer, Primary Key),ProductName (Variable-length string, max 50 characters, Not Null)
     --Price (Decimal with 2 decimal places),StockQuantity (Integer, Default value 0)

	 create table Products( ProductId Int PRIMARY KEY,ProductName VarChar(50) NOT NULL,
    Price DECIMAL(10,2),StockQuantity Int DEFAULT 0);

--8)Modify the "Products" table to add a new column Category (VARCHAR(30)).
alter table Products add Category VarChar(30);

--9) Rename the table "Products" to "Inventory".
exec sp_rename 'Products','Inventory';

--10) Drop the "Inventory" table from the database.
drop table Inventory;

--11)(5 Marks) Identify and list the system databases available in SQL Server. Provide a brief description of each.
SELECT name FROM sys.databases;
--1. master: System database contains server-wide configuration settings, logins, and system objects.
--2. model: Acts as a template for newly created databases.
--3. msdb: Used by SQL Server Agent to schedule jobs, alerts, and backups.
--4. tempdb:A temporary database used for storing temporary tables, worktables, and sorting operations.Resets every time SQL Server restarts.


--12)(5 Marks) Write a query to display all database files (MDF, LDF, NDF) for a specific database.
USE Employees;
SELECT name AS FileName, type_desc AS FileType, physical_name AS FilePath, size * 8 / 1024 AS SizeMB 
FROM sys.master_files 
WHERE database_id = DB_ID('Employees');

--13) (5 Marks) Create a new user-defined database named SalesDB with a primary data file of 10MB and a log file of 5MB.

CREATE DATABASE SalesDB
ON PRIMARY 
( 
    NAME = 'SalesDB_Data', 
    FILENAME = 'D:\ms sql server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SalesDB.mdf', 
    SIZE = 5MB 
)
LOG ON 
( 
    NAME = 'SalesDB_Log', 
    FILENAME = 'D:\ms sql server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SalesDB.ldf', 
    SIZE = 2MB
);

--14)(5 Marks) Rename the database SalesDB to RetailDB using an SQL query.
alter database SalesDB MODIFY NAME = RetailDB;

--15) (5 Marks) Drop the RetailDB database safely, ensuring that no active connections exist before deletion.
ALTER DATABASE RetailDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
Use master;
DROP DATABASE RetailDB;
