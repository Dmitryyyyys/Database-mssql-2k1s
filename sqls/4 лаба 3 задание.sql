select *from SUBJECT;
select *from PROFESSION;
select *from PROGRESS;
select *from PULPIT;
select *from GROUPS;
select *from STUDENT;
select *from FACULTY;

SELECT PROGRESS.NOTE,STUDENT.IDSTUDENT,
Case 
when (PROGRESS.NOTE BETWEEN 6 AND 8) THEN 'оценки между 6 и 8'
else 
'больше 8'
end Предел
from PROGRESS INNER JOIN STUDENT
ON PROGRESS.NOTE=STUDENT.IDSTUDENT


