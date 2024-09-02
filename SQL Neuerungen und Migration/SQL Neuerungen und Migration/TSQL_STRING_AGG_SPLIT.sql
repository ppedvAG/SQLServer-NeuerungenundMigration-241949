use northwind
GO
SELECT STRING_AGG (CONVERT(NVARCHAR(max),FirstName), CHAR(13)) AS csv 
FROM Employees;
GO



SELECT STRING_AGG (CONVERT(NVARCHAR(max),FirstName), '; ') AS csv 
FROM Employees;
GO

--Sortieren
SELECT STRING_AGG (CONVERT(NVARCHAR(max),FirstName), '; ') within group (order by Firstname) AS csv 
FROM Employees;
GO


--STRING_SPLIT

DECLARE @tags NVARCHAR(400) = 'clothing,road,,touring,bike'  
  
SELECT value  
FROM STRING_SPLIT(@tags, ',')  
WHERE RTRIM(value) <> '';


