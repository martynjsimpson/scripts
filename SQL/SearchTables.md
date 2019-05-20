# Searching Table's for Collums

## Search Tables
```SQL
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%MyName%'
ORDER BY    TableName
            ,ColumnName;
```

## Search Tables & Views
```SQL
SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE '%MyName%'
ORDER BY    TableName
            ,ColumnName;
```
Credit: https://stackoverflow.com/questions/4849652/find-all-tables-containing-column-with-specified-name-ms-sql-server


