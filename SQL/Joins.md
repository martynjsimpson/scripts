# SQL Joining

## Standard Join
```SQL
select tab1.col1, tab2.col2
from TABLE1 as tab1
join TABLE2 as tab2
	on tab1.idcol /* Optional Collate */ collate Latin1_General_BIN = tab2.idcol collate Latin1_General_BIN
where /* where clause in tab.1 format */
```