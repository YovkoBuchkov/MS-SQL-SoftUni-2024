
CREATE DATABASE CarRental 
GO

USE CarRental 
GO
--Copy From HIRE for Judge


CREATE TABLE Categories 
(
Id INT PRIMARY KEY IDENTITY, 
CategoryName VARCHAR (30),
DailyRate money , 
WeeklyRate money , 
MonthlyRate money , 
WeekendRate money
)

INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) 
VALUES 
('Fast', '10', '80', '350', '20'),
('Slow', '5', '40', '150', '10'),
('Broken', '1', '10', '50', '2')



CREATE TABLE Cars 
(
Id INT PRIMARY KEY IDENTITY,  
PlateNumber VARCHAR (10),
Manufacturer VARCHAR (40), 
Model VARCHAR (30), 
CarYear CHAR (4), 
CategoryId INT FOREIGN KEY REFERENCES Categories(Id), 
Doors numeric (2), 
Picture VARBINARY (MAX), 
Condition VARCHAR (30), 
Available VARCHAR (5)
		CHECK(Available in('Yes', 'No')),
)


INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Available) 
VALUES 
('SA2030SB', '6546546546532', 'Tastarosa', 2024, 1, 2, 'Yes'),
('SA2030SD', '6546546546533', 'Mustang', 2024, 2, 4, 'Yes'),
('SA2030SF', '6546546546534', 'Corsa', 1981, 3, 5, 'No')



CREATE TABLE Employees 
(
Id INT PRIMARY KEY IDENTITY, 
FirstName VARCHAR (15), 
LastName VARCHAR (20), 
Title VARCHAR (50), 
Notes VARCHAR (MAX)
)

INSERT INTO Employees (FirstName, LastName, Title) 
VALUES 
('Ivan', 'Ivanov', 'Manager' ),
('Petkan', 'Petkanov', 'Senior engineer'),
('Dragan', 'Smit', 'dismissed worker')

CREATE TABLE Customers 
(
Id INT PRIMARY KEY IDENTITY, 
DriverLicenceNumber VARCHAR (30), 
FullName VARCHAR (50), 
[Address] VARCHAR (50), 
City VARCHAR (30), 
ZIPCode numeric (10), 
Notes VARCHAR (MAX)
) 

INSERT INTO Customers (DriverLicenceNumber, FullName) 
VALUES 
('654654654654', 'Antonio Fagaldo' ),
('654654654655', 'Antonio Affreto' ),
('654654654656', 'pesho Busmanci' )



CREATE TABLE RentalOrders 
(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
CustomerId INT FOREIGN KEY REFERENCES Customers(Id), 
CarId INT FOREIGN KEY REFERENCES Cars(Id), 
TankLevel VARCHAR (15), 
		CHECK(TankLevel in('FULL', 'EMPTY', 'MIDDLE')),
KilometrageStart numeric (10), 
KilometrageEnd numeric (10), 
TotalKilometrage numeric (10), 
StartDate DATETIME2 NOT NULL, 
EndDate DATETIME2 NOT NULL, 
TotalDays numeric (10), 
RateApplied VARCHAR (30), 
TaxRate numeric (10), 
OrderStatus VARCHAR (30), 
Notes VARCHAR (MAX)

)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, StartDate, EndDate) 
VALUES 
(1, 1, 2, 'FULL', '2024-06-05', '2024-06-08'),
(2, 2, 1, 'MIDDLE', '2024-06-06', '2024-06-09'),
(3, 3, 3, 'EMPTY', '2024-06-12', '2024-06-14')


--Copy to HIRE for Judge

SELECT * FROM RentalOrders
SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Cars
SELECT * FROM Categories

SELECT *
FROM RentalOrders
JOIN Cars on RentalOrders.CarId = Cars.Id
JOIN Customers on RentalOrders.CustomerId = Customers.Id
JOIN Employees on RentalOrders.EmployeeId = Employees.Id

