Columnstore

--exterm hohe KOmpression
--Sehr n�tzlich bei Archivdaten 
--neue Datens�tze oder ge�nderte werden allerdings
--in unsortierte Heaps abgelegt...Da hier zun�chst 
--nur unkomprimierte Daten sind, die mit einem Scan durchsucht werden m�ssen
--werden ABfragen, die ganu aif diese Daten losgehen
--"leider m�ssen"

--Jeder NOn CL oder CL IX ist immer aktuell. Der CS IX nicht




set statistics io, time on


select country, city, sum(unitprice*quantity)
from ku
where freight < 5 
group by country, city

--idealer IX


select * into ku2 from ku --ku2 hat keinen IX 



select country, city, sum(unitprice*quantity)
from ku2
where freight < 5 
group by country, city

