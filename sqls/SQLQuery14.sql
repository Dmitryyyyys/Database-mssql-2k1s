USE UNIVER1;
select * from FACULTY;
select * from GROUPS;
select * from STUDENT;
-- Функция для подсчета студентов по факультету
CREATE FUNCTION COUNT_STUDENTS_BY_FACULTY(@faculty varchar(20))
RETURNS int 
AS 
BEGIN
    DECLARE @rc int = 0;
    SET @rc = (
        SELECT COUNT(S.IDSTUDENT) 
        FROM STUDENT S 
        JOIN GROUPS G ON S.IDGROUP = G.IDGROUP
        JOIN FACULTY F ON G.FACULTY = F.FACULTY
        WHERE F.FACULTY = @faculty
    );
    RETURN @rc;
END

-- Функция для подсчета студентов по профессии
CREATE FUNCTION COUNT_STUDENTS_BY_PROFESSION(@prof varchar(20))
RETURNS int 
AS 
BEGIN
    DECLARE @rc int = 0;
    SET @rc = (
        SELECT COUNT(S.IDSTUDENT) 
        FROM STUDENT S 
        JOIN GROUPS G ON S.IDGROUP = G.IDGROUP
        WHERE G.PROFESSION = @prof
    );
    RETURN @rc;
END

-- Пример использования функций
DECLARE @f_students int = dbo.COUNT_STUDENTS_BY_FACULTY('ИЭФ');
PRINT 'Количество студентов на факультете = ' + CAST(@f_students as varchar(20));

DECLARE @prof_students int = dbo.COUNT_STUDENTS_BY_PROFESSION('1-36 01 08');
PRINT 'Количество студентов по профессии = ' + CAST(@prof_students as varchar(20));

-- Получение количества студентов для каждого факультета
SELECT F.FACULTY, dbo.COUNT_STUDENTS_BY_FACULTY(F.FACULTY) 
FROM FACULTY F;

---TASK 2
drop function FSUBJECTS
create function FSUBJECTS (@p VARCHAR(20))
returns VARCHAR(300)
as begin 
declare @s char(20);
declare @a varchar(300) = 'Дисциплины: ';
declare CSUBJECTS cursor local
for select S.SUBJECT FROM SUBJECT S where S.PULPIT = @p;
open CSUBJECTS;
FETCH CSUBJECTS INTO @s
while @@FETCH_STATUS = 0
begin set @a = @a+RTRIM(@s)+',';
fetch CSUBJECTS INTO @s;
end;
return @a;
end;
select P.PULPIT,dbo.FSUBJECTS(PULPIT) FROM PULPIT P 
---Task 3
CREATE FUNCTION FFACPUL(@ff varchar(20), @pp varchar(20))
RETURNS TABLE
AS
RETURN (
    SELECT F.FACULTY, P.PULPIT 
    FROM FACULTY F
    -- Присоедините таблицу PULPIT, если необходимо
    -- JOIN PULPIT P ON ...
    WHERE (@ff IS NULL OR F.FACULTY = @ff)
      AND (@pp IS NULL OR P.PULPIT = @pp)
);
USE UNIVER1;
select * from dbo.FFACPUL(NULL,NULL);
select * from dbo.FFACPUL('ИЭФ',NULL);
select * from dbo.FFACPUL(NULL,'ИТ');
select * from dbo.FFACPUL('ИЭФ','ИЭФ');

---Task 4
drop function FCTEACHER;
create function FCTEACHER(@p varchar(20)) returns int 
as begin 
declare @rc int = (select count(*) from TEACHER T
WHERE PULPIT = ISNULL(@p,PULPIT));
return @rc;
end;
select PULPIT,dbo.FCTEACHER(PULPIT) [Количество] from PULPIT 
select dbo.FCTEACHER(NULL) [Всего]

---Task 5
create function C_PULPITS(@f varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(PULPIT) from PULPIT where PULPIT.FACULTY = @f);
return @rc; 
end;
CREATE FUNCTION C_GROUPS(@f varchar (20)) returns int 
as begin declare @rc int = 0;
set @rc = (select count(GROUPS.FACULTY) from GROUPS where GROUPS.FACULTY = @f);
return @rc;
end;
CREATE FUNCTION C_PROF(@f varchar (20)) returns int 
as begin declare @rc int = 0;
set @rc = (select count(PROFESSION) from PROFESSION where FACULTY = @f);
return @rc;
end;
drop function FACULTY_REPORT;
create function FACULTY_REPORT(@c int)
returns @fr table
([Факультет] varchar(50),[Количество кафедр] int,[Количество групп] int,
[Количество студентов] int ,[Количество специальностей] int)
as begin 
declare cc CURSOR static for
select FACULTY from FACULTY
WHERE dbo.COUNT_STUDENTS_BY_FACULTY(FACULTY,default)>@c;
declare @f varchar(30);
open cc;
fetch cc into @f;
while @@FETCH_STATUS = 0 
begin 
insert @fr values(@f,dbo.C_PULPITS(@f),dbo.C_GROUPS(@f),
dbo.COUNT_STUDENTS_BY_FACULTY(@f,default),
dbo.C_PROF(@f));
fetch cc into @f;
end;
return;
end;
select *from FACULTY_REPORT(15)




