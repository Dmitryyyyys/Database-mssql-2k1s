SELECT *FROM ������
 ALTER Table ������ ADD ����_����������� date;
 ALTER Table ������ ADD ���_���������� nvarchar(20);
 ALTER Table ������ ADD PRO nchar(3) default '�' check(PRO in('�','�')) ;
 ALTER Table ������  DROP Column ����_�����������;