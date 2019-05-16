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