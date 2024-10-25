SELECT *FROM Товары
 ALTER Table Товары ADD Дата_поступления date;
 ALTER Table Товары ADD Имя_поставщика nvarchar(20);
 ALTER Table Товары ADD PRO nchar(3) default 'п' check(PRO in('п','н')) ;
 ALTER Table Товары  DROP Column Дата_поступления;