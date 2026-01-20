# [Azure AD Connect Port 443](11 Key Ports for AD and Azure AD/Azure AD Connect Port 443.md)

Canonical documentation for [Azure AD Connect Port 443](11 Key Ports for AD and Azure AD/Azure AD Connect Port 443.md). This document defines concepts, terminology, and standard usage.

## Purpose
The use of Port 443 in the context of Azure AD Connect (now part of Microsoft Entra Connect) serves as the primary secure transport mechanism for identity synchronization between on-premises directories and cloud-based identity providers. It exists to ensure that sensitive identity data—including user attributes, group memberships, and credential hashes—is transmitted over an encrypted, authenticated channel. 

By utilizing the standard HTTPS protocol, Port 443 facilitates communication through most corporate firewalls and proxies while maintaining the confidentiality and integrity of the identity perimeter.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative regarding the architectural requirements of the transport layer.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The role of Transmission Control Protocol (TCP) Port 443 in identity synchronization.
* Requirements for Transport Layer Security (TLS) and certificate validation.
* Outbound connectivity requirements and endpoint categorization.
* The impact of traffic inspection on identity data streams.

**Out of scope:**
* Configuration steps for specific firewall hardware (e.g., Cisco, Palo Alto, Checkpoint).
* Troubleshooting specific software-defined networking (SDN) bugs.
* Non-HTTPS ports (e.g., Port 80 for CRLs, though mentioned as a dependency).

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Outbound Connectivity** | Traffic initiated from the internal synchronization server toward the cloud service provider. |
| **TLS Termination** | The process of decrypting traffic at an intermediary device (like a proxy) before re-encrypting it to the final destination. |
| **Endpoint** | A specific URL or IP address range representing a cloud service destination. |
| **CRL (Certificate Revocation List)** | A list of digital certificates that have been revoked by the issuing Certificate Authority before their scheduled expiration date. |
| **Mutual Authentication** | A process where both the client and the server verify each other's identities via certificates. |

## Core Concepts
### The Secure Transport Layer
Port 443 is the industry standard for HTTPS. In the context of identity synchronization, it is used to wrap the SOAP or REST-based API calls made by the synchronization engine. This ensures that even if packets are intercepted, the identity data remains unreadable to unauthorized parties.

### Directionality
Communication over Port 443 for Azure AD Connect is strictly **outbound**. The synchronization server initiates the connection to the cloud service. No inbound ports are required to be opened from the internet to the on-premises synchronization server for standard identity sync operations.

### Certificate Validation
Because Port 443 relies on TLS, the synchronization server must be able to validate the SSL/TLS certificates presented by the cloud endpoints. This requires the server to have access to the relevant Root Certificate Authorities (CAs) and the ability to check revocation status (often via Port 80 or 443).

## Standard Model
The standard model for Port 443 usage involves a "Direct or Proxy" outbound path:

1.  **Initiation:** The Sync Engine initiates a TLS handshake to a predefined cloud endpoint (e.g., `*.msappproxy.net` or `*.servicebus.windows.net`).
2.  **Negotiation:** The server and cloud endpoint negotiate the highest supported TLS version (standardized at TLS 1.2 or higher).
3.  **Authentication:** The cloud service presents a certificate. The sync server validates this against its local trusted root store.
4.  **Data Transfer:** Identity objects are batched and transmitted via encrypted payloads.

## Common Patterns
*   **Proxy Bypass:** Configuring the synchronization server to bypass authenticated proxies to avoid latency and potential connection drops during large sync cycles.
*   **FQDN Filtering:** Restricting outbound Port 443 traffic to a specific list of Fully Qualified Domain Names (FQDNs) rather than allowing all outbound 443 traffic.
*   **Split-Brain DNS:** Ensuring that the synchronization server resolves cloud endpoints to their public IP addresses even if internal DNS overrides exist for other services.

## Anti-Patterns
*   **Inbound Port Opening:** Opening Port 443 for inbound traffic from the internet to the sync server. This increases the attack surface unnecessarily.
*   **SSL Inspection/Interception:** Decrypting and re-encrypting Port 443 traffic at a firewall or proxy. This often breaks the trust chain, interferes with certificate pinning, and can lead to synchronization failures.
*   **Hardcoding IP Addresses:** Relying on specific IP addresses for firewall rules instead of FQDNs. Cloud service IPs are dynamic and subject to frequent change.
*   **Disabling CRL Checks:** Turning off Certificate Revocation List checks to bypass firewall restrictions, which compromises the security of the TLS connection.

## Edge Cases
*   **Air-Gapped Environments:** Environments with no direct internet access require a "Staging Mode" server or a complex proxy chain to bridge the gap, though Port 443 remains the protocol of choice for the final hop.
*   **High-Latency Satellite Links:** In scenarios with extreme latency, the standard TLS handshake on Port 443 may timeout, requiring adjustment of TCP window sizes or specialized WAN optimization that does not interfere with encryption.
*   **Certificate Pinning:** If the cloud service implements certificate pinning, any intermediary device attempting to present a different certificate (even if trusted) will cause the connection to be severed.

## Related Topics
*   **TLS 1.2/1.3 Protocols:** The underlying encryption standards used over Port 443.
*   **Port 80 (HTTP):** Used specifically for CRL and OCSP checks to validate the certificates used on Port 443.
*   **Microsoft Entra Connect Health:** A related service that also utilizes Port 443 for monitoring telemetry.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |