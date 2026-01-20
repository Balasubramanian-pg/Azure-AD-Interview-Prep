# [List All Users](02 Azure Active Directory/List All Users.md)

Canonical documentation for [List All Users](02 Azure Active Directory/List All Users.md). This document defines concepts, terminology, and standard usage.

## Purpose
The "[List All Users](02 Azure Active Directory/List All Users.md)" operation serves as a foundational administrative and operational capability within identity management systems. Its primary purpose is to provide a structured overview of the identity population within a defined system or domain. This capability addresses the need for system visibility, auditing, user management, and data synchronization. It allows administrators and automated processes to discover, inspect, and iterate through the set of principals recognized by the system.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
*   The conceptual framework for retrieving a collection of user identities.
*   Standard mechanisms for data navigation (pagination, filtering, and sorting).
*   Security and privacy considerations inherent in bulk identity disclosure.
*   Data consistency and performance expectations in distributed systems.

**Out of scope:**
*   Specific database query syntax (e.g., SQL, NoSQL).
*   Vendor-specific API endpoints or SDK implementations.
*   User creation, deletion, or modification workflows.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Principal** | An entity that can be authenticated and authorized within a system, typically representing a human user or a service account. |
| **Identity Store** | The authoritative repository where user records and attributes are persisted. |
| **Pagination** | The process of dividing a large result set into discrete, manageable chunks (pages). |
| **Filtering** | The application of criteria to include or exclude specific users from the result set based on attributes. |
| **Projection** | The selection of a specific subset of user attributes to be returned, rather than the full user object. |
| **Cursor** | An opaque pointer used in pagination to mark the position in the dataset for subsequent retrieval. |

## Core Concepts
The "[List All Users](02 Azure Active Directory/List All Users.md)" operation is governed by three core pillars:

1.  **Identity Discovery:** The ability to locate and identify all active, inactive, or specific subsets of users within a system.
2.  **Resource Management:** The balancing of data completeness against system performance. Retrieving a total population in a single request is often computationally expensive and risky.
3.  **Access Control:** The enforcement of the Principle of Least Privilege. Listing users often exposes Personally Identifiable Information (PII), requiring strict authorization checks before execution.

## Standard Model
The standard model for listing users follows a Request/Response pattern designed for scalability and predictability.

### The Request Model
A standard request should support:
*   **Selection Criteria:** Filters (e.g., `status=active`, `group=admin`).
*   **Pagination Parameters:** Limits (page size) and offsets or cursors.
*   **Sort Order:** Specification of the attribute and direction (ascending/descending) for ordering.
*   **Attribute Selection:** A list of requested fields to minimize payload size.

### The Response Model
A standard response must include:
*   **The Collection:** An array of user objects.
*   **Metadata:** Information about the result set, such as the total count of users matching the criteria and pagination tokens for the next/previous set.
*   **Consistency Indicator:** (Optional) Information regarding the "freshness" of the data in eventually consistent systems.

## Common Patterns
*   **Cursor-Based Pagination:** Using a unique identifier or timestamp to fetch the "next" set of records. This is preferred for high-frequency or large-scale datasets to avoid the performance degradation associated with deep offsets.
*   **Offset-Based Pagination:** Using a numerical skip/limit approach. Common in smaller datasets or where random access to specific pages is required.
*   **Search-Driven Listing:** Utilizing an inverted index to allow for complex text-based filtering and high-speed retrieval of user subsets.
*   **Summary vs. Detail Views:** Returning a "lightweight" version of the user list (e.g., IDs and Display Names) with a separate mechanism to fetch full profiles.

## Anti-Patterns
*   **Unbounded Requests:** Attempting to return the entire user population in a single response without pagination. This leads to timeouts, memory exhaustion, and denial-of-service vulnerabilities.
*   **Over-Fetching:** Returning sensitive attributes (e.g., hashed passwords, internal metadata, or private contact info) by default in a list view.
*   **Inconsistent Sorting:** Failing to provide a deterministic sort order, which causes records to be skipped or duplicated during paginated navigation.
*   **Lack of Rate Limiting:** Allowing unrestricted bulk listing, which can be exploited for data scraping or system enumeration.

## Edge Cases
*   **Empty Result Sets:** The system must distinguish between a successful request with zero matches and a failed request.
*   **Concurrent Mutations:** Handling scenarios where users are added or deleted while a consumer is paginating through the list (the "sliding window" problem).
*   **Soft-Deleted Users:** Determining whether "all users" includes those marked for deletion but still present in the database.
*   **Large-Scale Skew:** Performance issues arising when a filter matches a disproportionately large percentage of the total population (e.g., "List all users where `type=human`" in a system with 100 million humans).

## Related Topics
*   **User Profile Management:** The lifecycle of individual user data.
*   **Role-Based Access Control (RBAC):** Determining who has the permission to list users.
*   **Data Privacy and Compliance (GDPR/CCPA):** Legal requirements regarding the visibility and export of user lists.
*   **Audit Logging:** Recording who accessed the user list and when.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |