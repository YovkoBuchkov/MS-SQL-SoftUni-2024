SELECT FirstName, LastName, JobTitle FROM Employees

SELECT * FROM Projects WHERE StartDate = '1/1/2006'

INSERT INTO Projects(Name, StartDate)
			VALUES ('Introduction to SQL Course', '1/1/2003')

UPDATE Project
SET EndDate = '8/31/2006'
WHERE StartDate = '1/1/2006'

DELETE FROM Projects
WHERE StartDate = '1/1/2006'

--триене на FOREIGN KEY и създаването му отново
ALTER TABLE Pro
DROP CONSTRAINT FK_MYForeignKey

ALTER TABLE Pro
ADD CONSTRAINT FK_MYForeignKey FOREIGN KEY ManagerId REFERENCES Manages(Id)

--триене на FOREIGN KEY и създаването му отново



CREATE DATABASE DEMO2024
GO

USE DEMO2024
GO

CREATE TABLE Employees

(
EmployeesID INT PRIMARY KEY IDENTITY,
Name VARCHAR (50) NOT NULL,
LastName VARCHAR (50) NOT NULL,
Salary DECIMAL (8, 2) NOT NULL,
IsActive BIT NOT NULL DEFAULT (1)
)

INSERT INTO Employees (Name, LastName, Salary)
VALUES
('Pesho', 'Ivanov', 5000),
('Gosho', 'peshov', 6000),
('Ivan', 'Goshev', 7000)

SELECT *  FROM Employees

UPDATE [Employees]
SET [IsActive] = 0
WHERE ]Name] = 'Ivan'

drop TABLE Employees


--Aliases rename a table or column 

SELECT EmployeesID AS ID
FROM Employees

--Select and Filtering
SELECT	[EmployeesID], 
		[Name], 
		[Salary] AS [Pari za kurvi]
   From Employees
  Where [Salary] > 5000

--end

--Concatenate - Събиране на текстове and Aliases

SELECT [name] + ' ' + [LastName] AS ['Full Name'],
		[Salary]
FROM [Employees]

--Second Concatenate

SELECT [co].[ContinentCode],[co].[ContinentName], [mo].[MountainRange], [mo].[id], [con].*
FROM [Continents] as co, [Mountains] as mo, [Countries] as con
WHERE [co].[ContinentCode] = [con].CountryCode

--end

--Create VIEW

GO
CREATE OR ALTER VIEW [v_HighPeaks] AS
SELECT TOP (1)*, GETDATE ()
AS [Execution DateTime]
FROM [Peaks]
ORDER BY [Elevation] DESC
GO

SELECT *
FROM [dbo].[v_HighPeaks]

--записва данните от VIEW в нова таблица
SELECT * INTO [HighPeak]
FROM [dbo].[v_HighPeaks]
--end

