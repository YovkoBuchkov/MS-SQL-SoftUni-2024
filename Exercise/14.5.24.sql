--1 -create database

CREATE DATABASE Minions
USE Minions;
GO;

--1 -create table
CREATE TABLE Minions
(
Id INT PRIMARY KEY,
[Name] VARCHAR(50),
Age INT
)


CREATE TABLE Towns
(
Id INT PRIMARY KEY,
[Name] VARCHAR(50)
)

-- Alter Minions Table
ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

--Options 2

ALTAR TABLE Minions
ADD [TownId] INT FOREIGN KEY REFERENCEC [Towns] (Id)



--4 insert Record 

INSERT INTO Towns
VALUES (1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')


INSERT INTO Minions (Id, [Name], Age, TownId)
VALUES (1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)


TRUNKATE TABLE Minions





SELECT * FROM Minions
SELECT * FROM Towns



-- Truncate table
TRUNCATE TABLE Minions
SELECT * FROM Minions


SELECT * FROM Minions
JOIN Towns on Towns.Id = Minions.TownId


--6 drop table

DROP TABLE Minions
DROP TABLE Towns

--7 Create Table
DROP TABLE People
SELECT * FROM People


CREATE TABLE People
(
Id INT PRIMARY KEY IDENTITY, 
[Name] NVARCHAR (200) NOT NULL,
Picture VARBINARY (MAX),
Height DECIMAL (3,2),
[Weight] DECIMAL (5,2),
Gender CHAR(1) NOT NULL,
	CHECK(Gender in('m', 'f')),
Birthdate  DATETIME2 NOT NULL,
Biography VARCHAR (MAX)
)

INSERT INTO People ([Name], Gender, Birthdate)
		VALUES ('Pesho', 'm', '1988-05-05'),
				 ('Radka', 'f', '1994-03-07'),
				 ('Ivan', 'm', '1982-05-01'),
				 ('Petkan', 'm', '1982-02-01'),
				 ('Dragan', 'm', '1999-01-01')




ALTER TABLE People
ADD CONSTRAINT PK_People
PRIMARY KEY(Id)



--8 CREATE TABLE Users

CREATE TABLE Users
(
Id BIGINT PRIMARY KEY IDENTITY, 
Username VARCHAR (30) NOT NULL,
[Password] VARCHAR (26) NOT NULL,
ProfilePicture VARBINARY (MAX),
LastLoginTime DATETIME2,
IsDeleted BIT

)

INSERT INTO Users (Username, [Password])
			VALUES ('pesho12', '12345'),
			('mesho13', '12345'),
			('stesho14', '12345'),
			('tresho16', '12345'),
			('pencho11', '12345')


SELECT * FROM Users



-- 9.	Change Primary Key

ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC073336B331

ALTER TABLE Users
ADD CONSTRAINT PK_UsersTable PRIMARY KEY(Id, Username)


--10.	Add Check Constraint

ALTER TABLE Users
ADD CONSTRAINT CHK_PasswordIsAtLeastFiveSimbols
	CHECK(LEN(Password) >=5)

INSERT INTO Users (Username, [Password])
		VALUES ('peturpetrov', '1234')

SELECT * FROM Users

SELECT LEN('fgfgdggdgdffgdffgf')


--11.	Set Default Value of a Field





--16

CREATE DATABASE SoftUni
USE SoftUni;

CREATE TABLE Towns
(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR (60)

)


CREATE TABLE Addresses
(
Id INT PRIMARY KEY IDENTITY,
AddressText VARCHAR (MAX),
TownId INT FOREIGN KEY REFERENCES Towns(Id)

)

CREATE TABLE Departments
(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR (60)

)

CREATE TABLE Employees

(
Id INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(60),
MiddleName VARCHAR(60),
LastName VARCHAR(60),
JobsTitle VARCHAR(60),
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
HireDate DATETIME2,
Salary DECIMAL(10,2),
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)

)