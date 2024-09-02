use TemporalTables
GO

insert into Contacts 
(Lastname,Firstname,Birthday, Phone, email) 
select 'Kent', 'Clark','3.4.2010', '089-3303003', 'clarkk@krypton.universe' 

insert into Contacts 
(Lastname,Firstname,Birthday, Phone, email) 
select 'Wayne', 'Bruce','3.4.2012', '08677-3303003', 'brucew@gotham.city' 

--Und nun die Änderungen, die zu einer Versionierung der Datensätze führt 
WAITFOR DELAY '00:00:02'
update contacts set email = 'wer@earth.de' where cid = 1 
update contacts set Phone = 'w3434' where cid = 1 
update contacts set Lastname = 'Wayne' where cid = 1 

WAITFOR DELAY '00:00:02'

select getdate() as Zeit into #Zeit

WAITFOR DELAY '00:00:02'


update contacts set email = 'asas@earth.de' where cid = 1 
update contacts set Phone = 'w34sasaa34' where cid = 2 
update contacts set Lastname = 'Smith' where cid = 1 

--Result
select * from contacts 

select * from contactshistory


select * , 
		(Select  
			convert(varchar(50),min(Startdatum)) 
			+ '<-->' + 
			convert(varchar(50), Max(Enddatum)) 
		from ContactsHistory )
	from ContactsHistory


--2020-04-14 18:50:43.1110912<-->2020-04-14 18:57:53.3801501

--nach Version suchen

select * from contactshistory 
where 
    Startdatum >= '2023-08-31 08:05:22.6761329'  
    and 
    Enddatum <= '2023-08-31 08:05:28.4933421'

--Noch besser.. DS für einen Zeitpunkt
select * from contacts 
    FOR SYSTEM_TIME AS OF'2024-06-19 08:01:50'


select cid from contacts
INTERSECT
select cid from contactshistory


select * from contacts 
    FOR SYSTEM_TIME ALL('2023-08-31 08:05:21'	 ,'2023-08-31 08:05:29')

--inerhalb eines Zeitraum geöffnet und geschlossenen Datensatz
select * from contacts 
    FOR SYSTEM_TIME CONTAINED IN ('2023-08-31 08:05:21'	 ,'2023-08-31 08:05:29')

 select * from contacts 
    FOR SYSTEM_TIME ALL 
	where cid = 2
	order by CID


select * from contactshistory
except
select cid from contacts 


alter table contacts add SPX int








    where cid =1 

--Neue Spalten
Alter Table contacts
	add spx int


update contacts set Firstname= 'Chris', spx=2 where cid = 1

	--nope
delete from Contactshistory where StartDatum <= '2016-08-05 12:45:43.2711351'


