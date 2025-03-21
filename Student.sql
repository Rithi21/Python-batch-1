--Write an SQL script to create a database named StudentRecords.
 create database StudentRecords;
 
 --Rename the StudentRecords database to UniversityRecords.

 alter DATABASE StudentRecords MODIFY NAME = UniversityRecords;

 
--Delete the UniversityRecords database safely.

DROP database UniversityRecords;

 create database StudentRecords;
 use StudentRecords;

--Create a Students table with appropriate columns and data types.
 CREATE TABLE Students (
    StudentID INT PRIMARY KEY,  FirstName VARCHAR(50) , LastName VARCHAR(50) ,            
    DateOfBirth DATE, Gender CHAR(1), Phone VARCHAR(15), Address VARCHAR(50));

 
--Add a new column Email to the Students table.
 Alter table Students ADD Email VARCHAR(50);

--List and describe common SQL Server data types.
 select COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Students';

-- 1.int - Stores whole numbers.
--2.VARCHAR(n)	Stores variable-length text and used for names, emails.
-- 3.DATE-	Stores date.
 
 
--Rename the Students table to UniversityStudents.
 EXEC sp_rename 'Students', 'UniversityStudents';

--Delete the UniversityStudents table.
 DROP TABLE UniversityStudents;

 
--Insert five sample student records into the Students table.
CREATE TABLE Students (StudentID INT PRIMARY KEY,  FirstName VARCHAR(50) , LastName VARCHAR(50) ,
DateOfBirth DATE, Gender CHAR(1), Phone VARCHAR(15), Address VARCHAR(50),Email VARCHAR(50),Dept VARCHAR(25),Graduation DATE);

 insert into Students(StudentID, FirstName, LastName,DateOfBirth,Gender, Phone, Address,Email,Dept,Graduation) values 
(1, 'Rahul', 'Kumar', '2004-05-30', 'M', '9840843210', '13A,45 st, Chennai','rahul@gmail.com','Computer Science','2022-05-30'),
(2, 'John', 'Smith','2003-04-15', 'M',  '9806751234', '7B,54 st, Chennai','smith@gmail.com','Electronics','2025-04-30'),
(3, 'Sam', 'Curan', '2002-03-20', 'M', '9876534567', '15,JB st, Chennai','samcuran@gmail.com','Mechanical','2026-05-30'),
(4, 'Priscila', 'Peniel', '2005-07-01', 'F', '9876547890', '2A,3rd Avenue,Chennai','priscila@gmail.com','Computer Science','2023-05-30'),
(5, 'Priya', 'Dharshini', '2004-08-05', 'F', '9946167851', '3A,west cross st, Chennai','priya@gmail.com','Mechanical','2025-06-12');
 
 select * from Students;
--Update the email of a specific student.
 Update Students set Email = 'sam15@gmail.com' WHERE StudentID = 3; 
 
--Delete a record of a student who has graduated.
DELETE FROM Students  WHERE Graduation < GETDATE(); 
 select * from Students;

 
--Select and display only the names and emails of students.
 SELECT Concat(FirstName,' ',LastName) as Name, Email FROM Students;
 
--Retrieve students based on a specific condition (e.g., age > 18).
 SELECT * FROM Students WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) > 18;
 
--Fetch all records from the table.
 select * from Students;
 
--Retrieve students who belong to a specific department.
 
select * from Students where Dept='Electronics';
 
--Execute filtering queries and explain the results
--in
SELECT * FROM Students WHERE Dept IN ( 'Mechanical');
--distinct
SELECT DISTINCT Dept FROM Students;
--AND
SELECT * FROM Students WHERE Gender = 'M' AND Dept = 'Electronics';
--OR
SELECT * FROM Students WHERE Address LIKE '%Chennai%' OR Dept = 'Electronics';
--BETWEEN
SELECT * FROM Students WHERE DateOfBirth BETWEEN '2003-01-01' AND '2004-12-31';
--LIKE
SELECT * FROM Students WHERE Email LIKE 'p%';
--AS
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Dept AS Department FROM Students;


