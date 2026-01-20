# [SMB Port 445](11 Key Ports for AD and Azure AD/SMB Port 445.md)

Canonical documentation for [SMB Port 445](11 Key Ports for AD and Azure AD/SMB Port 445.md). This document defines concepts, terminology, and standard usage.

## Purpose
Port 445 is the standard transport for "Direct Hosted" Server Message Block (SMB) over TCP/IP. Its primary purpose is to facilitate the sharing of resources—such as files, printers, and serial ports—and to provide a transport mechanism for Inter-Process Communication (IPC) via named pipes.

Historically, SMB required a NetBIOS abstraction layer to function over TCP/IP (using ports 137, 138, and 139). Port 445 was introduced to eliminate the overhead and complexity of NetBIOS, allowing SMB to run directly on the TCP stack. This transition streamlined network communication and simplified name resolution within local and wide area networks.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The functional role of TCP Port 445 in network architectures.
* The transition from NetBIOS-dependent SMB to Direct Hosted SMB.
* Protocol-level requirements for establishing connections over Port 445.
* Security considerations inherent to the port's exposure.

**Out of scope:**
* Specific vendor implementations (e.g., Microsoft Windows, Samba, Apple SMB).
* Detailed packet-level analysis of specific SMB dialects (SMB 1.0, 2.x, 3.x).
* Configuration guides for specific operating systems.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **SMB (Server Message Block)** | A network file sharing protocol used for providing shared access to files, printers, and serial ports. |
| **Direct Hosting** | The method of running SMB directly over TCP/IP (Port 445) without the NetBIOS over TCP/IP (NBT) layer. |
| **CIFS** | Common Internet File System; a specific, older dialect of SMB. Often used interchangeably with SMB, though technically distinct. |
| **Named Pipe** | A method for inter-process communication that uses the SMB protocol to provide a communication channel between a client and a server. |
| **IPC$** | The Inter-Process Communication share, used for facilitating communication between processes and for remote administration. |
| **Dialect** | A specific version or variation of the SMB protocol negotiated during the initial connection phase. |

## Core Concepts
### Transport Mechanism
Port 445 utilizes the Transmission Control Protocol (TCP) to ensure reliable, ordered, and error-checked delivery of data. Unlike its predecessors, it does not require a separate name service (like WINS) to function, relying instead on standard DNS or IP-based addressing.

### The SMB Stack
When a connection is initiated on Port 445, the communication follows a structured hierarchy:
1.  **TCP Handshake:** Establishment of a connection on Port 445.
2.  **Protocol Negotiation:** The client and server agree on the highest supported SMB dialect.
3.  **Session Setup:** Authentication occurs (e.g., via NTLM or Kerberos).
4.  **Tree Connect:** The client requests access to a specific resource (share).

### Direct Hosting vs. NetBIOS
Direct hosting on Port 445 simplifies the protocol stack by removing the NetBIOS "Session Service" layer. This reduces the number of packets required to establish a session and eliminates the dependency on NetBIOS name resolution, which is often broadcast-heavy and non-routable.

## Standard Model
The standard model for Port 445 usage follows a strict Client-Server architecture:

1.  **Listener:** A server listens for inbound TCP SYN packets on Port 445.
2.  **Initiator:** A client initiates a connection to the server's IP address or FQDN on Port 445.
3.  **Encapsulation:** SMB messages are encapsulated directly within TCP segments. A 4-byte NetBIOS Session Service header (often called the "Direct TCP" header) precedes the SMB data to indicate the length of the SMB message.
4.  **Security:** Modern implementations require packet signing (to prevent man-in-the-middle attacks) and encryption (to ensure data privacy) at the protocol level, negotiated over this port.

## Common Patterns
*   **File Services:** Centralized storage access where clients map remote directories as local drives.
*   **Print Services:** Sending print jobs to a shared network printer.
*   **Remote Administration:** Using named pipes (e.g., `\pipe\svcctl`) over Port 445 to manage services or registry settings on a remote host.
*   **Domain Controller Communication:** In directory service environments, Port 445 is essential for Group Policy updates and authentication scripts.

## Anti-Patterns
*   **Public Exposure:** Exposing Port 445 directly to the public internet. This is a critical security risk due to the protocol's historical vulnerability to remote code execution (RCE) exploits.
*   **SMB 1.0 Usage:** Allowing the negotiation of SMB 1.0 (CIFS) over Port 445. SMB 1.0 is deprecated, inefficient, and lacks modern security features.
*   **Unsigned Traffic:** Disabling SMB signing on untrusted networks, which allows for relay attacks.
*   **Anonymous Access:** Permitting "Null Sessions" or anonymous access to IPC$ shares, which can leak sensitive system information to unauthorized users.

## Edge Cases
*   **SMB over QUIC:** A modern evolution that uses Port 443 (UDP) instead of Port 445 (TCP) to provide SMB access over untrusted networks without requiring a VPN.
*   **Port 445 Blocking in WAN:** Many Internet Service Providers (ISPs) block Port 445 by default to prevent the spread of malware, which can cause connectivity issues for remote workers attempting to access shares without a tunnel.
*   **Dual-Stack Environments:** Systems that listen on both 139 and 445. Generally, the client will attempt a connection on Port 445 first; if it fails or times out, it may fail back to Port 139.

## Related Topics
*   **NetBIOS (Ports 137, 138, 139):** The legacy transport for SMB.
*   **DNS (Port 53):** The primary name resolution mechanism for Direct Hosted SMB.
*   **Kerberos (Port 88):** The preferred authentication mechanism used during the SMB session setup.
*   **DFS (Distributed File System):** A logical grouping of shares that often utilizes Port 445 for referral and data access.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |