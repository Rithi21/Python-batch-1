If not exists(select * from sys.databases where name='PetCare')
create database PetCare

Use PetCare

If not exists(select * from sys.tables where name='Shelters')
create table Shelters(ShelterID int Primary Key, Name Varchar(100) NOT NULL, Location Varchar(100) NOT NULL)

If not exists(select * from sys.tables where name='Pets')
create table Pets(PetID Int Primary Key, Name varchar(100) NOT NULL, Age int check(Age >= 0), Breed varchar(100) , 
Type varchar(75),AvailableForAdoption bit default 1, ShelterID INT,
       Foreign Key (ShelterID) REFERENCES Shelters(ShelterID))

If not exists(select * from sys.tables where name='Donations')
create table Donations (DonationID int Primary Key, DonorName varchar(100) NOT NULL, DonationType varchar(50), 
DonationAmount Decimal(10,2), DonationItem varchar(75),  DonationDate Date,ShelterID int,
Foreign Key(ShelterID) REFERENCES Shelters(ShelterID))

If not exists(select * from sys.tables where name='AdoptionEvents')
create table AdoptionEvents(EventID int Primary key, EventName varchar(100), EventDate Date, Location varchar(100))

If not exists(select * from sys.tables where name='Participants')
create table Participants(ParticipantID int Primary Key, ParticipantName varchar(75), ParticipantType varchar(75), 
EventID int ,Foreign Key(EventId) REFERENCES AdoptionEvents(EventId))

INSERT INTO Pets (PetId,Name, Age, Breed, Type, AvailableForAdoption,ShelterID) VALUES
(1,'Shero', 3, 'Golden Retriever', 'Dog', 0,1),
(2,'Nobita', 2, 'BullDog', 'Cat', 0,2),
(3,'Subramani', 1, 'Beagle', 'Dog', 1,NULL),
(4,'Coco', 4, 'Parrot', 'Bird', 0,2),
(5,'Lina', 5, 'Persian', 'Cat', 1,Null),
(6,'Charlie', 6, 'Beagle', 'Dog', 0,3),
(7,'Leo', 3, 'Golden Retriever', 'Dog', 0,4),
(8,'Teddy', 2, 'Sparrow', 'Bird', 1,Null)


Insert Into Shelters (ShelterID,Name, Location) VALUES
(1,'Twisty Tales', 'Chennai'),
(2,'Heaven For Pets', 'Bangalore'),
(3,'Pet Rescue Camp', 'Mumbai'),
(4,'Pets Friendly Home', 'Hyderabad'),
(5,'Animal Care Hub', 'Chennai');

Insert into Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate,ShelterID) VALUES
(101, 'Peter John', 'Money', 100.00, NULL, '2025-03-20',1),
(102, 'Henry Keith', 'Item', NULL, 'Dog Food', '2025-03-15',2),
(103, 'John Smith', 'Money', 250.00, NULL, '2025-02-22',3),
(104, 'Alan Walker', 'Item', NULL, 'Cat Toys', '2025-02-18',4),
(105, 'Kamal Khan', 'Money', 500.00, NULL, '2025-02-16',5);


Insert into AdoptionEvents (EventId,EventName, EventDate, Location) VALUES
(1,'Summer Pet Fair', '2025-02-15', 'Central Park,Chennai'),
(2,'Pet Rescue Camp', '2024-12-10', 'DownTown,Bangalore'),
(3,'Furry Friends Meetup', '2025-02-20', 'Express Mall,Hyderabad'),
(4,'Pet Adoption Day', '2025-03-26', 'Animal Shelter,Mumbai'),
(5,'Happy PetCare Event', '2025-03-28', 'City Hall,Mumbai');

Insert into Participants (ParticipantId,ParticipantName, ParticipantType, EventID) VALUES
(1,'David Miller', 'Adopter', 1),
(2,'Spencer Jhonson', 'Volunteer', 2),
(3,'Prasanth Neel', 'Sponsor', 3),
(4,'Rahul Chahar', 'Adopter', 4),
(5,'Taylor Shift', 'Volunteer', 5)

select * from Pets
select * from Shelters
select * from Donations
select * from AdoptionEvents
select * from Participants


--3.	Retrieve Available Pets: Write an SQL query to list pets available for adoption.
select Name,Age,Breed,Type from Pets where AvailableForAdoption=1

--4.	Retrieve Event Participants:
--Write an SQL query to list participant names and types for a specific event based on EventID.
declare @EventId 3
select ParticipantName,ParticipantType from Participants where EventID = @EventID;

--5.	Update Shelter Information (Stored Procedure):
--	Create a stored procedure to update a shelter’s name and location.The procedure should take ShelterID, NewName, and NewLocation as parameters.
CREATE PROCEDURE UpdateShelterInfo
    @ShelterID INT,
    @NewName VARCHAR(50),
    @NewLocation NVARCHAR(50)
AS
BEGIN
    UPDATE Shelters
    SET Name = @NewName, Location = @NewLocation
    WHERE ShelterID = @ShelterID;
END;
--6.	Calculate Shelter Donations: Write an SQL query to calculate the total donation amount per shelter.The output should include Shelter Name and Total Donation Amount.
-- 6. Calculate Shelter Donations
select S.Name AS ShelterName, SUM(D.DonationAmount) AS TotalDonation
from Shelters S
JOIN Donations D ON S.ShelterID = D.ShelterID
group by S.Name

--7.	Retrieve Pets Without Owners:
--Write an SQL query to list all pets that do not have an owner (OwnerID IS NULL).
SELECT * FROM Pets WHERE ShelterID IS NULL;

--8. Monthly Donation Summary:
--Write an SQL query to retrieve total donations per month and year.
Select YEAR(DonationDate) AS Year, MONTH(DonationDate) AS Month, SUM(DonationAmount) AS TotalDonations from Donations
GROUP BY YEAR(DonationDate), MONTH(DonationDate);

--9.	Filter Pets by Age:
--Retrieve distinct pet breeds where pets are aged between 1 and 3 years or older than 5 years.

select distinct Breed from Pets where Age Between 1 and 3 Or Age > 5

--10.	Pets and Their Shelters:
--•	List all pets and their respective shelters where pets are available for adoption.
SELECT P.Name AS PetName, S.Name AS ShelterName FROM Pets P
JOIN Shelters S ON P.ShelterID = S.ShelterID WHERE P.AvailableForAdoption = 1;

--11.	Count Event Participants by City:
--•	Find the total number of participants in adoption events held in a specific city (e.g., Mumbai).
select Location, COUNT(*) AS TotalParticipants FROM AdoptionEvents E
JOIN Participants P ON E.EventID = P.EventID WHERE Location = 'Mumbai'
GROUP BY Location;

--12.	Unique Breeds of Young Pets:
--Retrieve unique pet breeds for pets aged between 1 and 5 years.
select distinct Breed FROM Pets WHERE Age BETWEEN 1 AND 5

--13.	Find Pets Not Yet Adopted:
--Retrieve a list of pets that have not been adopted.
select * FROM Pets WHERE AvailableForAdoption = 1;

--14.	Retrieve Adopted Pets and Adopters:
--Fetch the names of adopted pets along with their adopter’s name.
SELECT P.Name AS PetName, Pt.ParticipantName AS AdopterName
FROM Pets P JOIN Participants Pt ON P.PetID = Pt.ParticipantID;

--15.	Count Available Pets in Shelters:
--List all shelters along with the count of pets currently available for adoption in each shelter.
SELECT S.Name AS ShelterName, COUNT(P.PetID) AS AvailablePets
FROM Shelters S LEFT JOIN Pets P ON S.ShelterID = P.ShelterID AND P.AvailableForAdoption = 1
GROUP BY S.Name;

--16.	Find Matching Pet Pairs in Shelters:
--List pairs of pets from the same shelter that have the same breed.
SELECT P1.Name AS Pet1, P2.Name AS Pet2, S.Name AS Shelter
FROM Pets P1, Pets P2, Shelters S
WHERE P1.Breed = P2.Breed AND P1.ShelterID = P2.ShelterID AND P1.PetID < P2.PetID;

--17.	Find All Shelter-Event Combinations:
--Retrieve all possible combinations of shelters and adoption events.
SELECT S.Name AS Shelter, E.EventName FROM Shelters S CROSS JOIN AdoptionEvents E;

--18.	Identify the Most Successful Shelter:
--Determine the shelter that has the highest number of adopted pets.

SELECT TOP 1 S.Name AS ShelterName, COUNT(P.PetID) AS AdoptedPets
FROM Shelters S JOIN Pets P ON S.ShelterID = P.ShelterID WHERE P.AvailableForAdoption = 0
GROUP BY S.Name ORDER BY COUNT(P.PetID) DESC;

--19.	Trigger for Adoption Status Update:
--Create a database trigger that updates a pet’s AvailableForAdoption status when it is adopted.
-- Trigger for Adoption Status Update
-- Trigger for Adoption Status Update
CREATE TRIGGER trg_UpdateAdoptionStatus
ON Participants
AFTER INSERT
AS
BEGIN
    UPDATE Pets
    SET AvailableForAdoption = 0
    FROM Pets
    JOIN inserted i ON Pets.PetID = i.ParticipantID
    WHERE i.ParticipantType = 'Adopter';
END;

--20.	Data Integrity Check:
--Ensure that a pet cannot be adopted twice using a constraint or validation trigger.
-- Trigger for Adoption Status Update

CREATE TRIGGER trg_PreventDuplicateAdoption
ON Participants
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Participants p
        JOIN inserted i ON p.ParticipantID = i.ParticipantID
        WHERE p.ParticipantType = 'Adopter'
        GROUP BY p.ParticipantID
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('A pet cannot be adopted twice.', 16, 1);
        ROLLBACK;
    END;
END;
