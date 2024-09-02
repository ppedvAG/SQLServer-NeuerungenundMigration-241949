Use master

Drop database if exists temporalTables

Create database TemporalTables
GO

Use TemporalTables
GO



Create table contacts  
( 
Cid int identity primary key, 
Lastname varchar(50), 
Firstname varchar(50), 
Birthday date, 
Phone varchar(50), 
email varchar(50), 
StartDatum datetime2 Generated always as row start not null, 
EndDatum datetime2 Generated always as row end not null, 
Period for system_time (StartDatum, EndDatum) 
) 
with (system_Versioning = ON (History_table=dbo.Contactshistory)) 
GO


--Aktivieren bei bestehenden Tabellen
CREATE TABLE Demo2 
( 
SP1 int identity primary key, 
SP2 int, 
StartFrom datetime2 not null, EndTo datetime2 not null
); 

--Aktivierung der PERIOD 

ALTER TABLE demo2 
ADD PERIOD FOR SYSTEM_TIME(StartFrom,EndTo) 

--Aktivierung des SYSTEM_VERSIONING 

ALTER TABLE demo2
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.demohistory, 
	DATA_CONSISTENCY_CHECK = ON)) 
	--prüft ob Überlappung, abe rnicht manipuliert unbedingt


--falls Datumsspalten für Versionierung nich  nicht vorhanden sind
CREATE TABLE Demo3 
( 
SP1 int identity primary key, SP2 int 
) 
 

ALTER TABLE demo3 
ADD PERIOD FOR SYSTEM_TIME (StartFrom, EndTo), 
StartFrom datetime2 GENERATED ALWAYS AS ROW START NOT NULL DEFAULT GETUTCDATE(), 
EndTo datetime2 GENERATED ALWAYS AS ROW END NOT NULL DEFAULT CONVERT(DATETIME2,'9999.12.31'); 
     

ALTER TABLE demo3 
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.demo3history, DATA_CONSISTENCY_CHECK = ON)) 


Alter Table contacts 
set (system_versioning=off)

drop table contacts

 
ALTER TABLE dbo.demo2
SET
(SYSTEM_VERSIONING = ON (HISTORY_RETENTION_PERIOD = 9 DAYS));




--falls Datumsspalten für Versionierung noch  nicht aber Daten vorhanden sind
CREATE TABLE Demo4
( 
SP1 int identity primary key, SP2 int 
) 

insert into demo4 select 10
insert into demo4 select 20 

select * from demo4

ALTER TABLE demo4 
ADD PERIOD FOR SYSTEM_TIME (StartFrom, EndTo), 
StartFrom datetime2 GENERATED ALWAYS AS ROW START NOT NULL DEFAULT SYSUTCDATETIME(), 
EndTo datetime2 GENERATED ALWAYS AS ROW END NOT NULL DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.99999999'); 



ALTER TABLE demo4
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.demo4history, DATA_CONSISTENCY_CHECK = ON))