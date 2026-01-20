# [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md)

Canonical documentation for [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md). This document defines concepts, terminology, and standard usage.

## Purpose
[Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md) (now part of the Microsoft Entra suite) exists to bridge the gap between on-premises identity infrastructures and cloud-based identity providers. Its primary purpose is to facilitate a **Hybrid Identity** model, ensuring that users, groups, and devices maintained in local directory services are represented accurately and securely in the cloud. 

By automating the synchronization of identity data, the tool eliminates the need for redundant administrative overhead and provides users with a consistent sign-on experience across heterogeneous environments.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative. While it references specific architectural components of the Microsoft ecosystem, the principles of identity synchronization and lifecycle management described herein apply to the broader discipline of hybrid directory integration.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* **Identity Synchronization:** The mechanisms for replicating objects and attributes from source directories to target cloud directories.
* **Authentication Integration:** The methods for validating user credentials across hybrid boundaries (e.g., Password Hash Sync, Pass-through Authentication).
* **Attribute Mapping and Transformation:** The logic governing how data is translated between different schema definitions.
* **Health Monitoring:** The oversight of synchronization health and alerting.

**Out of scope:**
* **Third-party Identity Providers:** Integration with non-Microsoft identity providers (e.g., Okta, Ping Identity) except where they function as a federation target.
* **Legacy Migration Tools:** Tools specifically designed for one-time migrations rather than ongoing synchronization (e.g., User State Migration Tool).
* **Client-side Application Configuration:** The specific setup of end-user applications to consume the synchronized identities.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Source Anchor** | An immutable attribute used to uniquely identify an object in both the on-premises and cloud directories, ensuring they remain linked regardless of attribute changes (e.g., `mS-DS-ConsistencyGuid`). |
| **Metaverse** | The central, consolidated storage area within the sync engine that holds the combined identity information from all connected directories. |
| **Connector Space** | A staging area that contains a representation of the objects in a specific connected directory (e.g., an on-premises AD forest). |
| **Password Hash Sync (PHS)** | A synchronization method where a hash of the hash of a user's password is synchronized to the cloud, allowing for cloud-native authentication. |
| **Pass-through Authentication (PTA)** | An authentication method where the cloud service validates the user's password directly against the on-premises directory via a lightweight agent. |
| **Writeback** | The process of synchronizing specific attributes or objects from the cloud directory back to the on-premises directory (e.g., Password Writeback, Device Writeback). |
| **Soft-match** | The process of linking an on-premises object to an existing cloud object based on matching primary attributes (usually SMTP address or UPN). |
| **Hard-match** | The process of linking objects using the Source Anchor/ImmutableID. |

## Core Concepts

### The Synchronization Cycle
The engine operates on a cyclical basis, typically consisting of three phases:
1.  **Import:** Data is pulled from the connected directories into their respective Connector Spaces.
2.  **Synchronization:** Rules are applied to move data from the Connector Space to the Metaverse (Inbound) and from the Metaverse to other Connector Spaces (Outbound).
3.  **Export:** Changes staged in the Connector Spaces are pushed to the respective target directories.

### Declarative Provisioning
[Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md) utilizes a rule-based system known as Declarative Provisioning. This allows administrators to define how attributes flow between systems using expressions and functions, rather than custom scripts. It provides a predictable way to handle complex attribute transformations.

### Identity Lifecycle Management
The tool manages the entire lifecycle of an identity:
*   **Provisioning:** Creating the cloud object when a user is created on-premises.
*   **Maintenance:** Updating attributes (e.g., job title, department) as they change.
*   **Deprovisioning:** Disabling or deleting the cloud object when the on-premises source is removed or falls out of sync scope.

## Standard Model
The standard model for [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md) is the **Single Forest, Single Tenant** topology. In this model:
*   A single on-premises Active Directory forest is the authoritative source.
*   A single [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md) server manages the synchronization.
*   A single Azure AD (Microsoft Entra) tenant is the destination.
*   **Password Hash Sync (PHS)** is the recommended authentication method for its resilience and support for leaked credential detection.

## Common Patterns

### Staging Mode
A high-availability and safety pattern where a second [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md) server is installed but does not export data to the directories. It processes imports and synchronizations to the Metaverse, allowing an administrator to verify changes before "promoting" it to active status.

### Multi-Forest Consolidation
A pattern used by large organizations where multiple disconnected on-premises forests are synchronized to a single cloud tenant. The sync engine resolves duplicate identities across forests by joining them into a single Metaverse object based on shared attributes (like mail).

### Filtering
The practice of limiting which objects are synchronized to the cloud. Common patterns include:
*   **Domain-based:** Only specific domains in a forest.
*   **OU-based:** Only specific Organizational Units.
*   **Attribute-based:** Only objects with a specific attribute value (e.g., `extensionAttribute15 == "SyncToCloud"`).

## Anti-Patterns

### Direct Database Manipulation
Attempting to modify the underlying SQL Server database used by [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md). This voids support and leads to database corruption or synchronization failure. All changes must be made via the Synchronization Rules Editor.

### Overlapping Sync Servers
Running two active (non-staging) sync servers targeting the same tenant and the same source objects. This causes "flapping," where attributes are constantly overwritten, leading to identity instability.

### Ignoring the "Source of Truth"
Manually editing synchronized attributes in the cloud portal. Because the on-premises directory is the authoritative source, these changes will be overwritten during the next synchronization cycle.

## Edge Cases

### Disconnected Forests
When an organization has forests with no network connectivity between them. [Azure AD Connect](02 Azure Active Directory/Azure AD Connect.md) must have line-of-sight to all domain controllers it manages. If connectivity is impossible, a decentralized architecture (like multiple sync tools or cloud sync agents) may be required.

### Large Group Handling
Synchronizing groups with memberships exceeding 50,000 members can lead to performance degradation and synchronization timeouts. Standard practice involves breaking large groups into nested sub-groups or utilizing cloud-native dynamic groups.

### Source Anchor Changes
Changing the attribute used as the Source Anchor after synchronization has been established is a destructive operation. It requires a full "matching" exercise and can lead to the deletion and recreation of all cloud objects if not handled via a specific migration path.

## Related Topics
*   **Microsoft Entra Cloud Sync:** A lightweight agent-based synchronization alternative for specific use cases.
*   **Active Directory Federation Services (AD FS):** A legacy authentication method often used in conjunction with sync for complex authorization requirements.
*   **Directory Extensions:** The process of extending the cloud schema to accommodate custom on-premises attributes.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |