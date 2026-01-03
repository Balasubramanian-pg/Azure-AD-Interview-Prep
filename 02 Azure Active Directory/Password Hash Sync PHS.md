# PASSWORD HASH SYNC PHS

## Introduction  
Password Hash Sync (PHS) is a protocol used to synchronize password hashes between on-premise Active Directory (AD) and Azure Active Directory (Azure AD). This enables single sign-on (SSO) for users accessing cloud services like Office 365, ensuring authentication is performed using their existing domain credentials without exposing plain-text passwords. PHS is part of Microsoft’s hybrid identity solution and is typically configured using **Azure AD Connect**, simplifying the integration of on-premise systems with cloud services. Unlike alternative methods such as Pass-through Authentication (PTA) or federation, PHS does not require infrastructure like AD FS or Azure AD Application Proxy, making it a lightweight synchronization option.

---

## Core Concepts  

### Key Components  
1. **Azure AD Connect**: The software used to configure synchronization between on-premise AD and Azure AD.  
2. **On-Premise Active Directory**: Stores user and password information locally.  
3. **Azure Active Directory**: Stores synchronized password hashes to authenticate users for cloud resources.  

### How PHS Works  
- **Hash Sync Mechanism**: When a user changes their password in AD, only the **password hash** (not the plaintext password) is transmitted to Azure AD.  
- **One-Way Synchronization**: Changes in Azure AD (e.g., password resets) do **not** propagate to on-premise AD.  
- **Authentication Flow**:  
  1. A user attempts to log in to a cloud service.  
  2. Azure AD verifies the entered password by comparing it to the stored hash.  
  3. If the hash matches, access is granted without exposing the plaintext password.  

### Security Considerations  
- **Hash Algorithm**: Uses the NT LAN Manager (NTLM) hash by default.  
- **No Password Replay**: Azure AD never handles plaintext passwords or transmits hashes over insecure channels.  
- **On-Premise Password Policies**: Password expiration, complexity, etc., must be enforced at the on-premise AD level.  

### Key Parameters  
- **Sync Interval**: Password hashes are pushed to Azure AD every **30 minutes by default**, but this can be adjusted.  
- **Account Mismatch**: Users must exist in both directories before synchronization can occur (configured via **Object Sync** in Azure AD Connect).  

---

## Examples  
### Scenario 1: User Password Change  
**On-Premises AD**:  
- A user changes their password via the `Control Panel` or `net user` command.  
- The NTLM hash of the new password is stored in AD.  

**Azure AD Sync**:  
- Azure AD Connect detects the password update and replicates the hash to Azure AD within 30 minutes.  

**Cloud Access**:  
- The user can immediately log in to Office 365 using their updated password, without needing to reset it in Azure AD separately.  

---

### Scenario 2: Configuration via Azure AD Connect  
1. **Install Azure AD Connect**: Deploy the tool on a domain-joined computer with internet access.  
2. **Select Synchronization Options**:  
   - Choose **Password Writeback** to enable password resets in Azure AD propagating back to on-premise AD (optional but strongly recommended for PHS use).  
   - Select **Password Hash Sync** during the customization phase.  
3. **Configure Authentication**: Ensure the synchronization account has permissions to read passwords from AD.  
4. **Test Sync**: Use `Test-AzureADConnectSyncConfiguration` to verify connectivity and synchronization rules.  

---

### Scenario 3: Troubleshooting Issues  
**Problem**: Users report needing to reset passwords in Azure AD even after on-premise changes.  
**Solution**:  
- Check the last synchronization time in Azure AD Connect.  
- Ensure the synchronization service (`Azure AD Sync`) is running and no firewall rules block outbound HTTPS requests.  

---

### Example Command for Status Check  
```powershell  
# View sync status  
SyncSvcManager get status  

# Run synchronization manually  
SyncSvcManager run /force  
```  

---

## Summary  
- **Primary Use Case**: Enabling seamless cloud authentication using on-premise password policies.  
- **Key Advantages**:  
  - Lightweight and easy to configure compared to federation with AD FS.  
  - Eliminates the need for users to remember separate passwords.  
- **Limitations**:  
  - Password changes initiated in Azure AD do **not** propagate to on-premise AD (requires **Password Writeback** add-on).  
  - Dependent on scheduled synchronization, so changes may take up to 30 minutes to propagate.  
- **Alternatives**:  
  - **Pass-through Authentication (PTA)**: For on-premise validation without storing hashes in Azure AD.  
  - **Federation (ADFS)**: Provides robust integration with more control over authentication processes.  

PHS is ideal for organizations prioritizing simplicity over advanced features, while PTA or AD FS are preferred for environments requiring stricter policy enforcement or real-time password validation. Always ensure compliance with NTLM hash security recommendations as part of a robust SSO strategy.

---
*Generated by Puter.js & Qwen*