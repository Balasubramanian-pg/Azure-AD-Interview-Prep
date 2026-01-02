# Single Sign-On (SSO)

## SSO Protocols
- **SAML 2.0**: XML-based for enterprise apps
- **OAuth 2.0**: Delegated authorization for APIs
- **OpenID Connect**: Authentication layer on OAuth 2.0
- **WS-Fed**: Microsoft SOAP-based SSO
- **Kerberos**: Ticket-based for on-prem AD

## SAML SSO Flow
1. User accesses app (SP)
2. SP redirects to IdP with SAML request
3. User authenticates with IdP
4. IdP sends SAML response to SP
5. SP grants access

## Troubleshooting Guide
See troubleshooting.md for common issues and solutions.
