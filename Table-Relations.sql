--1.	One-To-One Relationship
--Create two tables and use appropriate data types.
--Insert the data from the example above. Alter the Persons table and make PersonID a primary key. Create a foreign key between Persons and Passports by using the PassportID column.

CREATE DATABASE Persons
GO
USE Persons
GO

CREATE TABLE Passports(
  PassportID int PRIMARY KEY IDENTITY (101, 1),
  PassportNumber VARCHAR(50) NOT NULL  

)

CREATE TABLE Persons (
  PersonID int PRIMARY KEY IDENTITY,
  FirstName VARCHAR(50) NOT NULL,
  Salary DECIMAL (8, 2),
  PassportID int UNIQUE FOREIGN KEY REFERENCES  Passports(PassportID) 
)

INSERT INTO Passports (PassportNumber)
VALUES 
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')


INSERT INTO Persons (FirstName, Salary, PassportID)
VALUES
('Roberto', 43300, 102),
('Tom', 56100, 103),
('Yana', 60200, 101)

--2.	One-To-Many Relationship
--Create two tables and use appropriate data types.
--Insert the data from the example above and add primary keys and foreign keys.


CREATE DATABASE ONE_Many
GO
USE ONE_Many
GO

CREATE TABLE Manufacturers
(
[ManufacturerID] INT IDENTITY PRIMARY KEY,
[Name] VARCHAR (50),
EstablishedOn DATETIME2 
)

CREATE TABLE Models 
(
ModelID INT PRIMARY KEY IDENTITY (100, 1),
Name VARCHAR (50),
[ManufacturerID] INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers (Name, EstablishedOn)
VALUES
('BMW', '07/03/1913'),
('Tesla', '01/01/2003'),
('Lada', '01/05/1966')


INSERT INTO Models (Name, ManufacturerID)
VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 3),
('Nova', 3)




--3.	Many-To-Many Relationship
--Create three tables and use appropriate data types.
--Insert the data from the example above and add primary keys and foreign keys. Keep in mind that the table "StudentsExams" should have a composite primary key.

CREATE DATABASE many_to_many
GO
USE many_to_many
GO

--Copy from hire for Judge
  
CREATE TABLE Students
(
StudentID INT IDENTITY PRIMARY KEY,
[Name] VARCHAR (32)
)


CREATE TABLE Exams
(
ExamID INT IDENTITY (101, 1) PRIMARY KEY,
[Name] VARCHAR (32)
)

CREATE TABLE StudentsExams
(
StudentID INT foreign key REFERENCES Students(StudentID),
ExamID INT foreign key REFERENCES Exams(ExamID),
CONSTRAINT PK_StudentsExams Primary key (StudentID, ExamID)
)


INSERT INTO Students (Name)
VALUES 
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams (Name)
VALUES 
('SpringMVC'),
('Neo4j'),
('Oracle 11g')


INSERT INTO StudentsExams (StudentID, ExamID)
VALUES 
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103)



--4.	Self-Referencing 
--Create one table and use appropriate data types.
--Insert the data from the example above and add primary keys and foreign keys. The foreign key should be between ManagerId and TeacherId.

CREATE DATABASE Self_Referencing 
GO
USE Self_Referencing
GO

--USE DOWN FOR JUDGE


CREATE TABLE Teachers
(
TeacherID INT PRIMARY KEY,
Name VARCHAR (50),
ManagerID INT
)

INSERT INTO Teachers (TeacherID, Name, ManagerID)
VALUES
(101, 'John', NULL ),
(102, 'Maya', 106), 
(103, 'Silvia', 106),
(104, 'Ted', 105), 
(105, 'Mark', 101),
(106, 'Greta', 101)

ALTER TABLE Teachers
ADD CONSTRAINT fk_managerID FOREIGN KEY(ManagerID)
REFERENCES Teachers(TeacherID)
ON DELETE NO ACTION;

5.	Online Store Database
Create a new database and design the following structure:

CREATE DATABASE Online_Store_DATEBASE2
GO
USE Online_Store_DATEBASE2
GO

--Paste in Judge after this

CREATE TABLE ItemTypes
(
ItemTypeID INT IDENTITY PRIMARY KEY,
Name VARCHAR (50) NOT NULL
)

CREATE TABLE Items
(
ItemID INT IDENTITY PRIMARY KEY,
Name VARCHAR (120) NOT NULL,
ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE Cities
(
CityID INT IDENTITY PRIMARY KEY,
Name VARCHAR (50) NOT NULL
)

CREATE TABLE Customers
(
CustomerID INT IDENTITY PRIMARY KEY, 
Name VARCHAR (50) NOT NULL,
Birthday DATETIME2,
CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
OrderID INT IDENTITY PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)


CREATE TABLE OrderItems
(
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
CONSTRAINT PK_OrderItems PRIMARY KEY(OrderID,ItemID)

)


--6.	University Database
--Create a new database and design the following structure:

CREATE DATABASE University_Database2
GO
USE University_Database2
GO

CREATE TABLE Majors
(
MajorID INT IDENTITY PRIMARY KEY,
[Name] VARCHAR (50)
)


CREATE TABLE Students
(
StudentID INT IDENTITY PRIMARY KEY,
StudentNumber VARCHAR (30) NOT NULL,
StudentName VARCHAR (50) NOT NULL,
MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)


CREATE TABLE Subjects
(
SubjectID INT IDENTITY PRIMARY KEY,
SubjectName VARCHAR (50) NOT NULL
)


CREATE TABLE Agenda
(
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
CONSTRAINT PK_Agenda PRIMARY KEY(StudentID,SubjectID)

)

CREATE TABLE Payments
(
PaymentID INT IDENTITY PRIMARY KEY,
PaymentDate DATETIME2 NOT NULL,
PaymentAmount DECIMAL (10,2),
StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)



--9.	*Peaks in Rila
--Display all peaks for "Rila" mountain. Include:
--•	MountainRange
--•	PeakName
--•	Elevation
--Peaks should be sorted by elevation descending.



SELECT * FROM Mountains
SELECT * FROM Peaks

SELECT MountainRange
FROM Mountains AS m
WHERE Id = 17


--copy in judge

SELECT MountainRange, PeakName, Elevation FROM Peaks AS p
JOIN Mountains AS m ON p.MountainId= m.Id
WHERE MountainId = 17
ORDER BY Elevation DESC