--Snapshotidolation


--Schreiben hindert Lesen nicht mehr
--Versionen kommen in Tempdb!!

--wird standard für jeden Client

USE [master]
GO
ALTER DATABASE [Northwind] SET DATE_CORRELATION_OPTIMIZATION ON WITH NO_WAIT
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO


