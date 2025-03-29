-- Create the database
CREATE DATABASE CourseManagementSystem;

USE CourseManagementSystem;

CREATE TABLE Instructors (
    InstructorID INT  PRIMARY KEY,
    FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Expertise NVARCHAR(255) NOT NULL
)


CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(255) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    Duration INT NOT NULL CHECK (Duration > 0),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID) ON DELETE SET NULL
)

CREATE TABLE Students (
    StudentID INT  PRIMARY KEY,
    FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(20) UNIQUE NOT NULL
)

CREATE TABLE Enrollments (
    EnrollmentID INT  PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    CONSTRAINT UC_Student_Course UNIQUE (StudentID, CourseID) -- Ensures students cannot enroll in the same course multiple times
)


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    StudentID INT,
    AmountPaid DECIMAL(10,2) CHECK (AmountPaid > 0),
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE
)

CREATE TABLE Assessments (
    AssessmentID INT  PRIMARY KEY,
    CourseID INT,
    AssessmentType NVARCHAR(100) NOT NULL CHECK (AssessmentType IN ('Quiz', 'Assignment')),
    TotalMarks INT NOT NULL CHECK (TotalMarks > 0),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
)

-- Insert Instructors
INSERT INTO Instructors (InstructorID,FullName, Email, Expertise)
VALUES 
(1,'Dr. John Smith', 'john@gmail.com', 'Computer Science'),
(2,'Dr. Alia Bhatt ', 'alia@gmail.com', 'Data Science'),
(3,'Dr. Robert Johnson', 'robert@gmail.com', 'Cybersecurity'),
(4,'Dr. Michael Lee', 'michael@gmail.com', 'Artificial Intelligence'),
(5,'Dr. Sarah Davis', 'sarah@gmail.com', 'Software Engineering');

-- Insert Courses
INSERT INTO Courses (CourseID, CourseName, Category, Duration, InstructorID)
VALUES 
(101, 'Introduction to Programming', 'Computer Science', 12, 1),
(102, 'Data Analytics with Python', 'Data Science', 10, 2),
(103, 'Network Security Fundamentals', 'Cybersecurity', 8, 3),
(104, 'Machine Learning Basics', 'Artificial Intelligence', 14, 4),
(105, 'Software Development Cycle', 'Software Engineering', 16, 5),
(106, 'Deep Learning Fundamentals', 'Artificial Intelligence', 18, 2),
(107, 'Ethical Hacking', 'Cybersecurity', 10, 3); 

-- Insert Students
INSERT INTO Students (StudentID, FullName, Email, PhoneNumber)
VALUES 
(201, 'Alice Williams', 'alice.williams@demo.com', '9876543210'),
(202, 'Bob Taylor', 'bob.taylor@demo.com', '9876543211'),
(203, 'Charlie John', 'charlie@yahoo.com', '9876543212'),
(204, 'David Miller', 'david.martinez@gmail.com', '9876543213'),
(205, 'Emma White', 'emma.white@demo.com', '9876543214'),
(206, 'Fiona Clark', 'fiona.clark@example.com', '9876543215'),
(207, 'George Baker', 'george.baker@example.com', '9876543216');

