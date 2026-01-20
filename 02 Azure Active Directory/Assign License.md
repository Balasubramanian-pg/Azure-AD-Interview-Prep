# [Assign License](02 Azure Active Directory/Assign License.md)

Canonical documentation for [Assign License](02 Azure Active Directory/Assign License.md). This document defines concepts, terminology, and standard usage.

## Purpose
The process of assigning a license serves as the bridge between an organization’s legal entitlement to software or services and the functional consumption of those resources by specific entities. It is the mechanism by which an abstract right (the entitlement) is bound to a concrete identity (the subject).

The primary purpose of license assignment is to ensure compliance with contractual obligations, optimize resource allocation, and provide a verifiable audit trail of who or what is authorized to access specific capabilities. It transforms a pool of purchased assets into active, operational permissions.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The logical mapping of entitlements to subjects (users, devices, or services).
* Lifecycle management of the assignment state (allocation, deallocation, and reassignment).
* Governance models for distribution (manual vs. automated).
* Theoretical constraints such as quotas and concurrency.

**Out of scope:**
* Specific vendor licensing portals or command-line interfaces.
* Financial procurement processes (purchasing the licenses).
* Technical enforcement mechanisms (the code that checks for a license at runtime).
* Legal drafting of End User License Agreements (EULAs).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Subject** | The entity to which a license is assigned (e.g., a User, Device, Service Account, or Workload). |
| **Entitlement** | The specific right or set of features granted by a license. |
| **License Pool** | A collection of available, unassigned entitlements of a specific type. |
| **Allocation** | The act of reserving or dedicating a license to a subject. |
| **Deallocation** | The removal of a license from a subject, returning it to the pool. |
| **Seat** | A unit of measurement representing a single assignable instance of a license. |
| **Consumption** | The actual utilization of the resource enabled by the assigned license. |
| **Over-provisioning** | The state where more licenses are assigned than are functionally required or utilized. |

## Core Concepts

### The Assignment Triad
License assignment is governed by the relationship between three components:
1.  **The Identity:** Who or what is requesting access.
2.  **The Resource:** The software, feature, or service being accessed.
3.  **The Policy:** The rules governing whether the identity is permitted to hold the license (e.g., department, job role, or geographic location).

### Statefulness
An assignment is inherently stateful. It exists in a lifecycle:
*   **Pending:** The assignment is requested but not yet active.
*   **Active:** The subject is authorized to use the resource.
*   **Suspended:** The assignment exists, but the right to use is temporarily revoked (e.g., during a disciplinary period or payment lapse).
*   **Released:** The assignment is terminated, and the seat is returned to the pool.

### Quota Management
Assignment systems must track "Available vs. Assigned" counts. A quota acts as a hard or soft limit on the number of subjects that can hold an active assignment simultaneously.

## Standard Model
The standard model for license assignment follows a **Centralized Governance Model**. In this model, a central authority (either a human administrator or an automated system) manages a unified directory of subjects and a unified inventory of licenses.

1.  **Request:** A subject or system triggers a need for a license.
2.  **Validation:** The system checks if a seat is available in the pool and if the subject meets the policy requirements.
3.  **Binding:** The system creates a unique record linking the Subject ID to the License ID.
4.  **Propagation:** The assignment status is synchronized with the resource's enforcement point (the application or service).

## Common Patterns

### Direct Assignment
The explicit mapping of a license to an individual subject by an administrator. This is high-control but low-scalability.

### Group-Based Assignment (Inheritance)
Licenses are assigned to a container (e.g., a directory group or department). Any subject that is a member of that container automatically inherits the license. This is the preferred pattern for enterprise-scale operations.

### Auto-Claim (Just-in-Time)
A license is automatically assigned from the pool the first time a subject attempts to access the resource. This minimizes administrative overhead but requires strict monitoring of the license pool to prevent exhaustion.

### Concurrent Assignment
Licenses are not bound to a subject permanently but are checked out from a pool during an active session and returned immediately upon session termination.

## Anti-Patterns

### License Hoarding
Retaining assignments for subjects that no longer require them (e.g., terminated employees or decommissioned devices). This leads to unnecessary costs and "ghost" consumption.

### Manual Reconciliation
Relying on spreadsheets or disconnected systems to track assignments. This creates a "Source of Truth" conflict between the assignment record and the actual state of the resource.

### Over-Assignment (Hard-Coding)
Assigning licenses to generic or shared accounts to bypass per-user tracking. This obscures audit trails and violates most security and compliance frameworks.

## Edge Cases

### Orphaned Assignments
When a subject (e.g., a user account) is deleted from the identity provider, but the license assignment remains "active" in the licensing system. This consumes a seat that cannot be easily recovered without manual intervention.

### Nested Inheritance Conflicts
In group-based licensing, a subject may belong to two groups: one that grants a "Basic" license and one that grants a "Premium" license. The system must have a deterministic resolution logic (usually "Highest Entitlement Wins").

### Offline Assignment
Scenarios where a license must be assigned to a device that does not have a persistent connection to the assignment authority. This usually requires a "lease" mechanism with a pre-defined expiration.

### Transitive Licensing
When assigning a license to a "Parent" entity (e.g., a Virtual Machine Host) automatically grants licenses to all "Child" entities (e.g., Virtual Machines).

## Related Topics
*   **Identity and Access Management (IAM):** The foundation upon which subjects are defined.
*   **License Enforcement:** The technical check that validates an assignment at the point of use.
*   **Software Asset Management (SAM):** The broader discipline of managing the lifecycle of software assets.
*   **Usage Metering:** Tracking how an assigned license is actually used.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |