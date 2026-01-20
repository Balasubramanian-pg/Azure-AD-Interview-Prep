# [LDAP Port 389](11 Key Ports for AD and Azure AD/LDAP Port 389.md)

Canonical documentation for [LDAP Port 389](11 Key Ports for AD and Azure AD/LDAP Port 389.md). This document defines concepts, terminology, and standard usage.

## Purpose
[LDAP Port 389](11 Key Ports for AD and Azure AD/LDAP Port 389.md) is the industry-standard network port assigned by the Internet Assigned Numbers Authority (IANA) for the Lightweight Directory Access Protocol (LDAP). It exists to provide a predictable, standardized entry point for clients to access and manage distributed directory information services. 

The primary problem space addressed by Port 389 is the need for a uniform communication channel between Directory User Agents (DUAs) and Directory System Agents (DSAs). It facilitates the querying, modification, and authentication of entries within a Directory Information Tree (DIT) over Internet Protocol (IP) networks.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The functional role of Port 389 in the TCP/IP stack.
* Protocol behavior for both unencrypted and StartTLS-secured sessions.
* Standard communication flows (TCP and UDP/CLDAP).
* Theoretical boundaries of the port's lifecycle and security posture.

**Out of scope:**
* Specific vendor implementations (e.g., Microsoft Active Directory, OpenLDAP, 389 Directory Server).
* Configuration syntax for specific firewall software or load balancers.
* Detailed cryptographic analysis of TLS ciphers.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **LDAP** | Lightweight Directory Access Protocol; an open, vendor-neutral, industry-standard application protocol for accessing and maintaining distributed directory information services. |
| **DSA** | Directory System Agent; the server-side component that hosts the directory and responds to requests on Port 389. |
| **DUA** | Directory User Agent; the client-side application or service initiating a connection to Port 389. |
| **StartTLS** | An opportunistic security mechanism that upgrades an existing insecure connection on Port 389 to a secure connection using TLS. |
| **CLDAP** | Connectionless LDAP; the use of Port 389 over UDP for limited, high-performance directory queries. |
| **Bind** | The operation used to authenticate a client to the directory server over the established port. |

## Core Concepts
[LDAP Port 389](11 Key Ports for AD and Azure AD/LDAP Port 389.md) operates primarily at the Application Layer (Layer 7) of the OSI model, utilizing the Transmission Control Protocol (TCP) for reliable, connection-oriented communication. 

### Transport Protocols
*   **TCP 389:** The standard transport for the majority of LDAP operations, including searches, binds, and modifications. It ensures data integrity and ordered delivery.
*   **UDP 389:** Used for Connectionless LDAP (CLDAP). This is typically restricted to basic "rootDSE" queries or server location services where the overhead of a TCP handshake is undesirable.

### Security State Transition
Unlike Port 636 (LDAPS), which mandates SSL/TLS from the moment of connection, Port 389 begins as a cleartext channel. It may remain in cleartext for non-sensitive operations or be upgraded to an encrypted state via the `StartTLS` extended operation.

## Standard Model
The standard model for Port 389 follows a request-response paradigm:

1.  **Session Initiation:** The DUA initiates a TCP three-way handshake with the DSA on Port 389.
2.  **Security Negotiation (Optional):** If the DUA and DSA support it, a `StartTLS` request is sent. Upon a successful handshake, all subsequent data on Port 389 is encrypted.
3.  **Authentication (Bind):** The DUA authenticates itself. This can be an "Anonymous Bind," "Simple Bind" (password-based), or "SASL Bind" (framework-based).
4.  **Operation Execution:** The DUA performs operations (Search, Compare, Add, Delete, Modify).
5.  **Session Termination:** The DUA sends an `Unbind` request, and the TCP connection is closed.

## Common Patterns
*   **StartTLS Upgrade:** Using Port 389 with StartTLS is the modern standard for directory communication, as it allows for a single port to handle both secure and (where permitted) insecure traffic, simplifying firewall configurations.
*   **Load Balancing:** Port 389 is frequently targeted by Layer 4 load balancers to distribute directory traffic across a cluster of DSAs.
*   **Proxying:** LDAP proxies often listen on Port 389 to intercept, transform, or route requests to backend directory stores.

## Anti-Patterns
*   **Cleartext Authentication:** Transmitting "Simple Bind" credentials over Port 389 without first invoking StartTLS. This exposes sensitive credentials to packet sniffing.
*   **Hardcoding Port 389:** Hardcoding the port number in application logic rather than using SRV records (Service Records) for discovery, which limits environment flexibility.
*   **Mixing Traffic Types:** Using Port 389 for non-LDAP traffic or proprietary protocols that do not adhere to the LDAP specifications.
*   **Exposing to Public Internet:** Allowing unrestricted inbound traffic to Port 389 from the public internet, which invites brute-force attacks and reconnaissance.

## Edge Cases
*   **Port 3268 (Global Catalog):** In multi-domain environments, Port 389 is used for domain-specific queries, while a separate port (3268) is often used for forest-wide searches. Confusing these can lead to incomplete search results.
*   **Firewall "Fixups":** Some legacy firewalls perform "LDAP inspection" on Port 389. This can inadvertently break StartTLS negotiations because the firewall does not recognize the encrypted payload as valid LDAP traffic.
*   **UDP Fragmentation:** Large CLDAP responses over UDP 389 may exceed the Maximum Transmission Unit (MTU), leading to packet fragmentation and potential drops in restrictive network environments.

## Related Topics
*   **LDAP Port 636 (LDAPS):** The legacy method of securing LDAP via "Implicit SSL/TLS."
*   **RFC 4511:** The core specification for LDAP v3.
*   **SASL (Simple Authentication and Security Layer):** A framework for authentication often used over Port 389.
*   **DNS SRV Records:** The mechanism for discovering DSAs listening on Port 389.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |