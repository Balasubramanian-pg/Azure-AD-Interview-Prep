# [Create User](02 Azure Active Directory/Create User.md)

Canonical documentation for [Create User](02 Azure Active Directory/Create User.md). This document defines concepts, terminology, and standard usage.

## Purpose
The "[Create User](02 Azure Active Directory/Create User.md)" process is the foundational mechanism for identity provisioning within a system. Its primary purpose is to transition an external entity (human, service, or device) into a recognized **Principal** with a unique identity. This process establishes the baseline for authentication, authorization, accountability, and personalization. By formalizing the creation of a user, a system establishes a trust boundary and begins the identity lifecycle.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The logical workflow of identity provisioning.
* Validation requirements for unique identifiers.
* Establishment of initial security postures and attributes.
* Theoretical boundaries of user persistence.

**Out of scope:**
* Specific database schemas or API syntax (e.g., SQL `INSERT` or REST `POST` specifics).
* Vendor-specific identity providers (e.g., AWS IAM, Azure AD, Okta).
* Password recovery or secondary authentication factor setup (MFA).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity** | A set of attributes that uniquely describe an entity within a specific domain. |
| **Principal** | An entity that can be authenticated by the system (e.g., a user, program, or computer). |
| **Identifier (UID)** | A unique string or token used to distinguish one identity from all others (e.g., UUID, email, or username). |
| **Provisioning** | The process of creating, preparing, and enabling access to resources based on the new identity. |
| **Attribute** | A discrete piece of information associated with a user (e.g., name, role, or department). |
| **Idempotency** | The property of an operation where multiple identical requests have the same effect as a single request. |

## Core Concepts
Explain the fundamental ideas.

### Uniqueness and Collision
The most critical constraint of the [Create User](02 Azure Active Directory/Create User.md) process is the guarantee of uniqueness. An identifier must map to exactly one principal. A "collision" occurs when a creation request attempts to use an identifier already assigned to an active or archived entity.

### Identity Lifecycle: The Birth Phase
Creation represents the "Birth" phase of the Identity Lifecycle. It must capture sufficient metadata to support subsequent phases: Maintenance (Update), Usage (Authenticate), and Termination (Delete/Disable).

### Atomic Provisioning
User creation should be atomic. The system must ensure that the user record, initial permissions, and associated metadata are either all created successfully or none are, preventing "orphaned" or "partial" identities that could pose security risks.

## Standard Model
The standard model for creating a user follows a linear progression of state:

1.  **Request:** An initiator (admin or self-service) submits identity attributes.
2.  **Validation:**
    *   **Syntactic:** Ensures data formats are correct (e.g., valid email structure).
    *   **Semantic:** Ensures values make sense within the domain (e.g., age requirements).
    *   **Uniqueness:** Checks the registry to ensure the identifier is not in use.
3.  **Persistence:** The identity is committed to the authoritative data store.
4.  **Credential Issuance:** Initial secrets (passwords, tokens, or keys) are generated or requested.
5.  **Initialization:** Default roles, permissions, and profile defaults are applied.
6.  **Notification:** The principal or administrator is alerted that the identity is active.

## Common Patterns
Recurring patterns or approaches.

*   **Self-Service Registration:** The end-user provides their own attributes, often requiring an external verification step (e.g., email confirmation).
*   **Administrative Provisioning:** A privileged user creates the account on behalf of another entity, typically in enterprise environments.
*   **Just-In-Time (JIT) Provisioning:** The user is created automatically upon their first successful authentication via a trusted external Identity Provider (IdP).
*   **Bulk Provisioning:** The simultaneous creation of multiple identities via structured data import (e.g., CSV or JSON batch).

## Anti-Patterns
Common mistakes or discouraged practices.

*   **Identifier Recycling:** Reassigning a unique identifier from a deleted user to a new user. This can lead to "identity bleeding" where the new user inherits legacy logs or permissions.
*   **Over-Provisioning at Birth:** Assigning excessive permissions by default rather than following the Principle of Least Privilege.
*   **Silent Failures:** Failing to provide specific feedback when a user cannot be created (e.g., returning a generic error when the username is actually taken).
*   **Hardcoded Defaults:** Using "password123" or other predictable initial credentials.

## Edge Cases
Explain unusual, ambiguous, or boundary scenarios.

*   **Race Conditions:** Two simultaneous requests attempting to create the same identifier. Systems must implement locking or unique constraints at the persistence layer to prevent duplicates.
*   **Soft-Deleted Collisions:** Attempting to create a user with an identifier that belongs to a "deactivated" or "soft-deleted" account that still exists in the database.
*   **Partial Provisioning Failure:** The user record is created in the primary database, but the downstream system (e.g., an email inbox or file share) fails to initialize.
*   **Internationalization (i18n):** Handling non-Latin characters in identifiers or attributes, which may affect sorting, searching, and uniqueness checks.

## Related Topics
*   **Authentication:** The process of verifying the identity created.
*   **Authorization:** Defining what the created user is allowed to do.
*   **User Lifecycle Management:** The broader framework of managing identities from creation to deletion.
*   **Identity Federation:** Creating local representations of users authenticated by external systems.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |