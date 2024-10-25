use master
go 
create database UNIVER	
on primary
( name = N'UNIVER_mdf',filename = N'C:\datebase2\UNIVER_mdf.mdf',
size=10240Kb,maxsize = unlimited,filegrowth = 1024Kb),
( name = N'UNIVER_ndf',filename = N'C:\datebase2\UNIVER_ndf.ndf',
size=10240Kb,maxsize = unlimited,filegrowth = 1024Kb),

filegroup FG1
(
name = N'UNIVER_fg1_1',filename = N'C:\datebase2\UNIVER_fgq-1.ndf',
size=10240Kb,maxsize = 1Gb,filegrowth = 25%
),
(
name = N'UNIVER_fg1_2',filename = N'C:\datebase2\UNIVER_fgq-2.ndf',
size=10240Kb,maxsize = 1Gb,filegrowth = 25%
)
log on 
(
name = N'UNIVER_log',filename = N'C:\datebase2\UNIVER_log.ldf',
size=10240Kb,maxsize = 2048Gb,filegrowth = 10%
)
go	