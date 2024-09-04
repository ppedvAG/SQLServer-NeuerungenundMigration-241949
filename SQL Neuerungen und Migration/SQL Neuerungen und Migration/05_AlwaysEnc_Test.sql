select * from dbo.EncryptedTable

INSERT dbo.EncryptedTable(LastName,Salary)
SELECT N'Bertrand',720000;

DECLARE @LastName NVARCHAR(32) = N'Bertrand', @Salary INT = 720000;
INSERT dbo.EncryptedTable(LastName,Salary) SELECT @LastName, @Salary;

DECLARE @LastName NVARCHAR(32) = N'Bertrand', @Salary INT = 720000;
EXEC dbo.AddPerson @LastName, @Salary;


select * from EncryptedTable