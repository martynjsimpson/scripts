# EZPrint
EZPrint is the software used on IBM Power Series and AS400 for generating PDF's etc.

## Starting and stopping
    WRKJOBSCDE --> EZPRTSTART or EZPRTSTOP --> Option 10
Ensure that the EZMonitor is started
```
ADDLIBLE ACOM
ACOM --> 3 --> 1 --> 7 --> (Check for status *START. If not start but can only be done as a configured user)
Check for jobs waiting in queue
ACOM --> 3 --> 1 --> 4
```

## Purging
```ADDLIBLE ACOM
ACOM --> 50 --> 30 --> 4
Select By :                             
 Status ..................:  *ALL       
 User ID .................:  *all       
 Date Type ...............:  2          
 From ....................:  01010001  (USA Format)
 To ......................:  11282015  (USA Format) 
Print Purged Transactions.   *NO        
- Clear down docs from directories in IFS (Can be done via SMB Share)
```
### Purge SMB Locations
```
\\rental\ACOM\EDOCS\EZEMAIL\INPUT 	(Leave x months of data)
\\rental\ACOM\EDOCS\EZEMAIL\LOG 	(Leave x months of data)
\\rental\ACOM\EDOCS\EZEMAIL\OUTPUT 	(Should be empty)
\\rental\ACOM\EDOCS\EZPDF\LOG		(Leave x months of data)
```
