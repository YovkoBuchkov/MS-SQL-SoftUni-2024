CREATE DATABASE RailwaysDb 
GO
USE RailwaysDb 
GO

--Create a database called RailwaysDb. You need to create 7 tables:
--•	Passengers – contains information about the names of the passengers;
--•	Towns – contains information about the names of the towns;
--•	RailwayStations – holds data about railway stations, such as their names and associated town IDs, indicating the towns where these stations are located.;
--•	Trains – details about trains, including departure and arrival times and their corresponding town IDs;
--•	TrainsRailwayStations - Manages the many-to-many relationship between trains and railway stations, indicating which trains stop at which stations;
--•	MaintenanceRecords – records maintenance activities for trains, including dates and detailed descriptions of maintenance work;
--•	Tickets – contains information about tickets, including price, departure and arrival date, and associated train and passenger IDs;
--NOTE: Keep in mind that Judge doesn't accept "ALTER" statement and square brackets naming (when the names are not keywords).


CREATE TABLE Passengers
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
[Name] VARCHAR (80) NOT NULL
);

CREATE TABLE Towns
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
[Name] NVARCHAR(30) NOT NULL
);

CREATE TABLE RailwayStations
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
[Name] VARCHAR(50) NOT NULL,
TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
);

CREATE TABLE Trains
(
Id INT PRIMARY KEY IDENTITY,
HourOfDeparture VARCHAR(5) NOT NULL,
HourOfArrival VARCHAR(5) NOT NULL, 
DepartureTownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL,
ArrivalTownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL,
);


CREATE TABLE TrainsRailwayStations
(
TrainId INT  NOT NULL,
RailwayStationId INT NOT NULL,
PRIMARY KEY (TrainId, RailwayStationId),
FOREIGN KEY (TrainId) REFERENCES Trains(Id),
FOREIGN KEY (RailwayStationId) REFERENCES RailwayStations(Id),

);


CREATE TABLE MaintenanceRecords
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
DateOfMaintenance DATETIME2 NOT NULL,
Details VARCHAR(2000) NOT NULL, 
TrainId INT FOREIGN KEY REFERENCES Trains(Id) NOT NULL
);


CREATE TABLE Tickets
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
Price DECIMAL (18,2) NOT NULL,
DateOfDeparture DATETIME2 NOT NULL, 
DateOfArrival DATETIME2 NOT NULL, 
TrainId INT FOREIGN KEY REFERENCES Trains(Id) NOT NULL,
PassengerId INT FOREIGN KEY REFERENCES Passengers(Id) NOT NULL
);

--2.	Insert
--Let's insert some sample data into the database. Write a query to add the following records into the corresponding tables. All IDs (Primary Keys) should be auto-generated.



INSERT INTO Trains (HourOfDeparture, HourOfArrival, DepartureTownId, ArrivalTownId)
VALUES ('07:00', '19:00', 1, 3),
		('08:30', '20:30', 5, 6),
		('09:00', '21:00', 4, 8),
		('06:45', '03:55', 27, 7),
		('10:15', '12:15', 15, 5) 


INSERT INTO TrainsRailwayStations (TrainId, RailwayStationId)
VALUES (36,1),
		(36,4),
		(36,31),
		(36,57),
		(36,7),
		(37,13),
		(37,54),
		(37,60),
		(37,16),
		(38,10),
		(38,50),
		(38,52),
		(38,22),
		(39,68),
		(39,3),
		(39,31),
		(39,19),
		(40,41),
		(40,7),
		(40,52),
		(40,13)

INSERT INTO  Tickets (Price, DateOfDeparture, DateOfArrival, TrainId, PassengerId)
VALUES	(90.00, '2023-12-01', '2023-12-01', 36, 1),
		(115.00, '2023-08-02', '2023-08-02', 37, 2),
		(160.00, '2023-08-03', '2023-08-03', 38, 3),
		(255.00, '2023-09-01', '2023-09-02', 39, 21),
		(95.00, '2023-09-02', '2023-09-03', 40, 22)


--3.	Update
--Due to technical reasons, every ticket with a DateOfDeparture after October 31st will be postponed with one week.  That means that both DateOfDeparture and DateOfArrival should be changed for 7 days later.



