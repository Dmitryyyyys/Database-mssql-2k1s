select *from AUDITORIUM;
select *from AUDITORIUM_TYPE;
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPE
FROM AUDITORIUM Inner Join  AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM  = AUDITORIUM.AUDITORIUM_TYPE 

