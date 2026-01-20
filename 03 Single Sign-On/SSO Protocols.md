# [SSO Protocols](03 Single Sign-On/SSO Protocols.md)

Canonical documentation for [SSO Protocols](03 Single Sign-On/SSO Protocols.md). This document defines concepts, terminology, and standard usage.

## Purpose
Single Sign-On (SSO) protocols exist to solve the problem of identity fragmentation across distributed systems. In a modern computing environment, users interact with multiple independent applications. Without SSO, each application must manage its own user directory and authentication logic, leading to "password fatigue," increased security risks, and administrative overhead.

SSO protocols provide a standardized framework for an entity (the Identity Provider) to attest to the identity of a user to another entity (the Service Provider or Relying Party). This allows a user to authenticate once and gain access to multiple disparate systems without re-entering credentials, thereby centralizing identity management and improving the security posture of the entire ecosystem.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* Core functionality of identity federation and exchange.
* Theoretical boundaries of authentication vs. authorization within SSO.
* Standard message formats (XML, JSON) and transport mechanisms.
* Trust establishment models between participating entities.

**Out of scope:**
* Specific vendor implementations (e.g., Okta, Azure AD, Auth0).
* Programming language-specific SDKs or libraries.
* User interface (UI) or User Experience (UX) design for login screens.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | The authoritative system that authenticates the user and issues identity assertions or tokens. |
| **Service Provider (SP)** | The application or resource that provides services to the user and relies on the IdP for authentication. |
| **Relying Party (RP)** | A term often used interchangeably with SP, specifically in OIDC contexts, denoting the entity that "relies" on the IdP's claims. |
| **Assertion / Claim** | A statement issued by an IdP about a subject (user), typically containing identity attributes and authentication context. |
| **Subject** | The entity (usually a human user) whose identity is being asserted. |
| **Trust Relationship** | A pre-configured agreement where an SP agrees to honor assertions issued by a specific IdP, usually established via exchange of metadata or public keys. |
| **Binding** | The mapping of protocol messages onto standard messaging formats or transport protocols (e.g., HTTP POST binding). |
| **Metadata** | An XML or JSON document describing the capabilities, endpoints, and security keys of an IdP or SP. |

## Core Concepts

### Identity Federation
Federation is the practice of linking a user's identity across multiple distinct identity management systems. SSO protocols are the technical realization of federation, allowing an identity managed in "Domain A" to be recognized and trusted in "Domain B."

### Decoupling of Concerns
SSO protocols decouple the **Authentication** (verifying who the user is) from the **Application Logic** (what the user does). The application no longer handles passwords; it only handles the proof of identity provided by the IdP.

### Tokens and Assertions
Identity information is transmitted via structured data packages. These packages are digitally signed to ensure integrity and authenticity.
*   **SAML Assertions:** XML-based documents used primarily in enterprise web environments.
*   **OIDC ID Tokens:** JSON Web Tokens (JWT) optimized for modern web and mobile applications.

### Front-Channel vs. Back-Channel
*   **Front-Channel:** Communication occurs via the user's browser (e.g., HTTP redirects). This is visible to the user but allows for seamless transitions between domains.
*   **Back-Channel:** Direct server-to-server communication. This is more secure as the data does not pass through the user's browser, preventing certain types of interception.

## Standard Model
The standard model for SSO involves a triangular relationship between the **User (User Agent)**, the **Service Provider (SP)**, and the **Identity Provider (IdP)**.

1.  **Request:** The user attempts to access a protected resource on the SP.
2.  **Challenge:** The SP detects the user is not authenticated and redirects the User Agent to the IdP with an Authentication Request.
3.  **Authentication:** The IdP authenticates the user (via password, MFA, etc.).
4.  **Assertion:** Upon success, the IdP generates an assertion/token and sends it back to the User Agent, which forwards it to the SP.
5.  **Validation:** The SP validates the digital signature of the assertion using the IdP’s public key.
6.  **Access:** If valid, the SP establishes a local session for the user and grants access.

## Common Patterns

### SP-Initiated SSO
The user navigates directly to the application (SP) first. The SP recognizes the user is unauthenticated and triggers the SSO flow by sending the user to the IdP. This is the most common pattern for SaaS applications.

### IdP-Initiated SSO
The user logs into a central portal (IdP) first and clicks a link to an application. The IdP "pushes" the assertion to the SP. While convenient, this pattern is more susceptible to Man-in-the-Middle (MitM) attacks if not implemented with strict security controls.

### Just-In-Time (JIT) Provisioning
A pattern where the SP automatically creates a local user record the first time a user logs in via SSO, using the attributes provided in the assertion (e.g., email, name, department).

## Anti-Patterns

### Using [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) for Authentication
[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) is an **authorization** framework, not an authentication protocol. Using an Access Token as proof of identity without the OpenID Connect (OIDC) layer is a security flaw, as Access Tokens do not inherently contain identity information or audience restrictions.

### Hardcoding Metadata
Manually hardcoding IdP certificates or endpoints within application code. This leads to system failure when certificates expire or endpoints change. Standard practice dictates using dynamic metadata URLs or configuration files.

### Long-Lived Sessions without Revocation
Maintaining an SP session indefinitely without checking the status of the IdP session. If a user is terminated or their account is locked at the IdP, the SP should have a mechanism (like short-lived tokens or SLO) to terminate access.

### Passing Sensitive Data in URLs
Transmitting assertions or sensitive identifiers via URL query parameters, which are often logged in browser history and server logs.

## Edge Cases

### Single Logout (SLO)
While SSO handles logging in, "logging out" is significantly more complex. SLO attempts to terminate sessions across all SPs when a user logs out of the IdP. This often fails due to browser cookie restrictions, network timeouts, or SPs not supporting the SLO profile.

### Deep Linking
When a user clicks a link to a specific resource within an SP (e.g., `app.com/reports/123`) but is not logged in. The SSO flow must be able to preserve the "RelayState" or "Target URL" so the user is returned to the specific resource after authentication, rather than the application home page.

### Clock Skew
SSO assertions are time-bound (NotBefore and NotOnOrAfter). If the system clocks of the IdP and SP are not synchronized, assertions may be rejected as "expired" or "not yet valid" even if they were just issued.

## Related Topics
*   **[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md):** The underlying framework for OIDC, focused on delegated authorization.
*   **SCIM (System for Cross-domain Identity Management):** A protocol for automating the exchange of user identity information between identity domains (Provisioning).
*   **MFA (Multi-Factor Authentication):** Often integrated into the IdP phase of the SSO flow.
*   **RBAC/ABAC:** Access control models used by the SP to determine what a user can do after SSO has identified who they are.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |