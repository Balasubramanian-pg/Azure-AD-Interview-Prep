# WS Fed

Canonical documentation for WS Fed. This document defines concepts, terminology, and standard usage.

## Purpose
[WS-Fed](03 Single Sign-On/WS-Fed.md)eration (WS-Fed) is a protocol designed to facilitate the exchange of identity and security information across different security realms or trust boundaries. It exists to solve the problem of identity fragmentation in distributed systems, allowing a user authenticated in one domain (the Identity Provider) to access resources in another domain (the Relying Party) without requiring a local account or re-authentication.

By leveraging the WS-Trust and WS-Security frameworks, [WS-Fed](03 Single Sign-On/WS-Fed.md) provides a standardized mechanism for requesting, issuing, and validating security tokens, thereby enabling Single Sign-On (SSO) and federated identity management in heterogeneous environments.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   The Passive Requestor Profile (Web-based SSO).
*   The relationship between [WS-Fed](03 Single Sign-On/WS-Fed.md)eration and the WS-* stack (WS-Trust, WS-Security).
*   Protocol-level message parameters and flow logic.
*   The concept of Claims-based identity within the federation context.

**Out of scope:**
*   Specific vendor implementations (e.g., AD FS, Azure AD, PingFederate).
*   Configuration guides for specific web servers or application frameworks.
*   Detailed specifications of the underlying WS-Trust SOAP headers (except where necessary for context).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | An entity that authenticates users and issues security tokens containing claims about those users. |
| **Relying Party (RP)** | An application or service that consumes security tokens from an IdP to make authorization decisions. |
| **Security Token Service (STS)** | A service component that issues, validates, renews, and cancels security tokens based on the WS-Trust standard. |
| **Claim** | A statement about a subject (e.g., name, email, role) made by an issuer. |
| **Realm** | A logical boundary or domain that defines the scope of a security policy or identity management system. |
| **Passive Requestor** | An agent (typically a web browser) that is incapable of understanding complex SOAP protocols and relies on HTTP redirects and form posts. |
| **Wtrealm** | A parameter identifying the target realm (the RP) for which the token is intended. |
| **Wresult** | The parameter containing the issued security token (usually a RSTR) in the response. |

## Core Concepts

### Claims-Based Identity
[WS-Fed](03 Single Sign-On/WS-Fed.md)eration operates on the principle of claims-based identity. Rather than the application managing user credentials, it trusts an external authority (the IdP) to provide a set of "claims" about the user. The application then maps these claims to internal permissions.

### Federation Trust
A federation trust is a formal relationship established between an IdP and an RP. This trust is typically secured via cryptographic certificates. The RP trusts tokens signed by the IdP's private key, and the IdP knows where to send users based on the RP's registered realm and endpoint.

### The WS-* Foundation
[WS-Fed](03 Single Sign-On/WS-Fed.md)eration is an extension of the Web Services (WS-*) roadmap. It specifically utilizes:
*   **WS-Trust:** For the format of the token request and response (RST/RSTR).
*   **WS-Security:** For securing the message content (signing and encryption).

## Standard Model

### The Passive Requestor Profile (Web SSO)
The most common application of [WS-Fed](03 Single Sign-On/WS-Fed.md) is the Passive Requestor Profile, which uses standard HTTP mechanisms (GET, POST, Redirects) to facilitate SSO for web browsers.

1.  **Request:** A user attempts to access a protected resource on the RP.
2.  **Redirect:** The RP detects the user is unauthenticated and redirects the browser to the IdP with a `wa=wsignin1.0` action and a `wtrealm` parameter.
3.  **Authentication:** The IdP authenticates the user (via password, MFA, etc.).
4.  **Token Issuance:** The IdP generates a Security Token (often SAML 1.1 or 2.0) wrapped in a `RequestSecurityTokenResponse` (RSTR).
5.  **Response:** The IdP sends an HTTP POST containing the `wresult` (the RSTR) back to the RP's endpoint.
6.  **Validation:** The RP validates the signature of the token, extracts the claims, and establishes a local session for the user.

## Common Patterns

### Home Realm Discovery (HRD)
In scenarios where an RP trusts multiple IdPs, the RP must determine which IdP the user belongs to. This is often handled via an intermediary page (HRD) where the user selects their organization or enters an email suffix to trigger the correct redirect.

### Single Sign-Out
[WS-Fed](03 Single Sign-On/WS-Fed.md)eration supports a standardized sign-out flow using the `wa=wsignout1.0` action. This notifies the IdP to terminate the session and, optionally, notify other RPs that the user has logged out (Sign-Out Cleanup).

### Token Transformation
An STS may act as a "Federation Provider" (FP), sitting between an RP and a master IdP. The FP receives a token from the IdP, transforms the claims (e.g., renaming "UID" to "NameID"), and issues a new token to the RP.

## Anti-Patterns

### Hardcoding Endpoints
Relying on hardcoded URLs for IdPs or RPs rather than using metadata exchange or dynamic configuration makes the federation fragile and difficult to maintain during certificate rotations or infrastructure changes.

### Ignoring Token Expiration
Failing to validate the `NotBefore` and `NotOnOrAfter` attributes within the security token allows for replay attacks or the use of stale identity data.

### Over-reliance on Browser State
Assuming that a session at the IdP automatically implies a valid session at the RP (or vice versa) without proper protocol-level verification can lead to "zombie sessions" where a user remains logged into an application after their central identity has been revoked.

## Edge Cases

### Large Token Sizes
Because [WS-Fed](03 Single Sign-On/WS-Fed.md) responses (the `wresult`) are often passed via HTTP POST, very large tokens (containing hundreds of group claims) can exceed web server header or post-body limits, leading to HTTP 400 or 413 errors.

### Nested Federation
In complex corporate mergers, a user might authenticate at IdP-A, which federates to IdP-B, which finally issues a token to the RP. Each hop must correctly preserve the original subject's identity while adhering to the trust constraints of the next hop.

### Clock Skew
If the system clocks of the IdP and RP are not synchronized, valid tokens may be rejected as "not yet valid" or "expired." Standard practice is to allow a 3-5 minute "skew" buffer during validation.

## Related Topics
*   **SAML (Security Assertion Markup Language):** Often used as the token format within [WS-Fed](03 Single Sign-On/WS-Fed.md)eration.
*   **WS-Trust:** The underlying protocol for requesting and issuing security tokens.
*   **[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) / OpenID Connect:** Modern alternatives to [WS-Fed](03 Single Sign-On/WS-Fed.md)eration, typically used for REST APIs and mobile applications.
*   **WS-Policy:** Used to describe the requirements and capabilities of the entities in a federation.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |