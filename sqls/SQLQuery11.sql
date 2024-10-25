use  UNIVER1;
select *from SUBJECT;
SELECT SUBJECT FROM SUBJECT 
WHERE SUBJECT.PULPIT LIKE 'ИСиТ'
deallocate snames
declare @tv char(20),@t char(300)='';
declare SNAMES CURSOR FOR SELECT SUBJECT FROM SUBJECT 
WHERE SUBJECT.PULPIT LIKE 'ИСиТ';
OPEN SNAMES;
FETCH SNAMES INTO @tv;
print 'fdfdfd';
while @@FETCH_STATUS = 0
BEGIN 
SET @t = rtrim(@tv)+','+ @t;
FETCH SNAMES INTO @tv;
end;
print @t;
OPEN SNAMES;
close SNAMES;


---2
declare @sb char(20),@mrk real;
	open Marks;
	fetch Marks into @sb,@mrk;
	print '1' + rtrim(@sb) + ':' + cast(@mrk as varchar(6));
	go
declare @sb char(20),@mrk real;
	fetch Marks into @sb,@mrk;
	print '2' + rtrim(@sb) + ':' + cast(@mrk as varchar(6));
	go

Declare Marks cursor global
			for  select PROGRESS.SUBJECT, PROGRESS.NOTE
										from PROGRESS
declare @sb char(20),@mrk real;
	open Marks;
	fetch Marks into @sb,@mrk;
	print '1' + rtrim(@sb) + ':' + cast(@mrk as varchar(6));
	go
declare @sb char(20),@mrk real;
	fetch Marks into @sb,@mrk;
	print '2' + rtrim(@sb) + ':' + cast(@mrk as varchar(6));
	go
---3
declare @ids int, @gr int, @name nchar(50), @bday date;
declare STDENTS_A1999 CURSOR LOCAL DYNAMIC --DYNAMIC
for select IDSTUDENT, IDGROUP, NAME, BDAY
FROM STUDENT
WHERE BDAY > CAST('1999-01-01' AS date);
open STDENTS_A1999
fetch STDENTS_A1999 INTO @ids, @gr, @name, @bday;
PRINT  N'Кол-во строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 
update STUDENT set BDAY = cast('1999-09-09' as date) where IDSTUDENT = 1018;
--DELETE STUDENT where STUDENT.NAME = N'Äâîðÿíèíêè Ìàêñèì Àíàòîëüåâè÷';
--INSERT STUDENT(IDGROUP, NAME, BDAY) VALUES (29, N'Äâîðÿíèíêè Ìàêñèì Àíàòîëüåâè÷', cast('1999-09-09' as date));
while @@FETCH_STATUS = 0
begin
print cast(@ids as varchar(5)) + ' ' + cast(@gr as varchar(5)) + ' ' + @name + ' ' + cast(@bday as varchar(15)) + '.';
fetch STDENTS_A1999 INTO @ids, @gr, @name, @bday;
end;
close STDENTS_A1999;

---4
DECLARE @tc int = 0, @fk nchar(10), @fk_full nchar(55);
declare PRIMER1 cursor local dynamic scroll
for 
select ROW_NUMBER() over (order by FACULTY) N,
FACULTY.FACULTY, FACULTY.FACULTY_NAME
FROM FACULTY;
OPEN PRIMER1;
FETCH first from PRIMER1 into @tc, @fk, @fk_full;
print N'след строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH last from PRIMER1 into @tc, @fk, @fk_full;
print N'послед строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH ABSOLUTE 3 from PRIMER1 into @tc, @fk, @fk_full;
print N'след строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH next from PRIMER1 into @tc, @fk, @fk_full;
print N'след строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH prior from PRIMER1 into @tc, @fk, @fk_full;
print N'след строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH absolute -2 from PRIMER1 into @tc, @fk, @fk_full;
print N' : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH relative -1 from PRIMER1 into @tc, @fk, @fk_full;
print N'Relative -1 : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);

---5
declare @one int, @two nchar(10), @thr date, @fur int, @stid int = 1012;

declare PRIMER2 CURSOR LOCAL DYNAMIC for
select PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, PROGRESS.PDATE, PROGRESS.NOTE
from PROGRESS 
inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP 
where PROGRESS.NOTE < 4
for update;

declare PRIMER3 CURSOR LOCAL DYNAMIC for 
select * from PROGRESS
where IDSTUDENT = @stid;

open PRIMER2;
fetch PRIMER2 into @one, @two, @thr, @fur;

while @@FETCH_STATUS = 0
begin
    delete PROGRESS where current of PRIMER2;
    fetch PRIMER2 into @one, @two, @thr, @fur;
end

close PRIMER2;

open PRIMER3;
fetch PRIMER3 into @one, @two, @thr, @fur;

while @@FETCH_STATUS = 0
begin
    update PROGRESS set NOTE = NOTE + 1 where current of PRIMER3;
    fetch PRIMER3 into @one, @two, @thr, @fur;
end

close PRIMER3;
