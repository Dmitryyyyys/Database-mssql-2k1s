use Leon_MyBase
select * from ��������;
select * from ��������;
select * from ������;

update �������� set ��� = '�' where �����_����������� < 2;
update �������� set ��� = isnull(���, '�');

select ��������.��������,
	   ��������.���������,
	   ������.����_��������,
	   ��������.�������,
	   ��������.���,
	   ��������.��������,
case
	when (��������.��� between '�' and '�') then '�������'
	when (��������.��� between '�' and '�') then '�������'
	else '-'
end [���]
from �������� 
inner join ������ on ��������.[��������] = ������.��������_��������
inner join �������� on ������.[��������] = ��������.�����_�����������
where ��������.�������� like '%�����%';
go