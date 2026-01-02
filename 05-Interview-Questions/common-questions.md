# Common Interview Questions

## Active Directory

**Q: What is the difference between domain local, global, and universal groups?**
- Domain Local: Permissions within the same domain
- Global: Members from same domain; permissions across domains
- Universal: Members from any domain; permissions across forests

**Q: How does Kerberos authentication work?**
1. User requests TGT from KDC
2. TGT is used to request service ticket
3. Service ticket presented to resource for access

## Azure AD

**Q: What is the difference between Azure AD and AD DS?**
- Azure AD: Cloud-based, OAuth/SAML, flat structure
- AD DS: On-premises, LDAP/Kerberos, hierarchical

**Q: How does Azure AD Connect work?**
Syncs on-prem AD objects to Azure AD with Password Hash Sync, Pass-Through Auth, or Federation

**Q: What is Conditional Access?**
Policies enforcing controls (MFA, device compliance) based on conditions (user, location, app risk)

## SSO

**Q: Explain SAML authentication flow**
User → SP → IdP (auth) → SAML assertion → SP (access granted)

**Q: OAuth 2.0 vs OpenID Connect?**
- OAuth 2.0: Authorization (delegated access)
- OpenID Connect: Authentication (adds ID token to OAuth)

## RBAC

**Q: What is the principle of least privilege?**
Grant users minimum permissions needed for their tasks

**Q: How to assign a role in Azure RBAC?**
Via Portal, PowerShell (New-AzRoleAssignment), or CLI (az role assignment create)
