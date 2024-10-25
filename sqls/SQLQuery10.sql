use  UNIVER1;
---1
EXEC SP_HELPINDEX 'AUDITORIUM';
EXEC SP_HELPINDEX 'AUDITORIUM_TYPE';
CREATE TABLE #EXPLRE
(
TIND INT,
TFIELD VARCHAR(100)
);
set nocount on;
DECLARE @i int = 0;
WHILE @i<1000
begin
insert #EXPLRE(TIND,TFIELD)
VALUES (FLOOR(3000*RAND()),REPLICATE('ÑÒÐÎÊÀ',10));
IF (@i % 100 = 0)
print @i;
SET @i = @i+1;
end;
select *from #EXPLRE;

SELECT * FROM #EXPLRE where TIND between 1500 and 2500 order by TIND;

checkpoint;
DBCC DROPCLEANBUFFERS;
CREATE CLUSTERED INDEX #EXPLRE_CL ON #EXPLRE(TIND ASC)

---2
go
CREATE table #EX
(
TKEY INT,
CC INT IDENTITY(1,1),
TF VARCHAR(100)
);
set nocount on;
declare @i int = 0; 
while @i <  10000
begin 
INSERT #EX(TKEY,TF) VALUES(FLOOR(30000*RAND()),REPLICATE('ÑÒÐÎÊÀ',10));
set @i = @i + 1;
end;
SELECT count(*)[êîëè÷åñòâî ñòðîê] from #EX;
  SELECT * from #EX
  CREATE index #EX_NONCLU ON #EX(TKEY,CC)
    SELECT * from  #EX where  TKEY > 1500 and  CC < 4500;  
    SELECT * from  #EX order by  TKEY, CC

	SELECT * from  #EX where  TKEY = 556 and  CC > 3

--3
go
CREATE table #EX2
(
TKEY INT,
CC INT IDENTITY(1,1),
TF VARCHAR(100)
);
set nocount on;
declare @i int = 0; 
while @i <  10000
begin 
INSERT #EX(TKEY,TF) VALUES(FLOOR(30000*RAND()),REPLICATE('ÑÒÐÎÊÀ',10));
set @i = @i + 1;
end;

select *from #EX2;
CREATE INDEX EX_TKEY_Y ON #EX2(TKEY) INCLUDE(CC)
SELECT CC from #EX2 where TKEY>15000 
---4
go
CREATE table #EX3
(
TKEY INT,
CC INT IDENTITY(1,1),
TF VARCHAR(100)
);
set nocount on;
declare @i int = 0; 
while @i <  10000
begin 
INSERT #EX(TKEY,TF) VALUES(FLOOR(30000*RAND()),REPLICATE('ÑÒÐÎÊÀ',10));
set @i = @i + 1;
end;

select TKEY from #EX3 WHERE TKEY BETWEEN 5000 AND 19999;
select TKEY from #EX3 WHERE TKEY>5000 AND TKEY<10000;
SELECT TKEY FROM #EX3 WHERE TKEY = 8000

CREATE index #EX_WHERE ON #EX3(TKEY)  WHERE (TKEY>=5000 AND TKEY < 8000);
CREATE INDEX EX_TKEY ON #EX3(TKEY) INCLUDE(CC)
go
DROP INDEX #EX3_TF ON #EX3;

---5
USE tempdb;
CREATE INDEX #EX3_TF ON #EX3(TF);
INSERT top(10000) #EX3(TKEY,TF) select TKEY ,TF FROM #EX3; 
SELECT name [Èíäåêñ],avg_fragmentation_in_percent[Ôðàãìåíòàöèÿ(%)]
from sys.dm_db_index_physical_stats(DB_ID('TEMPDB'),
OBJECT_ID ('#EX'),NULL,NULL,NULL) SS JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id= ii.index_id 
where name is not null;
alter index #EX_TKEY ON #EX3 REORGANIZE;
alter index #EX_TF ON #EX3 REORGANIZE;
alter index #EX_WHERE ON #EX3 REBUILD WITH(ONLINE = OFF)
alter index #EX_NONCLU ON #EX3 REBUILD WITH (ONLINE = OFF)

DROP INDEX #EX_TF ON #EX;
DROP INDEX #EX3_TF ON #EX3;
DROP INDEX #EX_TKEY ON #EX3;


---6
DROP index #EX_TKEY ON #EX
CREATE INDEX #EX_TKEY ON #EX(TKEY) WITH (FILLFACTOR = 100)
INSERT TOP(50) PERCENT INTO #EX(TKEY,TF)
SELECT TKEY,TF FROM #EX
SELECT NAME[Èíäåêñ],avg_fragmentation_in_percent[Ôðàãìåíòàöèÿ(%)]
FROM  sys.dm_db_index_physical_stats(DB_ID('TEMPDB'),
OBJECT_ID('#EX'),NULL,NULL,NULL) SS JOIN sys.indexes ii
on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;