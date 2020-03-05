# Odata Example Queries for D365 FFO

## Customer

## By CustomerAccount Number

    /data/CustomersV3?$filter=CustomerAccount eq 'T211'&cross-company=true

## Rental Order Header

### By Sales Order Number

    /data/DNRRentalOrderHeaders?$filter=SalesOrderNumber eq '334195'&cross-company=true

## Rental Order Lines

### By Sales Order Number

    /data/DNRRentalOrderLines?$filter=SalesOrderNumber eq 'VALUE'&cross-company=true

## Part Release

### All Part Releases

    /data/EBCReleaseProductEntitys

### Failed Part Releases

    /data/EBCReleaseProductEntitys?$filter=IsSuccess eq Microsoft.Dynamics.DataEntities.NoYes'No'