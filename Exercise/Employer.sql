CREATE TABLE Employer
(
Id INT PRIMARY KEY,
FirstName VARCHAR (50),
MiddleName VARCHAR (50),
LastName VARCHAR (50),
Paycheck Money
)

Drop TABLE Employer

INSERT INTO Employer
	(Id, FirstName, MiddleName, LastName, Paycheck)
VALUES(1, 'Mitko', 'Mitkov', 'Mitakov', '1000'),
		(2, 'Ivan', 'Ivanov', 'Ivanchev', '2000'),
		(3, 'Stefan', 'Stefanov', 'Stefanchev', '3000'),
		(4, 'Georgi', 'Georgiev', 'Goshov', '4000'),
		(5, 'Antracit', 'Antracitov', 'Antracitski', '5000')

SELECT * FROM Employer


ALTER TABLE Employer
ADD Town VARCHAR (50)

EXEC sp_rename 'dbo.Employer.Town', 'City', 'COLUMN';


Update Employer
SET City = 'Pernik'
WHERE ID = 5;