# [OpenID Connect OIDC](03 Single Sign-On/OpenID Connect OIDC.md)

Canonical documentation for [OpenID Connect OIDC](03 Single Sign-On/OpenID Connect OIDC.md). This document defines concepts, terminology, and standard usage.

## Purpose
OpenID Connect (OIDC) exists to provide a standardized identity layer on top of the [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) framework. While [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) was designed specifically for *authorization* (delegating access to resources), it lacked a native mechanism for *authentication* (verifying who a user is). 

OIDC addresses this gap by allowing clients to verify the identity of an end-user based on the authentication performed by an Authorization Server, as well as to obtain basic profile information about the end-user in an interoperable and REST-like manner. It enables Single Sign-On (SSO) across diverse applications and platforms without requiring applications to manage or see user credentials.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The relationship between OIDC and [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md).
* Core protocol flows (Authorization Code, Implicit, Hybrid).
* Standardized token formats (ID Tokens) and claims.
* Discovery mechanisms and dynamic registration.
* Security considerations inherent to the protocol.

**Out of scope:**
* Specific vendor implementations (e.g., Okta, Auth0, Keycloak, Microsoft Entra ID).
* Programming language-specific SDKs or libraries.
* Proprietary extensions not defined in the OpenID Foundation specifications.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **End-User** | The human entity being authenticated. |
| **Relying Party (RP)** | The application or client requiring user authentication and claims from an OP. |
| **OpenID Provider (OP)** | The [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) Authorization Server that is capable of authenticating the End-User and providing claims to the RP. |
| **ID Token** | A JSON Web Token (JWT) that contains claims about the authentication event and the user. |
| **Claim** | A piece of information asserted about an entity (e.g., name, email, or subject identifier). |
| **Subject (sub)** | A locally unique and never reassigned identifier within the Issuer for the End-User. |
| **Scope** | A mechanism to limit the amount of access/information requested (e.g., `openid`, `profile`, `email`). |
| **UserInfo Endpoint** | A protected resource that, when presented with an Access Token, returns claims about the authenticated End-User. |

## Core Concepts

### 1. Extension of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md)
OIDC is not a replacement for [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md); it is an extension. It uses [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) flows to exchange messages. The presence of the `openid` scope in the authorization request signals to the server that the OIDC extension is being invoked.

### 2. The ID Token
The primary innovation of OIDC is the ID Token. Unlike the Access Token (which is opaque to the client), the ID Token is a structured JSON Web Token (JWT). It is intended to be consumed by the Relying Party to understand who the user is and how/when they authenticated.

### 3. Claims and Scopes
OIDC standardizes the names of user attributes (Claims) and groups them into Scopes. 
*   `openid`: (Required) Informs the server that the request is an OIDC request.
*   `profile`: Requests access to default profile claims (name, picture, etc.).
*   `email`: Requests access to `email` and `email_verified` claims.

### 4. Discovery and Metadata
OIDC provides a standard way for RPs to discover an OP's configuration (endpoints, supported scopes, signing keys) via a "Discovery Document," typically located at `/.well-known/openid-configuration`.

## Standard Model

The standard model for OIDC implementation follows the **Authorization Code Flow** (often enhanced with PKCE for security).

1.  **Request:** The RP sends an Authorization Request to the OP.
2.  **Authentication:** The OP authenticates the End-User and obtains authorization.
3.  **Response:** The OP sends an Authorization Code back to the RP.
4.  **Token Exchange:** The RP exchanges the Authorization Code for an ID Token and an Access Token.
5.  **Validation:** The RP validates the ID Token (signature, issuer, audience, expiration).
6.  **UserInfo (Optional):** The RP uses the Access Token to request additional claims from the UserInfo Endpoint.

## Common Patterns

### Single Sign-On (SSO)
A user authenticates once with an OP and gains access to multiple independent RPs without being prompted for credentials again, as the OP maintains the user's session.

### Proof Key for Code Exchange (PKCE)
Originally designed for mobile apps, PKCE is now the recommended pattern for all RPs (including web apps) to prevent authorization code injection attacks.

### Third-Party (Social) Login
Using a public OP (e.g., Google, GitHub) to provide identity to a private RP, reducing the friction of account creation.

## Anti-Patterns

### Using Access Tokens for Authentication
Access Tokens are for authorization. An RP should never assume that possession of an Access Token proves a user's identity; only the ID Token is designed for this purpose.

### Ignoring ID Token Validation
Failing to verify the JWT signature, the `aud` (audience) claim, or the `exp` (expiration) claim allows for token forgery and replay attacks.

### Storing Secrets in Public Clients
Hardcoding a `client_secret` in a Single Page Application (SPA) or mobile app is an anti-pattern. Public clients should use flows that do not require a secret (e.g., Authorization Code Flow with PKCE).

### Using the Implicit Flow
The Implicit Flow (where tokens are returned directly in the URL fragment) is deprecated in favor of the Authorization Code Flow due to security risks regarding token leakage in browser history and referrer headers.

## Edge Cases

### Clock Skew
RPs must account for minor differences in system clocks when validating the `iat` (issued at) and `exp` (expiration) claims. A "leeway" of 1–5 minutes is standard.

### Subject Identifier Stability
While the `sub` claim is unique, OIDC allows for "Pairwise" identifiers. This means the same user will have different `sub` values for different RPs, preventing RPs from correlating user activity across different services without consent.

### Prompt and Max_Age
The `prompt` parameter can force re-authentication even if a session exists, while `max_age` allows an RP to demand that the authentication event occurred within a specific timeframe.

## Related Topics
*   **[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md):** The underlying authorization framework.
*   **JSON Web Token (JWT):** The format used for ID Tokens.
*   **JOSE (JSON Object Signing and Encryption):** The suite of specs (JWS, JWE, JWK) used to secure tokens.
*   **[SAML 2.0](03 Single Sign-On/SAML 2.0.md):** An older, XML-based identity federation standard.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |