CREATE DATABASE SoftUni
GO

USE SoftUni
GO


CREATE TABLE Towns 
(
Id INT PRIMARY KEY IDENTITY (1,1),
[Name] VARCHAR (30)
)

INSERT INTO Towns ([Name])
VALUES	('Sofia'), 
		('Plovdiv'), 
		('Paris'),
		('Busmanci'),
		('Chelopech')


CREATE TABLE Addresses 
(
Id INT PRIMARY KEY IDENTITY (1,1),
AddressText VARCHAR (80),
TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

INSERT INTO Addresses (AddressText, TownId)
VALUES	('Vitoshka 2', 1), 
		('Руски 2', 2), 
		('Shanzelize 1', 3),
		('Zdrave 1', 4),
		('Zlatna 1', 5)

CREATE TABLE Departments 
(
Id INT PRIMARY KEY IDENTITY (1,1),
 [Name] VARCHAR (30)
)

INSERT INTO Departments ([Name])
VALUES	('managment'), 
		('workers'), 
		('accounting'),
		('Sales'),
		('Engineering')

CREATE TABLE Employees 
(
Id INT PRIMARY KEY IDENTITY (1,1),
FirstName VARCHAR (30),
MiddleName VARCHAR (30),
LastName VARCHAR (30),
JobTitle VARCHAR (80),
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
HireDate DATETIME2 ,
Salary money,
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)


INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
VALUES	('Pencho', 'Penchov', 'Penchovski', 'Merinjey', 1, '2024-01-01', '10000', 1), 
		('Stanka', 'Stankova', 'Stamatova', 'Mravka rabotnik', 2, '2024-01-01', '1000', 2), 
		('Elka', 'Smyatai', 'Smetacheva', 'Schetovoditel', 3, '2024-01-01', '20000', 3),
		('Mincho', 'Provchev', 'Praznikov', 'Turgovec', 4, '2024-01-01', '2000', 4),
		('Djuni', 'Munchov', 'Prekopaichev', 'Worker in mine', 5, '2024-01-01', '985', 5)

