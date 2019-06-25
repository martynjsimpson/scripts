## Create SQL auth login from master 

Use this to create a username and password using SQL Auth. Do this on MASTER.

    CREATE LOGIN [test] WITH PASSWORD = 'SuperSecret!' 

## Create a User within a DB

Use this to create the associated User within the DB.

    CREATE USER [test] FOR LOGIN [test] WITH DEFAULT_SCHEMA = dbo; 


## User within the Tennant AAD

Keep the email address within the braces. Do this on the DB the user needs access to.

    CREATE USER [bob@contoso.com] FROM EXTERNAL PROVIDER;

## User within different Tennant

    CREATE USER [alice@fabrikam.onmicrosoft.com] FROM EXTERNAL PROVIDER;

## Add user to a role.

To add an existing user to an existing role use (AAD Use email)

    ALTER ROLE db_datareader ADD MEMBER [bob@contoso.com]; 