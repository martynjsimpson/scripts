# Performance

There’s nothing new or magic here, the code snippet simply identifies the top 20 most expensive queries (currently cached) based on the cumulative CPU cost.
The query returns both the SQL Text from the sys.dm_exec_sql_text DMV and the XML Showplan data from the sys.dm_exec_query_plan DMV. */

## 20 most costly queries in terms of Total CPU
```SQL
SELECT TOP 20
    qs.sql_handle,
    qs.execution_count,
    qs.total_worker_time AS Total_CPU,
    total_CPU_inSeconds = --Converted from microseconds
    qs.total_worker_time/1000000,
    average_CPU_inSeconds = --Converted from microseconds
    (qs.total_worker_time/1000000) / qs.execution_count,
    qs.total_elapsed_time,
    total_elapsed_time_inSeconds = --Converted from microseconds
    qs.total_elapsed_time/1000000,
    st.text,
    qp.query_plan
FROM
    sys.dm_exec_query_stats AS qs
        CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
        CROSS apply sys.dm_exec_query_plan (qs.plan_handle) AS qp
ORDER BY qs.total_worker_time DESC
```

## Kill a Session
```SQL
KILL { session ID | UOW } [ WITH STATUSONLY ]
```

## SP_WHO Information
sp_who supports parameters of SPID or Username
```SQL
sp_who [ [ @loginame = ] 'login' | session ID | 'ACTIVE' ]  
```

## Find all Active queries
```SQL
SELECT      r.start_time [Start Time],session_ID [SPID],
            DB_NAME(database_id) [Database],
            SUBSTRING(t.text,(r.statement_start_offset/2)+1,
            CASE WHEN statement_end_offset=-1 OR statement_end_offset=0
            THEN (DATALENGTH(t.Text)-r.statement_start_offset/2)+1
            ELSE (r.statement_end_offset-r.statement_start_offset)/2+1
            END) [Executing SQL],
            Status,command,wait_type,wait_time,wait_resource,
            last_wait_type
FROM        sys.dm_exec_requests r
OUTER APPLY sys.dm_exec_sql_text(sql_handle) t
WHERE       session_id != @@SPID -- don't show this query
AND         session_id > 50 -- don't show system queries
ORDER BY    r.start_time
```
