# [Reply URL Mismatch](03 Single Sign-On/Reply URL Mismatch.md)

Canonical documentation for [Reply URL Mismatch](03 Single Sign-On/Reply URL Mismatch.md). This document defines concepts, terminology, and standard usage.

## Purpose
The concept of the [Reply URL Mismatch](03 Single Sign-On/Reply URL Mismatch.md) exists to enforce security boundaries during the delegation of authorization and identity. In modern federated identity protocols (such as [OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) and OpenID Connect), the "Reply URL" (or Redirect URI) serves as the designated destination where an Authorization Server (AS) sends sensitive data—including authorization codes and access tokens—after a user has successfully authenticated.

A mismatch occurs when the destination requested during a runtime transaction does not align with the pre-registered destinations known to the Authorization Server. This mechanism addresses the "Open Redirector" vulnerability, preventing malicious actors from intercepting security tokens by redirecting them to an unauthorized or attacker-controlled endpoint.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The theoretical framework of URI validation in delegated authorization.
* Security implications of URI redirection.
* Standard validation logic (exact matching vs. pattern matching).
* Protocol-level requirements for Client and Authorization Server interaction.

**Out of scope:**
* Specific vendor error codes (e.g., Microsoft AADSTS50011, Google "Error 400: redirect_uri_mismatch").
* Implementation-specific UI/UX for registering URLs.
* Network-level routing or DNS resolution issues.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Authorization Server (AS)** | The engine that issues tokens to the client after successfully authenticating the resource owner and obtaining authorization. |
| **Client (Application)** | The entity requesting access to protected resources on behalf of the resource owner. |
| **Redirect URI / Reply URL** | The endpoint on the Client application where the AS sends the user-agent back with the authorization response. |
| **Registration** | The administrative process of informing the AS of valid Redirect URIs before any runtime requests are made. |
| **Exact Match** | A validation requirement where the requested URI must be identical to the registered URI, character-for-character. |
| **Open Redirector** | A security flaw where an application takes a parameter and redirects the user to that parameter without sufficient validation. |

## Core Concepts
The [Reply URL Mismatch](03 Single Sign-On/Reply URL Mismatch.md) is a failure of the **Trust Handshake**. The fundamental ideas include:

1.  **Pre-registration of Intent:** The Client must declare its valid callback endpoints during an out-of-band registration phase. This establishes a "whitelist" of trusted destinations.
2.  **Runtime Validation:** During an authorization request, the Client sends a `redirect_uri` parameter. The AS compares this parameter against the registered whitelist.
3.  **Integrity of the Response:** If the URIs do not match, the AS must terminate the request and must not redirect the user-agent to the unverified URI, as doing so could leak credentials.

## Standard Model
The generally accepted model for preventing [Reply URL Mismatch](03 Single Sign-On/Reply URL Mismatch.md)es follows the **Strict Validation Model**:

*   **Protocol Requirement:** The `redirect_uri` is an absolute URI.
*   **Comparison Logic:** The AS performs a binary string comparison. Any variation in scheme (http vs https), host, port, path, or query parameters results in a mismatch.
*   **State Management:** To handle dynamic data (like return paths within an app), the `state` parameter is used instead of modifying the Redirect URI.
*   **Failure State:** Upon a mismatch, the AS displays an error to the user on its own domain and halts the flow. It does not redirect back to the faulty URI.

## Common Patterns
*   **Static URI Mapping:** A 1:1 mapping where each environment (Dev, Staging, Production) has a single, fixed Redirect URI.
*   **Multiple Registered URIs:** Allowing a single Client ID to have multiple registered URIs to support different entry points or platforms (e.g., web vs. mobile deep links).
*   **Localhost Exception:** Some models allow relaxed port matching for `localhost` or `127.0.0.1` to facilitate local development, though this is increasingly discouraged in favor of exact port matching.

## Anti-Patterns
*   **Wildcard Matching:** Using asterisks (e.g., `https://*.example.com`) to match subdomains. This significantly increases the attack surface, as any compromised subdomain can then intercept tokens.
*   **Path Traversal Permissiveness:** Allowing any path under a registered domain (e.g., registering `https://example.com/` and accepting `https://example.com/malicious/callback`).
*   **HTTP in Production:** Allowing non-TLS endpoints for redirection, which exposes tokens to man-in-the-middle (MITM) interception.
*   **Reflected Redirect URIs:** An AS that echoes back whatever URI is provided in the request without checking a whitelist.

## Edge Cases
*   **Trailing Slashes:** `https://app.com/callback` vs `https://app.com/callback/`. Many systems treat these as distinct, causing a mismatch.
*   **Case Sensitivity:** While domain names are case-insensitive, paths and query parameters are often case-sensitive. A mismatch may occur if the registration is `.../Callback` but the request is `.../callback`.
*   **URL Encoding:** Discrepancies in how the Client encodes the URI in the request versus how the AS decodes it for comparison.
*   **Private-Use URI Schemes:** In mobile applications (e.g., `com.myapp://oauth`), the lack of a standard hierarchy can lead to validation complexities across different operating systems.

## Related Topics
*   **[OAuth 2.0](03 Single Sign-On/OAuth 2.0.md) Security Best Current Practice (BCP):** The evolving standard for securing redirection.
*   **State Parameter:** The mechanism for maintaining application state without altering the Redirect URI.
*   **PKCE (Proof Key for Code Exchange):** A security extension that provides additional protection even if a Redirect URI is partially compromised.
*   **Cross-Site Request Forgery (CSRF):** The class of attack that the `state` parameter and Redirect URI validation work together to prevent.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |