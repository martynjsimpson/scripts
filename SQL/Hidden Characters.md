# Dealing with non-printable characters in SQL Server.

## Finding Bare Line Breaks
A bare line feed is a single line feed character (LF or ASCII 10 or \n) that isn't immediately preceded by the carriage return character (CR or ASCII 13 or \r). The line separator in an email message is supposed to be CRLF, not just LF.

Uee the below query to identify records that contain a \n without a preceeding \r.

Will return the ID Field, Original Description and a "ReplacedDescription" with Char(10) replaced with \n for readability.

Note the cast is only required if your field type is NTEXT. This will probably break if your NTEXT contains more than NVARCHAR(MAX) data.

``` sql
SELECT 
    IDField, 
    Description, 
    REPLACE(CAST(Description AS varChar(3000)),char(10),'\n') as ReplacedDescription
FROM Product2
WHERE  
   Description LIKE '%[^'+CHAR(13)+']'+CHAR(10)+'%'
```

We needed this as noticed email deliverability problems with SMTP error "550 5.6.11" - Bare Line Feeds. The source of the Bare Line Feeds was the data retrieved from the DB.