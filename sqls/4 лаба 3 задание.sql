select *from SUBJECT;
select *from PROFESSION;
select *from PROGRESS;
select *from PULPIT;
select *from GROUPS;
select *from STUDENT;
select *from FACULTY;

SELECT PROGRESS.NOTE,STUDENT.IDSTUDENT,
Case 
when (PROGRESS.NOTE BETWEEN 6 AND 8) THEN '������ ����� 6 � 8'
else 
'������ 8'
end ������
from PROGRESS INNER JOIN STUDENT
ON PROGRESS.NOTE=STUDENT.IDSTUDENT