UPDATE Tickets SET
		DateOfDeparture = DATEADD(DAY, 7, DateOfDeparture),
		DateOfArrival = DATEADD(DAY, 7, DateOfArrival)
WHERE DATEPART(MONTH,  DateOfDeparture) > 10
--test
SELECT *
FROM Tickets
WHERE DATEPART(MONTH, DateOfDeparture) > 10

SELECT *
FROM Tickets
WHERE DateOfDeparture > '2023-10-31'
--/test

--4.	Delete
--In table Trains, delete the train, that departures from Berlin. Keep in mind that there could be foreign key constraint conflicts.


BEGIN TRANSACTION

DELETE
FROM TrainsRailwayStations
WHERE TrainId = 7; 

DELETE
FROM MaintenanceRecords
WHERE TrainId = 7; 

DELETE
FROM Tickets
WHERE TrainId = 7; 

DELETE
FROM Trains 
WHERE DepartureTownId IN
(SELECT Id FROM Towns WHERE [Name] = 'Berlin');

ROLLBACK


	--Section 3. 
--5.	Tickets by Price and Date of Departure
--Select all tickets, ordered by price  (ascending), then by departure date (descending).
--Required columns:
--•	DateOfDeparture
--•	TicketPrice



SELECT FORMAT (DateOfDeparture, 'yyyy-MM-dd' ), Price
FROM Tickets
ORDER BY Price, DateOfDeparture DESC

--for judje work this
SELECT DateOfDeparture, Price AS TicketPrice
FROM Tickets
ORDER BY Price, DateOfDeparture DESC
--/for

--6.	Passengers with their Tickets
--Select all the tickets purchased, along with the names of the passengers who purchased them.  For the tickets you will need information for the price, date of departure, related train’s id. The report should be organized in a way that lists the tickets starting from the highest price to the lowest. In case of identical ticket prices, further order the entries alphabetically by the passenger's name.
--Required columns:
--•	PassengerName
--•	TicketPrice
--•	DateOfDeparture
--•	TrainID


SELECT p.[Name], t.Price AS TicketPrice, DateOfDeparture, TrainId
FROM Passengers As p
JOIN Tickets AS t ON t.PassengerId = p.Id
ORDER BY Price DESC, p.[Name]


--7.	Railway Stations without Passing Trains
--Select all railway stations that do not have any trains scheduled to stop or pass through them. Each station must be associated with the town it is located in. The town's name should be included in your result set to understand the geographical distribution of these inactive stations. The results should be ordered by the name of the town in ascending order, then by the name of the railway station in ascending order.
--Required columns:
--•	Town
--•	RailwayStation


SELECT t.[Name] AS Town, rs.[Name] AS RailwayStation
FROM RailwayStations AS rs
JOIN Towns AS t ON t.Id = rs.TownId
WHERE NOT EXISTS (SELECT 1 FROM TrainsRailwayStations WHERE RailwayStationId = rs.Id)
ORDER BY t.[Name], rs.[Name];


--second

SELECT t.[Name] AS Town, rs.[Name] AS RailwayStation
FROM RailwayStations AS rs
LEFT JOIN TrainsRailwayStations AS trs ON rs.Id = trs.RailwayStationId
INNER JOIN Towns AS t ON rs.TownId = t.Id
WHERE trs.TrainId IS NULL
ORDER BY t.[Name], rs.[Name];

--3 answer



SELECT t.[Name] AS Town, rs.[Name] AS RailwayStation
FROM RailwayStations AS rs
JOIN Towns AS t ON t.Id = rs.TownId
WHERE rs.Id NOT IN
	(SELECT RailwayStationId FROM TrainsRailwayStations)
ORDER BY t.[Name], rs.[Name];





--8.	First 3 Trains Between 8:00 and 8:59
--Select the top 3 trains departing between 8:00 and 08:59 with ticket prices above €50.00 in the RailwaysDb. Your query should join trains with arrival town names, 
--ordering the results by ticket price in ascending order. The output should include TrainId, HourOfDeparture, TicketPrice, and Destination. 
--Keep in mind that you cannot compare VARCHAR data, so you will have to approach differently. 
--Required columns:
--•	TrainId
--•	HourOfDeparture
--•	TicketPrice
--•	Destination
 


SELECT TOP 3 
	ti.TrainId, tr.HourOfDeparture, ti.Price AS TicketPrice, tw.[Name]
FROM Trains AS tr
JOIN Tickets AS ti ON ti.TrainId = tr.Id
JOIN Towns AS tw ON tw.Id = tr.ArrivalTownId
WHERE tr.HourOfDeparture LIKE '08:%' AND ti.Price > 50
ORDER BY Price 

--Second answare
SELECT TOP 3 
	ti.TrainId, tr.HourOfDeparture, ti.Price AS TicketPrice, tw.[Name]
FROM Trains AS tr
JOIN Tickets AS ti ON ti.TrainId = tr.Id
JOIN Towns AS tw ON tw.Id = tr.ArrivalTownId
WHERE CAST (tr.HourOfDeparture AS TIME ) BETWEEN '08:00' AND '08:59' AND ti.Price > 50
ORDER BY Price 

--9.	Count of Passengers Paid More Than Average With Arrival Towns
--The average price of all tickets is €76.99. Select all passengers who have paid more than the average price of all tickets. 
--Your query should generate a table grouped by the name of arrival town, showing the count of passengers arriving in each town. Order the results by town name.
--Required columns:
--•	TownName
--•	PassengersCount

SELECT tw.[Name] AS TownName,
	COUNT (p.Id) AS PassengersCounts
FROM Passengers AS p
JOIN Tickets AS tk ON tk.PassengerId = p.Id
JOIN Trains AS tr ON tr.Id = tk.TrainId
JOIN Towns AS tw ON tw.Id = tr.ArrivalTownId
WHERE tk.Price > 76.99
GROUP BY tw.[Name]
ORDER BY tw.[Name]



--10.	Maintenance Inspection with Town
--Your task is to generate a table report for train maintenance related to inspections. This report should include the train ID, the name of the town where the train departs from and the maintenance record details, that include the word "inspection". Order the records by train ID.
--Required columns:
--•	TrainID
--•	DepartureTown
--•	Details

SELECT tr.Id AS TrainID, t.[Name] AS DepartureTown,  m.Details AS Details
FROM Trains AS tr
JOIN Towns AS t ON tr.DepartureTownId = t.Id
JOIN MaintenanceRecords AS m ON m.TrainId = tr.Id
WHERE m.Details LIKE '%inspection%'
ORDER BY tr.Id


--11.	Towns with Trains
--Create a user-defined function, named udf_TownsWithTrains(@name) that receives a town’s name.
--The function should return the total number of trains that departures or arrives at that town.

CREATE FUNCTION udf_TownsWithTrains(@name VARCHAR(30))
RETURNS INT
AS
BEGIN
	 DECLARE @result INT;
		
		SELECT @result = 
		COUNT (tr.Id)
		FROM Trains AS tr
		JOIN Towns AS ta ON tr.ArrivalTownId = ta.Id
		JOIN Towns AS td ON tr.DepartureTownId = td.Id
		WHERE ta.[Name] = @name OR td.[Name] = @Name

	 RETURN @result;

END;


--test

SELECT dbo.udf_TownsWithTrains('Paris')

--/test


--12.	Search Passenger Travelling to Specific Town
--Create a stored procedure, named usp_SearchByTown(@townName) that receives a town name. The procedure must print full information about all passengers that are travelling to the town with the given townName. Order them by DateOfDeparture (descending) and PassengerName (ascending).
--Required columns:
--•	PassengerName
--•	DateOfDeparture
--•	HourOfDeparture


CREATE PROCEDURE usp_SearchByTown(@townName VARCHAR(30))
AS
BEGIN
	SELECT 
		p.[Name] AS PassengerName,
		tk.DateOfDeparture AS DateOfDeparture, 
		tr.HourOfDeparture AS HourOfDeparture
	FROM Passengers AS p
		JOIN Tickets AS tk ON tk.PassengerId = p.Id
		JOIN Trains AS tr ON tr.Id = tk.TrainId
		JOIN Towns AS t ON t.Id = tr.ArrivalTownId
	WHERE t.[Name] = @townName
	ORDER BY DateOfDeparture DESC, p.[Name] 

END;



--test

EXEC usp_SearchByTown 'Berlin'