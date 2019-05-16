# Moving files in SQL Server
Use this to move SQL Server MDF and LDF files.

## Look at the files and state
```SQL
SELECT name, physical_name AS CurrentLocation, state_desc
FROM sys.master_files;
```
## Steps

1. Take the DB Offline
```SQL
ALTER DATABASE DBName SET OFFLINE;
```
1. Physically Move the files
1. Change the locations of the files
```SQL
ALTER DATABASE DBName
MODIFY FILE ( NAME = DBName_Data, FILENAME = 'E:\data\DBName.mdf' );
ALTER DATABASE DBName
MODIFY FILE ( NAME = DBName_Logs, FILENAME = 'E:\data\DBName_Logs.ldf' );
GO
```
1. Bring the DB Back Online
```SQL
ALTER DATABASE DBName SET ONLINE;
```