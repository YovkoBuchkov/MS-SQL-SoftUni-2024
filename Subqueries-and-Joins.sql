--1.	Employee Address
--Create a query that selects:
--•	EmployeeId
--•	JobTitle
--•	AddressId
--•	AddressText
--Return the first 5 rows sorted by AddressId in ascending order.


Use SoftUni
Go


SELECT TOP 5
e.EmployeeID,
e.JobTitle,
e.AddressID,
a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
ORDER BY AddressID 

--2.	Addresses with Towns
--Write a query that selects:
--•	FirstName
--•	LastName
--•	Town
--•	AddressText
--Sort them by FirstName in ascending order, then by LastName. Select the first 50 employees.

Use SoftUni
Go


SELECT TOP 50
e.FirstName,
e.LastName,
t.[Name] AS Town,
a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON  e.AddressID = a.AddressID
JOIN Towns AS t ON  t.TownID = a.TownID
ORDER BY FirstName, LastName


--3.	Sales Employee
--Create a query that selects:
--•	EmployeeID
--•	FirstName
--•	LastName
--•	DepartmentName


Use SoftUni
Go




SELECT
e.EmployeeID,
e.FirstName,
e.LastName,
d.[Name] AS Departments
FROM Employees AS e 
RIGHT JOIN Departments AS d ON  e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID



--4.	Employee Departments
--Create a query that selects:
--•	EmployeeID
--•	FirstName 
--•	Salary
--•	DepartmentName
--Filter only employees with a salary higher than 15000. Return the first 5 rows, sorted by DepartmentID in ascending order.



Use SoftUni
Go




SELECT TOP 5
e.EmployeeID,
e.FirstName,
e.Salary,
d.[Name] AS DepartmentName
FROM Employees AS e 
RIGHT JOIN Departments AS d ON  e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID


--5.	Employees Without Project
--Create a query that selects:
--•	EmployeeID
--•	FirstName
--Filter only employees without a project. Return the first 3 rows, sorted by EmployeeID in ascending order.




Use SoftUni
Go




SELECT TOP 3
e.EmployeeID, 
e.FirstName 
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY ep.ProjectID

--second

SELECT TOP 3
EmployeeID, 
FirstName 
FROM Employees
WHERE EmployeeID NOT IN
		(SELECT DISTINCT EmployeeID FROM EmployeesProjects)


--3
WITH CTE_EmployeesProject AS (
SELECT 
	e.EmployeeID, 
	e.FirstName 
FROM Employees AS e
EXCEPT
SELECT e.EmployeeID, FirstName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID)

SELECT TOP 3 EmployeeID, FirstName
FROM CTE_EmployeesProject



--6.	Employees Hired After
--Create a query that selects:
--•	FirstName
--•	LastName
--•	HireDate
--•	DeptName
--Filter only employees hired after 1.1.1999 and are from either "Sales" or "Finance" department. Sort them by HireDate (ascending).




Use SoftUni
Go



SELECT 
e.FirstName,
e.LastName,
e.HireDate,
d.Name AS DeptName
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1999-01-01' AND d.Name IN  ('Sales', 'Finance')
ORDER BY HireDate


--Create a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). 
--Return the first 5 rows sorted by EmployeeID in ascending order.





Use SoftUni
Go



SELECT TOP 5
e.EmployeeID, 
e.FirstName,
p.[Name] AS ProjectName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
LEFT JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS Null
ORDER BY e.EmployeeID



--8.	Employee 24
--Create a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter all the projects of employee with Id 24. If the project has started during or after 2005 the returned value should be NULL.





Use SoftUni
Go



SELECT 
    e.EmployeeID,
    e.FirstName,
    CASE 
        WHEN p.StartDate >= '2005' THEN NULL
        ELSE p.[Name]
    END AS ProjectName
FROM 
    Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
LEFT JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24;


--9.	Employee Manager
--Create a query that selects:
--•	EmployeeID
--•	FirstName
--•	ManagerID
--•	ManagerName
--Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by EmployeeID in ascending order.


Use SoftUni
Go



SELECT 
    e.EmployeeID,
    e.FirstName,
	e.ManagerID,
	m.FirstName AS ManagrName
FROM 
    Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN (3, 7);


--10.	Employees Summary
--Create a query that selects:
--•	EmployeeID
--•	EmployeeName
--•	ManagerName
--•	DepartmentName
--Show the first 50 employees with their managers and the departments they are in (show the departments of the employees). Order them by EmployeeID.



Use SoftUni
Go



SELECT TOP 50
    e.EmployeeID,
    CONCAT_WS (' ', e.FirstName, e.LastName) AS EmployeeName,
	CONCAT_WS (' ', m.FirstName, m.LastName) AS ManagrName,
	d.[Name] AS DepartmentName
	
FROM 
    Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID;



--11.	Min Average Salary
--Create a query that returns the value of the lowest average salary of all departments.




Use SoftUni
Go


SELECT TOP 1
AVG (Salary) AS MinAvgSalary

FROM Employees
GROUP BY DepartmentID 
ORDER BY MinAvgSalary


--Second 
SELECT TOP 1
dt.AvgSalary AS MinAvgSalary
FROM
(
SELECT
AVG (Salary) AS AvgSalary

FROM Employees
GROUP BY DepartmentID) AS dt
ORDER BY AvgSalary



--12.	Highest Peaks in Bulgaria
--Create a query that selects:
--•	CountryCode
--•	MountainRange
--•	PeakName
--•	Elevation
--Filter all the peaks in Bulgaria, which have elevation over 2835. Return all the rows, sorted by elevation in descending order.




Use Geography
Go





SELECT 
	mc.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
FROM Mountains AS m
	JOIN Peaks AS p ON m.Id = p.MountainId
	JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
WHERE mc.CountryCode = 'BG' AND
	p.Elevation > 2835
ORDER BY p.Elevation DESC;


--13.	Count Mountain Ranges
--Create a query that selects:
--•	CountryCode
--•	MountainRanges
--Filter the count of the mountain ranges in the United States, Russia and Bulgaria.





Use Geography
Go





SELECT 
	mc.CountryCode,
	COUNT (m.MountainRange)
FROM Mountains AS m
	JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
WHERE mc.CountryCode IN ('US', 'BG', 'RU') 
GROUP BY mc.CountryCode


--14.	Countries With or Without Rivers
--Create a query that selects:
--•	CountryName
--•	RiverName
--Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.





Use Geography
Go





SELECT TOP 5
	c.CountryName,
	r.RiverName
FROM CountriesRivers AS cr
FULL JOIN Countries AS c ON c.CountryCode = cr.CountryCode
FULL JOIN Rivers AS r ON r.Id = cr.RiverId
WHERE  c.ContinentCode = 'AF'
ORDER BY c.CountryName


--15.	*Continents and Currencies
--Create a query that selects:
--•	ContinentCode
--•	CurrencyCode
--•	CurrencyUsage
--Find all continents and their most used currency. Filter any currency, which is used in only one country. Sort your results by ContinentCode.



Use Geography
Go


SELECT [ContinentCode]
	  ,[CurrencyCode]
	  ,[CurrencyUsage]
FROM 
	(
			SELECT *,
				DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY CurrencyUsage DESC)
			AS [CurrencyRank]
			FROM
		 (
		     SELECT 
		    	 [ContinentCode],
		    	 [CurrencyCode],
		    	 COUNT(*) AS CurrencyUsage
		    FROM Countries
		    GROUP BY [ContinentCode], [CurrencyCode]
		    HAVING COUNT(*) > 1
		)
			AS [CurrencyUsageSubquery]
	)
	AS [CurrencyRankingSubquery]
	WHERE [CurrencyRank] = 1



--16.	Countries Without Any Mountains
--Create a query that returns the count of all countries, which don’t have a mountain.


SELECT 
	COUNT (c.CountryName) AS Count
FROM Countries AS c
FULL JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
FULL JOIN Mountains AS m ON m.Id = mc.MountainId
WHERE m.MountainRange IS NULL



--2
SELECT COUNT (*)
FROM Countries
WHERE CountryCode NOT IN
	(SELECT DISTINCT CountryCode FROM MountainsCountries)


--17.	Highest Peak and Longest River by Country
--For each country, find the elevation of the highest peak and the length of the longest river, 
--sorted by the highest peak elevation (from highest to lowest), 
--then by the longest river length (from longest to smallest), 
--then by country name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5 rows.



SELECT TOP 5
	c.CountryName,
	MAX(p.Elevation) AS HighestPeakElevation,
	MAX (r.Length) AS LongestRiverLength
FROM Countries AS c
	LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p ON p.MountainId = m.Id
WHERE p.Elevation IS NOT NULL AND r.[Length] IS NOT NULL
GROUP BY c.CountryName 
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC;


--18.	Highest Peak Name and Elevation by Country
--For each country, find the name and elevation of the highest peak, along with its mountain. 
--When no peaks are available in some countries, display elevation 0, "(no highest peak)" as peak name and "(no mountain)" as a mountain name.
--When multiple peaks in some countries have the same elevation, display all of them. Sort the results by country name alphabetically, 
--then by highest peak name alphabetically. Limit only the first 5 rows.



WITH PeaksRankedByElevation AS
(
SELECT 
	c.CountryName,
	p.PeakName,
	p.Elevation,
	m.MountainRange,
		DENSE_RANK() OVER
			(PARTITION BY c.CountryName ORDER BY Elevation DESC) AS PeakRank
FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
	LEFT JOIN Peaks AS p ON p.MountainId = m.Id
)
SELECT TOP 5
	CountryName As Country,
	ISNULL(PeakName, '(no highest peak)') AS 'Highest Peak Name',
	ISNULL(Elevation, 0) AS 'Highest Peak Elevation',
	ISNULL([MountainRange], '(no mountain)') AS '[Mountain]'
	
FROM PeaksRankedByElevation
WHERE PeakRank = 1 
ORDER BY CountryName, Elevation