-- Insert Enrollments
INSERT INTO Enrollments(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES 
(301, 201, 101, '2023-09-01'),
(302, 202, 102, '2024-11-21'),
(303, 203, 103, '2024-08-25'),
(304, 204, 104, '2023-02-10'),
(305, 205, 105, '2025-02-15'),
(306, 201, 102, '2025-01-05'), 
(307, 201, 103, '2024-12-27'), 
(308, 201, 104,'2024-08-18'), 
(309, 202, 105, '2025-03-01'), 
(310, 202, 103, '2025-02-21')

INSERT INTO Payments (PaymentID, StudentID, AmountPaid, PaymentDate)
VALUES 
(401, 201, 500.00, '2023-09-21'),
(402, 202, 750.00, '2024-11-25'),
(403, 203, 600.00, '2024-08-30'),
(404, 204, 800.00, '2023-02-20'),
(405, 205, 900.00, '2025-02-23');

-- Insert Assessments
INSERT INTO Assessments (AssessmentID, CourseID, AssessmentType, TotalMarks)
VALUES 
(501, 101, 'Quiz', 20),
(502, 102, 'Assignment', 50),
(503, 103, 'Quiz', 100),
(504, 104, 'Quiz', 30),
(505, 105, 'Assignment', 40),
(506, 106, 'Assignment', 100); 

select * from Instructors

select * from Students

select * from Enrollments

select * from Payments

select * from Assessments
--3.	Retrieve Available Courses:
--Write an SQL query to list all courses, including their Course Name, Category, Duration, and Instructor Name.
select c.CourseName,c.Category,c.Duration,i.FullName from Courses c left join Instructors i on 
c.InstructorID=i.InstructorID

--4.	Retrieve Students Enrolled in a Specific Course:
--Write a query to fetch the Student Name, Email, and Enrollment Date for students enrolled in a course (use a parameter for CourseID).

select s.FullName,s.Email,e.EnrollmentDate from Students s join Enrollments e on s.StudentId=e.StudentId 
where e.CourseId=103

--5.Update Instructor Information (Stored Procedure):
--Create a stored procedure to update an instructor's Full Name and Email based on InstructorID.
CREATE PROCEDURE UpdateInstructor
@InstructorId int,
@NewName varchar(75),
@NewEmail varchar(100)
As
BEGIN
Update Instructors set FullName=@NewName,Email=@NewEmail where InstructorID=@InstructorId
END
EXEC UpdateInstructor 1, 'Dr. Kamal Khan', 'Kamal@gmail.com';

--6.	Calculate Total Payments per Student:
--Write an SQL query to retrieve the Student Name and Total Amount Paid.Ensure that students with no payments are still included.
select s.FullName,p.AmountPaid from Students s left join Payments p on s.StudentID=p.StudentID

--7.	Retrieve Students Without Enrollments:
--Fetch a list of students who have not enrolled in any course.
select s.StudentId,s.FullName from Students s left join Enrollments e on s.StudentID=e.StudentID where e.EnrollmentID is null

--8.	Retrieve Monthly Revenue:
--Write an SQL query to calculate total payments received per month and year.

select year(PaymentDate) as Payment_Year,month(PaymentDate) as Payment_Month,Sum(AmountPaid) as Total_Payments from Payments
group by year(PaymentDate),month(PaymentDate) order by  Payment_Year, Payment_Month

--9.	Find Students Enrolled in More Than 3 Courses:
--Retrieve student details for those who have enrolled in more than 3 courses.
select s.StudentId,s.FullName, Count(e.StudentId) as Course_Enrolled from Students s left join Enrollments e on s.StudentID=e.StudentID group by s.StudentID,s.FullName
having Count(e.StudentID)>3

--10.	Retrieve Instructor-wise Course Count:
--List Instructors along with the number of courses they are teaching.
select i.FullName as Instructor_Name,Count(c.InstructorId) as Number_Courses_Teaching from Instructors i join Courses c on i.InstructorID=c.InstructorID
group by i.FullName,c.InstructorID

--11.	Find Students Without Payments:
--Write a query to retrieve students who have enrolled in at least one course but have not made any payment.
select s.StudentID,s.FullName from Students s join Enrollments e ON s.StudentID = e.StudentID left join Payments p on s.StudentID=p.StudentID where p.StudentID is Null

--12.	Retrieve Courses with No Enrollments:
--Fetch a list of courses that have never been enrolled in.
select c.CourseID,c.CourseName from  Courses c left join Enrollments e on c.CourseID=e.CourseID where e.CourseID is null

--13.	Find the Most Popular Course:
--Write an SQL query to determine the course with the highest number of enrollments.
select TOP 1 c.CourseID,c.CourseName,COUNT(e.CourseId) as Number_of_Enrollments from  Courses c left join Enrollments e 
on c.CourseID=e.CourseID group by c.CourseID,c.CourseName order by Number_of_Enrollments desc

--14.	Retrieve Students and Their Total Marks in a Course:
--Write a query that retrieves each student’s name, course name, and their total assessment marks.
select s.StudentId,s.FullName,c.CourseName,Sum(a.TotalMarks) as Total_Marks from Courses c
join Assessments a on c.CourseID=a.CourseID join Enrollments e on e.CourseID=c.CourseID 
join Students s on s.StudentID=e.StudentID group by s.StudentID,s.FullName,c.CourseName

--15. List Courses with Assessments but No Enrollments
select c.CourseID,c.CourseName from  Courses c left join  Assessments a on c.CourseID=a.CourseID 
left join Enrollments e on c.CourseID=e.CourseID where e.CourseID is null and a.CourseID is not null

--16.	Retrieve Payment Status per Student:
--Display each student's name, number of enrolled courses, and total amount paid.
select s.StudentId,s.FullName, Count(e.StudentId) as Course_Enrolled,p.AmountPaid
from Students s left join Enrollments e on s.StudentID=e.StudentID
join Payments p on p.StudentId=s.StudentId  group by s.StudentID,s.FullName,p.AmountPaid

--17.	Find Course Pairs with the Same Instructor:
--List pairs of courses that are taught by the same instructor.

select c1.CourseName AS Course1,c2.CourseName AS Course2,i.FullName AS Instructor_Name
FROM Courses c1 join Courses c2 ON c1.InstructorID = c2.InstructorID and c1.CourseID < c2.CourseID  
join Instructors i ON c1.InstructorID = i.InstructorID
ORDER BY i.FullName;

--18.	List All Possible Student-Course Combinations:
--Retrieve a Cartesian product of all students and courses (potential enrollments).
select s.StudentId,s.FullName as Name,c.CourseID, c.CourseName from Students s cross join Courses c 
order by s.StudentID

--19.	Determine the Instructor with the Highest Number of Students:
--Find the Instructor Name and the number of students enrolled in their courses.

select  Top 1 i.FullName as Instructor_Name,Count(e.StudentId) as Number_of_students from Instructors i  join Courses c on i.InstructorID=c.InstructorID 
 join Enrollments e on e.CourseID=c.CourseID
group by i.FullName order by Number_of_students desc

--20.	Trigger to Prevent Double Enrollment:
--Create a trigger to prevent a student from enrolling in the same course more than once.

CREATE TRIGGER PreventDoubleEnrollment
ON Enrollments
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Enrollments e
        JOIN inserted i ON e.StudentID = i.StudentID AND e.CourseID = i.CourseID
    )
    BEGIN
        RAISERROR ('Student is already enrolled in this course.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
