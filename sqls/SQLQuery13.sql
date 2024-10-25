use UNIVER1;
go 
CREATE PROCEDURE PSUBJECT
AS 
BEGIN
declare @k int =  (select count(*) from SUBJECT);
select * from SUBJECT;
RETURN @k;
end;

declare @d int = 0;
EXEC @d = PSUBJECT;
print '���-�� ������� =' +cast(@d as varchar(5)) 

---Task 2
GO
alter procedure PSUBJECT @p varchar(20), @c int output
as begin
declare @k int = (select count(*) from SUBJECT);
print '���������: @p= ' + @p + ', @c= ' + cast(@c as varchar(3));
select *from SUBJECT where PULPIT = @p;
set @c = @@ROWCOUNT;
return @k;
end;
GO
declare @k int = 0, @r int = 0 ,  @p nvarchar(20) = '';
exec @k = PSUBJECT @p = '�C��',@c = @r output;
print '���-�� ��������� ����� = ' +cast(@k as varchar(20));
print '���-�� ���������  = ' +cast(@p as varchar(3)) + '=' + cast(@r as varchar(30));

---task 3

create table #SUBJECT (
SUBJECT nchar(10),
SUBJECT_NAME nvarchar(100),
PULPIT nchar(20));
GO
ALTER procedure [dbo].[PSUBJECT] @p nvarchar(20)
AS
begin
declare @k int = (select count(*) from  SUBJECT);
select * from SUBJECT where PULPIT = @p;
end;
GO
insert #SUBJECT exec PSUBJECT @p= N''
insert #SUBJECT exec PSUBJECT @p= N''
select * from #SUBJECT

---task 4
USE UNIVER1
GO
CREATE procedure PAUDITORIUM_INSERT 
@a nchar(20),@n nchar(10),@c int = 0,@t nvarchar(50)
as declare @forr int = 1;
begin try
insert into AUDITORIUM(AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
values(@a,@n,@n,@t)
return @forr;
end try
begin catch
print '����� ������ :' + cast(error_number() as varchar(6));
print '��������� :' + error_message();
print '������� :' + cast(error_severity() as varchar(6));
print '����� :' + cast(error_state() as varchar(8));
print '����� ������ :' + cast(error_line() as varchar(8));
if error_procedure() is not null
print '��� ���������: ' + error_procedure();
return -1;
end catch;


EXEC PAUDITORIUM_INSERT @a= '113-4', @n = N'��', @c = 20, @t = '113-4';
EXEC PAUDITORIUM_INSERT @a= '207-2a', @n = N'��', @c = 3, @t = '207-2';
EXEC PAUDITORIUM_INSERT @a= '229-4', @n = N'��', @c = 30, @t = '229-4';
---TASK 5
go
 ALTER procedure SUBJECT_REPORT @p nchar(20)
 as 
 declare @rc int = 0;
 begin try
 declare @tv nchar(20),@t nchar(300) = '';
 declare SUBREP cursor for
select SUBJECT from SUBJECT where PULPIT = @p;
IF not exists (select SUBJECT from SUBJECT  where PULPIT = @p)
raiserror('������',11,1);
else
open SUBREP;
FETCH SUBREP into @tv;
print 'gdfgd: ';
while @@FETCH_STATUS = 0
begin 
set @t = RTRIM(@tv) + ', ' + @t;
set @rc = @rc + 1;
fetch SUBREP into @tv;
end;
print @t;
close SUBREP;
deallocate SUBREP;
return @rc;
end try 
begin catch
print '������ � ���������� ' + @p
if ERROR_PROCEDURE() is not null
print '��� ���������: ' + error_procedure();
return @rc;
end catch;
GO
declare @rc int;
exec @rc = SUBJECT_REPORT @p = '�C��'
print '���������� = ' + cast(@rc as varchar(3));
GO
---TASK 6
go
create procedure PAUDITORIUM_INSERTX @a nchar(20),@n char(10),@c int = 0,@t nvarchar(50),@tn nvarchar(50)
as 
declare @rc int = 1;
begin try 
set transaction isolation level SERIALIZABLE
begin tran 
insert into
AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
VALUES(@n,@tn)
exec @rc = PAUDITORIUM_INSERT @a,@n,@c,@t;
commit tran;
return @rc;
end try
begin catch 
print '����� ������ :' + cast(error_number() as varchar(6));
print '��������� :' + error_message();
print '������� :' + cast(error_severity() as varchar(6));
print '����� :' + cast(error_state() as varchar(8));
print '����� ������ :' + cast(error_line() as varchar(8));
if ERROR_PROCEDURE() is not null 
print '��� ���������: ' + error_procedure();
if @@TRANCOUNT > 0 ROLLBACK;
RETURN -1;
END CATCH;
go
declare @rc int ;
exec @rc = PAUDITORIUM_INSERTX @a = '104-4', @n = N'��', @c = 30, @t = '104-4', @tn = N'��������';
print '��� ������' + CAST(@rc as varchar(3));
select *from AUDITORIUM;