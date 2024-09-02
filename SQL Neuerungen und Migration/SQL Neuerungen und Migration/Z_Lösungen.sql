--Probleml�sung

--hohe CPU Last
wg NUMA in der VM k�nnte die Hardware nicht unbedingt der Realti�t entsprochen haben
zB: 1 Sockel mit 8 kerne in der VM
aber real 2 Sockel mit jew 4 Kernen

Ausnahme: wg Lizenz weil zB Std Version nur 4 Sockel supportet oder Express nur 1 Sockel aber 4 Kerne

Was kann man sehenb: Manche CPU Kerne tun evtl gar nichts...


MAXDOP je mehr Kerne bei einer Abfrage verwendet werden, umso h�her die CPU Last

Was kann man tun: MAXDOP ungleich 0 , sondern: soviel wie Kerne, max 8 
Wichtig dabei ist: der Kostenschwellenwert (default 5) ist meist zu niedrig
Dieser taucht in Servereinstellungen auf und im Plan

EXEC sys.sp_configure N'cost threshold for parallelism', N'20'
GO
EXEC sys.sp_configure N'max degree of parallelism', N'4'
GO
RECONFIGURE WITH OVERRIDE
GO

-->man kann den Mxdop allerdings auch in der DB
USE [master]
GO

GO
USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO


--Abfrage-->DB-->Server


---HDD  ..alles irgendwie zu langsam
aufteilen der DAten und Logdateien (Setup,neue DB)

Volumewartungstask (Lok Sicherheitsrichtline: SQL Dienstkonto bekommt Rechte Dateien zu Vergr��rn ohne vorher Ausnullen zu m�ssen))
beim Restore :-)

--Restore ist langsam oft umfangreiche Transaktionen (evtl Rollback)... und alles braucht irgend sehr lange Zeit
ADR  Accelerated DB Recovery 
Versionspeicher bleibt in der DB
pro DB
ALTER  DATABASE NewStyle SET ACCELERATED_DATABASE_RECOVERY = ON;
Evtl langsameres Schreiben (Optimieren poer HDDs)
Regel: auf dem Server soviele Threads reservieren wie ADR DB (ab SQL 2022)


---Locks
Momentaufnamenisolation + Read Commited Snapshot pro DB  -- daf�r Traffic auf Tempdb
USE [master]
GO
ALTER DATABASE [NewStyle] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [NewStyle] SET ALLOW_SNAPSHOT_ISOLATION ON
GO

zuerst richtige Indexstrategie


--TempDB Probleme beheben
---#tab  ##tab  Momentaufnahmerisolation IX Rebuild mit Sort  Cursor  wen zu wenig RAM gesch�tzt wurde--> Auslagern
Gr��en anpassen (Startwert der Dateien)
Anzahl der DAtendateien auf Anzahl der Kerne (max 8) setzen
und alle m�ssen immer gleich gro� sein (ab SQL 2016 im Setup) Traceflag T1117 (aber nur wenn sie automat wachsen)
eig HDDS
T1118  Uniform Extents  juede Tabelle bekommt eig Block  Vermeiden von Latch

--Ver�nderung von DS (historisieren)
Temporal Tables


--Sind Datens�tze unver�ndert:
--ledger  ab SQL 2022



























