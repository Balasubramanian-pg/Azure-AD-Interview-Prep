# [Pass Through Authentication PTA](02 Azure Active Directory/Pass Through Authentication PTA.md)

Canonical documentation for [Pass Through Authentication PTA](02 Azure Active Directory/Pass Through Authentication PTA.md). This document defines concepts, terminology, and standard usage.

## Purpose
Pass Through Authentication (PTA) exists to bridge the gap between cloud-based service providers and on-premises or isolated identity stores. It addresses the requirement for centralized authentication without necessitating the synchronization of sensitive credential data (such as password hashes) to the cloud or the complexity of maintaining a full-scale Federation infrastructure.

The primary problem space PTA addresses is the enforcement of security policies and credential validation at the source of truth in real-time, ensuring that account states (e.g., disabled, locked out, or password expired) are honored immediately across all connected services.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* Architectural flow of credential validation from a service to a backend directory.
* Security implications of handling credentials in transit.
* The role of lightweight agents in the authentication chain.
* Theoretical requirements for high availability and scalability.

**Out of scope:**
* Specific vendor implementations (e.g., Microsoft Entra ID PTA, Okta LDAP Agent).
* Step-by-step configuration guides for specific operating systems.
* Comparison of specific pricing models between vendors.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity Provider (IdP)** | The service that manages digital identities and issues security tokens. |
| **Authentication Agent** | A lightweight software component residing within a secure network that facilitates communication between the IdP and the Identity Store. |
| **Identity Store** | The authoritative database of user records (e.g., LDAP, Active Directory) where credentials reside. |
| **Credential Validation** | The process of verifying that the provided identifier and secret match the records in the Identity Store. |
| **Outbound Connection** | A network connection initiated from the internal network to the IdP, typically used to avoid opening inbound firewall ports. |
| **Token Issuance** | The act of providing a signed security assertion to the user after successful validation. |

## Core Concepts
The fundamental ideas of PTA revolve around **delegation** and **real-time verification**.

1.  **Delegated Validation:** Unlike Password Hash Synchronization (PHS), where a representation of the password is moved to the IdP, PTA delegates the act of validation to an agent that has direct access to the local Identity Store.
2.  **Zero-Knowledge Persistence:** The IdP does not store the user's password in any form. It acts as a temporary conduit for the credentials during the authentication transaction.
3.  **Real-Time Policy Enforcement:** Because the check happens against the live Identity Store, any changes to the user's status (e.g., an account being disabled by an administrator) take effect globally for all services relying on PTA immediately.
4.  **Outbound-Only Connectivity:** To maintain a high security posture, PTA models typically rely on agents that poll the IdP for authentication requests via outbound HTTPS connections, eliminating the need for inbound holes in the corporate firewall.

## Standard Model
The standard model for Pass Through Authentication follows a linear request-response cycle:

1.  **Initiation:** A user attempts to access a resource and provides their credentials (username and password) to the IdP's sign-in page.
2.  **Queueing:** The IdP places the authentication request into a secure, encrypted queue.
3.  **Retrieval:** An Authentication Agent, sitting behind a firewall, retrieves the pending request from the IdP via a persistent outbound connection.
4.  **Validation:** The Agent performs a validation check against the local Identity Store (e.g., via a standard LDAP bind or Kerberos call).
5.  **Response:** The Agent returns the result (Success/Failure/Reason) to the IdP.
6.  **Completion:** If successful, the IdP issues the appropriate security tokens to the user's browser or application.

## Common Patterns
*   **Agent Redundancy:** Deploying multiple agents across different physical or logical networks to ensure that the failure of a single server or data center does not interrupt authentication services.
*   **Protocol Translation:** The IdP may receive a modern request (OIDC/SAML) but the PTA agent translates this into a legacy protocol (LDAP/NTLM) to communicate with the Identity Store.
*   **Hybrid Coexistence:** Using PTA as the primary method while maintaining a secondary method (like Password Hash Sync) as a disaster recovery fallback.

## Anti-Patterns
*   **Inbound Port Exposure:** Opening firewall ports to allow the IdP to "push" authentication requests to the internal network, rather than using an outbound polling agent.
*   **Credential Logging:** Configuring agents or intermediate proxies to log clear-text credentials for debugging purposes.
*   **Single Point of Failure:** Relying on a single agent instance, which creates a bottleneck and a critical failure point for all organizational logins.
*   **Bypassing MFA:** Implementing PTA without a secondary factor, assuming that the "on-premises" validation is sufficient security for cloud-based resources.

## Edge Cases
*   **Account Lockout Loops:** If the IdP and the Identity Store have different lockout thresholds, a user might be locked out of the local directory while the IdP continues to attempt (and fail) authentications, or vice versa.
*   **Network Latency:** High latency between the Authentication Agent and the IdP can lead to request timeouts, resulting in "False Negatives" where the user provides correct credentials but is denied access.
*   **Expired Credentials:** Handling the workflow for a user whose password has expired. The PTA agent must be able to pass the "Password Expired" status back to the IdP so the IdP can trigger a password change workflow.
*   **Legacy Protocol Support:** Some legacy applications may use protocols that do not support the redirection or queueing required for PTA, necessitating alternative access methods like App Proxies.

## Related Topics
*   **Federated Identity:** An alternative where the user is redirected to a local login page rather than providing credentials to the cloud IdP.
*   **Password Hash Synchronization (PHS):** A method where a one-way hash of a hash is stored in the cloud.
*   **Multi-Factor Authentication (MFA):** A secondary layer of security often triggered after a successful PTA validation.
*   **Single Sign-On (SSO):** The broader goal of providing access to multiple applications with one set of credentials.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |