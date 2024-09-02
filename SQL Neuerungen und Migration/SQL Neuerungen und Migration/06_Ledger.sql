--Alle durch eine Transaktion in einer Ledgertabelle geänderten Zeilen 
--werden kryptografisch mit einem SHA-256-Hash versehen.
--Dabei wird eine Merkle-Baumdatenstruktur verwendet, 
--die einen Stammhash generiert, 
--der alle Zeilen in der Transaktion repräsentiert.
--Die von der Datenbank 
--verarbeiteten Transaktionen werden über eine
--Merkle-Baumdatenstruktur gemeinsam
--mit einem SHA-256-Hash versehen. Das Ergebnis ist 
--ein Stammhash, der einen -Block bildet. 
--Der Block wird dann mithilfe seines Stammhashes 
--zusammen mit dem Stammhash des vorherigen Blocks 
--als Eingabe für die Hashfunktion mit SHA-256 gehasht. 


--Durch diesen Hashvorgang wird eine Blockchain gebildet.



DECLARE @digest_locations NVARCHAR(MAX) = 
(SELECT * FROM sys.database_ledger_digest_locations 
FOR JSON AUTO, INCLUDE_NULL_VALUES);

SELECT @digest_locations as digest_locations;

BEGIN TRY
    EXEC sys.sp_verify_database_ledger_from_digest_storage @digest_locations;
    SELECT 'Ledger verification succeeded.' AS Result;
END TRY
BEGIN CATCH
    THROW;
END CATCH



CREATE TABLE dbo.[KeyCardEvents]
   (
      [EmployeeID] INT NOT NULL,
      [AccessOperationDescription] NVARCHAR (1024) NOT NULL,
      [Timestamp] Datetime2 NOT NULL
   )
   WITH (LEDGER = ON (APPEND_ONLY = ON));



INSERT INTO dbo.[KeyCardEvents]
VALUES ('43869', 'Building42', '2020-05-02T19:58:47.1234567');
--geht nicht
update KeyCardEvents
set employeeid = 10000 where AccessOperationDescription= ' Building42'


SELECT *
     ,[ledger_start_transaction_id]
     ,[ledger_start_sequence_number]
FROM dbo.[KeyCardEvents];


SELECT
 t.[commit_time] AS [CommitTime] 
 , t.[principal_name] AS [UserName]
 , l.[EmployeeID]
 , l.[AccessOperationDescription]
 , l.[Timestamp]
 , l.[ledger_operation_type_desc] AS Operation
 FROM dbo.[KeyCardEvents_Ledger] l
 JOIN sys.database_ledger_transactions t
 ON t.transaction_id = l.ledger_transaction_id
 ORDER BY t.commit_time DESC;

---Aktualisierbar

CREATE TABLE dbo.[Balance]
(
    [CustomerID] INT NOT NULL PRIMARY KEY CLUSTERED,
    [LastName] VARCHAR (50) NOT NULL,
    [FirstName] VARCHAR (50) NOT NULL,
    [Balance] DECIMAL (10,2) NOT NULL
)
WITH 
(
 SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.[BalanceHistory]),
 LEDGER = ON
);


SELECT 
ts.[name] + '.' + t.[name] AS [ledger_table_name]
, hs.[name] + '.' + h.[name] AS [history_table_name]
, vs.[name] + '.' + v.[name] AS [ledger_view_name]
FROM sys.tables AS t
JOIN sys.tables AS h ON (h.[object_id] = t.[history_table_id])
JOIN sys.views v ON (v.[object_id] = t.[ledger_view_id])
JOIN sys.schemas ts ON (ts.[schema_id] = t.[schema_id])
JOIN sys.schemas hs ON (hs.[schema_id] = h.[schema_id])
JOIN sys.schemas vs ON (vs.[schema_id] = v.[schema_id])
WHERE t.[name] = 'Balance';



INSERT INTO dbo.[Balance]
VALUES (1, 'Jones', 'Nick', 50);


INSERT INTO dbo.[Balance]
VALUES (2, 'Smith', 'Tom', 30);


INSERT INTO dbo.[Balance]
VALUES (3, 'Smith', 'John', 500),
(4, 'Smith', 'Joe', 30),
(5, 'Michaels', 'Mary', 200);



SELECT [CustomerID]
   ,[LastName]
   ,[FirstName]
   ,[Balance]
   ,[ledger_start_transaction_id]
   ,[ledger_end_transaction_id]
   ,[ledger_start_sequence_number]
   ,[ledger_end_sequence_number]
 FROM dbo.[Balance];




 UPDATE dbo.[Balance] SET [Balance] = 100
WHERE [CustomerID] = 1;




SELECT
 t.[commit_time] AS [CommitTime] 
 , t.[principal_name] AS [UserName]
 , l.[CustomerID]
 , l.[LastName]
 , l.[FirstName]
 , l.[Balance]
 , l.[ledger_operation_type_desc] AS Operation
 FROM dbo.[Balance_Ledger] l
 JOIN sys.database_ledger_transactions t
 ON t.transaction_id = l.ledger_transaction_id
 ORDER BY t.commit_time DESC;