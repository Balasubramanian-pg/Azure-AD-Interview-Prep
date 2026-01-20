# [MFA Prompt Loop](03 Single Sign-On/MFA Prompt Loop.md)

Canonical documentation for [MFA Prompt Loop](03 Single Sign-On/MFA Prompt Loop.md). This document defines concepts, terminology, and standard usage.

## Purpose
The [MFA Prompt Loop](03 Single Sign-On/MFA Prompt Loop.md) is a failure state within an identity and access management (IAM) lifecycle where a user is repeatedly challenged for multi-factor authentication (MFA) despite providing valid credentials and second-factor proofs. 

This topic exists to address the systemic breakdown between identity providers (IdP), service providers (SP), and the client-side session state. It addresses the problem of "authentication persistence failure," where the system fails to transition from the "challenging" state to the "authenticated" state, or fails to maintain that state across subsequent requests.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* Logical flow of authentication challenges and assertions.
* Session management and token persistence mechanisms.
* Conflict resolution between overlapping access policies.
* Protocol-level handshaking (SAML, OIDC, OAuth2) as it relates to looping.

**Out of scope:**
* Specific vendor-specific configuration steps (e.g., specific Azure AD or Okta menu navigation).
* Hardware-level troubleshooting of MFA devices (e.g., battery failure in a physical token).
* User interface (UI) design of the MFA prompt itself.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **[MFA Prompt Loop](03 Single Sign-On/MFA Prompt Loop.md)** | A recursive authentication state where the completion of an MFA challenge fails to satisfy the access requirements of the resource, triggering a new challenge. |
| **Identity Provider (IdP)** | The system that creates, maintains, and manages identity information and provides authentication services. |
| **Service Provider (SP)** | The entity providing the resource or application that relies on the IdP for authentication. |
| **Assertion/Token** | A cryptographically signed statement issued by an IdP that informs an SP of the user's identity and authentication status. |
| **Session State** | The temporary data stored by the client or server that tracks the "logged-in" status of a user. |
| **Conditional Access Policy** | A set of rules that evaluate signals (location, device, risk) to determine if MFA is required. |
| **Clock Skew** | The difference in time between the system clocks of the IdP, SP, and client. |

## Core Concepts
The [MFA Prompt Loop](03 Single Sign-On/MFA Prompt Loop.md) is fundamentally a failure of **State Synchronization**.

1.  **The Authentication Lifecycle:** A standard flow involves a Request, a Challenge, a Verification, and a Session Establishment. A loop occurs when the "Session Establishment" phase fails to satisfy the "Request" phase of the next interaction.
2.  **Trust Discontinuity:** The SP may not trust the MFA claim provided by the IdP, or the IdP may not recognize the session established by its own previous challenge.
3.  **Policy Recursion:** When multiple policies apply to a single resource, the satisfaction of Policy A may trigger the evaluation of Policy B, which in turn re-triggers Policy A.

## Standard Model
In a healthy authentication model, the MFA event is a "point-in-time" verification that updates the user's **Authentication Context**.

1.  **Request:** User attempts to access a resource.
2.  **Evaluation:** The system checks for a valid, unexpired session token containing an MFA claim.
3.  **Challenge (if required):** If no valid claim exists, the user is prompted.
4.  **Assertion:** Upon success, the IdP issues a token with an `auth_time` and `amr` (Authentication Methods References) claim.
5.  **Persistence:** The client stores this token (Cookie, LocalStorage) and presents it for subsequent requests.

The loop occurs when Step 5 fails to satisfy Step 2 in a subsequent cycle.

## Common Patterns
*   **The Redirect Loop:** The SP redirects to the IdP for MFA. The IdP validates the user and redirects back to the SP. The SP fails to read the session cookie (often due to SameSite cookie attributes or domain mismatches) and redirects the user back to the IdP.
*   **The Token Expiry Loop:** The "Session Lifetime" is set shorter than the "MFA Requirement Frequency." The token expires almost immediately after issuance, triggering a new prompt.
*   **The Nested Resource Loop:** An application (SP) loads sub-resources (APIs) that each have independent MFA requirements. If these APIs do not share a common session context, the user is prompted for each individual component.
*   **The Policy Conflict Loop:** A "Global" policy requires MFA, but a "Legacy" policy on the same resource does not recognize the modern MFA claim, causing the system to request a different, potentially incompatible factor.

## Anti-Patterns
*   **Stateless MFA:** Requiring MFA on every single API call rather than establishing a time-bound session.
*   **Incompatible Timeouts:** Setting the IdP session timeout to be longer than the SP session timeout without a mechanism for silent re-authentication.
*   **Cookie Suppression:** Implementing security headers or browser settings that block the persistence of the very session cookies required to prove MFA was completed.
*   **Hard-coded MFA Logic:** Embedding MFA triggers within application code rather than delegating them to the identity layer, leading to "Double MFA" scenarios.

## Edge Cases
*   **Clock Skew:** If the IdP's clock is ahead of the SP's clock, the SP may receive a token that appears to be from the "future" or already expired, leading to an immediate rejection and re-prompt.
*   **Cross-Device Flows:** When a user authenticates on a desktop but the MFA is completed on a mobile device, a failure in the back-channel communication can leave the desktop in a polling loop.
*   **Privacy Mode/Incognito:** Browsers in private modes often discard session state or block third-party cookies, which are frequently used in federated identity (SAML/OIDC) to maintain the MFA state across different domains.
*   **MFA Fatigue Protection:** Some systems intentionally break a loop by locking the account if too many MFA prompts are generated in a short window, turning a "Loop" into a "Lockout."

## Related Topics
*   **Session Management:** The lifecycle of a user's authenticated state.
*   **Federated Identity:** The protocols (SAML, OIDC) used to communicate identity between systems.
*   **Token Binding:** Techniques to ensure tokens cannot be reused by unauthorized parties.
*   **Zero Trust Architecture:** A security model that often increases MFA frequency, potentially increasing the risk of loops.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |