CREATE DATABASE Movies 
GO

USE Movies 
GO

--Paste in Judge after this raw

CREATE TABLE Directors 
(
Id INT PRIMARY KEY IDENTITY, 
DirectorName VARCHAR (60) , 
Notes VARCHAR (MAX)
)

INSERT INTO Directors (DirectorName, Notes)
VALUES ('Stiven Spilberg', 'text'),
		('Martin Scorsese', 'text'),
		('Alfred Hitchcock', 'text'),
		('Stenley Kubrick', 'text'),
		('Tim Burton', 'text')


CREATE TABLE Genres 
(
Id INT PRIMARY KEY IDENTITY, 
GenreName VARCHAR (30), 
Notes VARCHAR(MAX)
)

INSERT INTO Genres (GenreName)
VALUES ('Action'),
		('Drama'),
		('Sifi'),
		('Mistery'),
		('Fantasy')


CREATE TABLE Categories 
(
Id INT PRIMARY KEY IDENTITY, 
CategoryName VARCHAR (120), 
Notes VARCHAR (MAX)
)

INSERT INTO Categories (CategoryName)
VALUES ('Experimental film‎'),
		('Documentary film‎‎'),
		('Magic realism‎‎'),
		('Abstract animation‎‎'),
		('Fantasy film‎')

CREATE TABLE Movies 
(
Id INT PRIMARY KEY IDENTITY, 
Title VARCHAR (255), 
DirectorId INT FOREIGN KEY REFERENCES Directors(Id), 
CopyrightYear CHAR (4), 
[Length] numeric (3,2), 
GenreId INT FOREIGN KEY REFERENCES Genres(Id), 
CategoryId INT FOREIGN KEY REFERENCES Categories(Id), 
Rating numeric (1), 
	CHECK(Rating in('1', '2', '3', '4', '5')),
Notes VARCHAR (255)
)

INSERT INTO Movies (Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating)
VALUES ('Untuchable', 1, 2003, 2.20, 1, 1, 1),
		('La la Lend', 2, 2020, 2.30, 2, 2, 3),
		('Matrix', 3, 2003, 3.10, 3, 3, 5),
		('KungFu Panda', 4, 2024, 2.15, 4, 4, 5),
		('Mad Max', 5, 2015, 2.41, 5, 5, 2)

--For Judge copy to this raw


--Check things 
TRUNCATE TABLE Movies
DROP TABLE Movies

SELECT * FROM Directors
SELECT * FROM Genres
SELECT * FROM Categories
SELECT * FROM Movies


SELECT Movies.Title, Directors.DirectorName, Movies.CopyrightYear, Genres.GenreName, [Length]
FROM Movies
JOIN Directors on Movies.DirectorId = Directors.Id
JOIN Genres on Movies.GenreId = Genres.Id