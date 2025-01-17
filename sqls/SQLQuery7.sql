use UNIVER1
select *from FACULTY;
select *from PROGRESS;
select *from GROUPS;
select *from STUDENT;
select *from PROFESSION;
SELECT *FROM PULPIT;
SELECT *FROM SUBJECT;
SELECT
    FACULTY.FACULTY,
    GROUPS.FACULTY,
    STUDENT.IDSTUDENT,
	
    AVG(PROGRESS.NOTE)AS AVERAGE_GRADE
FROM
    FACULTY
INNER JOIN
    GROUPS ON FACULTY.FACULTY = GROUPS.FACULTY
INNER JOIN
    STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
INNER JOIN
    PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	WHERE FACULTY.FACULTY = '���'

GROUP BY
ROLLUP( FACULTY.FACULTY,
    GROUPS.FACULTY,
    STUDENT.IDSTUDENT)
	
ORDER BY
    AVERAGE_GRADE DESC


2

SELECT
    FACULTY.FACULTY,
    GROUPS.FACULTY,
    STUDENT.IDSTUDENT,
PROGRESS.SUBJECT,	
    AVG(PROGRESS.NOTE)AS AVERAGE_GRADE
FROM
    FACULTY
INNER JOIN
    GROUPS ON FACULTY.FACULTY = GROUPS.FACULTY
INNER JOIN
    STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
INNER JOIN
    PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	WHERE FACULTY.FACULTY = '���'

GROUP BY
CUBE( FACULTY.FACULTY,
    GROUPS.FACULTY,
    STUDENT.IDSTUDENT,
	PROGRESS.SUBJECT)
	
ORDER BY
    AVERAGE_GRADE DESC;
 

--3
SELECT
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT,
AVG(PROGRESS.NOTE) AS AVERAGE_PROGRESS
FROM FACULTY 
INNER JOIN 
PROFESSION ON PROFESSION.FACULTY=FACULTY.FACULTY
INNER JOIN 
PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
full outer join 
SUBJECT ON PULPIT.PULPIT=SUBJECT.PULPIT
FULL OUTER JOIN
PROGRESS ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
WHERE 
FACULTY.FACULTY='���'
GROUP BY 
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT
UNION
SELECT
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT,
AVG(PROGRESS.NOTE) AS AVERAGE_PROGRESS
FROM FACULTY 
INNER JOIN 
PROFESSION ON PROFESSION.FACULTY=FACULTY.FACULTY
INNER JOIN 
PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
full outer join 
SUBJECT ON PULPIT.PULPIT=SUBJECT.PULPIT
FULL OUTER JOIN
PROGRESS ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
WHERE 
FACULTY.FACULTY='����'
GROUP BY 
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT




---\

SELECT
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT,
AVG(PROGRESS.NOTE) AS AVERAGE_PROGRESS
FROM FACULTY 
INNER JOIN 
PROFESSION ON PROFESSION.FACULTY=FACULTY.FACULTY
INNER JOIN 
PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
full outer join 
SUBJECT ON PULPIT.PULPIT=SUBJECT.PULPIT
FULL OUTER JOIN
PROGRESS ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
WHERE 
FACULTY.FACULTY='���'
GROUP BY 
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT
INTERSECT
SELECT
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT,
AVG(PROGRESS.NOTE) AS AVERAGE_PROGRESS
FROM FACULTY 
INNER JOIN 
PROFESSION ON PROFESSION.FACULTY=FACULTY.FACULTY
INNER JOIN 
PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
full outer join 
SUBJECT ON PULPIT.PULPIT=SUBJECT.PULPIT
FULL OUTER JOIN
PROGRESS ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
WHERE 
FACULTY.FACULTY='����'
GROUP BY 
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT


---/

SELECT
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT,
AVG(PROGRESS.NOTE) AS AVERAGE_PROGRESS
FROM FACULTY 
INNER JOIN 
PROFESSION ON PROFESSION.FACULTY=FACULTY.FACULTY
INNER JOIN 
PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
full outer join 
SUBJECT ON PULPIT.PULPIT=SUBJECT.PULPIT
FULL OUTER JOIN
PROGRESS ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
WHERE 
FACULTY.FACULTY='���'
GROUP BY 
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT
EXCEPT
SELECT
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT,
AVG(PROGRESS.NOTE) AS AVERAGE_PROGRESS
FROM FACULTY 
INNER JOIN 
PROFESSION ON PROFESSION.FACULTY=FACULTY.FACULTY
INNER JOIN 
PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
full outer join 
SUBJECT ON PULPIT.PULPIT=SUBJECT.PULPIT
FULL OUTER JOIN
PROGRESS ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
WHERE 
FACULTY.FACULTY='����'
GROUP BY 
FACULTY.FACULTY,
PROFESSION.PROFESSION,
PROGRESS.SUBJECT