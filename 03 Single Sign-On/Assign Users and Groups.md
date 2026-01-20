# [Assign Users and Groups](03 Single Sign-On/Assign Users and Groups.md)

Canonical documentation for [Assign Users and Groups](03 Single Sign-On/Assign Users and Groups.md). This document defines concepts, terminology, and standard usage.

## Purpose
The assignment of users and groups serves as the fundamental mechanism for managing access control and resource allocation within a digital ecosystem. It addresses the problem of scalability in identity management by decoupling individual identities from specific permissions. By associating identities (Users) with logical containers (Groups), organizations can manage entitlements efficiently, ensure consistent security postures, and streamline the lifecycle of access as individuals join, move, or leave an organization.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The logical association between identities and containers.
* Mechanisms of membership (static, dynamic, and transitive).
* The relationship between principals and entitlements.
* Theoretical frameworks for hierarchical and flat assignment structures.

**Out of scope:**
* Specific vendor implementations (e.g., Active Directory, AWS IAM, Okta).
* Protocol-specific details (e.g., SAML assertions, OIDC scopes).
* Hardware-level authentication methods.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identity** | A unique digital representation of an entity (human or non-human). |
| **User** | A specific type of identity, typically representing an individual person or a service account. |
| **Group** | A logical collection of identities that can be managed as a single unit. |
| **Principal** | An entity (User or Group) that is capable of being assigned permissions or roles. |
| **Assignment** | The formal link established between a principal and a resource, role, or group. |
| **Membership** | The state of a User or Group being contained within another Group. |
| **Entitlement** | A specific right or privilege granted to a principal through an assignment. |
| **Nesting** | The practice of assigning one group as a member of another group. |

## Core Concepts

### The Principal-Target Relationship
At its core, assignment is a directional relationship where a **Principal** (the actor) is linked to a **Target** (the resource or role). This relationship defines "who" can do "what."

### Membership Types
*   **Direct Membership:** A user is explicitly added to a group.
*   **Indirect (Transitive) Membership:** A user gains membership in a group because they are a member of a subgroup nested within that group.
*   **Dynamic Membership:** Membership is automatically calculated based on metadata or attributes (e.g., "All users where Department = 'Engineering'").

### Inheritance
Inheritance is the mechanism by which permissions assigned to a group are automatically granted to all members of that group. In hierarchical structures, inheritance typically flows downward from parent groups to child groups and finally to individual users.

## Standard Model

The standard model for assigning users and groups follows the **RBAC (Role-Based Access Control)** framework, often extended by **ABAC (Attribute-Based Access Control)** for finer granularity.

1.  **Identity Creation:** A User is provisioned in the system.
2.  **Group Categorization:** Groups are created based on functions (e.g., "Marketing"), locations (e.g., "EMEA"), or security levels (e.g., "Admin").
3.  **Assignment to Groups:** Users are assigned to one or more groups.
4.  **Entitlement Mapping:** Permissions or Roles are assigned to the Groups, not the Users.
5.  **Resolution:** When a user attempts to access a resource, the system resolves the user's effective permissions by aggregating the entitlements of all groups to which the user belongs.

## Common Patterns

### Functional Grouping
Groups are organized by job function or department. This is the most common pattern for organizational alignment.

### Resource-Based Grouping
Groups are created specifically to manage access to a single resource (e.g., "Project-Alpha-Read-Only"). Users are added to these groups to gain specific access.

### Tiered Administration
A hierarchical pattern where "Super Admin" groups contain "Regional Admin" groups, which in turn contain "Local Admin" groups. This allows for delegated administration.

### Just-In-Time (JIT) Assignment
A pattern where a user is assigned to a group temporarily for a specific duration or task, after which the assignment is automatically revoked.

## Anti-Patterns

### Direct User Entitlement
Assigning permissions directly to individual users rather than through groups. This leads to "permission creep" and makes auditing nearly impossible at scale.

### Circular Nesting
A scenario where Group A is a member of Group B, and Group B is a member of Group A. This can cause infinite loops in permission resolution engines and system instability.

### Deep Nesting
Creating excessively long chains of nested groups (e.g., User -> G1 -> G2 -> G3... -> G10). This obscures the "Effective Permissions" of a user and degrades system performance during authorization checks.

### The "Everything" Group
Creating a single group that contains all users and assigning it broad permissions. This violates the Principle of Least Privilege.

## Edge Cases

### Conflicting Permissions
A user belongs to Group A (Allow Access) and Group B (Deny Access). The canonical resolution is that an explicit **Deny** overrides an **Allow**, but this varies by implementation.

### Orphaned Assignments
When a resource or group is deleted, but the assignment records remain in the database. This can lead to security vulnerabilities if a new resource is later created with the same identifier.

### Cross-Domain/Cross-Tenant Assignment
Assigning a user from one identity provider or domain to a group in a different domain. This requires trust relationships and introduces complexities in identity lifecycle management.

### Shadow Memberships
Users who gain access through undocumented or legacy back-door assignments that bypass the standard group-based management system.

## Related Topics
*   **Identity and Access Management (IAM):** The broader framework for managing digital identities.
*   **Principle of Least Privilege (PoLP):** The security discipline of providing only the minimum access necessary.
*   **Access Control Lists (ACL):** The low-level mapping of principals to specific resource operations.
*   **Lifecycle Management:** The process of managing the stages of an identity from creation to deletion.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |