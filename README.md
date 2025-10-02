# Azure-AD-Interview-Prep
Active Directory tf is that?


Here’s a **comprehensive cheat sheet** for **Active Directory (AD), Azure Active Directory (Azure AD), Single Sign-On (SSO), and Role-Based Access Control (RBAC)**, tailored for interviews and quick reference:

## **1. Active Directory (AD) Basics**
### **Key Concepts**
| Term | Description |
|------|-------------|
| **Domain** | Logical group of objects (users, computers, groups) with a common database (e.g., `contoso.com`). |
| **Forest** | Collection of one or more domains with trust relationships. |
| **Tree** | Hierarchical arrangement of domains within a forest. |
| **Organizational Unit (OU)** | Container for grouping objects (e.g., "Sales OU," "IT OU"). |
| **Domain Controller (DC)** | Server that authenticates users and enforces security policies. |
| **Global Catalog (GC)** | Distributed data store for fast searches across domains. |
| **Schema** | Defines object types (users, groups) and their attributes. |
| **Sites** | Physical locations (for replication optimization). |
| **Trusts** | Allows users in one domain/forest to access resources in another. |

### **AD Objects**
| Object Type | Description | Example |
|-------------|-------------|---------|
| **User** | Represents a person or service account. | `jdoe@contoso.com` |
| **Group** | Collection of users/computers for permission management. | `Domain Admins`, `Sales Team` |
| **Computer** | Devices joined to the domain. | `WS-001$` |
| **Group Policy Object (GPO)** | Set of rules applied to users/computers. | "Password Policy," "Desktop Restrictions" |

### **Group Types**
| Type | Scope | Description |
|------|-------|-------------|
| **Security Group** | Domain Local, Global, Universal | Used for permissions (e.g., file shares). |
| **Distribution Group** | Global, Universal | Used for email distributions (no security permissions). |
| **Domain Local** | Domain-local | Permissions within the same domain. |
| **Global** | Global | Members from the same domain; permissions across domains. |
| **Universal** | Forest-wide | Members from any domain; permissions across forests. |

### **Common AD Commands (PowerShell)**
```powershell
# Create a new user
New-ADUser -Name "John Doe" -SamAccountName jdoe -Enabled $true -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -Path "OU=Users,DC=contoso,DC=com"

# Add user to a group
Add-ADGroupMember -Identity "Sales Team" -Members jdoe

# Search for a user
Get-ADUser -Filter "Name -like '*Doe*'" -Properties *

# Reset password
Set-ADAccountPassword -Identity jdoe -NewPassword (ConvertTo-SecureString "NewP@ss123" -AsPlainText -Force)

# Unlock account
Unlock-ADAccount -Identity jdoe

# List all GPOs
Get-GPO -All
```

### **Group Policy (GPO)**
- **Link Order**: Local → Site → Domain → OU (last applied wins).
- **Inheritance**: Child OUs inherit parent GPOs (can be blocked).
- **Common GPOs**:
  - Password policies (`MinimumPasswordLength`).
  - Software deployment.
  - Folder redirection.
  - Startup/shutdown scripts.

## **2. Azure Active Directory (Azure AD)**
### **Key Differences: AD vs. Azure AD**
| Feature | AD | Azure AD |
|---------|----|----------|
| **Protocol** | LDAP, Kerberos | OAuth 2.0, OpenID Connect, SAML |
| **Scope** | On-premises | Cloud-based |
| **Structure** | OUs, GPOs | Flat structure (no OUs/GPOs) |
| **Authentication** | NTLM, Kerberos | Modern auth (MFA, conditional access) |
| **Sync** | N/A | Syncs with on-prem AD via **Azure AD Connect** |
| **Devices** | Domain-joined | Azure AD-joined, Hybrid AD-joined, Registered |

### **Azure AD Editions**
| Edition | Features |
|---------|----------|
| **Free** | Basic user/group management, SSO, MFA (security defaults). |
| **P1** | Conditional Access, Hybrid Identity, Dynamic Groups. |
| **P2** | Identity Protection, Privileged Identity Management (PIM), Risk-based policies. |

### **Azure AD Connect**
- **Sync Types**:
  - **Password Hash Sync (PHS)**: Syncs password hashes (not actual passwords).
  - **Pass-Through Authentication (PTA)**: Validates passwords on-prem.
  - **Federation (AD FS)**: Redirects auth to on-prem AD FS.
- **Sync Command**:
  ```powershell
  Start-ADSyncSyncCycle -PolicyType Delta
  ```

### **Azure AD PowerShell Commands**
```powershell
# Connect to Azure AD
Connect-AzureAD

# Create a user
New-AzureADUser -DisplayName "John Doe" -UserPrincipalName "jdoe@contoso.onmicrosoft.com" -PasswordProfile (New-Object Microsoft.Open.AzureAD.Model.PasswordProfile -Property @{Password = "P@ssw0rd123"})

# Add user to a group
Add-AzureADGroupMember -ObjectId (Get-AzureADGroup -SearchString "Sales").ObjectId -RefObjectId (Get-AzureADUser -SearchString "jdoe").ObjectId

# List all users
Get-AzureADUser -All $true

# Assign a license
$license = Get-AzureADSubscribedSku | Where {$_.SkuPartNumber -eq "ENTERPRISEPACK"}
New-AzureADUserLicenseAssignment -ObjectId (Get-AzureADUser -SearchString "jdoe").ObjectId -AssignedLicenses (New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense -Property @{SkuId = $license.SkuId})
```

## **3. Single Sign-On (SSO)**
### **SSO Protocols**
| Protocol | Description | Use Case |
|----------|-------------|----------|
| **SAML 2.0** | XML-based; uses IDP (Identity Provider) and SP (Service Provider). | Enterprise apps (e.g., Salesforce, Workday). |
| **OAuth 2.0** | Delegated authorization (access tokens). | APIs, mobile apps (e.g., Facebook Login). |
| **OpenID Connect (OIDC)** | Authentication layer on top of OAuth 2.0. | Modern web/mobile apps. |
| **WS-Fed** | Microsoft’s SOAP-based SSO. | Legacy apps (e.g., SharePoint). |
| **Kerberos** | Ticket-based auth for on-prem AD. | Internal apps. |

### **SAML SSO Flow**
1. User accesses app (SP).
2. SP redirects to IdP (Azure AD) with a SAML request.
3. User authenticates with IdP.
4. IdP sends SAML response (assertion) to SP.
5. SP grants access.

### **OAuth 2.0 Flow**
1. App requests authorization from user.
2. User consents and grants an **authorization code**.
3. App exchanges code for an **access token**.
4. App uses token to access resources (e.g., Microsoft Graph API).

### **Azure AD SSO Configuration**
1. **Add an Enterprise App**:
   - Go to **Azure Portal** → **Azure AD** → **Enterprise Applications** → **New Application**.
2. **Configure SSO**:
   - For **SAML**: Upload metadata file or manually configure issuer URL, ACS URL, and claims.
   - For **OAuth/OIDC**: Register app in **App Registrations**, define redirect URIs and permissions.
3. **Assign Users/Groups**:
   - Under **Users and Groups**, assign access to the app.

### **Troubleshooting SSO**
| Issue | Solution |
|-------|----------|
| **"AADSTS50011: Reply URL mismatch"** | Ensure the **Reply URL** in Azure AD matches the app’s callback URL. |
| **"AADSTS700016: Application not found"** | Verify the **App ID URI** or **Client ID**. |
| **"Invalid SAML Response"** | Check clock sync between IdP and SP; validate certificates. |
| **MFA Prompt Loop** | Exclude the app from Conditional Access or adjust MFA settings. |

## **4. Role-Based Access Control (RBAC)**
### **RBAC in Azure AD**
| Role | Description |
|------|-------------|
| **Global Administrator** | Full access to all Azure AD features. |
| **User Administrator** | Manages users/groups (cannot assign admin roles). |
| **Application Administrator** | Manages app registrations and enterprise apps. |
| **Cloud Application Administrator** | Manages SaaS apps. |
| **Conditional Access Administrator** | Manages Conditional Access policies. |
| **Security Administrator** | Manages security policies (e.g., MFA, Identity Protection). |
| **Privileged Role Administrator** | Manages role assignments in PIM. |

### **Custom Roles**
- Create custom roles in **Azure AD** → **Roles and Administrators** → **New Custom Role**.
- Example: Assign permissions like `microsoft.directory/users/read` or `microsoft.directory/groups/create`.

### **RBAC in Azure Resources**
| Role | Scope | Permissions |
|------|-------|-------------|
| **Owner** | Subscription/Resource Group/Resource | Full access + manage roles. |
| **Contributor** | Subscription/Resource Group/Resource | Full access (no role management). |
| **Reader** | Subscription/Resource Group/Resource | Read-only. |
| **User Access Administrator** | Subscription/Resource Group | Manage user access to resources. |

### **Assign RBAC Roles (Azure CLI)**
```bash
# Assign 'Contributor' role to a user for a resource group
az role assignment create --assignee "jdoe@contoso.com" --role "Contributor" --resource-group "Sales-RG"

# List role assignments
az role assignment list --assignee "jdoe@contoso.com"

# Remove a role assignment
az role assignment delete --assignee "jdoe@contoso.com" --role "Contributor" --resource-group "Sales-RG"
```

### **Privileged Identity Management (PIM)**
- **Just-In-Time (JIT) Access**: Temporary role activation.
- **Approval Workflows**: Require approval for sensitive roles.
- **Access Reviews**: Periodically review role assignments.
- **PIM Commands**:
  ```powershell
  # Activate a role (PowerShell)
  Open-AzureADMSPrivilegedRoleAssignmentRequest -ProviderId aadRoles -ResourceId (Get-AzureADDirectoryRole | Where {$_.DisplayName -eq "Global Administrator"}).ObjectId -RoleDefinitionId (Get-AzureADDirectoryRole | Where {$_.DisplayName -eq "Global Administrator"}).ObjectId -Type UserAdd -AssignmentState Active -Duration 3600 -Reason "Troubleshooting"
  ```

## **5. Conditional Access**
### **Key Policies**
| Policy | Description |
|--------|-------------|
| **MFA for Admins** | Require MFA for all admin roles. |
| **Block Legacy Auth** | Block older protocols (e.g., POP3, IMAP). |
| **Trusted Locations** | Allow access only from corporate IPs. |
| **Device Compliance** | Require Intune-compliant devices. |
| **Risk-Based Policies** | Block or require MFA for high-risk sign-ins. |

### **Example Policy: Require MFA for Azure Portal**
1. Go to **Azure AD** → **Security** → **Conditional Access** → **New Policy**.
2. **Users/Groups**: Select "All Users" or specific groups.
3. **Cloud Apps**: Select "Microsoft Azure Management".
4. **Conditions**: Include "All Device Platforms".
5. **Access Controls**: Grant access → Require MFA.

---
## **6. Application Registration & Permissions**
### **App Registration vs. Enterprise App**
| Feature | App Registration | Enterprise App |
|---------|------------------|----------------|
| **Purpose** | For developers to integrate apps with Azure AD. | For admins to manage SaaS apps. |
| **Permissions** | Defines API permissions (e.g., `User.Read`). | Configures SSO and user access. |
| **Consent** | Requires admin/user consent for permissions. | Assigned to users/groups. |

### **Permission Types**
| Type | Description | Example |
|------|-------------|---------|
| **Delegated** | Act on behalf of a user. | `Mail.Read` (read user’s email). |
| **Application** | Act as the app (no user context). | `User.Read.All` (read all users’ profiles). |

### **Grant Admin Consent (PowerShell)**
```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Application.ReadWrite.All"

# Grant admin consent for an app
New-MgOAuth2PermissionGrant -ClientId "app-client-id" -ConsentType "AllPrincipals" -ResourceId "resource-app-id" -Scope "User.Read.All"
```

## **7. Hybrid Identity**
### **Azure AD Connect Sync Options**
| Option | Description |
|--------|-------------|
| **Password Hash Sync** | Syncs password hashes to Azure AD. |
| **Pass-Through Authentication** | Validates passwords against on-prem AD. |
| **Federation (AD FS)** | Redirects auth to on-prem AD FS. |
| **Seamless SSO** | Automatically signs users into cloud apps when on corporate devices. |

### **Seamless SSO Configuration**
1. Enable in **Azure AD Connect**.
2. Add Azure AD URL (`https://autologon.microsoftazuread-sso.com`) to intranet zones via GPO.
3. Users are silently signed in on corporate devices.

## **8. Security Best Practices**
### **Azure AD**
- Enable **Security Defaults** (enforces MFA for admins).
- Use **Conditional Access** to restrict access.
- Regularly review **Sign-in Logs** and **Audit Logs**.
- Enable **Identity Protection** for risk-based policies.
- Use **Privileged Identity Management (PIM)** for just-in-time access.

### **AD**
- **Tiered Admin Model**: Separate admin accounts for different tiers (e.g., Tier 0 for AD, Tier 1 for servers).
- **LSAss Protection**: Enable to prevent credential theft.
- **Restricted Admin Mode**: For RDP (prevents credential caching).
- **Audit GPO Changes**: Track who modifies Group Policies.

### **SSO**
- **Certificate Rotation**: Renew SAML/OIDC certificates before expiry.
- **Least Privilege**: Assign minimal permissions to apps.
- **Monitor Consent Grants**: Review apps with user-consented permissions.

## **9. Common Interview Questions**
### **Active Directory**
1. **What is the difference between a domain local, global, and universal group?**
   - **Domain Local**: Permissions within the same domain.
   - **Global**: Members from the same domain; permissions across domains.
   - **Universal**: Members from any domain; permissions across forests.

