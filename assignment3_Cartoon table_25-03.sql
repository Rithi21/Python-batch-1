create table Organization (
    OrgID INT PRIMARY KEY ,
    OrgName VARCHAR(75) NOT NULL UNIQUE,
    FoundedYear INT, 
    Headquarters VARCHAR(50),
	Popular_series VARCHAR(100)
);

create table Series(
SeriesID int PRIMARY KEY,SeriesName varchar(75) NOT NULL UNIQUE,OrgId int,
TRP Decimal(5,2),No_of_views int, FOREIGN KEY (OrgID) REFERENCES Organization(OrgID) 
);

create table cartoon(
CartoonId int PRIMARY KEY,CartoonName varchar(75),SeriesID int,First_appeared_date DATE,
FOREIGN KEY(SeriesId) REFERENCES Series(SeriesId));

INSERT INTO Organization (OrgID,OrgName, FoundedYear, Headquarters, Popular_series) VALUES
(1,'Warner Bros', 1923, 'Burbank, California, USA', 'Tom and Jerry'),
(2,'Nintendo', 1889, 'Kyoto, Japan', 'Pokemon'),
(3,'Green Gold Animation', 2001, 'Hyderabad, India', 'Chhota Bheem'),
(4,'Shin-Ei Animation', 1976, 'Tokyo, Japan', 'Shinchan'),
(5,'Fujiko F. Fujio Productions', 1969, 'Tokyo, Japan', 'Doraemon'),
(6,'Disney', 1923, 'Burbank, California, USA', 'Mickey Mouse');




INSERT INTO Series (SeriesId,SeriesName, OrgID, TRP, No_Of_Views) VALUES
(1,'Tom and Jerry', 1, 9.5, 1000000),
(2,'Pokemon', 2, 9.2, 950000),
(3,'Chhota Bheem', 3, 6.5, 850000),
(4,'Shinchan', 4, 8.9, 900000),
(5,'Doraemon', 5, 9.0, 920000),
(6,'Mickey Mouse',6,6.8,750000);

INSERT INTO cartoon (CartoonId,CartoonName, SeriesID, First_appeared_date) VALUES
(101,'Tom', 1, '1940-02-10'),
(102,'Jerry', 1, '1940-02-10'),
(103,'Pikachu', 2, '1997-04-01'),
(104,'Chhota Bheem', 3, '2008-04-06'),
(105,'Shinchan', 4, '1992-04-13'),
(106,'Doraemon', 5, '1970-01-01'),
(107,'Doraemon', 5, '1970-01-01'),
(108,'Nobita', 5, '1970-01-01'),
(109,'Mickey', 6, '1923-05-01');






--Filter Series Based on TRP
SELECT * from Series where TRP > 7.0;
--Sort Series Based on TRP
SELECT * from Series order by TRP DESC; 
--Find the Most Popular Cartoon Character
SELECT TOP 1 c.CartoonName, s.SeriesName, s.TRP, s.No_of_views  
FROM cartoon c  
JOIN Series s ON c.SeriesID = s.SeriesID  
ORDER BY s.TRP DESC, s.No_of_views DESC;

--Highest no of views
SELECT TOP 1 SeriesName, No_Of_Views  FROM Series  
ORDER BY No_Of_Views DESC;
