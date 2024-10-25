use UNIVER
create table TIMETABLE(
	WEAK_DAY nvarchar(12) check(WEAK_DAY in (N'понедельник', N'вторник', N'среда', N'четверг', N'пятница', N'суббота')),
	SUBJECT_NUMBER int check (SUBJECT_NUMBER > 0 and SUBJECT_NUMBER <= 4),
	GROUPS int constraint GROUP_FK foreign key references GROUPS(IDGROUP),
	AUDITORIUM nvarchar(20) constraint AUDITORIUM_FK foreign key references AUDITORIUM(AUDITORIUM),
	PULPIT nvarchar(20) constraint PULPIT_FK foreign key references PULPIT(PULPIT),
	TEACHER nvarchar(10) constraint TEACHER_FK foreign key references TEACHER(TEACHER),
	SUBJECT nvarchar(10) constraint SUBJECT_FK foreign key references SUBJECT(SUBJECT)
);
insert into TIMETABLE(WEAK_DAY, SUBJECT_NUMBER, GROUPS, AUDITORIUM, PULPIT, TEACHER, SUBJECT)
values (N'понедельник', 1, 1, '206-1', N'ХПД', N'РЖК', N'ЭТ'),
	   (N'понедельник', 2, 2, '236-1', N'ИСиТ', N'ЖЛК', N'ИНФ'),
	   (N'понедельник', 1, 3, '236-1', N'ИСиТ', N'ЖЛК', N'ИНФ'),
	   (N'вторник', 3, 2, '313-1', N'ИСиТ', N'РЖК', N'ИНФ')

select * from TIMETABLE;
select AUDITORIUM.AUDITORIUM_NAME
from AUDITORIUM
where not AUDITORIUM.AUDITORIUM_NAME in (
	select AUDITORIUM.AUDITORIUM_NAME 
	from TIMETABLE
		inner join AUDITORIUM on TIMETABLE.[AUDITORIUM] = AUDITORIUM.AUDITORIUM
	where TIMETABLE.WEAK_DAY = N'понедельник' and TIMETABLE.SUBJECT_NUMBER = 1
);

create table #result(
	SUBJECT_NUMBER int check (SUBJECT_NUMBER > 0 and SUBJECT_NUMBER <= 4),
	TEACHER nvarchar(10) constraint TEACHER_FK foreign key references TEACHER(TEACHER)
);

declare @i int = 1;
while @i <= 4
begin

	set @i = @i + 1;
end
drop table #result;

select TIMETABLE.SUBJECT_NUMBER, TIMETABLE.TEACHER
from TIMETABLE
where not TIMETABLE.TEACHER in (
	select TIMETABLE.TEACHER
	from TIMETABLE
		inner join TEACHER on TIMETABLE.[TEACHER] = TEACHER.TEACHER
	where TIMETABLE.WEAK_DAY = N'понедельник' and TIMETABLE.SUBJECT_NUMBER = 1
) and TIMETABLE.WEAK_DAY = N'понедельник'
union
select TIMETABLE.SUBJECT_NUMBER, TIMETABLE.TEACHER
from TIMETABLE
where not TIMETABLE.TEACHER in (
	select TIMETABLE.TEACHER
	from TIMETABLE
		inner join TEACHER on TIMETABLE.[TEACHER] = TEACHER.TEACHER
	where TIMETABLE.WEAK_DAY = N'понедельник' and TIMETABLE.SUBJECT_NUMBER = 2
) and TIMETABLE.WEAK_DAY = N'понедельник';

select TIMETABLE.SUBJECT_NUMBER, TIMETABLE.TEACHER
from TIMETABLE
	inner join TEACHER on TIMETABLE.[TEACHER] = TEACHER.TEACHER
where TIMETABLE.WEAK_DAY = N'понедельник'
go