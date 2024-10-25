use UNIVER
select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
from FACULTY, PULPIT
where FACULTY.FACULTY = PULPIT.FACULTY and 
	  FACULTY.FACULTY in (
		select FACULTY 
		from PROFESSION 
		where (PROFESSION.PROFESSION_NAME like '%технология%') or
			  (PROFESSION.PROFESSION_NAME like '%технологии%')
	  );

select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME
from FACULTY inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
where FACULTY.FACULTY in (
		select FACULTY 
		from PROFESSION 
		where (PROFESSION.PROFESSION_NAME like '%технология%') or
			  (PROFESSION.PROFESSION_NAME like '%технологии%')
	  );

select FACULTY.FACULTY_NAME, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from FACULTY
inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
where (PROFESSION.PROFESSION_NAME like '%технология%') or
	  (PROFESSION.PROFESSION_NAME like '%технологии%');

select *
from AUDITORIUM a
where AUDITORIUM_CAPACITY = (
	select top(1) AUDITORIUM_CAPACITY 
	from AUDITORIUM aa 
	where a.AUDITORIUM_TYPE = aa.AUDITORIUM_TYPE 
	order by AUDITORIUM_CAPACITY desc
);

insert into FACULTY (FACULTY, FACULTY_NAME)
values (N'ТЕСТ', N'Test')

select *
from FACULTY
where not exists (
	select *
	from PULPIT
	where PULPIT.FACULTY = FACULTY.FACULTY
);

select top(1)
(select avg(PROGRESS.NOTE) from PROGRESS
	where PROGRESS.SUBJECT = N'ОАиП')[OAaP],
(select avg(PROGRESS.NOTE) from PROGRESS
	where PROGRESS.SUBJECT = N'БД')[DB],
(select avg(PROGRESS.NOTE) from PROGRESS
	where PROGRESS.SUBJECT = N'СУБД')[SYDB]
from PROGRESS;

select *
from PROGRESS
where PROGRESS.NOTE >= all(
	select PROGRESS.NOTE
	from PROGRESS
	where PROGRESS.SUBJECT = N'ОАиП'
);

select *
from STUDENT s
where s.BDAY = any(
	select ss.BDAY
	from STUDENT ss
	where s.BDAY = ss.BDAY and s.NAME != ss.NAME
) order by s.BDAY;
go