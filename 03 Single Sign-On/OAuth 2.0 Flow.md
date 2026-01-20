# [OAuth 2.0 Flow](03 Single Sign-On/OAuth 2.0 Flow.md)

Canonical documentation for [OAuth 2.0 Flow](03 Single Sign-On/OAuth 2.0 Flow.md). This document defines concepts, terminology, and standard usage.

## Purpose
The [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) flow exists to facilitate **delegated authorization**. It addresses the security risk of third-party applications accessing protected resources by requiring user credentials. By providing a standardized framework, [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) allows a Resource Owner to permit a Client application to access specific data held by a Resource Server without sharing their primary credentials (e.g., passwords) with that application.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative, focusing on the protocol as defined in RFC 6749 and subsequent security best practices.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The four primary roles defined by the protocol.
* The abstract protocol flow and specific Grant Types.
* Token exchange mechanisms and security extensions (e.g., PKCE).
* Theoretical boundaries of authorization delegation.

**Out of scope:**
* Specific vendor implementations (e.g., GitHub, Google, Microsoft Identity).
* Identity layer protocols built on top of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) (e.g., OpenID Connect), except where necessary for context.
* Specific cryptographic algorithms for token signing (e.g., RS256 vs. HS256).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Resource Owner** | The entity capable of granting access to a protected resource (typically the end-user). |
| **Client** | The application making protected resource requests on behalf of the resource owner and with its authorization. |
| **Resource Server** | The server hosting the protected resources, capable of accepting and responding to protected resource requests using access tokens. |
| **Authorization Server** | The server issuing access tokens to the client after successfully authenticating the resource owner and obtaining authorization. |
| **Access Token** | A string representing an authorization issued to the client, used to access protected resources. |
| **Refresh Token** | A credential used to obtain new access tokens when the current access token becomes invalid or expires. |
| **Grant Type** | The method used by the client to acquire an access token (e.g., Authorization Code, Client Credentials). |
| **Scope** | A mechanism to limit the amount of access that is granted to an access token. |
| **PKCE** | Proof Key for Code Exchange; an extension to the authorization code flow to prevent injection attacks. |

## Core Concepts
The [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) framework is built upon the following fundamental ideas:

1.  **Separation of Concerns:** The framework decouples the act of authentication (verifying who a user is) from authorization (verifying what a user can do).
2.  **Token-Based Access:** Instead of using the Resource Owner's credentials, the Client uses an opaque or structured token. This limits the "blast radius" if a Client is compromised.
3.  **Consent-Driven:** Access is predicated on the Resource Owner explicitly granting permission for specific scopes of data.
4.  **Least Privilege:** Through the use of Scopes, Clients are granted only the minimum level of access required to perform their function.

## Standard Model
The standard [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) model follows an abstract flow consisting of six logical steps:

1.  **Authorization Request:** The Client requests authorization from the Resource Owner.
2.  **Authorization Grant:** The Client receives an authorization grant (a credential representing the Resource Owner's authorization).
3.  **Authorization Grant (to Server):** The Client requests an access token by presenting the authorization grant to the Authorization Server.
4.  **Access Token Issuance:** The Authorization Server authenticates the Client and validates the authorization grant. If valid, it issues an access token.
5.  **Protected Resource Request:** The Client requests the protected resource from the Resource Server by presenting the access token.
6.  **Resource Delivery:** The Resource Server validates the access token and serves the request.

## Common Patterns
The following patterns (Grant Types) are used based on the nature of the Client:

*   **Authorization Code Flow:** The "Gold Standard" for web and mobile applications. It involves a redirection-based flow where the Client receives a temporary code, which is then exchanged for an access token on a secure back-channel.
*   **Authorization Code with PKCE:** The mandatory extension for mobile apps and Single Page Applications (SPAs) to prevent authorization code interception.
*   **Client Credentials Flow:** Used for Machine-to-Machine (M2M) communication where no Resource Owner (user) is involved. The Client uses its own credentials to authenticate.
*   **Refresh Token Flow:** Used when an Access Token expires, allowing the Client to obtain a new one without re-prompting the Resource Owner for consent.

## Anti-Patterns
Common mistakes or discouraged practices in [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) implementation:

*   **Implicit Grant:** Formerly used for SPAs; now deprecated due to the security risk of exposing access tokens in the URL fragment.
*   **Resource Owner Password Credentials (ROPC):** An anti-pattern where the Client asks for the user's password directly. This should only be used in legacy migration scenarios.
*   **Using Access Tokens for Authentication:** Treating the possession of an access token as proof of user identity. [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) is for authorization; OpenID Connect (OIDC) should be used for authentication.
*   **Hardcoding Client Secrets:** Including `client_secret` values in client-side code (JavaScript, Mobile binaries).
*   **Infinite Token Lifetimes:** Issuing access tokens that never expire, increasing the risk of unauthorized access if a token is leaked.

## Edge Cases
Explain unusual, ambiguous, or boundary scenarios.

*   **Scope Escalation:** When a Client requires additional permissions after the initial token issuance, a new flow must be initiated to obtain a token with broader scopes.
*   **Token Revocation:** The process of invalidating a token before its natural expiration (e.g., a user logging out or changing their password).
*   **Partial Consent:** Scenarios where a Resource Owner grants some requested scopes but denies others. The Client must be able to function with a subset of the requested permissions.
*   **Zombie Tokens:** Tokens that remain valid on a Resource Server because the Resource Server does not check a centralized revocation list or the token's TTL is too long.

## Related Topics
*   **OpenID Connect (OIDC):** An identity layer on top of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md).
*   **JSON Web Token (JWT):** A common format for representing claims between two parties.
*   **RFC 6749:** The core [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) Authorization Framework specification.
*   **RFC 7636:** Proof Key for Code Exchange (PKCE) by OAuth Public Clients.
*   **Bearer Token Usage (RFC 6750):** How to use tokens to access protected resources.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |