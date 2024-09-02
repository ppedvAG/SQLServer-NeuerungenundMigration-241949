--Starten , aber auch fortsetzen nach Pause

ALTER INDEX [NIX_CID_inkl]
 ON dbo.customers 
 rebuild
WITH (ONLINE = ON , RESUMABLE = ON );

--Maximal 1 Minute bis in Zustand Pause

ALTER INDEX [NIX_CID_inkl]
 ON dbo.customers 
 rebuild
WITH (ONLINE = ON , RESUMABLE = ON, Max_duration= 1 Minutes)

--Status des IX Rebuild

SELECT total_execution_time , Percent_complete , Name , state_desc , last_pause_time , page_count
 FROM sys . index_resumable_operations ;


--Logfile used
select 
    used_log_space_in_bytes / 1024 / 1024 as used_log_space_MB , 
    log_space_in_bytes_since_last_backup / 1024 / 1024 as log_space_MB_since_last_backup ,         
    used_log_space_in_percent
from  sys . dm_db_log_space_usage ;

--sicherung des Logfiles notwendig?
select name, log_reuse_wait_desc from sys.databases where name = 'nwindBig'

 --in anderer Session pausieren 

ALTER INDEX [NIX_CID_inkl]  ON dbo.customers   PAUSE  
ALTER INDEX [NIX_CID_inkl]  ON dbo.customers   RESUME  
ALTER INDEX [NIX_CID_inkl]  ON dbo.customers   ABort  
