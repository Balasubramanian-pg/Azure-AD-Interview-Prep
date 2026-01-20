# [Global Catalog SSL Port 3269](11 Key Ports for AD and Azure AD/Global Catalog SSL Port 3269.md)

Canonical documentation for [Global Catalog SSL Port 3269](11 Key Ports for AD and Azure AD/Global Catalog SSL Port 3269.md). This document defines concepts, terminology, and standard usage.

## Purpose
[Global Catalog SSL Port 3269](11 Key Ports for AD and Azure AD/Global Catalog SSL Port 3269.md) exists to provide a secure, encrypted interface for performing directory lookups across a multi-domain forest. In distributed directory environments, the Global Catalog (GC) serves as a central repository containing a partial, read-only replica of every object in the forest. Port 3269 facilitates these forest-wide searches while ensuring data confidentiality, server authenticity, and data integrity through Transport Layer Security (TLS) or Secure Sockets Layer (SSL).

This port addresses the need for applications and services to query directory information that may reside outside their immediate local domain without exposing sensitive identity data to interception or tampering during transit.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative. While Port 3269 is most commonly associated with LDAP-based directory services, the principles described herein apply to any hierarchical directory service utilizing a secure global index.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The functional role of Port 3269 in directory service architectures.
* The security mechanisms (TLS/SSL) governing the port.
* The distinction between standard LDAP SSL (Port 636) and Global Catalog SSL (Port 3269).
* Theoretical traffic flow and handshake requirements.

**Out of scope:**
* Specific vendor-specific configuration steps (e.g., Windows Server UI, Linux OpenLDAP configuration).
* Troubleshooting specific software versions.
* Hardware-level network routing beyond the application layer.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Global Catalog (GC)** | A distributed data repository that contains a searchable, partial representation of every object in every domain in a multi-domain forest. |
| **Port 3269** | The industry-standard TCP port designated for LDAP over SSL/TLS when querying the Global Catalog. |
| **Partial Attribute Set (PAS)** | The specific subset of object attributes replicated to the Global Catalog, optimized for search performance and cross-domain visibility. |
| **Forest** | The highest-level container in a directory service, encompassing all domains, schemas, and configuration information. |
| **Referral** | A mechanism where a directory server directs a client to another server if the requested data is not held locally; the GC minimizes the need for referrals. |

## Core Concepts
### Forest-Wide Visibility
Unlike standard directory ports that focus on a single domain partition, Port 3269 provides a unified view of the entire forest. This allows a client to locate an object (such as a user or a printer) regardless of which domain in the forest actually hosts the object.

### Secure Transport Layer
Port 3269 mandates the use of an encryption layer (TLS or SSL). This ensures:
1.  **Confidentiality:** Data cannot be read by unauthorized parties during transit.
2.  **Integrity:** Data cannot be modified without detection.
3.  **Authentication:** The client can verify the identity of the Global Catalog server via a digital certificate.

### Read-Only Optimization
While the directory itself may be writable, the Global Catalog interface is primarily optimized for read-only search operations. Queries directed to Port 3269 are intended to resolve object locations and basic attributes rather than perform complex directory modifications.

## Standard Model
The standard model for Port 3269 interaction follows a structured request-response pattern over an encrypted channel:

1.  **Connection Initiation:** The client initiates a TCP connection to the server on Port 3269.
2.  **TLS Handshake:** The server presents its X.509 digital certificate. The client validates the certificate against a trusted Root Certificate Authority (CA).
3.  **Session Encryption:** Once the handshake is complete, an encrypted tunnel is established.
4.  **LDAP Bind:** The client authenticates (binds) to the directory service over the encrypted channel.
5.  **Global Query:** The client submits a search request. The server searches its local Global Catalog replica and returns results from any domain in the forest.
6.  **Termination:** The session is closed, and the encrypted tunnel is torn down.

## Common Patterns
*   **Cross-Domain Authentication:** Applications (such as mail servers or VPNs) use Port 3269 to authenticate users who may belong to different child domains within a single forest.
*   **Load Balancing:** High-availability environments often place multiple Global Catalog servers behind a Load Balancer listening on Port 3269 to distribute query load.
*   **Centralized Identity Management:** Identity Providers (IdPs) use Port 3269 as the primary source of truth for forest-wide user attributes during synchronization tasks.

## Anti-Patterns
*   **Using Port 3268 for Sensitive Data:** Querying the Global Catalog over Port 3268 (cleartext) exposes credentials and sensitive attributes to packet sniffing.
*   **Over-Reliance on PAS:** Attempting to retrieve attributes via Port 3269 that are not part of the Partial Attribute Set. This results in missing data, as the GC only stores a subset of attributes.
*   **Direct IP Binding:** Hardcoding specific IP addresses for Port 3269 instead of using DNS-based service records (SRV), which breaks failover and site-awareness.
*   **Ignoring Certificate Revocation:** Failing to check CRL (Certificate Revocation List) or OCSP (Online Certificate Status Protocol) during the TLS handshake on Port 3269.

## Edge Cases
*   **Multi-Forest Environments:** Port 3269 only provides visibility within a single forest. Queries for objects in a separate, trusted forest require a different mechanism (such as Forest Trusts or specific referrals).
*   **Expired Server Certificates:** If the server's certificate expires, Port 3269 will typically refuse connections, potentially causing forest-wide authentication failures for integrated applications.
*   **Firewall Inspection:** Some "Deep Packet Inspection" firewalls may interfere with the TLS handshake on Port 3269 if they are not configured to recognize the specific directory service traffic patterns.
*   **Attribute Promotion:** When a new attribute is added to the Global Catalog (added to the PAS), a full synchronization of all GC servers occurs, which can temporarily increase traffic on Port 3269.

## Related Topics
*   **Port 3268:** The non-encrypted (cleartext) counterpart to Port 3269.
*   **Port 636:** LDAP over SSL for domain-specific (non-GC) queries.
*   **X.509 Certificates:** The standard for the digital certificates used to secure Port 3269.
*   **LDAP (Lightweight Directory Access Protocol):** The underlying protocol used for communication.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |