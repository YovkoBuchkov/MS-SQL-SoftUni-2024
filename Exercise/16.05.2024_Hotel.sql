
CREATE DATABASE Hotel 
GO

USE Hotel 
GO


CREATE TABLE Employees
(
Id INT PRIMARY KEY IDENTITY,
FirstName VARCHAR (15),
LastName VARCHAR (15),
Title VARCHAR (25),
Notes VARCHAR (MAX)
)

INSERT INTO Employees (FirstName, LastName, Title) 
VALUES 
('Ivan', 'Ivanov', 'Manager' ),
('Petkan', 'Petkanov', 'Senior engineer'),
('Dragan', 'Smit', 'dismissed worker')

CREATE TABLE Customers
(
AccountNumber INT PRIMARY KEY IDENTITY,
FirstName VARCHAR (15) NOT NULL,
LastName VARCHAR (15) NOT NULL,
PhoneNumber NVARCHAR(15),
EmergencyName VARCHAR (20),
EmergencyNumber NVARCHAR(15),
Notes VARCHAR (MAX)
)

INSERT INTO Customers (FirstName, LastName, PhoneNumber) 
VALUES 
		('Ivan', 'Ivanov', '0887708800' ),
		('Petkan', 'Petkanov', '0887708801'),
		('Dragan', 'Smit', '088770882')


CREATE TABLE RoomStatus
(
RoomStatus NVARCHAR(50) PRIMARY KEY,
Notes VARCHAR (MAX)
)

INSERT INTO RoomStatus (RoomStatus, Notes) 
VALUES 
	('Vacant', 'Free' ),
	('Clearing', 'Under Clearing'),
	('Occupied', 'NOT AVALIABLE')

CREATE TABLE RoomTypes
(
RoomType NVARCHAR(50) PRIMARY KEY,
Notes VARCHAR (MAX)
)

INSERT INTO RoomTypes (RoomType, Notes) 
VALUES 
	('XXL', 'Big room' ),
	('XL', 'Normal room'),
	('L', 'small room')


CREATE TABLE BedTypes
(
BedType NVARCHAR(50) PRIMARY KEY,
Notes VARCHAR (MAX)
)

INSERT INTO BedTypes (BedType, Notes) 
VALUES 
	('XXL', 'Big bed' ),
	('XL', 'Normal bed'),
	('L', 'small bed')


CREATE TABLE Rooms
(
RoomNumber INT PRIMARY KEY IDENTITY (100, 1),
RoomType VARCHAR(50),
		CHECK(RoomType in('XXL', 'XL', 'L')),
BedType VARCHAR(50),
		CHECK(RoomType in('XXL', 'XL', 'L')),
Rate money,
RoomStatus VARCHAR(50),
		CHECK(RoomStatus in('Vacant', 'Occupied', 'Clearing')),
Notes VARCHAR (MAX)
)

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus) 
VALUES 
	('XXL', 'XXL', 200, 'Vacant'),
	('XL', 'XL', 150, 'Occupied'),
	('L', 'L', 100, 'Clearing')


CREATE TABLE Payments
(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
PaymentDate DATETIME2 ,
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
FirstDateOccupied DATETIME2,
LastDateOccupied DATETIME2,
TotalDays VARCHAR (4),
AmountCharged money,
TaxRate money,
TaxAmount money,
PaymentTotal money,
Notes VARCHAR (MAX)
)

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal) 
VALUES 
		(1, '2024-01-01', 1, '2024-01-01', '2024-01-02', '2', '100', '10', '10', '120'),
		(2, '2024-01-01', 3, '2024-01-01', '2024-01-04', '4', '200', '10', '30', '230'),
		(3, '2024-01-01', 2, '2024-01-01', '2024-01-03', '3', '150', '10', '20', '180')

CREATE TABLE Occupancies
(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
DateOccupied DATETIME2,
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied money,
PhoneCharge money,
Notes VARCHAR (MAX)
)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge) 
VALUES 
	('1', '2024-01-01', '1', '100', '100', '10') ,
	('2', '2024-01-01', '2', '101', '150', '20') ,
	('3', '2024-01-01', '3', '102', '200', '30') 




SELECT * FROM RoomStatus
SELECT * FROM RoomTypes
SELECT * FROM BedTypes
SELECT * FROM Rooms
SELECT * FROM Payments
SELECT * FROM Occupancies


USE Hotel;
GO

UPDATE Payments
SET TaxRate = (1 - 0.03) * TaxRate;

SELECT TaxRate FROM Payments;


-- Use Hotel database
USE Hotel;
GO

TRUNCATE TABLE Occupancies;