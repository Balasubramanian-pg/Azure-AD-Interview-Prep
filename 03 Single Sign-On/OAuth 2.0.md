# [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md)

Canonical documentation for [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md). This document defines concepts, terminology, and standard usage.

## Purpose
[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) is an authorization framework designed to enable a third-party application to obtain limited access to an HTTP service. It addresses the "Valet Key" problem in computing: allowing a user (Resource Owner) to grant a third-party application (Client) access to their resources stored on a server (Resource Server) without sharing their primary credentials (e.g., username and password).

By decoupling the authentication of the user from the authorization of the application, [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) provides a secure mechanism for delegated access, reducing the attack surface and limiting the impact of potential credential compromises.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative, based primarily on RFC 6749 and RFC 6750.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The four fundamental authorization roles.
* The lifecycle of an authorization grant.
* Token types and their abstract properties.
* Standard grant types (flows) defined in the core specification.
* Security considerations for token handling.

**Out of scope:**
* Specific vendor implementations (e.g., Google, GitHub, Okta).
* Identity layers built on top of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) (e.g., OpenID Connect).
* Specific cryptographic algorithms for token signing (e.g., JWT/JWS details).
* User interface (UI) or User Experience (UX) design for consent screens.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Resource Owner** | An entity capable of granting access to a protected resource. When the resource owner is a person, it is referred to as an end-user. |
| **Resource Server** | The server hosting the protected resources, capable of accepting and responding to protected resource requests using access tokens. |
| **Client** | An application making protected resource requests on behalf of the resource owner and with its authorization. |
| **Authorization Server** | The server that issues access tokens to the client after successfully authenticating the resource owner and obtaining authorization. |
| **Access Token** | A credential used by the client to access protected resources. It represents the specific scope and duration of the access granted. |
| **Refresh Token** | A credential used to obtain a new access token when the current access token becomes invalid or expires. |
| **Scope** | A mechanism to limit the amount of access that is granted to an access token. |
| **Authorization Grant** | A credential representing the resource owner's authorization, used by the client to obtain an access token. |

## Core Concepts

### Delegation of Authority
The central premise of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) is delegation. The Resource Owner does not give their credentials to the Client. Instead, the Resource Owner authenticates with the Authorization Server, which then issues a specific token to the Client. This token acts as a limited-use key.

### Token-Based Access
Access to resources is governed by tokens rather than identity credentials. 
* **Bearer Tokens:** The most common type. Any party in possession of the token can use it to access the associated resources.
* **Opaque vs. Structured:** Tokens may be "opaque" (meaningless strings to the client) or "structured" (containing claims, such as JWTs), but the client should generally treat them as opaque.

### The Principle of Least Privilege
Through the use of **Scopes**, [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) enforces the principle of least privilege. A client should only request the minimum level of access required to perform its function, and the Resource Owner has the right to approve or deny specific subsets of that access.

## Standard Model

The standard [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) flow follows an abstract protocol exchange:

1.  **Authorization Request:** The Client requests authorization from the Resource Owner.
2.  **Authorization Grant:** The Client receives an authorization grant (a representation of the user's consent).
3.  **Token Request:** The Client requests an access token by presenting the authorization grant and its own client credentials to the Authorization Server.
4.  **Access Token:** The Authorization Server authenticates the Client, validates the grant, and issues an access token (and optionally a refresh token).
5.  **Protected Resource Request:** The Client requests the protected resource from the Resource Server by presenting the access token.
6.  **Protected Resource:** The Resource Server validates the access token and serves the request.

## Common Patterns

### Authorization Code Flow
The most secure and common flow, used for web applications where the client secret can be kept confidential on a server. It involves an intermediate "Authorization Code" exchanged for a token via a secure back-channel.

### Authorization Code Flow with PKCE
Proof Key for Code Exchange (PKCE) is an extension to the Authorization Code flow designed to prevent injection attacks. It is now the recommended standard for **all** clients, including mobile apps, Single Page Applications (SPAs), and traditional web apps.

### Client Credentials Flow
Used for machine-to-machine (M2M) communication where no "user" is involved. The Client acts on its own behalf to access resources it owns or has been granted permission to manage.

### Refresh Token Rotation
A security pattern where every time a refresh token is used to get a new access token, a new refresh token is also issued, and the old one is invalidated. This helps detect and mitigate token theft in non-confidential clients.

## Anti-Patterns

*   **OAuth as Authentication:** Using [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) (an authorization framework) to sign a user into an app without an identity layer like OpenID Connect. This often leads to "The Confused Deputy" problem.
*   **Implicit Flow:** Previously used for SPAs, this flow returns tokens directly in the URL fragment. It is now deprecated due to security risks (token leakage in browser history/referrer headers).
*   **Resource Owner Password Credentials (ROPC) Grant:** This flow requires the user to give their password directly to the Client. It is deprecated and should only be used for legacy migration scenarios.
*   **Hardcoding Client Secrets:** Including client secrets in mobile apps or frontend JavaScript code. These environments cannot keep secrets.
*   **Infinite Token Lifetimes:** Issuing access tokens that never expire increases the window of opportunity for an attacker if a token is intercepted.

## Edge Cases

### Scope Escalation
A scenario where a client requests additional permissions after an initial token has been issued. The Authorization Server must ensure the Resource Owner re-consents to the new scopes.

### Token Revocation
While access tokens are often short-lived and self-validating, there are cases where a token must be invalidated immediately (e.g., user logout or device loss). This requires a Revocation Endpoint (RFC 7009).

### Authorization Server Metadata
In complex ecosystems, clients need a way to discover the endpoints of an Authorization Server (e.g., the token endpoint, the authorization endpoint). This is handled via an "Issuer Discovery" or Metadata document (RFC 8414).

## Related Topics
*   **OpenID Connect (OIDC):** An identity layer on top of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) that adds ID Tokens and user information.
*   **JSON Web Tokens (JWT):** A common format for representing claims between two parties, often used for OAuth tokens.
*   **RFC 6749:** The core [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) Authorization Framework specification.
*   **RFC 7636:** PKCE (Proof Key for Code Exchange).
*   **SAML:** An XML-based authentication and authorization standard (often compared to OAuth/OIDC).

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |