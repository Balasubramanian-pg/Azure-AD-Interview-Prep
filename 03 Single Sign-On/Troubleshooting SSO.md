# [Troubleshooting SSO](03 Single Sign-On/Troubleshooting SSO.md)

Canonical documentation for [Troubleshooting SSO](03 Single Sign-On/Troubleshooting SSO.md). This document defines concepts, terminology, and standard usage.

## Purpose
The purpose of [Troubleshooting SSO](03 Single Sign-On/Troubleshooting SSO.md) (Single Sign-On) is to identify, diagnose, and resolve failures in the federated identity lifecycle. SSO systems exist to allow a single set of credentials to grant access to multiple independent software systems. Because this process involves a "Chain of Trust" between disparate entities—typically an Identity Provider (IdP) and a Service Provider (SP)—failures often occur at the boundaries of these systems. Troubleshooting this domain requires a systematic analysis of protocol handshakes, token integrity, and attribute mapping.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   **Protocol Integrity:** Validation of SAML, OIDC, and OAuth2 exchange patterns.
*   **Trust Establishment:** Verification of certificates, metadata, and cryptographic signatures.
*   **Identity Propagation:** Analysis of how user attributes are passed and mapped between systems.
*   **Session Management:** Troubleshooting the persistence and termination of authenticated states.

**Out of scope:**
*   **Specific Vendor Implementations:** Step-by-step guides for specific products (e.g., Okta, Azure AD, PingIdentity).
*   **Network Layer Issues:** General DNS or firewall troubleshooting, unless specifically related to SSO endpoints.
*   **On-Premises Hardware:** Physical server maintenance.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | The system that creates, maintains, and manages identity information and provides authentication services. |
| **Service Provider (SP)** | The application or resource that provides services to the user, relying on the IdP to assert the user's identity. |
| **Assertion / Token** | A cryptographically signed document (SAML XML or JWT) containing statements about a user’s identity and attributes. |
| **Metadata** | An XML or JSON file used to exchange configuration information (endpoints, certificates) between the IdP and SP to establish trust. |
| **Binding** | The mechanism by which SSO protocol messages are transmitted (e.g., HTTP POST, HTTP Redirect). |
| **Clock Skew** | The difference in system time between the IdP and the SP, which can cause token rejection if it exceeds a defined threshold. |
| **RelayState** | A parameter used to maintain state information, typically used to redirect a user back to their original destination after authentication. |
| **Claim / Attribute** | A specific piece of information about a user (e.g., email, group membership) contained within an assertion. |

## Core Concepts
The foundation of SSO troubleshooting rests on three pillars:

1.  **The Trust Triangle:** Troubleshooting must account for the User (Browser), the IdP, and the SP. A failure in any one of these nodes or the connections between them breaks the SSO flow.
2.  **The Chain of Trust:** SSO relies on asymmetric cryptography. The SP must trust the IdP’s public key to verify the signature of the incoming assertion. If the certificate is expired, mismatched, or untrusted, the chain breaks.
3.  **Protocol Compliance:** Both the IdP and SP must adhere to the same version of a protocol (e.g., SAML 2.0). Discrepancies in how messages are formatted or signed lead to "Invalid Request" errors.

## Standard Model
The standard model for troubleshooting follows the logical flow of an SSO transaction:

1.  **Initiation:** Determine if the flow is **SP-Initiated** (user starts at the app) or **IdP-Initiated** (user starts at a dashboard).
2.  **Redirection:** Verify the user is correctly redirected to the IdP's Single Sign-On URL with the appropriate request parameters.
3.  **Authentication:** Ensure the IdP successfully authenticates the user (MFA, password, etc.).
4.  **Assertion Generation:** The IdP generates a signed token. Troubleshooting here focuses on the presence of required claims and the correct `Subject` identifier.
5.  **Assertion Consumption:** The user’s browser posts the token to the SP's Assertion Consumer Service (ACS) URL.
6.  **Validation & Mapping:** The SP validates the signature, checks the timestamps (NotBefore/NotOnOrAfter), and maps the claims to a local user profile.

## Common Patterns
When diagnosing SSO failures, the following patterns are frequently observed:

*   **Metadata Mismatch:** The most common source of failure. The SP expects a specific EntityID or Certificate that does not match what the IdP is sending.
*   **Attribute Mapping Failure:** The SSO succeeds at the protocol level, but the user is denied access because the SP cannot find a local user matching the `NameID` or `email` claim provided by the IdP.
*   **Certificate Expiration:** A silent failure where the trust relationship expires because the public key stored in the SP's metadata is no longer valid.
*   **Looping Redirection:** Occurs when the SP does not recognize the session created by the IdP assertion and sends the user back to the IdP, creating an infinite loop.

## Anti-Patterns
Discouraged practices that complicate troubleshooting or introduce security risks:

*   **Disabling Signature Validation:** Turning off signature checks to "fix" a connection. This creates a critical security vulnerability where assertions can be spoofed.
*   **Hardcoding Endpoints:** Using static URLs instead of dynamic metadata exchange, which leads to breakage when the IdP rotates certificates or changes endpoints.
*   **Ignoring Clock Skew:** Failing to synchronize system clocks via NTP, leading to intermittent "Token Expired" or "Token Not Yet Valid" errors.
*   **Verbose Error Messages to End-Users:** Displaying raw XML or stack traces in the browser, which can leak sensitive configuration details to malicious actors.

## Edge Cases
Scenarios that deviate from the standard flow:

*   **Deep Linking:** A user attempts to access a specific sub-resource. If the `RelayState` is not handled correctly, the user is dropped at the application's home page after SSO instead of the intended resource.
*   **Multi-Factor Authentication (MFA) Step-up:** When an SP requires a higher level of assurance (AuthnContext) than the IdP's current session provides, requiring a re-authentication mid-flow.
*   **Cross-Domain Cookie Restrictions:** Modern browser privacy settings (e.g., Intelligent Tracking Prevention) may block the cookies required to maintain the SSO session if the IdP and SP are on different top-level domains.
*   **Just-In-Time (JIT) Provisioning:** Failures occurring during the automatic creation of a user account upon first login, often due to missing mandatory attributes in the assertion.

## Related Topics
*   **Identity Federation:** The broader framework of sharing identities across trust domains.
*   **[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) Authorization Framework:** The underlying protocol for modern API-based SSO.
*   **Public Key Infrastructure (PKI):** The system of certificates and keys that underpins SSO security.
*   **Directory Services (LDAP/AD):** The source data stores from which IdPs typically pull user attributes.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |