# Active Directory PowerShell Commands

# Create a new user
New-ADUser -Name "John Doe" -SamAccountName jdoe -Enabled $true `
  -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
  -Path "OU=Users,DC=contoso,DC=com"

# Add user to a group
Add-ADGroupMember -Identity "Sales Team" -Members jdoe

# Search for a user
Get-ADUser -Filter "Name -like '*Doe*'" -Properties *

# Reset password
Set-ADAccountPassword -Identity jdoe `
  -NewPassword (ConvertTo-SecureString "NewP@ss123" -AsPlainText -Force)

# Unlock account
Unlock-ADAccount -Identity jdoe

# List all GPOs
Get-GPO -All
