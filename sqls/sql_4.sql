use UNIVER
/*
select AUDITORIUM.AUDITORIUM_NAME, 
	   AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.[AUDITORIUM_TYPE] = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME from AUDITORIUM inner join AUDITORIUM_TYPE on AUDITORIUM.[AUDITORIUM_TYPE] = AUDITORIUM_TYPE.AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';
*/

/*
select FACULTY.FACULTY_NAME, 
	   PULPIT.PULPIT_NAME, 
	   PROFESSION.QUALIFICATION, 
	   SUBJECT.SUBJECT_NAME, 
	   STUDENT.NAME, 
case
	when (PROGRESS.NOTE between 6 and 6) then N'�����'
	when (PROGRESS.NOTE between 7 and 7) then N'����'
	when (PROGRESS.NOTE between 8 and 8) then N'������'
	else '������ �� ������������ ������'
end [NOTE]
from PROGRESS 
	inner join STUDENT on PROGRESS.[IDSTUDENT] = STUDENT.IDSTUDENT 
	inner join SUBJECT on PROGRESS.[SUBJECT] = SUBJECT.SUBJECT 
	inner join PULPIT  on SUBJECT.[PULPIT] = PULPIT.PULPIT
	inner join FACULTY on PULPIT.[FACULTY] = FACULTY.FACULTY
	inner join PROFESSION on FACULTY.[FACULTY] = PROFESSION.FACULTY
where PROGRESS.NOTE >= 6 and PROGRESS.NOTE <= 8
order by PROGRESS.NOTE desc;
*/

/*
select PULPIT.PULPIT_NAME, isnull(TEACHER.TEACHER_NAME, '***')[TEACHER_NAME] from PULPIT right outer join TEACHER on PULPIT.[PULPIT] = TEACHER.PULPIT;
*/

/*
select PULPIT.PULPIT_NAME, isnull(TEACHER.TEACHER_NAME, '***')[TEACHER_NAME] from PULPIT full outer join TEACHER on PULPIT.[PULPIT] = TEACHER.PULPIT;
*/

/*
select AUDITORIUM.AUDITORIUM_NAME, 
	   AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
from AUDITORIUM 
	cross join AUDITORIUM_TYPE 
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
*/
go