USE Leon_MyBase

DECLARE @ConstraintNames nvarchar(200)
SELECT @ConstraintNames = name FROM SYS.DEFAULT_CONSTRAINTS
EXEC('ALTER TABLE �������� DROP CONSTRAINT ' + @ConstraintNames);

SELECT @ConstraintNames = name FROM SYS.CHECK_CONSTRAINTS
EXEC('ALTER TABLE �������� DROP CONSTRAINT ' + @ConstraintNames);

ALTER TABLE �������� DROP COLUMN ���;

DECLARE @i int = 4;
WHILE @i <= 6
BEGIN
	DELETE FROM �������� WHERE �����_����������� = @i;
	SET @i = @i + 1;
END
GO