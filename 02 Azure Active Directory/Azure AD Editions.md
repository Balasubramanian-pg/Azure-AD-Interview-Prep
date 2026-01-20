# [Azure AD Editions](02 Azure Active Directory/Azure AD Editions.md)

Canonical documentation for [Azure AD Editions](02 Azure Active Directory/Azure AD Editions.md). This document defines concepts, terminology, and standard usage.

## Purpose
The purpose of Azure AD (now Microsoft Entra ID) editions is to provide a tiered functional framework that aligns identity management capabilities with organizational scale, security requirements, and regulatory compliance needs. This segmentation allows organizations to balance cost against the depth of identity protection, governance, and administrative control required for their specific environment.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative. While it references specific product tiers, it focuses on the functional architecture and theoretical boundaries of those tiers.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* Functional differentiation between identity service tiers.
* Theoretical boundaries of identity governance and security features.
* Core capabilities associated with Free, Premium P1, and Premium P2 models.
* Specialized editions for specific use cases (e.g., External Identities).

**Out of scope:**
* Specific pricing or licensing SKU bundles (e.g., Microsoft 365 E3/E5).
* Step-by-step configuration or deployment guides.
* Third-party identity provider comparisons.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Tenant** | A dedicated instance of the identity service that represents an organization. |
| **Identity Governance** | The policy-based management of identity and access, ensuring the right people have the right access to the right resources. |
| **Conditional Access** | A policy-driven engine that evaluates signals (user, device, location) to make automated access decisions. |
| **Privileged Identity Management (PIM)** | A service that enables managing, controlling, and monitoring access to important resources within an organization. |
| **Self-Service Password Reset (SSPR)** | A capability allowing users to reset their passwords without administrative intervention. |
| **B2B Collaboration** | A feature set allowing organizations to share applications and services with guest users from other organizations. |

## Core Concepts
The Azure AD edition model is built upon three fundamental pillars:

1.  **Identity Lifecycle Management:** The progression from basic user creation to automated provisioning and de-provisioning based on authoritative data sources.
2.  **Access Security:** The evolution from simple password-based authentication to sophisticated, risk-based adaptive access policies.
3.  **Governance and Compliance:** The transition from manual access reviews to automated, audited, and time-bound access management.

## Standard Model
The standard model for Azure AD editions follows a progressive hierarchy where each tier inherits the features of the previous one.

### 1. [Free Edition](02 Azure Active Directory/Free Edition.md)
The foundational tier provided with any Microsoft cloud service subscription.
*   **Core Functionality:** Directory object management, Single Sign-On (SSO) for a limited number of apps, and basic security reporting.
*   **Boundary:** Limited to basic authentication and lacks advanced security signals or automated governance.

### 2. Premium Plan 1 (P1)
Designed for organizations requiring enterprise-level identity management and hybrid integration.
*   **Core Functionality:** Advanced group management, SSPR for hybrid environments, and Conditional Access.
*   **Boundary:** Provides the "Zero Trust" foundation but lacks automated risk-based remediation and advanced governance.

### 3. Premium Plan 2 (P2)
The comprehensive tier for organizations requiring deep security and automated governance.
*   **Core Functionality:** Identity Protection (risk-based access), Privileged Identity Management (PIM), and Access Reviews.
*   **Boundary:** The ceiling for native identity security and lifecycle automation.

### 4. Specialized Editions (External/B2C)
Editions tailored for customer-facing applications or external collaboration.
*   **Core Functionality:** Highly customizable login journeys and massive scale for consumer identities.

## Common Patterns
*   **The Hybrid Bridge:** Organizations use P1 to synchronize on-premises directories with the cloud, enabling a unified identity across legacy and modern environments.
*   **Zero Trust Baseline:** Utilizing P1 Conditional Access to enforce Multi-Factor Authentication (MFA) based on location or device compliance.
*   **Least Privilege Enforcement:** Utilizing P2 PIM to ensure administrative rights are granted "Just-In-Time" rather than being permanent.

## Anti-Patterns
*   **Feature Over-Provisioning:** Purchasing P2 licenses for an entire workforce when only a subset of administrators requires PIM or advanced governance.
*   **Security Siloing:** Relying on the Free edition for production environments, which lacks the Conditional Access controls necessary to mitigate modern credential-based attacks.
*   **Manual Review Fatigue:** Attempting to manage large-scale access reviews manually in a P1 environment instead of utilizing P2 automation.

## Edge Cases
*   **Tenant-Level vs. User-Level Licensing:** While some features are technically enabled at the tenant level once a single license is purchased, compliance requires that every user benefiting from the feature be properly licensed.
*   **Guest User Ratios:** Historically, guest user licensing followed a 1:5 ratio; however, modern models have shifted toward Monthly Active Users (MAU), creating complexity in legacy tenants.
*   **Government and Sovereign Clouds:** Editions in specialized environments (e.g., GCC High) may have functional parity delays compared to the standard commercial editions.

## Related Topics
*   **Zero Trust Architecture:** The security framework that Azure AD editions support.
*   **Role-Based Access Control (RBAC):** The mechanism used within editions to manage permissions.
*   **Identity Protection:** The specific P2 capability focused on machine-learning-based risk detection.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |
| 1.1 | 2026-01-20 | Refined definitions to include Microsoft Entra ID context |