Drop database if exists testdb1
GO

create database testdb1
GO

Use testdb1
GO


select * into t1 from sysmessages
GO

create nonclustered index NIX1 on t1(error asc)
GO

--CLEANUP älterer Backups mit gleichem DB Namen
use master 
exec msdb.dbo.sp_delete_database_backuphistory @database_name = 'testdb1'
go 
exec sys.xp_delete_files 'c:\_sqlbackup\*.bkm'
-----------------------------------------------------------------

select count(*) from testdb1.dbo.t1

------------------------------------------------------------------
use master
GO
ALTER DATABASE testdb1 set suspend_for_Snapshot_backup = ON
GO

/*
Die Datenbank "testdb1" hat Sperren in der Sitzung 55 abgerufen.
Der E/A-Vorgang für die testdb1-Datenbank hängt. Es ist keine Benutzeraktion erforderlich. 
Wenn der E/A-Vorgang jedoch nicht umgehend fortgesetzt wird, sollten Sie die Sicherung möglicherweise abbrechen.
Database "testdb1" wurde erfolgreich für die Sicherungsmomentaufnahme in der Sitzung 55 angehalten.
*/


select 
		resource_type, resource_subtype,resource_database_id,resource_lock_partition,
		request_mode, request_status, request_owner_type, request_session_id
from	sys.dm_tran_locks
where	request_owner_type='SESSION'

--New Session: blocked -------------------
insert into testdb1..t1
select top 10 * from sysmessages


-------------------------------------------

--BACKUP
backup database testdb1
to disk='C:\_SQLBACKUP\testdb1.bkm' 
with metadata_only, FORMAT

--in new Session nachschauen.. completet----

select count(*) from testdb1.dbo.t1
select count(*) from sysmessages

--------------------------------------------

--RESTORING---------------------
use master
GO
ALTER DATABASE testdb1 set suspend_for_Snapshot_backup = OFF

/*
Database "testdb1" wird für die Sicherungsmomentaufnahme nicht angehalten.
*/

alter database testdb1 set single_user with rollback immediate
GO

drop database if exists testdb1

restore filelistonly  from disk='c:\_sqlbackup\testdb1.bkm' 
with file = 1, metadata_only, Replace, dbname='testdb1'





