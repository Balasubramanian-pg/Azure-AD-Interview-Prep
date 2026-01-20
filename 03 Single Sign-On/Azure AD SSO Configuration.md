# [Azure AD SSO Configuration](03 Single Sign-On/Azure AD SSO Configuration.md)

Canonical documentation for [Azure AD SSO Configuration](03 Single Sign-On/Azure AD SSO Configuration.md). This document defines concepts, terminology, and standard usage.

## Purpose
Azure AD Single Sign-On (SSO) configuration exists to solve the problem of identity fragmentation and authentication friction within an enterprise ecosystem. By establishing a centralized identity authority, organizations can eliminate the need for multiple sets of credentials, reduce the attack surface associated with password fatigue, and provide a seamless transition for users moving between disparate applications. 

The primary objective of this configuration is to establish a cryptographically secure trust relationship between an Identity Provider (IdP) and a Service Provider (SP), ensuring that identity assertions are authentic, integral, and authorized.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative. While "Azure AD" is the historical nomenclature, these principles apply to its evolution as Microsoft Entra ID.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   **Protocol Standards:** The theoretical application of [SAML 2.0](03 Single Sign-On/SAML 2.0.md), OpenID Connect (OIDC), and [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) within the Azure AD framework.
*   **Trust Architecture:** The mechanics of exchanging metadata, certificates, and identifiers to establish a secure handshake.
*   **Attribute Mapping:** The logic of transforming directory attributes into application-readable claims.
*   **Token Lifecycle:** The conceptual flow of issuance, validation, and expiration of identity assertions.

**Out of scope:**
*   **Vendor-Specific UI Guides:** Step-by-step instructions for specific third-party SaaS applications (e.g., "How to configure Salesforce").
*   **Network Infrastructure:** Configuration of firewalls, proxies, or local ISP routing.
*   **On-Premises Legacy Auth:** Detailed configuration of NTLM or [Kerberos](03 Single Sign-On/Kerberos.md), except where they interface with modern federation.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | The authoritative system that stores identity information and performs the actual authentication (Azure AD). |
| **Service Provider (SP)** | The application or resource that relies on the IdP to verify the identity of a user. Also known as a Relying Party (RP). |
| **Assertion / Token** | A cryptographically signed security object issued by the IdP containing user identity and privilege information. |
| **Claim** | A specific piece of information about a user (e.g., Email, Department, Role) packaged within a token. |
| **Metadata** | An XML or JSON document provided by both the IdP and SP to exchange configuration details like endpoints and public keys. |
| **Redirect URI** | The specific location where the IdP sends the security token after successful authentication. |
| **Identifier (Entity ID)** | A unique string that identifies the SP to the IdP and vice versa, ensuring the request is intended for the correct party. |

## Core Concepts

### Federation Trust
The foundation of SSO is the federation trust. This is not a persistent connection but a logical agreement where the SP agrees to honor identities verified by the IdP. This trust is secured via Public Key Infrastructure (PKI), where the IdP signs assertions with a private key, and the SP validates them using a corresponding public key.

### Protocol Selection
*   **[SAML 2.0](03 Single Sign-On/SAML 2.0.md):** An XML-based standard typically used for enterprise web applications. It is robust and supports complex attribute requirements.
*   **OIDC / [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md):** A modern, JSON-based layer on top of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md). It is preferred for mobile applications, single-page apps (SPAs), and modern API-driven architectures.

### Identity Mapping
The process of correlating a unique identifier in the IdP (such as a User Principal Name or ImmutableID) to the unique identifier expected by the SP. This ensures that "User A" in Azure AD is correctly recognized as "User A" in the target application.

## Standard Model

The standard model for Azure AD SSO follows the **Indirect Redirection Pattern**:

1.  **Request:** The user attempts to access the SP.
2.  **Challenge:** The SP identifies the user's home realm and redirects the user's browser to the Azure AD Auth Endpoint with an Authentication Request.
3.  **Authentication:** Azure AD challenges the user for credentials (and potentially multi-factor authentication).
4.  **Token Issuance:** Upon success, Azure AD generates a signed token and redirects the browser back to the SP's Assertion Consumer Service (ACS) URL.
5.  **Validation:** The SP validates the token's signature against the IdP's public certificate and grants access.

## Common Patterns

### SP-Initiated SSO
The user starts at the application login page. The application redirects to Azure AD for authentication. This is the most common and recommended pattern as it supports deep-linking.

### IdP-Initiated SSO
The user starts at the Azure AD portal (My Apps) and clicks an application icon. Azure AD sends a proactive POST request to the application with a token. 

### Just-In-Time (JIT) Provisioning
A pattern where the SP automatically creates a user record the first time a user logs in via SSO, using the claims provided in the SAML/OIDC token to populate the user profile.

## Anti-Patterns

*   **Hardcoded Redirect URIs:** Using static, non-configurable URIs in code rather than environment-specific variables, leading to environment mismatch.
*   **Over-Provisioning Claims:** Including sensitive user data in the token that the application does not require for functionality, increasing the risk of data exposure.
*   **Bypassing MFA at the SP Level:** Relying on the SP to perform MFA after the IdP has already authenticated the user, creating a fragmented and frustrating user experience.
*   **Using Wildcard Redirect URIs:** Configuring `https://*.contoso.com` as a redirect URI, which allows attackers to intercept tokens via malicious subdomains.

## Edge Cases

### Guest Users (B2B)
When a user from an external tenant accesses an application via SSO. The configuration must account for the `userType` attribute and ensure the SP can handle identities where the issuer is not the local tenant.

### Certificate Expiration
The trust relationship relies on certificates that expire. Failure to implement a rollover strategy (manual or automated) results in immediate SSO failure across all users for that specific application.

### Multi-Tenant Applications
Applications designed to serve multiple Azure AD tenants simultaneously. These require a dynamic "common" endpoint for authentication rather than a tenant-specific GUID.

## Related Topics
*   **SCIM (System for Cross-domain Identity Management):** For automated user provisioning/deprovisioning.
*   **Conditional Access:** For applying granular security policies before an SSO token is issued.
*   **Managed Identities:** For service-to-service authentication without shared secrets.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |