# Exchange Online PowerShell

# Microsoft Bookings

The following command can be used to retrieve information of all Bookings mailboxes and users who have access to them.

```powershell
Get-Mailbox -RecipientTypeDetails SchedulingMailbox -ResultSize: Unlimited | Get-MailboxPermission |Select-Object Identity, User, AccessRights | Where-Object {($\_.user -like '_@_')}
```
