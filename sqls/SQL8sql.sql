USE UNIVER1;
SELECT *FROM SUBJECT;
SELECT *FROM AUDITORIUM;
SELECT *FROM AUDITORIUM_TYPE;
SELECT *FROM PROGRESS;
SELECT *FROM PULPIT;
SELECT *FROM FACULTY;
SELECT *FROM GROUPS;
SELECT *FROM PROFESSION;
SELECT *FROM STUDENT;
SELECT *FROM TEACHER;
SELECT *FROM TIMETABLE;
--1
CREATE VIEW [�������������] 
AS SELECT TEACHER.TEACHER [���],
TEACHER.TEACHER_NAME [���],
TEACHER.GENDER[���],
TEACHER.PULPIT[��� �������] FROM
TEACHER
 
 SELECT *FROM [�������������]
  
--2
CREATE VIEW [���������� ������]
as select FACULTY.FACULTY_NAME [���������],(SELECT COUNT(*) FROM PULPIT WHERE FACULTY.FACULTY=PULPIT.FACULTY) [���������� ������]
FROM  FACULTY
ALTER VIEW  [���������� ������]
as select 
FACULTY.FACULTY_NAME[���������],count(PULPIT.PULPIT_NAME)[���������� ������]
from FACULTY JOIN PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
GROUP BY FACULTY.FACULTY_NAME

SELECT *FROM [���������� ������]

--3

CREATE VIEW [���������] (������������_���������,���) 
as select  AUDITORIUM_TYPE[������������_���������],
AUDITORIUM.AUDITORIUM[���]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE = '��';
GO 
SELECT *FROM [���������]
INSERT [���������] VALUES ('��',208)


--4
CREATE VIEW [����������]
as select top 5
SUBJECT[���],
SUBJECT_NAME[������������_����������],
PULPIT[���_�������]
FROM 
SUBJECT
ORDER BY  [���];
go
select *from [����������]

--5


Alter view [���������� ������] With Schemabinding
		as select F.FACULTY_NAME [���������], count(P.PULPIT_NAME) [���������� ������]
		from FACULTY
		join PULPIT on P.FACULTY = F.FACULTY 
		group by F.FACULTY_NAME;
select * from [���������� ������];
sp_help[���������� ������];