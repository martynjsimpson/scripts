# About
The Azure Az Module replaces the Azure RM Module previously used.

# Install the Azure AZ Module
To install execute the 2 commands below.

``` powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```

# Connect
To connect to Azure use the command below replacing the "<tenantId>" with the value from your Directory ID

``` powershell
Connect-AzAccount -TenantId <tenantId>
```

# Azure storage
Before doing anything in Azure Storage you need to set a "context" (ie connect to an Azure storage Account). This is easiest if you pull the connect string from the Azure Portal for the required storage account.

``` powershell
$StorageContext = New-AzStorageContext -ConnectionString "<connectionString>"
```
Once you have a Context you can perform operations

## Remove a Blob Object.
To remove an Object from Blob store you will need to know the Blob ID. If you have "folders" inside your container that "path" forms part of the BlobId.

E.g
```
containername
    folder1
        folderA
            doc1.pdf
        folderB
    folder2
```

In the above example your blob ID would be "folder1/folderA/doc1.pdf".

``` powershell
Remove-AzStorageBlob -Container "<containerName>" -Blob "<blobId>" -Context $StorageContext
```