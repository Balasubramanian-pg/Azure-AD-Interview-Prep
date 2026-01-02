# Azure AD PowerShell Commands

# Connect to Azure AD
Connect-AzureAD

# Create a user
New-AzureADUser -DisplayName "John Doe" `
  -UserPrincipalName "jdoe@contoso.onmicrosoft.com" `
  -PasswordProfile (New-Object Microsoft.Open.AzureAD.Model.PasswordProfile `
    -Property @{Password = "P@ssw0rd123"})

# Add user to a group
$groupId = (Get-AzureADGroup -SearchString "Sales").ObjectId
$userId = (Get-AzureADUser -SearchString "jdoe").ObjectId
Add-AzureADGroupMember -ObjectId $groupId -RefObjectId $userId

# List all users
Get-AzureADUser -All $true

# Assign a license
$license = Get-AzureADSubscribedSku | Where {$_.SkuPartNumber -eq "ENTERPRISEPACK"}
New-AzureADUserLicenseAssignment -ObjectId $userId `
  -AssignedLicenses (New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense `
    -Property @{SkuId = $license.SkuId})
