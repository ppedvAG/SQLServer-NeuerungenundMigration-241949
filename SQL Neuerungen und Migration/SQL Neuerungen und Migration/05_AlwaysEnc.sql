Drop database if exists AlwaysEnC
Go

create database AlwaysEnC
GO

USE AlwaysEnc
GO


CREATE TABLE dbo.EncryptedTable
(
  ID INT IDENTITY(1,1) PRIMARY KEY,
  
  LastName NVARCHAR(32) COLLATE Latin1_General_BIN2 , Salary int)
GO

CREATE PROCEDURE dbo.AddPerson
  @LastName NVARCHAR(32),
  @Salary   INT
AS
BEGIN
  INSERT dbo.EncryptedTable(LastName,Salary) SELECT @LastName, @Salary;
END
GO

CREATE PROCEDURE dbo.GetPeopleByLastName
  @LastName NVARCHAR(32) 
AS
BEGIN
  SELECT ID, LastName, Salary
  FROM dbo.EncryptedTable
  WHERE LastName = @LastName COLLATE Latin1_General_BIN2;
END
GO




--DS einfügen
INSERT dbo.EncryptedTable(LastName,Salary) SELECT N'Bertrand',720000;

select * from dbo.EncryptedTable

--Connection beenden.. AlwaysEnc einrichten
--Verbindung herstellen ohne AlwEnc

select * from dbo.EncryptedTable

--mit AlwaysEnc


select * from dbo.EncryptedTable

--Einfügen neuer Daten


--ERROR
INSERT dbo.EncryptedTable(LastName,Salary)
SELECT N'Bertrand',720000;

--geht ohne AlwEnc nicht
DECLARE @LastName NVARCHAR(32) = N'Bertrand', @Salary INT = 720000;
INSERT dbo.EncryptedTable(LastName,Salary) SELECT @LastName, @Salary;


--geht ..ohne AlwaysEnc nicht
DECLARE @LastName NVARCHAR(32) = N'Bertrand', @Salary INT = 720000;
EXEC dbo.AddPerson @LastName, @Salary;


select * from EncryptedTable

-- SSMS  Column Encryption Setting = Enabled