USE UNIVER1;
SELECT *from AUDITORIUM;
SELECT *from AUDITORIUM_TYPE;
SELECT *from FACULTY;
SELECT *from PULPIT;
SELECT *from GROUPS;
SELECT *from STUDENT;
SELECT *from PROFESSION;
SELECT *from PROGRESS;
SELECT *from SUBJECT;
SELECT *from TEACHER;
SELECT *from TIMETABLE;

CREATE VIEW [TEACHER1] 
AS SELECT
TEACHER AS CODETEACHER,
TEACHER_NAME AS  NAMEOFTEACHER,
GENDER AS GENDEROFTEACHER,
PULPIT  AS PULPITTEACHER
from TEACHER;
select *from TEACHER1;



SELECT *FROM NUMPULPIT;
ALTER VIEW [NUMPULPIT] 
AS SELECT
COUNT(PULPIT) AS PULPIT
from PULPIT ;

ALTER VIEW [NUMPULPIT] 
AS SELECT
FACULTY.FACULTY
FROM FACULTY;