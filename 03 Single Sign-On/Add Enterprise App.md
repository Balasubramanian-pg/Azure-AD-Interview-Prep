# [Add Enterprise App](03 Single Sign-On/Add Enterprise App.md)

Canonical documentation for [Add Enterprise App](03 Single Sign-On/Add Enterprise App.md). This document defines concepts, terminology, and standard usage.

## Purpose
The process of adding an enterprise application exists to integrate external or internal software services into an organization’s centralized management ecosystem. This process establishes a formal trust relationship between an Identity Provider (IdP) and a Service Provider (SP), enabling centralized governance, unified access control, and automated user lifecycle management. By formalizing the "Add" phase, organizations mitigate "Shadow IT," ensure compliance with security policies, and provide a frictionless authentication experience for end-users.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The conceptual framework for application onboarding and registration.
* Establishing trust boundaries and identity federation.
* Configuration of access policies and attribute exchange.
* Provisioning logic and lifecycle integration.

**Out of scope:**
* Specific vendor-specific UI walkthroughs (e.g., Microsoft Entra ID, Okta, or Google Workspace).
* Physical installation of software on local hardware.
* Source code development of the applications being added.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Enterprise Application** | A software solution used by an organization to perform business functions, typically requiring centralized identity management and security oversight. |
| **Identity Provider (IdP)** | The system that creates, maintains, and manages identity information for principals while providing authentication services. |
| **Service Provider (SP)** | The application or service that provides the functional resource and relies on the IdP to verify the identity of users. |
| **Federation** | A collection of domains that have established trust to allow for the exchange of identity and attributes across organizational boundaries. |
| **Provisioning** | The process of creating, maintaining, and deleting user accounts and permissions in the target application based on the IdP's state. |
| **Attribute Mapping** | The definition of how user data fields in the IdP (e.g., Email, Department) correspond to fields in the Enterprise App. |
| **SSO (Single Sign-On)** | An authentication scheme that allows a user to log in with a single ID to any of several related, yet independent, software systems. |

## Core Concepts
### The Trust Relationship
Adding an enterprise app is fundamentally about establishing a cryptographic trust. This is usually achieved through the exchange of metadata, certificates, or client secrets. Once trust is established, the SP trusts the assertions (claims) made by the IdP regarding a user's identity.

### Identity Federation
Federation allows identities to be managed in one place (the IdP) while being used across many applications. When an app is "added," it is joined to this federated circle, allowing for standardized protocols like SAML (Security Assertion Markup Language) or OIDC (OpenID Connect) to govern interactions.

### Governance and Consent
The act of adding an application involves a "Consent" phase where the organization (or an administrator) grants the application specific permissions to access organizational data (e.g., reading user profiles, accessing calendars).

## Standard Model
The standard model for adding an enterprise application follows a five-stage lifecycle:

1.  **Registration:** Defining the application within the IdP, generating unique identifiers (Client IDs), and specifying redirect URIs.
2.  **Authentication Configuration:** Selecting the protocol (SAML, OIDC, etc.) and exchanging the necessary keys or metadata files to enable SSO.
3.  **Attribute & Claim Mapping:** Determining which user data points the application requires to function and how they should be formatted in the identity token.
4.  **Assignment & Authorization:** Defining which users or groups are permitted to access the application and what roles they hold within it.
5.  **Provisioning Setup:** (Optional) Configuring automated synchronization (e.g., via SCIM) to manage user accounts within the application's own database.

## Common Patterns
*   **Gallery/Pre-Integrated Pattern:** Using a pre-configured template provided by the IdP vendor for well-known SaaS products. This minimizes manual configuration errors.
*   **Custom/Non-Gallery Pattern:** Manually configuring a trust relationship for bespoke or niche applications using standard protocols.
*   **On-Premises Proxy Pattern:** Adding an application that resides behind a firewall by using a connector or agent to bridge the cloud IdP with the local network.
*   **Self-Service Pattern:** Allowing end-users to request access to an application, which triggers an administrative approval workflow before the app is "added" to their profile.

## Anti-Patterns
*   **Hardcoded Credentials:** Storing administrative or service account passwords within the application configuration rather than using certificate-based or token-based authentication.
*   **Over-Provisioning (Permissive Scopes):** Granting an application more permissions to the directory than it requires for its core function (e.g., granting "Directory.ReadWrite.All" when only "User.Read" is needed).
*   **Bypassing Centralized IdP:** Allowing "siloed" logins where users create local accounts within the enterprise app, leading to orphaned accounts when employees leave the organization.
*   **Manual De-provisioning:** Relying on human memory to remove user access rather than integrating the app with the IdP's lifecycle management tools.

## Edge Cases
*   **Legacy Applications:** Applications that do not support modern federation protocols (SAML/OIDC). These may require "Header-based" authentication or password vaulting.
*   **Multi-Tenant vs. Single-Tenant:** Applications that serve multiple organizations may require specific "Tenant ID" configurations to ensure data isolation.
*   **Air-Gapped Environments:** Adding applications in environments with no outbound internet access requires localized IdPs and manual certificate rotation.
*   **Just-In-Time (JIT) Provisioning:** Scenarios where a user account is created in the application only at the moment of their first successful login, rather than being pre-provisioned.

## Related Topics
*   **Identity Lifecycle Management:** The broader process of managing a user's journey from hire to retire.
*   **Role-Based Access Control (RBAC):** The method of restricting system access to authorized users based on their role.
*   **SCIM (System for Cross-domain Identity Management):** The standard protocol for automating user provisioning.
*   **Conditional Access:** Policies that evaluate signals (location, device health) before allowing access to an added application.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |