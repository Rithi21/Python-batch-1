create database task_practice;
use task_practice;

--1. Storing Data in a Table (3 Marks)
--a) Write an SQL query to create a table named Employees with the following fields:

create table Employees(EmployeeId int PRIMARY KEY IDENTITY(1,1),Name varchar(100) NOT NULL,
    Age int,Department varchar(50),Salary decimal(10,2)
);



--b) Insert three records into the Employees table.
insert into Employees(Name,Age,Department,Salary) values
('Reshma',25,'HR',45000),
('Ram',28,'IT',75000),
('Priya',29,'Marketing',40000)

--2. Updating Data in a Table (3 Marks)
--Write an SQL query to update the Salary of employees in the HR department by 10%.

update Employees set Salary=Salary*1.10 where Department='HR';
select * from Employees

--3. Deleting Data from a Table (3 Marks)
--Write an SQL query to delete all employees from the IT department.

Delete from Employees where Department='IT';
select * from Employees

--4. Demo: Manipulating Data in Tables (6 Marks)
--a) Insert a new employee into the Employees table, but ensure the Salary is at least 30000. (2 Marks)
insert into Employees(Name,Age,Department,Salary) values
('Rahul',32,'Finance',35000),
('Vijay',55,'IT',75000),
('Rohini',60,'HR',82000),
('Sakthi',27,'Marketing',32000),
('Anitha',45,'IT',55000),
('Amit', 70, 'HR', 60000),
( 'Bala', 65, 'Marketing', 72000);
select * from Employees;
--b) Update the Department of employees who earn more than 50000 to Senior Staff. (2 Marks)
update Employees set Department='Senior staff' where Salary>50000

--c) Delete employees older than 60 years from the table. (2 Marks)
delete from Employees where age>60;

--Section B: Retrieving and Filtering Data (35 Marks)
--5. Retrieving Specific Attributes (3 Marks)
--Write an SQL query to retrieve only the Name and Salary of all employees.

select Name,Salary from Employees;

--6. Retrieving Selected Rows (3 Marks)
--Write an SQL query to retrieve employees from the HR department who have a salary greater than 50,000.

select * from Employees where Department='HR' and Salary>50000;
--7. Demo: Retrieving Data (4 Marks)
--Write an SQL query to retrieve all employees sorted by Salary in descending order.
select * from  Employees ORDER BY Salary DESC;


--8. Filtering Data - WHERE Clauses (5 Marks)
--a) Write an SQL query to retrieve employees whose Age is greater than 30. (2 Marks)
select * from Employees where age > 30
--b) Retrieve employees whose Department is either HR or Finance. (3 Marks)

SELECT * FROM Employees where Department IN ('HR', 'Finance');


--9. Filtering Data - Operators (10 Marks)
--a) Retrieve employees whose Salary is between 30,000 and 60,000. (2 Marks)
SELECT * FROM Employees 
WHERE Salary BETWEEN 30000 AND 60000;


--b) Retrieve employees whose Name starts with "A". (2 Marks)
select * from Employees where Name like 'A%'
--c) Retrieve employees who do NOT belong to the IT department. (2 Marks)
SELECT * FROM Employees 
WHERE Department <> 'IT';

--d) Retrieve employees whose Department is either "Sales" or "Marketing" using the IN operator. (2 Marks)
SELECT * FROM Employees 
WHERE Department IN ('Sales', 'Marketing');

--e) Retrieve employees with distinct Department names. (2 Marks)
Select distinct Department from Employees
--10. Column & Table Aliases (3 Marks)
--Write an SQL query that retrieves EmployeeID, Name, and Salary, renaming EmployeeID as "ID" and Salary as "Monthly Income".
SELECT EmployeeId AS ID, Name, Salary AS "Monthly Income" 
FROM Employees;

--11. Demo: Filtering Data (4 Marks)
--Write an SQL query to retrieve employees whose Name contains "John" and whose salary is greater than 40,000.
SELECT * FROM Employees 
WHERE Name LIKE '%John%' AND Salary > 40000;

