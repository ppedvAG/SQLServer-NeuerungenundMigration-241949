--Probleme bei Seiten..

--schlechter F�llgrad
--gro�e Tabellen --> hohe IO --hoher RAM - Verbrauch


--kein IX--> TABLE SCAN

set statistics io, time on--

select * from ku where id = 100 --61058--von HDD in RAM


--Feststellen des F�llgrads der Seiten
dbcc showcontig('KU')
--- Gescannte Seiten.............................: 48028
--- Mittlere Seitendichte (voll).....................: 97.86%

--DMV
select * from sys.dm_os_
select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku'),NULL,NULL,'detailed')

--forward record count!! muss NULL oder 0 sein
--wie krieg ich es weg?
--Gr IX = Tabelle , aber immer sortiert


Brent Ozar...  sp_blitzindex

---48274


--Was w�re, wenn die Seiten einen F�llgrad von 60% h�tten
--kommt �fter bei sehr breiten Tabellen vor..

--Tabellen splitten Kunde + Kundensonstiges
--Datentypen statt datetime (ms) date

--alles �ndert die APP...

--kompression--man kommt idr auf 40 bis 60%

--Seiten kommen 1:1 in RAM auch komprimiert
--wird bezahlt mit CPU


--Weniger IO ---------------------> weniger RAM --------------------> weniger CPU






