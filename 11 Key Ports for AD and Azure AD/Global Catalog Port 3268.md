# [Global Catalog Port 3268](11 Key Ports for AD and Azure AD/Global Catalog Port 3268.md)

Canonical documentation for [Global Catalog Port 3268](11 Key Ports for AD and Azure AD/Global Catalog Port 3268.md). This document defines concepts, terminology, and standard usage.

## Purpose
[Global Catalog Port 3268](11 Key Ports for AD and Azure AD/Global Catalog Port 3268.md) exists to facilitate efficient, forest-wide searches within a distributed directory service. In environments comprising multiple domain partitions, a standard directory query (typically via Port 389) is restricted to the local domain partition. Port 3268 provides a centralized entry point for clients to query objects across all domains in a forest without requiring knowledge of the specific domain where an object resides.

The primary problem space addressed by Port 3268 is the "Referral" overhead. Without a global catalog port, a client searching for a user in a different domain would receive an LDAP referral, necessitating a new connection to a different controller. Port 3268 eliminates this by providing a unified, though partial, view of every object in the entire directory hierarchy.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative regarding the architectural role of the Global Catalog service over LDAP.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The architectural role of Port 3268 in multi-domain environments.
* The behavior of LDAP queries directed at the Global Catalog.
* The distinction between full domain partitions and the Partial Attribute Set (PAS).
* Network-level requirements for cross-boundary directory discovery.

**Out of scope:**
* Specific vendor-specific GUI configuration steps (e.g., Microsoft AD Sites and Services).
* Port 3269 (LDAPS/SSL), which is the encrypted counterpart to 3268.
* Hardware sizing for Global Catalog servers.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Global Catalog (GC)** | A distributed data repository that contains a searchable, partial representation of every object in every domain in a multi-domain directory forest. |
| **Partial Attribute Set (PAS)** | A subset of object attributes (e.g., Display Name, Logon Name, SID) that are replicated to the Global Catalog for forest-wide searching. |
| **Forest** | The outermost logical container for a directory service, encompassing all domains, schemas, and configuration partitions. |
| **Referral** | A response from a directory server indicating that the requested data resides on a different server, requiring the client to initiate a new connection. |
| **Read-Only Partition** | A copy of a domain partition that cannot be modified directly; the Global Catalog hosts read-only copies of all domains except its own. |

## Core Concepts

### Forest-Wide Visibility
The fundamental concept of Port 3268 is the aggregation of metadata. While a standard LDAP port (389) provides deep access to a single domain, Port 3268 provides broad access to the entire forest. This is critical for services that must authenticate or locate users regardless of their specific domain membership.

### The Partial Attribute Set (PAS)
To maintain performance and reduce replication traffic, Port 3268 does not return every attribute of an object. Only attributes marked for replication to the Global Catalog are available. If a query requests an attribute not in the PAS, the Global Catalog will return a null value or an empty result, even if that data exists in the object's home domain.

### Referral Suppression
When a client queries Port 3268, the server is designed to resolve the query internally using its local Global Catalog database. Unlike Port 389, which may return an LDAP referral (LDAP result code 10) when an object is not found locally, Port 3268 is intended to provide a definitive "Found" or "Not Found" response for the entire forest.

## Standard Model

In the standard model of directory interaction, Port 3268 serves as the **Discovery Layer**.

1.  **Connection:** The client initiates a TCP connection to Port 3268 on a designated Global Catalog server.
2.  **Search Request:** The client submits an LDAP search filter (e.g., `(sAMAccountName=jdoe)`).
3.  **Scope:** The search scope is typically set to "Subtree" to encompass the entire forest.
4.  **Resolution:** The server searches its local partial replicas of all domains.
5.  **Response:** The server returns the object's Distinguished Name (DN) and the requested attributes (provided they are in the PAS).

## Common Patterns

### Universal Group Membership Resolution
During the authentication process, the system must determine a user's membership in "Universal Groups." Because these groups can contain members from any domain, the authentication service queries Port 3268 to ensure all relevant security identifiers (SIDs) are included in the user's access token.

### Multi-Domain Search Proxies
Applications that are "domain-unaware" (e.g., an email system or a third-party HR tool) are configured to point to Port 3268. This allows the application to treat the entire forest as a single, flat directory.

### Site-Aware Discovery
Clients typically use DNS service records (`_gc._tcp.<site>._sites.<forest>`) to locate the nearest Global Catalog server offering Port 3268 to minimize latency across Wide Area Networks (WAN).

## Anti-Patterns

### Writing to Port 3268
The Global Catalog is primarily a read-only service for partitions other than the server's home domain. Attempting to perform LDAP "Add," "Modify," or "Delete" operations on Port 3268 for objects outside the local domain will result in failure. Writes should always be directed to the standard LDAP port (389) of the object's specific domain controller.

### Querying Non-PAS Attributes
Requesting attributes that are not part of the Partial Attribute Set via Port 3268 is a common mistake. This results in incomplete data. If a specific, non-standard attribute is required for a forest-wide search, that attribute must be explicitly added to the PAS via schema modification.

### Over-Reliance on a Single GC
In large environments, pointing all applications to a single Global Catalog server creates a single point of failure and a performance bottleneck. The standard model dictates using a load balancer or DNS-based site-awareness.

## Edge Cases

### Single-Domain Forests
In a forest containing only one domain, the data available on Port 3268 is functionally identical to the data on Port 389 (as the "partial" set effectively covers the only existing domain). However, Port 3268 still behaves according to GC rules (e.g., no referrals).

### Deep Attribute Requirements
If an application requires a full attribute set for an object found via Port 3268, the correct pattern is a two-step process:
1.  Search Port 3268 to find the object's Distinguished Name (DN) and home domain.
2.  Connect to Port 389 of the home domain to retrieve the full attribute list.

### Multi-Forest Environments
Port 3268 is limited to a single forest. It cannot resolve objects in a different forest, even if a trust relationship exists. For cross-forest searches, specialized solutions like Forest Trust Referrals or Meta-Directories are required.

## Related Topics
* **LDAP (Lightweight Directory Access Protocol):** The underlying protocol used by Port 3268.
* **DNS SRV Records:** The mechanism used by clients to locate Port 3268 services.
* **Port 389 (LDAP):** The standard port for domain-specific directory access.
* **Port 3269 (LDAPS):** The secure, SSL/TLS-encrypted version of the Global Catalog port.
* **Partial Attribute Set (PAS):** The specific schema configuration defining what data is available on Port 3268.

## Change Log

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |