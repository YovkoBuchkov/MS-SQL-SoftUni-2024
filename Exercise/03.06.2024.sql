CREATE FUNCTION udf_GetSalaryLevel(@Salary MONEY)
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
dbo.udf_GetSalaryLevel (Salary) AS SalaryLevel
FROM Employees



--Сторнати процедури

CREATE OR ALTER PROC dbo.usp_SelectEmploeesBySeniotity 
AS
	SELECT *, 
	 DATEDIFF(Year, HireDate, GETDATE()) AS Years
	FROM Employees
	WHERE DATEDIFF(Year, HireDate, GETDATE()) > 20
GO


EXEC usp_SelectEmploeesBySeniotity

exec sp_depends 'usp_SelectEmploeesBySeniotity'


exec sp_depends 'Addresses'

--

CREATE OR ALTER PROC dbo.usp_MultyResuktProc
AS
BEGIN
	SELECT FirstName, LastName, Salary FROM Employees
	SELECT FirstName, LastName, Salary, d.[Name] FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
END
GO


EXEC usp_MultyResuktProc

--


