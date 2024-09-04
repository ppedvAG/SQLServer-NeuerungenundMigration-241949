USE [master]
GO
ALTER DATABASE [ztrrtz] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [ztrrtz] SET ALLOW_SNAPSHOT_ISOLATION ON
GO

--Achtung Tempdb.. 
--aber Schreiben hindert das Lesen nicht 
--und lesen hindert das schreiben nicht

--Die Anwndung bekommt diese Änderung nicht mit...

--DS werden vor Änderung in die Tempdb kopiert und dort versioniert..
--Abfragen an sich gerade ändernde DS werden auf die Version in der tempdb verwiesen


