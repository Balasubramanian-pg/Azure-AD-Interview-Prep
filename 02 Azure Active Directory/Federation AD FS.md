# [Federation AD FS](02 Azure Active Directory/Federation AD FS.md)

Canonical documentation for [Federation AD FS](02 Azure Active Directory/Federation AD FS.md). This document defines concepts, terminology, and standard usage.

## Purpose
[Federation AD FS](02 Azure Active Directory/Federation AD FS.md) (Active Directory Federation Services) exists to provide a standardized framework for extending local identity and access management (IAM) across organizational boundaries. It addresses the problem of identity fragmentation by enabling Single Sign-On (SSO) and secure identity delegation between disparate systems, platforms, and organizations without requiring the synchronization of sensitive credential data (such as passwords) to external parties.

By utilizing a claims-based identity model, [Federation AD FS](02 Azure Active Directory/Federation AD FS.md) allows an organization to maintain authoritative control over its user accounts while securely asserting the identity and attributes of those users to external "Relying Parties" (RPs).

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative, focusing on the architectural and logical framework of AD FS rather than specific software versioning or installation procedures.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   **Claims-Based Identity Model:** The fundamental logic of using assertions to communicate identity.
*   **Trust Relationships:** The establishment of cryptographic and logical links between Identity Providers (IdP) and Relying Parties (RP).
*   **Protocol Standards:** The utilization of SAML, WS-Federation, and OAuth/OpenID Connect within the federation context.
*   **Claims Transformation:** The logic governing how identity attributes are mapped, filtered, and issued.

**Out of scope:**
*   **Hardware/OS Specifications:** Specific server requirements or Windows Server version-specific UI instructions.
*   **Network Topology:** Detailed firewall configurations or load balancer hardware settings.
*   **Third-Party IdP Configuration:** Specific setup guides for external vendors (e.g., Okta, Ping, AWS) except where they act as a generic Relying Party.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | The entity that authenticates the user and issues security tokens containing claims. |
| **Relying Party (RP)** | The application or service that consumes claims from an IdP to make authorization decisions. |
| **Claim** | A statement made by an IdP about a subject (e.g., email address, group membership, or role). |
| **Security Token Service (STS)** | The functional component that issues, validates, and renews security tokens based on established trust. |
| **Federation Metadata** | An XML document containing the configuration, certificates, and endpoints required to establish a trust relationship. |
| **Claims Provider Trust** | A configuration that allows the federation service to accept claims from an external IdP. |
| **Relying Party Trust** | A configuration that defines how the federation service issues claims to a specific application. |
| **Home Realm Discovery (HRD)** | The process by which the federation service determines which IdP a user should use for authentication. |

## Core Concepts

### Claims-Based Identity
The core of [Federation AD FS](02 Azure Active Directory/Federation AD FS.md) is the abstraction of identity into "claims." Instead of an application querying a database for a user's password, the application receives a digitally signed token. This token contains specific attributes (claims) that the application trusts because they were issued by a known, trusted authority.

### The Trust Anchor
Federation relies on a "Chain of Trust." Both the IdP and the RP must exchange cryptographic material (usually X.509 certificates) to ensure that tokens cannot be forged or tampered with in transit. This trust is typically established via the exchange of Federation Metadata.

### Claims Pipeline
The Claims Pipeline is the logical engine that processes identity data. It consists of three primary stages:
1.  **Acceptance Rules:** Determining which claims to accept from the incoming source.
2.  **Authorization Rules:** Determining if the user is permitted to receive a token for the requested resource.
3.  **Issuance Rules:** Determining which claims will be included in the final outgoing token and how they are formatted.

## Standard Model

The standard model for [Federation AD FS](02 Azure Active Directory/Federation AD FS.md) follows the **Passive Requestor Profile** (browser-based) or the **Active Requestor Profile** (application-based).

1.  **Request:** A user attempts to access a Relying Party (RP).
2.  **Redirection:** The RP redirects the user to the Federation Service (IdP).
3.  **Authentication:** The user authenticates against the local directory (e.g., Active Directory) or a secondary Claims Provider.
4.  **Token Issuance:** The Federation Service generates a signed security token (SAML/JWT) containing the requested claims.
5.  **Submission:** The user's browser/client submits the token to the RP.
6.  **Consumption:** The RP validates the signature, extracts the claims, and grants access based on its internal logic.

## Common Patterns

### Web Single Sign-On (SSO)
The most frequent pattern where a user logs in once to their corporate network and gains access to multiple internal and external web applications without re-entering credentials.

### Federation Provider (IdP Proxy)
AD FS acts as an intermediary. It accepts claims from an external IdP (like a partner organization or a social provider) and transforms them into claims that internal applications can understand.

### OAuth 2.0 / OpenID Connect (OIDC)
Modern applications use AD FS as an Authorization Server to issue Access Tokens and ID Tokens, enabling secure access to Web APIs and modern mobile/single-page applications.

## Anti-Patterns

*   **Over-Provisioning Claims:** Issuing more user data than the Relying Party requires. This violates the principle of least privilege and increases the risk of data exposure.
*   **Bypassing MFA for Internal Users:** Assuming that "internal" network status is a sufficient proxy for identity verification. Multi-Factor Authentication (MFA) should be enforced at the Federation layer regardless of location.
*   **Hardcoding Claims Logic:** Creating complex, non-standard claim rules that are difficult to audit or migrate.
*   **Using AD FS as a Primary User Store:** Attempting to use the federation service to manage user accounts directly, rather than acting as a gateway to an authoritative directory.

## Edge Cases

### Home Realm Discovery (HRD) Loops
In complex environments with multiple Claims Providers, a user may be bounced between providers if HRD is not correctly configured, leading to an "infinite redirect" loop.

### Clock Skew
Security tokens have a "Not Before" and "Not On Or After" timestamp. If the system clocks of the IdP and RP are out of sync by more than the allowed threshold (usually 5 minutes), the token will be rejected as invalid.

### Certificate Rollover
When the Token-Signing or Token-Decrypting certificates expire, the trust relationship breaks immediately unless the Relying Party is capable of automatically consuming updated Federation Metadata.

## Related Topics
*   **SAML (Security Assertion Markup Language):** The XML-based standard for exchanging authentication and authorization data.
*   **OAuth 2.0 / OIDC:** The industry-standard protocol for authorization and identity layers.
*   **Directory Services (LDAP/Active Directory):** The authoritative source of identity data.
*   **Public Key Infrastructure (PKI):** The underlying system for managing the certificates used in federation.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |