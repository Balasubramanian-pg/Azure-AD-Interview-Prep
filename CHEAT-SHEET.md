# Active Directory & Azure AD Cheat Sheet

## Quick Reference

### Key Ports
- LDAP: 389 (TCP/UDP)
- LDAP SSL: 636 (TCP)
- Kerberos: 88 (TCP/UDP)
- DNS: 53 (TCP/UDP)
- SMB: 445 (TCP)

### Acronyms
- AD: Active Directory
- Azure AD: Azure Active Directory
- SSO: Single Sign-On
- RBAC: Role-Based Access Control
- SAML: Security Assertion Markup Language
- OAuth: Open Authorization
- OIDC: OpenID Connect
- PIM: Privileged Identity Management
- MFA: Multi-Factor Authentication
- GPO: Group Policy Object
- OU: Organizational Unit
- DC: Domain Controller

### Azure AD Connect Sync Options
- **Password Hash Sync**: Syncs password hashes to Azure AD
- **Pass-Through Authentication**: Validates passwords against on-prem AD
- **Federation (AD FS)**: Redirects auth to on-prem AD FS
- **Seamless SSO**: Auto sign-in on corporate devices

For detailed commands and explanations, see the relevant folders.
