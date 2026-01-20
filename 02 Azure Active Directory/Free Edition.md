# [Free Edition](02 Azure Active Directory/Free Edition.md)

Canonical documentation for [Free Edition](02 Azure Active Directory/Free Edition.md). This document defines concepts, terminology, and standard usage.

## Purpose
The [Free Edition](02 Azure Active Directory/Free Edition.md) exists to lower the barrier to entry for a product or service, allowing users to realize value without an initial financial commitment. It addresses the problem of high customer acquisition costs (CAC) and market friction by providing a functional subset of a product that serves as a foundation for user education, community growth, and eventual conversion to premium tiers.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* Structural characteristics of non-paid product tiers.
* Theoretical frameworks for feature gating and resource limitation.
* Strategic objectives of perpetual free access.
* Lifecycle management of free-tier users.

**Out of scope:**
* Specific vendor pricing models or marketing collateral.
* Open Source Software (OSS) licensing (unless used specifically as a "[Free Edition](02 Azure Active Directory/Free Edition.md)" strategy).
* Time-bound "Free Trials" (which are distinct from perpetual [Free Edition](02 Azure Active Directory/Free Edition.md)s).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **[Free Edition](02 Azure Active Directory/Free Edition.md)** | A version of a product offered to end-users at no monetary cost, typically for an indefinite duration. |
| **Freemium** | A business model that provides a [Free Edition](02 Azure Active Directory/Free Edition.md) with the option to purchase additional features or capacity. |
| **Feature Gating** | The practice of restricting access to specific functional components within the software based on the user's tier. |
| **Usage Quota** | Quantitative limits placed on resources (e.g., storage, API calls, seats) within the [Free Edition](02 Azure Active Directory/Free Edition.md). |
| **Conversion Path** | The defined journey or mechanism by which a [Free Edition](02 Azure Active Directory/Free Edition.md) user transitions to a paid tier. |
| **Monetization Friction** | The degree of difficulty or resistance a user faces when moving from a free to a paid state. |

## Core Concepts

### 1. The Value Exchange
The [Free Edition](02 Azure Active Directory/Free Edition.md) is not "free" in a strategic sense; it represents a value exchange. The provider offers functional utility in exchange for market share, user data, feedback, network effects, or a pipeline for future revenue.

### 2. Perpetual Access
Unlike a "Free Trial," which is a temporal restriction, a [Free Edition](02 Azure Active Directory/Free Edition.md) is defined by functional or capacity restrictions. The user retains access to the core utility for as long as the product exists or the terms of service remain unchanged.

### 3. Product-Led Growth (PLG)
The [Free Edition](02 Azure Active Directory/Free Edition.md) is the primary engine of PLG. It allows the product to "sell itself" by enabling users to reach a "Value Discovery" (Aha! moment) before a commercial transaction occurs.

## Standard Model

The standard model for a [Free Edition](02 Azure Active Directory/Free Edition.md) follows a **Core-Plus Architecture**:

1.  **Core Utility:** The [Free Edition](02 Azure Active Directory/Free Edition.md) must provide enough standalone value to be useful. If the product cannot solve a primary problem in its free state, it is considered "Crippledware" rather than a [Free Edition](02 Azure Active Directory/Free Edition.md).
2.  **Gating Mechanisms:**
    *   **Capacity Gating:** Limits on volume (e.g., 5GB of storage).
    *   **Feature Gating:** Limits on sophistication (e.g., no SSO, no advanced analytics).
    *   **Commercial Gating:** Limits on use case (e.g., "Free for personal use," "Free for non-profits").
3.  **Upsell Triggers:** Contextual prompts within the user interface that appear when a user encounters a gate, providing a direct path to the premium version.

## Common Patterns

### Feature-Limited Pattern
The most common pattern where the user has access to the basic interface but advanced modules (e.g., automation, integrations, security controls) are locked.

### Capacity-Limited Pattern
The user has access to all features, but only up to a certain threshold of data, users, or transactions. This is common in infrastructure and database services.

### Branding/Watermark Pattern
The [Free Edition](02 Azure Active Directory/Free Edition.md) is fully functional, but all output (reports, videos, emails) carries the provider's branding. Removing the branding is the primary incentive for upgrading.

### Community-Supported Pattern
The [Free Edition](02 Azure Active Directory/Free Edition.md) includes the software but excludes professional support. Users must rely on public forums or documentation for troubleshooting.

## Anti-Patterns

### The "Dead End"
Providing a [Free Edition](02 Azure Active Directory/Free Edition.md) that does not allow for data export or an easy upgrade path. This creates "vendor lock-in" that can damage brand reputation.

### Nagware
Interrupting the user's workflow excessively with upgrade prompts. This degrades the "Core Utility" and prevents the user from reaching the "Aha! moment."

### Security Neglect
Excluding critical security features (like Multi-Factor Authentication) from the [Free Edition](02 Azure Active Directory/Free Edition.md). This creates a vulnerable user base that can pose a systemic risk to the provider's infrastructure.

### The "Ghost Tier"
A [Free Edition](02 Azure Active Directory/Free Edition.md) that is so buried in the marketing site or documentation that it is effectively inaccessible, used only to claim a "starting at $0" price point.

## Edge Cases

*   **Legacy Free Users:** When a company sunsets a [Free Edition](02 Azure Active Directory/Free Edition.md) or changes its limits, existing users often fall into a "grandfathered" state, creating technical debt and complex entitlement logic.
*   **Educational/Non-Profit Use:** Organizations that qualify for free access to "Premium" features based on their status rather than a standard [Free Edition](02 Azure Active Directory/Free Edition.md) tier.
*   **The "Free-to-Paid" Forced Migration:** When a [Free Edition](02 Azure Active Directory/Free Edition.md) is discontinued, and users are forced to either pay or lose data. This is a high-risk maneuver for brand equity.

## Related Topics
*   **SaaS (Software as a Service):** The primary delivery model for modern [Free Edition](02 Azure Active Directory/Free Edition.md)s.
*   **Product-Led Growth (PLG):** The strategic framework that utilizes [Free Edition](02 Azure Active Directory/Free Edition.md)s for distribution.
*   **Customer Acquisition Cost (CAC):** The metric most directly impacted by the implementation of a [Free Edition](02 Azure Active Directory/Free Edition.md).
*   **Entitlement Management:** The technical system used to enforce gates and quotas.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |