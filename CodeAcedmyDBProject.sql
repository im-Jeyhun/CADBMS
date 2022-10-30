CREATE DATABASE CODEACEDEMY

USE CODEACEDEMY

CREATE TABLE EducationType (
Type nvarchar(30) PRIMARY KEY,
)

INSERT INTO EducationType VALUES(
'Ferdi')

SELECT * FROM EducationType

CREATE TABLE EducationCategory (
Id INT IDENTITY PRIMARY KEY,
EducationType nvarchar(30) FOREIGN KEY REFERENCES EducationType(Type),
Name nvarchar(30)NOT NULL UNIQUE,
Description nvarchar(100)
)

INSERT INTO EducationCategory VALUES('Korporativ','Design',NULL)
SELECT * FROM EducationCategory

CREATE TABLE Sylabbus (
Id INT IDENTITY PRIMARY KEY,
Content nvarchar(50)
)

INSERT INTO Sylabbus VALUES ('Front-End with ReactJS')

CREATE TABLE Lessons (
Id INT IDENTITY PRIMARY KEY,
Name nvarchar(50),
Desctiption nvarchar(50)
)

INSERT INTO Lessons VALUES ('Front End' , 'HTML , Basic REACTJS')

CREATE TABLE SylabbusLessons (
Id INT IDENTITY PRIMARY KEY,
SylabbusId INT FOREIGN KEY REFERENCES Sylabbus,
LessonsId INT FOREIGN KEY REFERENCES Lessons
)

INSERT INTO SylabbusLessons VALUES(
1,2)

SELECT * FROM SylabbusLessons


CREATE TABLE EducationProgram (
Id INT IDENTITY PRIMARY KEY,
EducationCategoryId INT FOREIGN KEY REFERENCES EducationCategory(Id),
Name nvarchar(30)NOT NULL UNIQUE,
Description nvarchar(100),
IsEducationFormOnline bit,
BasicConditions nvarchar(100)NULL,
EducationPurpose nvarchar(100)NULL,
SylabbusLessonsId INT FOREIGN KEY REFERENCES SylabbusLessons(Id),
)
INSERT INTO EducationProgram VALUES(1,'Front End Development',NULL,'False' , NULL , NULL ,3)



SELECT * FROM EducationProgram
JOIN EducationCategory ON EducationCategory.Id =EducationProgram.EducationCategoryId 
JOIN SylabbusLessons ON SylabbusLessons.Id = EducationProgram.SylabbusLessonsId 
JOIN  Sylabbus ON Sylabbus.Id = SylabbusLessons.SylabbusId
JOIN  Lessons ON Lessons.Id = SylabbusLessons.LessonsId

SELECT * FROM SylabbusLessons
JOIN Sylabbus ON Sylabbus.Id = SylabbusLessons.SylabbusId 
JOIN Lessons ON Lessons.Id = SylabbusLessons.LessonsId


CREATE TABLE GroupStatus (

Status nvarchar(30)PRIMARY KEY
)

INSERT INTO GroupStatus VALUES ('Aktiv')
SELECT * FROM GroupStatus

CREATE TABLE Groups (
Id INT IDENTITY PRIMARY KEY,
GroupName nvarchar(30) NOT NULL UNIQUE,
GruupStus nvarchar(30) FOREIGN KEY REFERENCES GroupStatus(Status),
StartDate DATE,
ProbableDate DATE,
FinishDate DATE,
EducationProgramId INT FOREIGN KEY REFERENCES EducationProgram(Id)
)

INSERT INTO Groups VALUES ('P325','Aktiv','2020-10-06',NULL,'2022-12-01',1)
SELECT * FROM Groups
JOIN EducationProgram ON Groups.EducationProgramId = EducationProgram.Id

CREATE TABLE ForeignEducation(
Name nvarchar(50) PRIMARY KEY
)

INSERT INTO ForeignEducation VALUES ('Master')
SELECT * FROM ForeignEducation

CREATE TABLE Nominated (
Id INT IDENTITY PRIMARY KEY,
Name nvarchar(30) NOT NULL,
Surnname nvarchar(30) NOT NULL,
FatherName nvarchar(30),
Information nvarchar(100),
ForeignEducationName nvarchar(50) FOREIGN KEY REFERENCES ForeignEducation(Name),
Email NVARCHAR(50) UNIQUE
)
INSERT INTO Nominated VALUES ('Yahyha','Camalzade',NULL,NULL,'Adi','yahyha@code.edu.az')
SELECT * FROM Nominated

CREATE TABLE Students (
Id INT IDENTITY PRIMARY KEY,
NominatedId INT FOREIGN KEY REFERENCES Nominated(Id),
BirthDate DATE,
FinCode NVARCHAR(50) UNIQUE,
SeriaNo NVARCHAR(50) UNIQUE,
GroupId INT FOREIGN KEY REFERENCES Groups(Id),
JoinDate DATE
)
INSERT INTO Students VALUES (1 , NULL,'7HHWWXR','AZE1585452',1,'2021-05-23')
SELECT * FROM Students
JOIN Nominated ON Students.NominatedId = Nominated.Id

CREATE TABLE Mentors (
Id INT IDENTITY PRIMARY KEY,
StudentId INT FOREIGN KEY REFERENCES Students(Id),
Salary decimal(18,2),
TelNumber NVARCHAR(50) UNIQUE,
Adress NVARCHAR(100),
)

INSERT INTO Mentors VALUES (1,120,'+994-55-910-69-00','E.Ezizov Kuc')
SELECT * FROM Mentors
JOIN Students ON Mentors.StudentId = Students.Id
JOIN Nominated ON Nominated.Id = Students.NominatedId


CREATE TABLE GroupsMentors (
MentorId INT FOREIGN KEY REFERENCES Mentors(Id),
GroupId INT FOREIGN KEY REFERENCES Groups(Id),
PRIMARY KEY (MentorId,GroupId)
)
INSERT INTO GroupsMentors VALUES (1,1)
SELECT * FROM GroupsMentors
JOIN Groups ON Groups.Id = GroupsMentors.GroupId
JOIN Mentors ON Mentors.Id = GroupsMentors.MentorId