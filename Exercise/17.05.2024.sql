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
		('Varna'),
		('Burgas')


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
		('Zlatna 1', 1)

CREATE TABLE Departments 
(
Id INT PRIMARY KEY IDENTITY (1,1),
 [Name] VARCHAR (30)
)

INSERT INTO Departments ([Name])
VALUES	('Software Development'), 
		('Engineering'), 
		('Quality Assurance'),
		('Sales'),
		('Marketing')

CREATE TABLE Employees 
(
Id INT PRIMARY KEY IDENTITY (1,1),
FirstName VARCHAR (30) NOT NULL,
MiddleName VARCHAR (30) NOT NULL,
LastName VARCHAR (30) NOT NULL,
JobTitle VARCHAR (80) NOT NULL,
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
HireDate DATETIME2 NOT NULL,
Salary money NOT NULL,
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)


INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
VALUES	('Pencho', 'Penchov', 'Penchovski', '.NET Developer', 1, '2024-01-01', '3500', 1), 
		('Stanka', 'Stankova', 'Stamatova', 'Senior Engineer', 2, '2024-01-01', '4000', 2), 
		('Elka', 'Smyatai', 'Smetacheva', 'Intern', 3, '2024-01-01', '525', 3),
		('Mincho', 'Provchev', 'Praznikov', 'CEO', 4, '2024-01-01', '3000', 4),
		('Djuni', 'Munchov', 'Prekopaichev', 'Intern', 1, '2024-01-01', '599', 1)


		--22 - заплати


SELECT Towns.Name, Departments.Name 
FROM Employees
JOIN Departments on Employees.DepartmentId = Departments.Id
JOIN Genres on Movies.GenreId = Genres.Id

USE SoftUni;
GO
--19
SELECT * FROM Towns;
SELECT * FROM Departments;
SELECT * FROM Employees;
--20
SELECT * FROM Towns ORDER BY Name;
SELECT * FROM Departments ORDER BY Name;
SELECT * FROM Employees ORDER BY Salary DESC;
--21
SELECT [Name] FROM Towns ORDER BY Name;
SELECT [Name] FROM Departments ORDER BY Name;
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC;


UPDATE Employees
SET Salary = Salary * 1.1

Update Employees
SET Salary = Salary + 665 
where id = 5

--delete row
delete from Employees
where id = 4

select * From Employees


TRUNCATE TABLE Departments
DROP DATABASE SoftUni


USE master
GO


  SELECT [FirstName]  + ' ' + [LastName] 
	  AS [Full Name],
	     [JobTitle],
		 [Salary]
	FROM Employees
ORDER BY [Salary]