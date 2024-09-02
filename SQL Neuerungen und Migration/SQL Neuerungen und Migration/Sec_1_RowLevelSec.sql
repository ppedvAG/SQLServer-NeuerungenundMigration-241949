drop database  if exists rowlevel
GO
create database rowlevel

Use RowLevel
GO

CREATE USER Manager WITHOUT LOGIN;  
CREATE USER Sales1 WITHOUT LOGIN;  
CREATE USER Sales2 WITHOUT LOGIN;  

CREATE TABLE Sales
    (  
    OrderID int,  
    SalesRep sysname,  
    Product varchar(10),  
    Qty int  
    );  
GO

INSERT Sales VALUES   
(1, 'Sales1', 'Valve', 5),   
(2, 'Sales1', 'Wheel', 2),   
(3, 'Sales1', 'Valve', 4),  
(4, 'Sales2', 'Bracket', 2),   
(5, 'Sales2', 'Wheel', 5),   
(6, 'Sales2', 'Seat', 5);  
GO


select * from sales
--Tipp: sehr easy wirds , wenn man Daten aus dem Login verwendet
--Anmeldename, Appname
EXEC sp_set_session_context @key='userid', @value='Sales3'
select session_context(N'userid')



select SUSER_NAME(), APP_NAME(), SESSION_CONTEXT(N'userid')
-- View the 6 rows in the table  
SELECT * FROM Sales;  
GO

CREATE SCHEMA Security;  
GO  

--Funktion gibt nur 1 oder 0 zurück.. 1 = ich darf
  
CREATE FUNCTION Security.fn_securitypredicate(@SalesRep AS sysname)  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS fn_securitypredicate_result   
		WHERE 
				@SalesRep = USER_NAME() 
				OR 
				USER_NAME() = 'Manager' 
			
			
			
			OR 
				CAST(SESSION_CONTEXT(N'UserId') AS varchar(10)) = 'Sales3';

--angemeldeten User auslesen... vergleich mit F() und Tabellenwert--> 1 oder 0


--Richtlinie für F() auf Tabelle legen
CREATE SECURITY POLICY SalesFilter  
ADD 
FILTER PREDICATE Security.fn_securitypredicate(SalesRep)   
ON dbo.Sales  
WITH (STATE = ON);  


--USer ohne Login für Test

GRANT SELECT ON Sales TO Manager;  
GRANT SELECT ON Sales TO Sales1;  
GRANT SELECT ON Sales TO Sales2;  


sp_set_session_context @key='userid',@value=N'ich bins'


EXECUTE AS USER = 'Sales1';  
SELECT * FROM Sales;   
REVERT;  
  
EXECUTE AS USER = 'Sales2';  
SELECT * FROM Sales   
REVERT;  
  
EXECUTE AS USER = 'Manager';  
SELECT * FROM Sales;   
REVERT;  

sp_set_session_context @key='userid',@value=N'Sales3'



ALTER SECURITY POLICY SalesFilter
WITH (STATE = OFF);  

--------------

