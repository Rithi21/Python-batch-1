--1) Write a query to list all system databases available in MS SQL Server.
select name from sys.databases;


--2) Write a query to retrieve the physical file locations (MDF & LDF) of a database named "CompanyDB".
create database CompanyDB;
Use CompanyDB;
select name, physical_name FROM sys.master_files WHERE database_id = DB_ID('CompanyDB');
exec sp_helpfile
--3) Write a query to create a database "HRDB" with the following specifications:
--Primary Data File: 10MB, Autogrow by 2MB & Log File: 5MB, Autogrow by 1MB
create database HRDB
ON PRIMARY 
( 
    NAME = 'HRDB_Data', 
    FILENAME = 'D:\ms sql server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HRDB.mdf', 
    SIZE = 10MB, 
    FILEGROWTH = 2MB 

)
LOG ON 
( 
    NAME = 'HRDB_Log', 
    FILENAME = 'D:\ms sql server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HRDB.ldf', 
    SIZE = 5MB, 
    FILEGROWTH = 1MB 
);
use HRDB;
EXEC sp_helpfile;


--4) Rename "HRDB" to "EmployeeDB" using SQL commands.

alter database HRDB modify name=EmployeeDB;

--5) Drop the database "EmployeeDB" from the system.

drop database EmployeeDB;

--6)Write a query to display all supported data types in MS SQL Server.

select name AS DataType FROM sys.types;

--7)Create a table "Employees" with the following fields:
--EmpID (Integer, Primary Key)
--EmpName (Variable-length string, max 100 characters, Not Null)
--JoinDate (Date, Not Null)
--Salary (Decimal with 2 decimal places, Default: 30000.00)
create table Employees( EmpID int PRIMARY KEY, EmpName varchar(100) NOT NULL,
JoinDate Date NOT NULL,Salary Decimal(10,2) DEFAULT 30000.00);

--8)Add a new column "Department" (VARCHAR(50)) to the "Employees" table.

alter table Employees add Department VARCHAR(50);
select * from Employees;


--9)Rename the table "Employees" to "Staff".
exec sp_rename 'Employees','Staff';

--10)Drop the table "Staff" from the database.
drop table staff;
