# [SAML 2.0](03 Single Sign-On/SAML 2.0.md)

Canonical documentation for [SAML 2.0](03 Single Sign-On/SAML 2.0.md). This document defines concepts, terminology, and standard usage.

## Purpose
Security Assertion Markup Language (SAML) 2.0 is an XML-based open standard for exchanging authentication and authorization data between parties. Its primary purpose is to enable **Federated Identity** and **Single Sign-On (SSO)**. 

[SAML 2.0](03 Single Sign-On/SAML 2.0.md) addresses the problem of identity fragmentation by allowing a user to authenticate with a single trusted authority (the Identity Provider) and subsequently gain access to multiple independent applications (Service Providers) without re-entering credentials. This decouples the authentication process from the application logic, enhancing security and improving user experience.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
**In scope:**
* Core XML schemas and assertion structures.
* Standard protocols (Request/Response) and bindings (HTTP Redirect, POST, etc.).
* Operational profiles (Web Browser SSO).
* Security requirements for digital signatures and encryption.
* Metadata exchange formats.

**Out of scope:**
* Specific vendor implementations (e.g., Okta, Azure AD, Shibboleth).
* Programming language-specific library documentation.
* SAML 1.x legacy specifications.
* Non-SAML protocols (e.g., OIDC, OAuth 2.0), except for comparative context.

## Definitions
| Term | Definition |
|------|------------|
| **Principal** | The entity (usually a human user) whose identity is being asserted. |
| **Identity Provider (IdP)** | The system that authenticates the Principal and issues SAML Assertions. |
| **Service Provider (SP)** | The system or application that relies on the IdP to verify the Principal's identity. |
| **Assertion** | A package of information (XML) containing statements about a Principal’s identity, attributes, or entitlements. |
| **Binding** | A mapping of a SAML protocol message onto standard messaging formats or transport protocols (e.g., HTTP POST). |
| **Metadata** | An XML document that defines the technical capabilities, endpoints, and certificates of an IdP or SP to establish trust. |
| **RelayState** | An opaque identifier used to maintain state information between the request and the response, often used to redirect users back to their original destination. |
| **Entity ID** | A unique URI that identifies a specific SAML entity (IdP or SP). |

## Core Concepts

### 1. Assertions
The fundamental unit of SAML is the Assertion. There are three primary types:
*   **Authentication Assertions:** Validate that the Principal authenticated at a specific time using a specific method.
*   **Attribute Assertions:** Provide specific data about the Principal (e.g., email, department, roles).
*   **Authorization Decision Assertions:** State whether the Principal is permitted to access a specific resource.

### 2. Protocols
[SAML 2.0](03 Single Sign-On/SAML 2.0.md) defines how assertions are requested and delivered. Key protocols include:
*   **Authentication Request Protocol:** How an SP asks an IdP for an assertion.
*   **Single Logout Protocol:** How a session is terminated across all participants in a federation.
*   **Assertion Query and Request Protocol:** How an SP requests specific assertions independently of a login flow.

### 3. Bindings
Bindings determine how SAML messages are transported.
*   **HTTP Redirect Binding:** Messages are passed via URL parameters (usually for AuthnRequests).
*   **HTTP POST Binding:** Messages are passed via base64-encoded content in an HTML form (usually for Assertions).
*   **HTTP Artifact Binding:** A reference (artifact) is passed, and the receiver fetches the actual message via a back-channel.

## Standard Model

### The Web Browser SSO Profile
The most common implementation of [SAML 2.0](03 Single Sign-On/SAML 2.0.md) is the Web Browser SSO Profile. It relies on the user's browser as the intermediary (the "User Agent").

#### SP-Initiated Flow
1.  **Access Attempt:** The Principal attempts to access a protected resource on the SP.
2.  **AuthnRequest:** The SP generates a `<samlp:AuthnRequest>` and redirects the browser to the IdP.
3.  **Authentication:** The IdP authenticates the Principal (e.g., via username/password or MFA).
4.  **SAML Response:** The IdP generates a `<samlp:Response>` containing a signed Assertion and sends it to the browser (usually via HTTP POST).
5.  **Assertion Consumer Service (ACS):** The browser posts the Assertion to the SP's ACS URL.
6.  **Validation & Access:** The SP validates the signature, checks the conditions, and grants access.

#### IdP-Initiated Flow
1.  **Portal Access:** The Principal logs into the IdP's dashboard/portal.
2.  **Selection:** The Principal clicks a link for a specific SP.
3.  **Unsolicited Response:** The IdP generates a SAML Response and sends it directly to the SP's ACS URL via the browser.

## Common Patterns

### Just-in-Time (JIT) Provisioning
The practice of automatically creating a user account in the SP's local database the first time they log in via SAML, using the attributes provided in the Assertion.

### Attribute Mapping
The process of translating IdP-specific attribute names (e.g., `urn:oid:0.9.2342.19200300.100.1.3`) into SP-friendly names (e.g., `email`).

### Metadata Exchange
The use of standardized XML files to automate the configuration of trust. This includes sharing public keys, endpoint URLs, and supported bindings.

## Anti-Patterns

### 1. Hardcoding Certificates
Embedding the IdP's public key directly into application code rather than using a configurable metadata endpoint. This leads to service outages when certificates expire.

### 2. Ignoring Signature Validation
Accepting a SAML Assertion without verifying the digital signature against the trusted IdP's public key. This allows for "SAML Response Spoofing."

### 3. Using SAML for Native Mobile Apps
While possible, SAML is designed for browser-based flows. Using it in native apps often requires "web-view" hacks. OpenID Connect (OIDC) is the preferred standard for mobile/native environments.

### 4. Failing to Validate "NotOnOrAfter"
Ignoring the time-based conditions within an assertion, which could allow for replay attacks where an old assertion is reused.

## Edge Cases

### Clock Skew
Differences in system time between the IdP and SP can cause valid assertions to be rejected. Standard practice is to allow a 3–5 minute "skew" when validating timestamps (`NotBefore` and `NotOnOrAfter`).

### Multiple SPs Behind a Single Proxy
When a single gateway acts as the SP for multiple downstream applications, the `RelayState` must be carefully managed to ensure the user is routed to the correct internal resource after authentication.

### Certificate Rotation
The period during which an IdP transitions from an old signing key to a new one. Robust implementations should support "Dual-Signing" or multiple keys in metadata to prevent downtime.

## Related Topics
*   **XML Digital Signature (XMLDSig):** The underlying mechanism for securing SAML messages.
*   **OpenID Connect (OIDC):** A modern identity layer built on top of [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md), often compared to SAML.
*   **XACML:** A standard for fine-grained access control policy, often used in conjunction with SAML.
*   **Federated Identity:** The broader concept of sharing identity across autonomous security domains.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |