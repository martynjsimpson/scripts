# Indexes
## To Rebuild or Reorganize: That is the Question
First off: ‘Reorganize’ and ‘Rebuild’ are two different operations that each reduce fragmentation in an index. They work differently toward the same end. You don’t need to run both against the same index. (I sometimes find that people are doing both against every index in a maintenance plan. That’s just double the work and NOT double the fun.)

Rebuild: An index ‘rebuild’ creates a fresh, sparkling new structure for the index. If the index is disabled, rebuilding brings it back to life. You can apply a new fillfactor when you rebuild an index. If you cancel a rebuild operation midway, it must roll back (and if it’s being done offline, that can take a while).

Reorganize: This option is more lightweight. It runs through the leaf level of the index, and as it goes it fixes physical ordering of pages and also compacts pages to apply any previously set fillfactor settings. This operation is always online, and if you cancel it then it’s able to just stop where it is (it doesn’t have a giant operation to rollback).

Factors to consider:

Standard Edition rebuilds ain’t awesome. If you’ve got SQL Server Standard Edition, index rebuilds are always an offline operation. Bad news: they’re also single-threaded. (Ouch!)
Enterprise Edition rebuilds have gotchas. With SQL Server Enterprise Edition, you can specify an online rebuild — unless the index contains large object types. (This restriction is relaxed somewhat in SQL Server 2012). You can also use parallelism when creating or rebuilding an index— and that can save a whole lot of time. Even with an online rebuild, a schema modification lock (SCH-M) is needed at the time the fresh new index is put in place. This is an exclusive lock and in highly concurrent environments, getting it can be a big (blocking) problem.
There’s a bug in SQL Server 2012 Enterprise Edition Rebuilds that can cause corruption. If you’re running SQL Server 2012 SP1 – SP2, parallel online index rebuilds can cause corruption. Read about your options here.
Rebuilding partitioned tables is especially tricky. You can rebuild an entire partitioned index online– but nobody really wants to do that because they’re huge! The whole idea behind horizontal partitioning is to break data into more manageable chunks, right? Unfortunately, partition level rebuilds are offline until SQL Server 2014.
Reorganizing can be pretty cool. ‘Reorganizing’ an index is always an online op, no matter what edition of SQL Server you’re using. It doesn’t require a schema mod lock, so it can provide better concurrency. Reorganizing only defragments the leaf level of the index. On large tables it can take longer than a rebuild would take, too. But as I said above, it’s nice that you can reorganize for a while and then stop without facing a massive rollback

https://www.brentozar.com/archive/2013/09/index-maintenance-sql-server-rebuild-reorganize/

## Create an Index
```SQL
USE [<DBName>]
GO
CREATE NONCLUSTERED INDEX [<IndexName>]
ON [dbo].[<table>] ([<column 1>],[column 2])
GO
```

## Get all index fragmentation info for a selected DB
```SQL
SELECT OBJECT_NAME(ind.OBJECT_ID) AS TableName,
  ind.name AS IndexName, indexstats.index_type_desc AS IndexType,
  indexstats.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) indexstats
  INNER JOIN sys.indexes ind ON ind.object_id = indexstats.object_id
       AND ind.index_id = indexstats.index_id
 WHERE
-- Line below set to 5% for fragmentation limit to stop showing everything
  indexstats.avg_fragmentation_in_percent > 5
 AND ind.Name is not null
 ORDER BY indexstats.avg_fragmentation_in_percent DESC
```

## Rebuild or Reorg all indexes in a given DB depending on limits.
```SQL
use --DBNAME--
GO

declare @tableName nvarchar(500)
declare @indexName nvarchar(500)
declare @indexType nvarchar(55)
declare @percentFragment decimal(11,2)

declare FragmentedTableList cursor for
 SELECT OBJECT_NAME(ind.OBJECT_ID) AS TableName,
   ind.name AS IndexName, indexstats.index_type_desc AS IndexType,
   indexstats.avg_fragmentation_in_percent
 FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) indexstats
   INNER JOIN sys.indexes ind ON ind.object_id = indexstats.object_id
        AND ind.index_id = indexstats.index_id
  WHERE
-- indexstats.avg_fragmentation_in_percent , e.g. > 30, you can specify any number in percent. 30% is a good starting point.
   indexstats.avg_fragmentation_in_percent > 30
  AND ind.Name is not null
  ORDER BY indexstats.avg_fragmentation_in_percent DESC

    OPEN FragmentedTableList
    FETCH NEXT FROM FragmentedTableList
    INTO @tableName, @indexName, @indexType, @percentFragment

    WHILE @@FETCH_STATUS = 0
    BEGIN
      print 'Processing ' + @indexName + 'on table ' + @tableName + ' which is ' + cast(@percentFragment as nvarchar(50)) + ' fragmented'

      if(@percentFragment>= 50) -- Rebuild indexes with fragmentation higher than this. Else Reorg
      BEGIN
            EXEC( 'ALTER INDEX ' +  @indexName + ' ON ' + @tableName + ' REBUILD; ')
       print 'Finished Rebuild ' + @indexName + 'on table ' + @tableName
      END
      ELSE
      BEGIN
         EXEC( 'ALTER INDEX ' +  @indexName + ' ON ' + @tableName + ' REORGANIZE;')
        print 'Finished reorg ' + @indexName + 'on table ' + @tableName
      END
      FETCH NEXT FROM FragmentedTableList
        INTO @tableName, @indexName, @indexType, @percentFragment
    END
    CLOSE FragmentedTableList
    DEALLOCATE FragmentedTableList
```
