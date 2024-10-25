USE UNIVER1;
select *from AUDITORIUM; 
select *from PROGRESS;
select *from STUDENT;
--1
DECLARE 
@dt  datetime,
@a char = 'Hello',
@c varchar(5) = 'Helloyyyyy',
@d time ,
@l int = 12,
@x smallint = 23,
@j tinyint = 255,
@s numeric(12,5) =12345.123; 
set @dt = GETDATE();
select @d =	CAST('07:07:07' as   time)
select  @dt dt,@c c,@a a ,@d d,@l l,@x x,@j j,@s s ;
print 'c = ' + cast(@c as varchar(10));

--2
declare @x1 int = (select sum(AUDITORIUM_CAPACITY) from dbo.AUDITORIUM), 
@x2 float, @x3 int, @x4 int, @X5 int
if @x1 > 200
begin 
select @x2 = (select cast(avg(AUDITORIUM_CAPACITY) as float) from AUDITORIUM),
@x3 = (select count(*) from AUDITORIUM)
set @x4 = (select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY > @x2)
set @x5 = (@x4 * 100) / @x3
select @x1 'Суммарная вместимость', @x2 'Средняя вместимость', @x3 'Кол-во аудиторий', @x4 'Аудитории вмест < средней', @X5 'Процент таких аудиторий'
end
else 
print N'Общая вместимость   : ' + cast(@x1 as varchar(10));

--3
print '@@ROWCOUNT :' + CAST(@@ROWCOUNT AS VARCHAR(10));
print '@@VERSION :' + CAST(@@VERSION AS VARCHAR(56));
print '@@SPID :' + CAST(@@SPID AS VARCHAR(10));
print '@@ERROR :' + CAST(@@ERROR AS VARCHAR(56));
print '@@SERVERNAME :' + CAST(@@SERVERNAME AS VARCHAR(10));
print '@@TRANCOUNT :' + CAST(@@TRANCOUNT AS VARCHAR(56));
print '@@FETCH_STATUS :' + CAST(@@FETCH_STATUS AS VARCHAR(10));
print '@@NESTLELVEL :' + CAST(@@VERSION AS VARCHAR(56));

--4
go
DECLARE @z float,@t int = 2,@x int = 3;
if (@t>@x)
set @z = sin(@t)*sin(@t)
else if 
(@t<@x)
set @z = 4*(@t+@x)
else 
set @z=1-exp(@x-2)
print 'z = ' + cast(@z as varchar(10));

--5
DECLARE @name NVARCHAR(50) ='Селех Дмитрий Сергеевич',
@name2 nvarchar(20),
@len int,
@pr int
set @len = len(@name)
set @pr = patindex('% %',@name)
print @pr
set @name2 = left(@name,@pr+1)+'.'
print @name2
set @name = right(@name,(@len-@pr-1))
print @name
set @pr = patindex('% %',@name)
set @len = len(@name)
set @name = right(@name,@len-@pr)
print @name
set @name2 = @name2 + left(@name,1) + '.'
print @name2;


declare
@a1 int = year(getdate()),
@a2 int = month(getdate())+1;
select STUDENT.NAME,BDAY,@a1-year(BDAY) as 'Возраст'
from 
STUDENT
WHERE MONTH(BDAY)=@a2

declare 
@dd int = 31;
SELECT distinct
CASE DATEPART(WEEKDAY,PDATE)
    WHEN 1 THEN N'Воскресенье' 
    WHEN 2 THEN N'Понедельник' 
    WHEN 3 THEN N'Вторник' 
    WHEN 4 THEN N'Среда' 
    WHEN 5 THEN N'Четверг' 
    WHEN 6 THEN N'Пятница' 
    WHEN 7 THEN N'Суббота' 
END as N'День недели', PROGRESS.SUBJECT, PROGRESS.PDATE
from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where IDGROUP = @dd;

--5
GO
DECLARE @ff int, @dd int,@cc int

SELECT
@cc = cast(avg (NOTE ) AS INT  ), @ff = CAST(SUM(NOTE) AS INT), @dd = COUNT(*) FROM PROGRESS;
IF @ff > 20
BEGIN
    PRINT 'Сумма отметок больше 20 ' + CAST(@ff as varchar(10));

    PRINT 'Количество отметок' + CAST(@dd as varchar(10));
END;
else
begin
PRINT 'Среднее значение' + CAST(@cc as varchar(10));
end;
go
--6

SELECT CASE 
WHEN NOTE BETWEEN 1 AND 2 THEN 'PLOHO'
WHEN NOTE BETWEEN 2 AND 4 THEN 'KLASSNO'
WHEN NOTE BETWEEN 3 AND 5 THEN 'SUPER'
WHEN NOTE BETWEEN 5 AND 6 THEN 'MOLODEC'
WHEN NOTE BETWEEN 7 AND 8 THEN 'GENIUS'
ELSE 
'AVTOMAT'
END AS MARK_CATEGORY,
COUNT (*) AS STUDENT_COUNT
FROM PROGRESS 
INNER JOIN 
STUDENT ON STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
GROUP BY CASE
WHEN NOTE BETWEEN 1 AND 2 THEN 'PLOHO'
WHEN NOTE BETWEEN 2 AND 4 THEN 'KLASSNO'
WHEN NOTE BETWEEN 3 AND 5 THEN 'SUPER'
WHEN NOTE BETWEEN 5 AND 6 THEN 'MOLODEC'
WHEN NOTE BETWEEN 7 AND 8 THEN 'GENIUS'
ELSE 
'AVTOMAT'
END

--7
--DROP TABLE #TIMETAB;
select *from #TIMETAB;
CREATE TABLE #TIMETAB(
    ID INT,
    NAME NVARCHAR(100), -- Указываем размер NVARCHAR (например, 100 символов)
    STROKA NVARCHAR(100) -- Указываем размер NVARCHAR (например, 100 символов)
);

SET NOCOUNT ON;

DECLARE @i INT = 0;

WHILE @i < 10
BEGIN
    INSERT INTO #TIMETAB(ID, NAME, STROKA)
    VALUES(ABS(CHECKSUM(NEWID())) % 20, REPLICATE('данные', 10), REPLICATE(' тоже данные', 10));

    SET @i = @i + 1;
END;

--8
DECLARE @X INT = 1
PRINT @X + 1
PRINT @X + 2
RETURN
PRINT @X + 3

--9
begin try
update AUDITORIUM SET AUDITORIUM_CAPACITY='12'
WHERE AUDITORIUM_CAPACITY='15'
END TRY
BEGIN CATCH
PRINT ERROR_NUMBER()
PRINT ERROR_MESSAGE()
PRINT ERROR_LINE()
PRINT ERROR_PROCEDURE()
PRINT ERROR_SEVERITY()
PRINT ERROR_STATE()
END CATCH
 SELECT *FROM AUDITORIUM;