2. **How does Kerberos authentication work?**
   - User requests a **TGT (Ticket Granting Ticket)** from the KDC.
   - TGT is used to request a **service ticket** for the target resource.
   - Service ticket is presented to the resource for access.

3. **What is the purpose of the Global Catalog?**
   - Provides a searchable directory of all objects in the forest (partial replica).

### **Azure AD**
1. **What is the difference between Azure AD and AD DS?**
   - Azure AD is designed for cloud apps (SAML/OAuth), while AD DS is for on-premises (LDAP/Kerberos).

2. **How does Azure AD Connect work?**
   - Syncs on-prem AD objects to Azure AD and can synchronize passwords or use PTA/Federation.

3. **What is Conditional Access?**
   - Policies that enforce controls (e.g., MFA, device compliance) based on conditions (user, location, app risk).

### **SSO**
1. **Explain the SAML authentication flow.**
   - User → SP → IdP (authentication) → SAML assertion → SP (access granted).

2. **What is the difference between OAuth 2.0 and OpenID Connect?**
   - OAuth 2.0 is for **authorization** (delegated access).
   - OpenID Connect is for **authentication** (adds an ID token to OAuth 2.0).

### **RBAC**
1. **What is the principle of least privilege?**
   - Grant users the minimum permissions needed to perform their tasks.

2. **How do you assign a role in Azure RBAC?**
   - Via the Azure Portal, PowerShell (`New-AzRoleAssignment`), or CLI (`az role assignment create`).

### **Troubleshooting**
1. **A user can’t access a SaaS app configured for SSO. How do you troubleshoot?**
   - Check **sign-in logs** in Azure AD.
   - Verify the user is **assigned** to the app.
   - Ensure the **SAML/OIDC configuration** is correct (reply URLs, certificates).
   - Test with another user to isolate the issue.

2. **How do you revoke a user’s access to an Azure resource?**
   - Remove their role assignment via **Azure Portal**, **PowerShell**, or **CLI**.

## **10. Quick Reference Commands**
### **Active Directory (PowerShell)**
```powershell
# Find locked-out accounts
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName

# Force password change on next logon
Set-ADUser -Identity jdoe -ChangePasswordAtLogon $true

# List all GPOs applied to a user
Get-GPResultantSetOfPolicy -ReportType Html -Path "C:\temp\RSOP.html"
```

### **Azure AD (PowerShell)**
```powershell
# List all users with a specific role
Get-AzureADDirectoryRole | Where {$_.DisplayName -eq "Global Administrator"} | Get-AzureADDirectoryRoleMember

# Check MFA status for a user
Get-MsolUser -UserPrincipalName "jdoe@contoso.com" | Select StrongAuthenticationMethods
```

### **Azure CLI (RBAC)**
```bash
# List all role definitions
az role definition list

# Check a user’s permissions on a resource
az role assignment list --assignee "jdoe@contoso.com" --scope "/subscriptions/<sub-id>/resourceGroups/Sales-RG"
```

## **11. Key Ports for AD/Azure AD**
| Service | Port | Protocol |
|---------|------|----------|
| **LDAP** | 389 | TCP/UDP |
| **LDAP (SSL)** | 636 | TCP |
| **Global Catalog** | 3268 | TCP |
| **Global Catalog (SSL)** | 3269 | TCP |
| **Kerberos** | 88 | TCP/UDP |
| **DNS** | 53 | TCP/UDP |
| **RPC Endpoint Mapper** | 135 | TCP |
| **SMB** | 445 | TCP |
| **AD FS** | 443 | TCP (HTTPS) |
| **Azure AD Connect** | 443 | TCP (HTTPS) |

## **12. Acronyms**
| Acronym | Meaning |
|---------|---------|
| **AD** | Active Directory |
| **Azure AD** | Azure Active Directory |
| **SSO** | Single Sign-On |
| **RBAC** | Role-Based Access Control |
| **SAML** | Security Assertion Markup Language |
| **OAuth** | Open Authorization |
| **OIDC** | OpenID Connect |
| **PIM** | Privileged Identity Management |
| **MFA** | Multi-Factor Authentication |
| **GPO** | Group Policy Object |
| **OU** | Organizational Unit |
| **DC** | Domain Controller |
| **GC** | Global Catalog |
| **IDP** | Identity Provider |
| **SP** | Service Provider |
| **PTA** | Pass-Through Authentication |
| **AD FS** | Active Directory Federation Services |
| **JIT** | Just-In-Time |
| **Conditional Access** | CA |

**Final Tip**: For interviews, focus on **real-world scenarios** (e.g., "How would you migrate from AD FS to Azure AD SSO?") and **security best practices**. Practice explaining concepts like **SAML flows** or **Conditional Access policies** in simple terms!
