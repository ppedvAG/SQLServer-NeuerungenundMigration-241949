-- Recoverymodel
--was schreibt das Logfile weg?

/*

Vollständig
IUD Bulk werden sehr ausführlich protokolliert
..wächst schneller
--daher Sicherung des L notwendig
--sicher: auf Sek restore



Massenprotokolliert
I U D Bulk werden protkolliert rudimentär
..es wird nichts gelöscht
Logfile wird nicht geleert, daher muss es gesichert werden
--Die Sicherung des Logfiles entfernt die Einträge, die dann aber im Backup sind



Einfach 
folgendes wird protokolliert
I U D
Bulkbefehle (select * into , bulk copy bulk insert) rudimentär

--wird aber später wieder gelöscht (vollautomatisch)..nach Checkpoint
--> keine Sicherung des Logfiles möglich, da nix vernünftiges drin