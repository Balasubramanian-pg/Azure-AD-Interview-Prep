# [Key Differences AD vs Azure AD](02 Azure Active Directory/Key Differences AD vs Azure AD.md)

Canonical documentation for [Key Differences AD vs Azure AD](02 Azure Active Directory/Key Differences AD vs Azure AD.md). This document defines concepts, terminology, and standard usage.

## Purpose
The purpose of this documentation is to delineate the fundamental architectural, functional, and philosophical differences between traditional on-premises directory services (Active Directory Domain Services) and cloud-native identity platforms (Azure Active Directory, now known as Microsoft Entra ID). 

This topic addresses the transition from a perimeter-based security model, where identity is tied to a physical or virtual local area network (LAN), to a decentralized, identity-as-a-perimeter model suitable for global, internet-accessible resources.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative. While it references specific product names for clarity, the principles apply to the broader shift from legacy LDAP/Kerberos environments to modern Identity-as-a-Service (IDaaS) architectures.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   Architectural paradigms (Hierarchical vs. Flat).
*   Authentication protocols and authorization frameworks.
*   Device management philosophies.
*   Identity lifecycle management in local vs. cloud contexts.

**Out of scope:**
*   Specific pricing tiers or licensing models.
*   Step-by-step migration tutorials.
*   Third-party identity provider comparisons (e.g., Okta, Ping Identity).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **AD DS (Active Directory Domain Services)** | A server-based directory service that uses a hierarchical structure to manage users, computers, and resources within a network perimeter. |
| **Azure AD / Entra ID** | A cloud-based identity and access management service that provides authentication and authorization for web-based applications and resources. |
| **LDAP** | Lightweight Directory Access Protocol; the primary protocol used for querying and modifying items in AD DS. |
| **Modern Authentication** | An umbrella term for authentication methods based on web-friendly protocols such as OAuth 2.0, OpenID Connect (OIDC), and SAML 2.0. |
| **Tenant** | A dedicated instance of a cloud identity service representing an organization, distinct from the "Forest" or "Domain" concept in on-premises AD. |
| **GPO (Group Policy Object)** | A feature of AD DS used to manage configuration and security settings for users and computers joined to a domain. |
| **MDM (Mobile Device Management)** | A protocol-based management system used by cloud identity platforms to manage devices regardless of their network location. |

## Core Concepts

### 1. Architectural Structure
*   **Active Directory (AD):** Utilizes a hierarchical structure consisting of Forests, Trees, and Domains. It relies on Organizational Units (OUs) to delegate administrative permissions and apply policies.
*   **Azure AD:** Utilizes a flat structure. While it supports "Administrative Units" for scoping management, it does not use the nested OU/GPO hierarchy. It is designed for web-scale and multi-tenant isolation.

### 2. Communication Protocols
*   **Active Directory:** Primarily uses Kerberos and NTLM for authentication and LDAP for directory queries. These protocols are designed for low-latency, trusted internal networks.
*   **Azure AD:** Primarily uses REST-based APIs and web protocols (SAML, WS-Federation, OAuth 2.0, and OIDC). These are designed to traverse the public internet and work across firewalls via HTTPS.

### 3. Identity vs. Device Management
*   **Active Directory:** Manages devices via "Domain Join." Once joined, the device is a trusted entity on the network, managed via GPOs.
*   **Azure AD:** Manages devices via "Registration" or "Join" to the cloud tenant. Management is performed via MDM (Mobile Device Management) policies rather than traditional GPOs.

## Standard Model
The generally accepted model for modern organizations is the **Hybrid Identity Model**. In this model, the on-premises AD DS remains the authoritative source for legacy applications and local network resources, while an identity synchronization engine (e.g., AD Connect) projects these identities into the cloud directory.

*   **Source of Authority:** Usually resides in the on-premises AD for synchronized users.
*   **Authentication Flow:** Can be managed via Password Hash Sync (PHS), Pass-Through Authentication (PTA), or Federation (ADFS).

## Common Patterns

### Identity Synchronization
The most common pattern where identities are created on-premises and synchronized to the cloud. This allows for a "Single Sign-On" (SSO) experience across both legacy and modern applications.

### Cloud-Only Identity
A pattern used by "born-in-the-cloud" organizations where no on-premises footprint exists. All users, groups, and devices are managed directly within the cloud identity platform.

### Federation
A pattern where the cloud identity platform trusts an external Identity Provider (IdP) to validate user credentials. This is often used in complex environments requiring high-security hardware tokens or specific compliance workflows.

## Anti-Patterns

### "Lift and Shift" Logic
Attempting to replicate an OU/GPO structure directly into a cloud identity platform. Cloud platforms are not designed to support the granular, inheritance-based logic of GPOs, and forcing this often leads to management complexity and security gaps.

### Exposing Legacy Protocols to the Internet
Attempting to use LDAP or Kerberos over the public internet to authenticate cloud applications. This is insecure and architecturally unsound; modern protocols (OIDC/SAML) should be used for internet-facing authentication.

### Shared Service Accounts in Cloud
Using traditional "Service Accounts" (username/password) for cloud-based automation. The preferred pattern is using **Managed Identities** or **Service Principals**, which eliminate the need for static credentials.

## Edge Cases

### Legacy Application Support
Applications that require a "Domain Join" or specific LDAP attributes that are not synchronized by default. These often require a managed domain service (e.g., Azure AD Domain Services) which acts as a bridge by providing a managed AD DS forest in the cloud.

### Multi-Tenant Collaboration
Scenarios where a user from one organization needs access to resources in another. Unlike AD "Forest Trusts," which are complex to set up and maintain, cloud platforms use B2B (Business-to-Business) collaboration features to invite external identities as "Guest" users.

## Related Topics
*   **Zero Trust Architecture:** The security framework that assumes no network is inherently trusted, relying heavily on cloud identity signals.
*   **RBAC (Role-Based Access Control):** The method of assigning permissions based on job functions within the cloud platform.
*   **SCIM (System for Cross-domain Identity Management):** An open standard for automating the exchange of user identity information between identity domains.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |