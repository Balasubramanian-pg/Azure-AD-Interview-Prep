# [AD FS Port 443](11 Key Ports for AD and Azure AD/AD FS Port 443.md)

Canonical documentation for [AD FS Port 443](11 Key Ports for AD and Azure AD/AD FS Port 443.md). This document defines concepts, terminology, and standard usage.

## Purpose
The use of Port 443 in Active Directory Federation Services (AD FS) serves as the primary transport layer for secure identity federation and access management. It facilitates the exchange of security tokens, authentication requests, and metadata between clients, federation proxies, and the federation service itself. 

By utilizing the standard Hypertext Transfer Protocol Secure (HTTPS) port, AD FS ensures that all identity-related traffic is encrypted via Transport Layer Security (TLS), maintaining the confidentiality and integrity of sensitive claims-based data as it traverses network boundaries.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The functional role of Port 443 in the federation lifecycle.
* Requirements for TLS termination and certificate binding.
* Traffic flow patterns between internal and external network segments.
* Theoretical requirements for secure endpoint exposure.

**Out of scope:**
* Specific hardware load balancer configuration steps.
* Step-by-step Windows Server installation guides.
* Troubleshooting specific firewall vendor software.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Federation Service** | The logical entity that issues security tokens based on authenticated identities. |
| **Federation Proxy** | A gateway component (typically in a DMZ) that forwards Port 443 traffic to the internal Federation Service. |
| **TLS Termination** | The process of decrypting encrypted traffic at a load balancer or proxy before forwarding it. |
| **SNI (Server Name Indication)** | An extension of the TLS protocol that allows a server to host multiple TLS certificates on a single IP address/port. |
| **Claims-based Identity** | An abstract approach to identity where information about a user is packaged into a signed token. |
| **Passive Request** | Authentication requests originating from web browsers using standard HTTPS redirects. |

## Core Concepts
### The Role of TLS
Port 443 is synonymous with TLS in the context of AD FS. Because federation involves the transmission of "claims" (which may include usernames, email addresses, and group memberships), encryption is mandatory. The port acts as the entry point for all modern authentication protocols supported by the service, including SAML, WS-Federation, and OAuth/OpenID Connect.

### Endpoint Mapping
The Federation Service exposes specific paths (endpoints) over Port 443. These endpoints handle different functions, such as:
* **Metadata Exchange:** Providing the public keys and service locations to relying parties.
* **Token Issuance:** The actual processing of credentials and issuance of assertions.
* **User Interaction:** Login pages, password change portals, and logout confirmations.

### Certificate Binding
For Port 443 to function, a Service Communication Certificate must be bound to the port. This certificate establishes the identity of the Federation Service to the client, preventing man-in-the-middle attacks.

## Standard Model
The standard model for Port 443 deployment involves a multi-tier architecture:

1.  **External Layer:** Clients initiate requests to the Federation Service URL via Port 443.
2.  **Proxy Layer:** A Federation Proxy (or Web Application Proxy) receives the Port 443 traffic in the DMZ. It validates the request at the application layer.
3.  **Internal Layer:** The Proxy forwards the request to the internal Federation Service over Port 443.
4.  **Identity Store:** The Federation Service authenticates the user against the directory and returns a token back through the chain.

In this model, Port 443 must be bi-directionally open between the Proxy and the internal Service, and inbound from the Internet to the Proxy.

## Common Patterns
### SSL Bridging (Re-encryption)
The most secure and common pattern where Port 443 traffic is terminated at a load balancer or proxy to be inspected, and then a new Port 443 session is initiated to the backend server. This ensures end-to-end encryption while allowing for traffic filtering.

### Split-Brain DNS
A pattern where the Federation Service URL resolves to a Proxy IP address for external clients and the internal Service IP address for internal clients, all while maintaining Port 443 as the consistent access point.

### SNI-Based Routing
Utilizing Server Name Indication to host multiple federation entities or related services on the same IP address, differentiating traffic based on the hostname provided in the TLS handshake.

## Anti-Patterns
*   **SSL Offloading to HTTP:** Terminating TLS at a load balancer and sending unencrypted traffic (Port 80) to the Federation Service. This is highly discouraged as it exposes sensitive tokens in plain text within the internal network.
*   **Non-Standard Port Usage:** Configuring the Federation Service to listen on a port other than 443 for standard client traffic. This often leads to firewall traversal issues and breaks standard protocol expectations for web browsers.
*   **Direct Exposure:** Placing the internal Federation Service directly on the public internet without a proxy layer, increasing the attack surface of the identity infrastructure.

## Edge Cases
### User Certificate Authentication (Port 49443)
While Port 443 is the standard, certain certificate-based authentication flows (especially for mobile devices or specific smart card implementations) require a separate port—traditionally **49443**. This is used to avoid conflicts with standard TLS handshakes when mutual TLS (mTLS) is required.

### Port 443 Multiplexing
In environments where a single public IP must host multiple services (e.g., AD FS and a web server), complex routing based on the URL path or SNI is required. This can lead to "certificate mismatch" errors if the routing layer is not configured to handle the specific AD FS hostname correctly.

### Legacy Client Support
Older clients that do not support SNI may fail to connect to a Port 443 endpoint if the server is hosting multiple certificates. This requires a "fallback" or "default" certificate binding on the port.

## Related Topics
*   **SAML 2.0 Protocol:** The primary XML-based framework for exchanging authentication data.
*   **OAuth 2.0 / OpenID Connect:** Modern authorization and identity layers that utilize Port 443 for RESTful API calls.
*   **Transport Layer Security (TLS):** The underlying cryptographic protocol for Port 443.
*   **Web Application Proxy (WAP):** The standard architectural component for exposing Port 443 to external networks.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |