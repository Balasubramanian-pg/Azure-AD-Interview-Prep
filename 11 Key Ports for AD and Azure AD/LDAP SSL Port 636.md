# [LDAP SSL Port 636](11 Key Ports for AD and Azure AD/LDAP SSL Port 636.md)

Canonical documentation for [LDAP SSL Port 636](11 Key Ports for AD and Azure AD/LDAP SSL Port 636.md). This document defines concepts, terminology, and standard usage.

## Purpose
The purpose of LDAP SSL (LDAPS) on Port 636 is to provide a secure, encrypted channel for the Lightweight Directory Access Protocol (LDAP). By default, standard LDAP (Port 389) transmits data in cleartext, which poses a significant security risk as directory services often handle sensitive information, including user credentials, personally identifiable information (PII), and organizational metadata. Port 636 addresses this by wrapping the LDAP protocol within a Secure Sockets Layer (SSL) or Transport Layer Security (TLS) tunnel from the moment the connection is established.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The architectural role of Port 636 in directory services.
* The mechanism of implicit SSL/TLS negotiation.
* Security requirements for establishing connections over Port 636.
* Comparison between implicit and explicit encryption models.

**Out of scope:**
* Specific vendor configuration steps (e.g., Active Directory, OpenLDAP, 389 Directory Server).
* Detailed cryptographic algorithm specifications (e.g., specific cipher suite mathematics).
* Network-layer routing or firewall hardware configuration.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **LDAPS** | LDAP over SSL/TLS; the practice of running LDAP over a dedicated encrypted port. |
| **Port 636** | The IANA-assigned default TCP port for LDAP over SSL. |
| **Implicit SSL** | A security model where the connection is encrypted immediately upon establishment, before any protocol-specific data is exchanged. |
| **X.509 Certificate** | A digital document used to prove the ownership of a public key, essential for the TLS handshake on Port 636. |
| **Handshake** | The initial negotiation process between client and server to establish security parameters and verify identities. |
| **Trust Store** | A repository of CA certificates on the client side used to verify the authenticity of the server's certificate. |

## Core Concepts
### Implicit Encryption
Unlike STARTTLS (which uses Port 389 and upgrades a cleartext connection to an encrypted one), Port 636 utilizes **Implicit SSL**. This means the server expects a TLS handshake to occur immediately after the TCP connection is accepted. If the client attempts to send raw LDAP commands before completing the handshake, the server will terminate the connection.

### Confidentiality and Integrity
Port 636 ensures two primary security pillars:
1.  **Confidentiality:** Data is encrypted, preventing eavesdroppers from reading sensitive directory information or passwords.
2.  **Integrity:** Data cannot be modified in transit without detection, preventing "man-in-the-middle" (MITM) attacks from altering directory queries or responses.

### Authentication via Certificates
The security of Port 636 relies on the server presenting a valid X.509 certificate. The client must be able to validate this certificate against a trusted Certificate Authority (CA). Without this validation, the connection is susceptible to interception.

## Standard Model
The standard model for Port 636 follows a strict sequence of operations:

1.  **Connection Initiation:** The client opens a TCP connection to the server on Port 636.
2.  **TLS Handshake:** The server immediately presents its digital certificate. The client verifies the certificate's validity (expiration, hostname match, and trust chain).
3.  **Session Key Exchange:** Once trust is established, the client and server negotiate symmetric encryption keys.
4.  **LDAP Protocol Exchange:** The LDAP "Bind" request and subsequent operations (Search, Modify, Add) occur within the encrypted tunnel.
5.  **Termination:** The session is closed, and the encrypted tunnel is torn down.

## Common Patterns
*   **Load Balancing:** In high-availability environments, Port 636 traffic is often routed through a Load Balancer. The balancer may either "pass through" the SSL (SSL Passthrough) or terminate the SSL (SSL Termination) and re-encrypt it to the backend.
*   **Certificate Pinning:** Some high-security clients are configured to trust only a specific server certificate rather than any certificate issued by a CA.
*   **Mutual TLS (mTLS):** In some configurations, the server also requires the client to present a certificate, ensuring that only authorized devices can even attempt an LDAP bind.

## Anti-Patterns
*   **Ignoring Certificate Validation:** Configuring clients to "trust all certificates" or "ignore certificate errors." This negates the security benefits of Port 636 by allowing MITM attacks.
*   **Hardcoding IP Addresses:** Using an IP address instead of a Fully Qualified Domain Name (FQDN) for the LDAP server. Since certificates are usually bound to a hostname, this often leads to validation failures.
*   **Mixing Security Models:** Attempting to issue a `STARTTLS` command over an already encrypted Port 636 connection. This is redundant and often leads to protocol errors.
*   **Self-Signed Certificates without Distribution:** Using self-signed certificates on the server without manually importing them into the client's trust store.

## Edge Cases
*   **Protocol Version Mismatch:** If a client supports only TLS 1.1 and the server requires TLS 1.3, the connection on Port 636 will fail during the handshake, often providing vague "connection reset" errors.
*   **Hostname Mismatch (SAN):** If the server's certificate does not include the specific DNS name the client is using to connect (in the Subject Alternative Name field), the handshake will fail even if the certificate is otherwise valid.
*   **Firewall Inspection:** Some "Next-Gen" firewalls attempt to perform Deep Packet Inspection (DPI) on Port 636. If the firewall replaces the server's certificate with its own for inspection purposes, the client must trust the firewall's CA.

## Related Topics
*   **[LDAP Port 389](11 Key Ports for AD and Azure AD/LDAP Port 389.md):** The standard port for unencrypted LDAP or LDAP with STARTTLS.
*   **STARTTLS:** The mechanism for upgrading an insecure connection to a secure one on Port 389.
*   **Global Catalog (Port 3269):** The SSL-encrypted version of the Microsoft Active Directory Global Catalog port.
*   **X.509 PKI:** The underlying infrastructure for managing digital certificates.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |