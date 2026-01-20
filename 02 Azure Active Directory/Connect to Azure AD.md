# [Connect to Azure AD](02 Azure Active Directory/Connect to Azure AD.md)

Canonical documentation for [Connect to Azure AD](02 Azure Active Directory/Connect to Azure AD.md). This document defines concepts, terminology, and standard usage.

## Purpose
The purpose of connecting to Azure AD (now part of Microsoft Entra) is to establish a secure, verifiable communication channel between an external entity—such as an application, service, or device—and a centralized identity provider (IdP). This connection facilitates the transition from network-based security perimeters to identity-based security models. It addresses the problem of fragmented identity management by providing a unified control plane for authentication, authorization, and auditing across heterogeneous environments.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative. While "Azure AD" is the historical name, the principles described herein apply to the evolved Microsoft Entra ID ecosystem.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   **Identity Integration:** The logical handshake between a client and the identity provider.
*   **Protocol Standards:** The use of industry-standard frameworks (OIDC, OAuth 2.0, SAML) for establishing connections.
*   **Security Principals:** The definition of entities that can initiate or receive a connection.
*   **Trust Relationships:** The theoretical framework for establishing trust between a tenant and an external resource.

**Out of scope:**
*   **Specific Vendor Implementations:** Step-by-step guides for third-party SaaS integrations.
*   **Code-level SDK Tutorials:** Language-specific syntax for libraries (e.g., MSAL, ADAL).
*   **Hardware-specific Configuration:** Physical setup of networking equipment or biometric sensors.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Tenant** | A dedicated instance of the identity service representing an organization or a specific boundary of trust. |
| **Service Principal** | A local representation (an object) of a global application object within a specific tenant, used for authentication and authorization. |
| **Managed Identity** | An identity automatically managed by the platform, eliminating the need for developers to manage credentials. |
| **Claim** | A statement about a subject (e.g., name, role, email) issued by the identity provider and packaged in a token. |
| **Scope** | A mechanism to limit an application's access to a user's account or a resource's data. |
| **Authority** | The URL or endpoint that indicates where the client should request tokens (the "Source of Truth"). |

## Core Concepts
Connecting to Azure AD is predicated on three fundamental pillars:

1.  **Identity as the Control Plane:** In a cloud-native environment, the network is assumed to be hostile. The connection to the identity provider serves as the primary gatekeeper for all resource access.
2.  **Claims-Based Identity:** Rather than the resource verifying the user's password, the resource trusts a signed "token" issued by Azure AD. This token contains "claims" that the resource uses to make authorization decisions.
3.  **Explicit Trust:** A connection cannot be established without a pre-existing trust relationship, usually defined by an Application Registration or a Federation agreement.

## Standard Model
The standard model for connecting to Azure AD follows the **Modern Authentication** framework, primarily utilizing OpenID Connect (OIDC) for authentication and OAuth 2.0 for authorization.

1.  **Discovery:** The client identifies the appropriate Authority (Tenant-specific or Common).
2.  **Challenge/Request:** The client sends a request for an identity or access token, providing its own credentials or a user's credentials.
3.  **Validation:** Azure AD validates the credentials against the directory and evaluates security policies (e.g., Conditional Access).
4.  **Issuance:** Upon success, Azure AD issues a JSON Web Token (JWT).
5.  **Consumption:** The client presents this token to the target resource, which validates the token's signature and claims.

## Common Patterns
*   **User-Interactive Flow:** Used for applications where a human is present to provide credentials (e.g., Web Apps, Mobile Apps).
*   **Daemon/Service Flow:** Used for non-interactive background processes (e.g., Cron jobs, APIs) using Client Credentials.
*   **On-Behalf-Of (OBO) Flow:** Used when an API needs to call another API while propagating the original user's identity and permissions.
*   **Device Code Flow:** Used for devices with limited input capabilities (e.g., IoT, CLI tools) where the user authenticates on a separate device.

## Anti-Patterns
*   **Hardcoded Secrets:** Storing client secrets or passwords in source code or configuration files.
*   **Over-Privileged Service Principals:** Granting "Directory.ReadWrite.All" when only specific resource access is required.
*   **Bypassing Modern Auth:** Using legacy protocols like Basic Authentication or NTLM, which do not support Multi-Factor Authentication (MFA).
*   **Implicit Grant Flow:** Using the OAuth 2.0 Implicit Flow for new applications, as it is less secure than the Authorization Code Flow with PKCE.
*   **Token Sharing:** Passing raw tokens between unrelated services without validating the audience (`aud`) claim.

## Edge Cases
*   **Multi-Tenant Applications:** Scenarios where an application must accept connections from users in any Azure AD tenant, requiring dynamic authority resolution.
*   **Disconnected/Hybrid Environments:** Situations where a connection must be established in an environment with intermittent internet connectivity, necessitating cached tokens or local identity synchronization.
*   **Guest Access (B2B):** When a connection is initiated by a user from an external organization, requiring the host tenant to map the external identity to local resource permissions.
*   **Conditional Access Blocking:** A valid connection attempt may be rejected not due to incorrect credentials, but due to environmental factors (e.g., unmanaged device, untrusted IP range).

## Related Topics
*   **OAuth 2.0 and OIDC Frameworks:** The underlying protocols for modern identity.
*   **Conditional Access Policies:** The rules engine that governs connection success.
*   **Managed Identities for Azure Resources:** The preferred method for service-to-service connection.
*   **Microsoft Graph API:** The primary resource accessed via an Azure AD connection.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |