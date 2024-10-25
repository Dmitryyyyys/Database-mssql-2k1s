select *from STUDENT;
set nocount on
if exists(select *from SYS.objects
where OBJECT_ID=object_id('DBO.Y'))
DROP TABLE Y;
declare @c int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON 
CREATE TABLE Y(Numbers bigint);
insert Y values (8792742937),(21313532),(740237409);
set @c = (select COUNT(*)from Y);
print 'кол-во стро в таблице X: ' + cast(@c as varchar(2)); 
if @flag = 'c' commit;
else rollback;
SET IMPLICIT_TRANSACTIONS OFF
IF EXISTS(SELECT *FROM SYS.objects
where OBJECT_ID=object_id('DBO.Y'))
PRINT 'Table here';
else print 'Table doesnt exists';
select *from Y
---Task 8
begin tran 
delete STUDENT where name = ''
insert STUDENT (IDGROUP, NAME, BDAY) values(12,'Баринов Виктор Сергеевич', '2004-03-28');
begin tran 
update PROGRESS set IDSTUDENT  =999 WHERE IDSTUDENT = 2107;
commit  
if @@TRANCOUNT > 0 
rollback;
select
	(select count(*) from progress where IDSTUDENT = 999) 'E. of 999',
	(select count(*) from STUDENT WHERE NAME = 'Баринов Виктор Сергеевич')  'Student';
select * from PROGRESS
select * from student 
--Task2
BEGIN TRY
    BEGIN TRAN

    DECLARE @id int = 2083;
    DELETE FROM STUDENT WHERE IDSTUDENT = @id;
    PRINT 'Student' + CAST(@id as varchar(10));

    INSERT INTO STUDENT (IDSTUDENT, IDGROUP, NAME, BDAY) VALUES (2081, 13, 'Иванов Дмитрий Васильевич', '2222-12-31');
    INSERT INTO STUDENT (IDSTUDENT, IDGROUP, NAME, BDAY) VALUES (2082, 12, 'Петров Геннадий Александрович', '2022-12-31');

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;

    PRINT 'Error: ' + 
        CASE
            WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%PK_STUDENT%', ERROR_MESSAGE()) > 0 THEN 'duplicate student'
            ELSE 'error: ' + CAST(ERROR_NUMBER() AS VARCHAR(5)) + ' ' + ERROR_MESSAGE()
        END;
END CATCH;


select *from STUDENT;

--Task 3
declare @point varchar(32);
begin try
begin tran
insert STUDENT (IDSTUDENT,IDGROUP,NAME,BDAY) VALUES (2086,13,'Геннадий Андреевич Апполонов','2010-12-31');
set @point = 'p1'; save tran @point;
insert STUDENT (IDGROUP, NAME, BDAY) values (12,'Александр Иванович Боровой','2022-12-31');
delete STUDENT where NAME like '%Геннадий%'
set @point='p2'; save tran @point;
commit tran;
end
try begin catch
print 'Error: ' + case 
when error_number() = 2627 and patindex('%PK_STUDENT%',error_message())>0
			then 'dublicate student'
			else 'error:' + cast(error_number() as varchar(5))+error_message()
		end;
		if @@TRANCOUNT > 0 rollback tran;
		begin 
			print 'point: ' + @point;
			rollback tran  @point;
			commit tran;
		end;
	end catch
	select *from STUDENT;

	--Task 4
	-- A -- 
set transaction isolation level READ UNCOMMITTED
begin transaction 
	----------------t1-------------
	select @@SPID, 'insert PROGRESS' 'result',* from PROGRESS where IDSTUDENT = 1007 ;
	select @@SPID, 'update PROGRESS' 'result',IDSTUDENT,NOTE from PROGRESS where IDSTUDENT = 1005 and NOTE = 5;
	commit;
	-----------t2-----------------
--B--
begin transaction 
	select @@SPID
	insert PROGRESS values('СУБД', 1007,'2022-11-19',8);
	update PROGRESS set NOTE = 5 where IDSTUDENT = 1005
	--------t1---------
	--------t2---------
	rollback;
select *  from progress

---Task 5
set transaction isolation level READ COMMITTED
begin transaction
select COUNT(*) from PROGRESS where SUBJECT = N'СУБД';
----------------t1---------
----------------t2---------
select N'update PROGRESS'N'Результат', count(*)
from PROGRESS where SUBJECT = N'СУБД';
commit;

----B----
begin transaction
---------t1-------
update PROGRESS set SUBJECT = N'СУБД'
where SUBJECT = N'КГ'
commit;

---Task 6
  ------A------
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

DECLARE @studentId INT;

SELECT @studentId = IDSTUDENT 
FROM PROGRESS WITH (UPDLOCK) -- Используем UPDLOCK для блокировки чтения
WHERE SUBJECT = N'ОИБ';

IF @studentId = 1000
BEGIN
    INSERT INTO PROGRESS VALUES (N'insert КГ', 1000, CAST('2016-01-29' AS DATE), 6);
END

COMMIT TRANSACTION;
select *from progress;
---Task 7
set transaction isolation level SERIALIZABLE
begin transaction
delete PROGRESS where IDSTUDENT = 1000;
INSERT PROGRESS values('СУБД', 1000, CAST('2016-06-12' AS DATE), 7);
update PROGRESS set IDSTUDENT = 1000 WHERE SUBJECT = N'СУБД';
select IDSTUDENT from PROGRESS WHERE SUBJECT = N'СУБД';
------------t1-------
select IDSTUDENT from PROGRESS WHERE SUBJECT = N'СУБД';
commit;

-----B----
begin transaction
delete PROGRESS where IDSTUDENT = 1000;
INSERT PROGRESS values(N'СУБД', 1000, CAST('2016-06-12' AS DATE), 7);
update PROGRESS set IDSTUDENT = 1000 WHERE SUBJECT = N'СУБД';
select IDSTUDENT from PROGRESS WHERE SUBJECT = N'СУБД';
commit;
select IDSTUDENT from PROGRESS WHERE SUBJECT = N'СУБД';
SELECT *FROM PROGRESS;