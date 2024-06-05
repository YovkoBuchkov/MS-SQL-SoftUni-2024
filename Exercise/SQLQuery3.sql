Create table People
(
Id INT Primary KEY, 
firstName VARCHAR(50),
LastName VARCHAR(50),
)

SELECT * FROM People

INSERT INTO People
(Id, FirstName, LastName)
VALUES(2, 'Ivan', 'Ivanov'),
(3, 'Maria', 'Ivanova'),
(4, 'Radka', 'Petrova')