# [Kerberos Port 88](11 Key Ports for AD and Azure AD/Kerberos Port 88.md)

Canonical documentation for [Kerberos Port 88](11 Key Ports for AD and Azure AD/Kerberos Port 88.md). This document defines concepts, terminology, and standard usage.

## Purpose
[Kerberos Port 88](11 Key Ports for AD and Azure AD/Kerberos Port 88.md) is the industry-standard network port assigned by the Internet Assigned Numbers Authority (IANA) for the Kerberos authentication protocol. It serves as the primary communication channel between clients and the Key Distribution Center (KDC). 

The existence of a dedicated port for Kerberos ensures that authentication requests—specifically the Authentication Service (AS) and Ticket Granting Service (TGS) exchanges—can be routed, filtered, and managed consistently across heterogeneous network environments. It facilitates the "trusted third party" model of authentication, allowing users and services to verify identities without transmitting passwords over the network.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative, focusing on the protocol standards defined in RFC 4120 and related specifications.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The functional role of Port 88 in the Kerberos protocol flow.
* Transport layer requirements (TCP and UDP).
* Interaction between the Client and the KDC via Port 88.
* Network-level considerations for Port 88 availability.

**Out of scope:**
* Specific vendor implementations (e.g., Microsoft Active Directory, MIT Kerberos, Heimdal) except where they illustrate a universal standard.
* Administrative protocols (e.g., kadmin on Port 749 or kpasswd on Port 464).
* Application-level protocols that use Kerberos tickets (e.g., LDAP, SMB, HTTP/SPNEGO).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **KDC** | Key Distribution Center; the network service that acts as the trusted arbitrator, consisting of the Authentication Service and the Ticket Granting Service. |
| **AS (Authentication Service)** | The component of the KDC that verifies a client's identity and issues a Ticket Granting Ticket (TGT). |
| **TGS (Ticket Granting Service)** | The component of the KDC that accepts a TGT and issues service tickets for specific resources. |
| **Principal** | A unique identity (user, host, or service) to which Kerberos can assign tickets. |
| **Realm** | A logical network boundary or domain within which a KDC has the authority to authenticate principals. |
| **Ticket** | A cryptographically secured record issued by the KDC that proves the identity of a principal to a service. |

## Core Concepts
The fundamental utility of Port 88 is to facilitate the exchange of Kerberos messages. The protocol relies on symmetric key cryptography to provide secure authentication over an insecure network.

1.  **The KDC Listener:** The KDC service listens on Port 88 for incoming requests. These requests are typically formatted as `KRB_AS_REQ` (initial login) or `KRB_TGS_REQ` (requesting access to a specific service).
2.  **Transport Versatility:** While originally designed for UDP to minimize overhead, modern Kerberos implementations utilize TCP for Port 88 to handle larger ticket sizes (often caused by extensive authorization data/PACs) that would otherwise result in IP fragmentation.
3.  **Statelessness:** From a network perspective, Port 88 traffic is largely transactional. Each request/response pair is independent, though the state is maintained on the client-side via the credential cache.

## Standard Model
In the standard model, Port 88 acts as the central hub for the "Kerberos Triangle":

1.  **Initial Authentication (AS Exchange):** The client sends a request to Port 88 of the KDC. The KDC responds via Port 88 with an encrypted TGT and a session key.
2.  **Service Ticket Request (TGS Exchange):** When the client needs to access a resource, it presents its TGT to Port 88 of the KDC. The KDC validates the TGT and responds via Port 88 with a service ticket.
3.  **Protocol Preference:** 
    *   Clients typically attempt UDP/88 first.
    *   If the response is too large (exceeding the MTU), the KDC sends a `KRB_ERR_RESPONSE_TOO_BIG` error.
    *   The client then retries the request using TCP/88.

## Common Patterns
*   **Firewall Permissiveness:** In enterprise environments, Port 88 (both TCP and UDP) must be bi-directionally open between all client segments and the KDC infrastructure.
*   **DNS Discovery:** Clients locate the Port 88 listener using SRV records (e.g., `_kerberos._udp.EXAMPLE.COM` or `_kerberos._tcp.EXAMPLE.COM`).
*   **Load Balancing:** High-availability environments often place multiple KDCs behind a load balancer or use Anycast, but the destination port remains 88.

## Anti-Patterns
*   **Blocking TCP/88:** Restricting Port 88 to UDP only. This often leads to intermittent authentication failures when user group memberships grow, causing ticket sizes to exceed the UDP packet limit.
*   **NAT Translation:** Performing Port Address Translation (PAT) on Port 88 can occasionally interfere with certain Kerberos implementations that embed IP addresses within the ticket (though this is less common in modern "addressless" ticket configurations).
*   **Exposing Port 88 to Public WAN:** Opening Port 88 to the internet without a VPN or encrypted tunnel. While Kerberos is cryptographically secure, exposing the KDC increases the attack surface for Denial of Service (DoS) and brute-force attempts.

## Edge Cases
*   **Cross-Realm Authentication:** When a client in Realm A needs a ticket for a service in Realm B, Port 88 communication occurs across realm boundaries. The client must be able to reach the KDCs of both realms on Port 88.
*   **Fragmentation and MTU:** In networks with non-standard MTUs (e.g., VPN tunnels), UDP/88 packets may be dropped if they are fragmented, necessitating a forced switch to TCP/88.
*   **Port Conflict:** While rare, legacy or proprietary services attempting to use Port 88 will prevent the KDC from binding to the socket, effectively halting all authentication for that node.

## Related Topics
*   **Port 464 (kpasswd):** Used for changing or setting passwords; often confused with Port 88.
*   **Port 749 (kadmin):** Used for Kerberos administration and principal management.
*   **RFC 4120:** The primary specification for the Kerberos Network Authentication Service (V5).
*   **GSS-API (Generic Security Services Application Program Interface):** The standard API used by applications to interact with Kerberos.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |