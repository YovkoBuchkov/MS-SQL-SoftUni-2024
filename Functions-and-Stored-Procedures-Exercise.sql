--1.	Employees with Salary Above 35000
--Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all employees' first and last names, whose salary above 35000. 



USE SoftUni
GO

--Judje
CREATE OR ALTER PROC usp_GetEmployeesSalaryAbove35000 AS
BEGIN
	SELECT FirstName, LastName FROM Employees
	WHERE Salary > 35000
END
--Judje

GO

EXEC usp_GetEmployeesSalaryAbove35000



--2.	Employees with Salary Above Number
--Create a stored procedure usp_GetEmployeesSalaryAboveNumber that accepts a number (of type DECIMAL(18,4)) as parameter and returns all employees' first and last names, 
--whose salary is above or equal to the given number. 



 


CREATE OR ALTER PROC dbo.usp_GetEmployeesSalaryAboveNumber @SalaryCheck DECIMAL(18,4)
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @SalaryCheck
END
GO


EXEC usp_GetEmployeesSalaryAboveNumber 48100


--3.	Town Names Starting With
--Create a stored procedure usp_GetTownsStartingWith that accepts a string as parameter and returns all town names starting with that string. 


CREATE OR ALTER PROC dbo.usp_GetTownsStartingWith @TownCheck VARCHAR (30)
AS
BEGIN
	SELECT [Name]
	FROM Towns
	WHERE [Name] LIKE @TownCheck + '%';
	--WHERE [Name] LIKE CONCAT(@TownCheck, '%')
END
GO

EXEC usp_GetTownsStartingWith b





--4.	Employees from Town
--Create a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and returns the first and last name of those employees, who live in the given town. 

 

CREATE OR ALTER PROC dbo.usp_GetEmployeesFromTown @TownCheck VARCHAR (30)
AS
BEGIN
	SELECT FirstName, LastName FROM Employees AS e
	JOIN Addresses AS a ON a.AddressID = e.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.[NAME] = @TownCheck
END
GO

EXEC usp_GetEmployeesFromTown Sofia


--5.	Salary Level Function
--Create a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an employee and returns the level of the salary.





CREATE FUNCTION ufn_GetSalaryLevel(@Salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @Result NVARCHAR(10)

	IF(@Salary < 30000)
		BEGIN
			SET @Result = 'Low'
		END
	
	ELSE IF (@Salary BETWEEN 30000 AND 50000)
		BEGIN
			SET @Result = 'Average'
		END

	ELSE
		BEGIN
			SET @Result = 'High'
		END

	RETURN @Result

END


SELECT 
Firstname,
LastName,
Salary,
dbo.ufn_GetSalaryLevel (Salary) AS SalaryLevel
FROM Employees



--6.	Employees by Salary Level
--Create a stored procedure usp_EmployeesBySalaryLevel that receives as parameter level of salary (low, average, or high) 
--and print the names of all employees, who have the given level of salary. You should use the function - "dbo.ufn_GetSalaryLevel(@Salary)", 
--which was part of the previous task, inside your "CREATE PROCEDURE …" query.



CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel  @SalaryLevel NVARCHAR(10)
AS
BEGIN
    SELECT FirstName, LastName
    FROM Employees
    WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel;
END;

EXEC dbo.usp_EmployeesBySalaryLevel High



--7.	Define Function
--Define a function ufn_IsWordComprised(@setOfLetters, @word) that returns true or false, depending on that if the word is comprised of the given set of letters. 


CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50)) 
RETURNS BIT
AS
BEGIN
DECLARE @currentIndex int = 1;

WHILE(@currentIndex <= LEN(@word))
	BEGIN

	DECLARE @currentLetter varchar(1) = SUBSTRING(@word, @currentIndex, 1);

	IF(CHARINDEX(@currentLetter, @setOfLetters)) = 0
	BEGIN
	RETURN 0;
	END

	SET @currentIndex += 1;
	END

RETURN 1;
END


--Second answer

CREATE FUNCTION ufn_IsWordComprised (@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX)) 
RETURNS BIT
AS
BEGIN
	DECLARE @WordLength INT = LEN(@Word)
	DECLARE @Iterator INT = 1

	WHILE(@Iterator <= @WordLength)
		BEGIN
			IF (CHARINDEX(SUBSTRING (@word, @Iterator, 1), @setOfLetters) = 0)
			RETURN 0
			SET @Iterator += 1
		END
	RETURN 1
END



--8. Delete Employees and Departments Create a procedure with the name usp_DeleteEmployeesFromDepartment (@departmentId INT) which deletes all Employees from a given department.
--Delete these departments from the Departments table too. Finally, SELECT the number of employees from the given department. 
--If the delete statements are correct the select query should return 0.
--After completing that exercise restore your database to revert all changes.

CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	DECLARE @DeletedEmployees TABLE(Id INT)
	--Stored data abaout deleted emplyees
	INSERT INTO @DeletedEmployees 
		SELECT EmployeeID
		FROM Employees
		WHERE DepartmentID = @departmentId
	--Make Manager in Departments ID Nulluble
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL
	--SET Manager ID to NULL in Departments
	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN 
		(
			SELECT Id FROM @DeletedEmployees
		)
	--Delete From Employees Project
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN 
		(
			SELECT Id FROM @DeletedEmployees
		)
	--Koituinieshto
	UPDATE Employees
	SET ManagerID = NULL
	WHERE EmployeeID IN
		(
			SELECT Id FROM @DeletedEmployees
		)

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId
	SELECT COUNT (*) FROM @DeletedEmployees
END;

EXEC dbo.usp_DeleteEmployeesFromDepartment 
 
 -- Judje мина с това

 CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS

DECLARE @empIDsToBeDeleted TABLE
(
Id int
)

INSERT INTO @empIDsToBeDeleted
SELECT e.EmployeeID
FROM Employees AS e
WHERE e.DepartmentID = @departmentId

ALTER TABLE Departments
ALTER COLUMN ManagerID int NULL

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (SELECT Id FROM @empIDsToBeDeleted)

UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (SELECT Id FROM @empIDsToBeDeleted)

UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (SELECT Id FROM @empIDsToBeDeleted)

DELETE FROM Employees
WHERE EmployeeID IN (SELECT Id FROM @empIDsToBeDeleted)

DELETE FROM Departments
WHERE DepartmentID = @departmentId 

SELECT COUNT(*) AS [Employees Count] FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE e.DepartmentID = @departmentId

--



--9.	Find Full Name
--You are given a database schema with tables AccountHolders(Id (PK), FirstName, LastName, SSN) and Accounts(Id (PK), AccountHolderId (FK), Balance).  
--Write a stored procedure usp_GetHoldersFullName that selects the full name of all people. 

USE Bank
GO
 

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName
AS
BEGIN
    SELECT CONCAT_WS(' ', FirstName, LastName) AS FullName
    FROM AccountHolders;
END;

EXEC usp_GetHoldersFullName



--10.	People with Balance Higher Than
--Your task is to create a stored procedure usp_GetHoldersWithBalanceHigherThan that accepts a number as a parameter and returns all the people, 
--who have more money in total in all their accounts than the supplied number. Order them by their first name, then by their last name.


 


CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan @BalanceCheck MONEY
AS
BEGIN
    SELECT ah.FirstName, ah.LastName
    FROM AccountHolders AS ah
	JOIN Accounts AS acc ON acc.[AccountHolderId] = ah.Id
	GROUP BY acc.[AccountHolderId], ah.FirstName, ah.LastName
    HAVING SUM(acc.Balance) >= @BalanceCheck
	ORDER BY ah.FirstName, ah.LastName
END;

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 50000



--11.	Future Value Function
--Your task is to create a function ufn_CalculateFutureValue that accepts as parameters – sum (decimal), yearly interest rate (float), and the number of years (int).
--It should calculate and return the future value of the initial sum rounded up to the fourth digit after the decimal delimiter. Use the following formula:


CREATE FUNCTION ufn_CalculateFutureValue (@Sum MONEY, @Rate FLOAT , @Years INT)
RETURNS MONEY AS
BEGIN
 RETURN @Sum * POWER(1+@Rate,@Years)
END

--RETURN @Sum * (POWER((1 + @Rate), @Years))


--12.	Calculating Interest
--Your task is to create a stored procedure usp_CalculateFutureValueForAccount that uses the function from 
--the previous problem to give an interest to a persons account for 5 years, along with information about their account id, 
--first name, last name and current balance as it is shown in the example below. It should take the AccountId and the interest rate as parameters. 
--Again, you are provided with the dbo.ufn_CalculateFutureValue function, which was part of the previous task.

CREATE PROC usp_CalculateFutureValueForAccount (@AccountId INT, @InterestRate FLOAT) AS
SELECT a.Id AS [Account Id],
	   ah.FirstName AS [First Name],
	   ah.LastName AS [Last Name],
	   a.Balance,
	   dbo.ufn_CalculateFutureValue(Balance, @InterestRate, 5) AS [Balance in 5 years]
  FROM AccountHolders AS ah
  JOIN Accounts AS a ON ah.Id = a.Id
 WHERE a.Id = @AccountId



--13.	*Scalar Function: Cash in User Games Odd Rows
--Create a function ufn_CashInUsersGames that sums the cash of the odd rows. Rows must be ordered by cash in descending order. 
--The function should take a game name as a parameter and return the result as a table. Submit only your function in.
--Execute the function over the following game names, ordered exactly like: "Love in a mist".


CREATE FUNCTION ufn_CashInUsersGames(@gameName varchar(max))
RETURNS @returnedTable TABLE
(
SumCash money
)
AS
BEGIN
	DECLARE @result money

	SET @result = 
	(SELECT SUM(ug.Cash) AS Cash
	FROM
		(SELECT Cash, GameId, ROW_NUMBER() OVER (ORDER BY Cash DESC) AS RowNumber
		FROM UsersGames
		WHERE GameId = (SELECT Id FROM Games WHERE Name = @gameName)
		) AS ug
	WHERE ug.RowNumber % 2 != 0
	)

	INSERT INTO @returnedTable SELECT @result
	RETURN
END

