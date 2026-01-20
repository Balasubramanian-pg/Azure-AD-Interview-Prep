# [Configure SSO](03 Single Sign-On/Configure SSO.md)

Canonical documentation for [Configure SSO](03 Single Sign-On/Configure SSO.md). This document defines concepts, terminology, and standard usage.

## Purpose
The configuration of Single Sign-On (SSO) addresses the fragmentation of identity management across disparate systems. By decoupling the authentication process from individual applications and centralizing it within a dedicated authority, SSO reduces the attack surface, minimizes credential fatigue for users, and provides administrators with a single point of control for access lifecycle management. It transforms the relationship between a user and a suite of services from multiple isolated logins into a unified federated session.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* Establishing trust relationships between entities.
* Exchange of identity metadata and assertions.
* Standardized authentication flows (SP-initiated and IdP-initiated).
* Identity propagation and attribute mapping.
* Session management and termination (Single Logout).

**Out of scope:**
* Specific vendor implementations (e.g., Okta, Azure AD, Auth0).
* Detailed code snippets for specific programming languages.
* Hardware-level authentication protocols (e.g., low-level FIDO2/WebAuthn implementation details).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | The authoritative system that authenticates the user and issues identity assertions. |
| **Service Provider (SP)** | The application or resource that relies on the IdP to verify the identity of a user. Also known as a Relying Party (RP). |
| **Assertion / Token** | A cryptographically signed package of data sent by the IdP to the SP containing user identity and attribute information. |
| **Metadata** | An XML or JSON document exchanged between IdP and SP to establish trust, containing endpoints, certificates, and entity IDs. |
| **Trust Relationship** | The mathematical and administrative agreement where an SP agrees to honor assertions signed by a specific IdP. |
| **Binding** | The mechanism by which messages are transported between parties (e.g., HTTP POST, HTTP Redirect). |
| **Claim / Attribute** | Specific pieces of information about a user (e.g., email, group membership) contained within an assertion. |

## Core Concepts

### Federation
Federation is the practice of linking a user's identity across multiple distinct security domains. In an SSO configuration, federation allows a user to maintain a single set of credentials while accessing resources owned by different organizations or business units.

### The Circle of Trust
A configuration is only valid when both the IdP and the SP recognize each other's unique identifiers (Entity IDs) and possess the necessary public keys to validate digital signatures. This "Circle of Trust" ensures that the SP only accepts identities from a verified source.

### Identity Propagation
Beyond simple authentication, SSO configuration involves the transmission of user attributes. This allows the SP to not only know *who* the user is but also what permissions or roles they should be granted based on data managed by the IdP.

## Standard Model

The standard model for SSO configuration follows a structured exchange of trust and a redirection-based authentication flow.

1.  **Trust Establishment:** The administrator exchanges Metadata between the IdP and SP. This includes the exchange of Public Key Infrastructure (PKI) certificates to ensure non-repudiation and integrity.
2.  **The Authentication Request:**
    *   **SP-Initiated:** The user visits the SP; the SP redirects the user to the IdP with an Authentication Request.
    *   **IdP-Initiated:** The user logs into an IdP portal and selects the SP, triggering an unsolicited assertion.
3.  **Challenge and Validation:** The IdP challenges the user (via password, MFA, etc.). Upon success, the IdP generates a signed Assertion.
4.  **Assertion Consumption:** The user’s browser delivers the Assertion to the SP’s Assertion Consumer Service (ACS) URL. The SP validates the signature against the stored IdP certificate.
5.  **Session Creation:** The SP establishes a local session for the user based on the validated identity.

## Common Patterns

### [SAML 2.0](03 Single Sign-On/SAML 2.0.md) (Security Assertion Markup Language)
An XML-based standard widely used in enterprise environments. It is robust and supports complex attribute mapping and formal metadata exchanges.

### OIDC (OpenID Connect)
An identity layer built on top of the [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) protocol. It uses JSON/JWT (JSON Web Tokens) and is preferred for modern web and mobile applications due to its lightweight nature and ease of integration with RESTful APIs.

### Just-in-Time (JIT) Provisioning
A pattern where the SP automatically creates a user record the first time a user authenticates via SSO, using the attributes provided in the assertion. This eliminates the need for manual user pre-provisioning.

## Anti-Patterns

*   **Hardcoded Endpoints:** Using static URLs instead of dynamic metadata exchange, leading to breakage when certificates rotate or endpoints change.
*   **Ignoring Signature Validation:** Accepting assertions without verifying the cryptographic signature against the trusted IdP certificate.
*   **Over-reliance on SP-Initiated Flow:** Failing to account for IdP-initiated entry points, which can lead to "Deep Linking" failures.
*   **Insecure Attribute Mapping:** Mapping sensitive roles (e.g., "SuperAdmin") based on mutable or easily spoofed user attributes.
*   **Lack of SLO (Single Logout):** Terminating the SP session but leaving the IdP session active, allowing subsequent users on a shared device to access the SP without re-authentication.

## Edge Cases

*   **Clock Skew:** If the system clocks of the IdP and SP are out of sync, assertions may be rejected as "not yet valid" or "expired." Standard configurations usually allow a 3–5 minute buffer.
*   **Certificate Rotation:** When an IdP certificate expires, the trust relationship breaks unless the SP is configured with the new public key in advance.
*   **Deep Linking:** A user attempts to access a specific resource URL within the SP while unauthenticated. The SSO configuration must ensure the user is returned to that specific URL after the IdP handshake, rather than the application root.
*   **Multi-Tenant IdPs:** Scenarios where a single SP must support multiple IdPs (e.g., a SaaS application supporting different customers' unique IdPs). This requires a "Discovery Service" or "Home Realm Discovery" (HRD) to determine which IdP to use.

## Related Topics

*   **Identity Lifecycle Management (ILM):** The broader process of provisioning and deprovisioning users.
*   **Multi-Factor Authentication (MFA):** Often integrated into the IdP phase of the SSO flow.
*   **[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md):** The authorization framework upon which OIDC is built.
*   **Directory Services (LDAP/AD):** The underlying data stores that often feed the IdP.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |