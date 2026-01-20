# [RPC Endpoint Mapper Port 135](11 Key Ports for AD and Azure AD/RPC Endpoint Mapper Port 135.md)

Canonical documentation for [RPC Endpoint Mapper Port 135](11 Key Ports for AD and Azure AD/RPC Endpoint Mapper Port 135.md). This document defines concepts, terminology, and standard usage.

## Purpose
The RPC Endpoint Mapper (EPM) exists to facilitate the discovery and connection process for Remote Procedure Call (RPC) services within a distributed computing environment. In complex network architectures, services often utilize dynamically assigned ports to avoid conflicts and maximize resource utilization. The Endpoint Mapper acts as a centralized directory or "lookup service" that allows clients to resolve a service's unique identifier (UUID) to the specific network endpoint (TCP/UDP port) where that service is currently listening.

This mechanism addresses the problem of static port exhaustion and the administrative burden of manually managing port assignments for hundreds of potential distributed services.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The architectural role of the Endpoint Mapper in the DCE/RPC (Distributed Computing Environment / Remote Procedure Call) model.
* The mechanism of service registration and endpoint resolution.
* The protocol-level interaction occurring on TCP/UDP Port 135.
* Theoretical boundaries of the mapping lifecycle.

**Out of scope:**
* Specific vendor implementations (e.g., Microsoft RPC, Samba, DCE).
* Operating system-specific configuration commands or registry keys.
* Security vulnerabilities or exploit histories associated with specific software versions.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **RPC (Remote Procedure Call)** | A protocol that allows a program to execute code on a remote server as if it were a local function call. |
| **Endpoint** | The specific network address and port (e.g., TCP 49152) where a server process listens for incoming RPC requests. |
| **Interface UUID** | A Universally Unique Identifier that distinguishes a specific RPC interface or service from all others. |
| **Protocol Sequence** | A string representing the network transport used for the RPC communication (e.g., `ncacn_ip_tcp`). |
| **Endpoint Map** | The internal database maintained by the mapper containing the associations between UUIDs and active endpoints. |
| **Tower** | A data structure used by the EPM to describe the full protocol stack required to reach an RPC service. |

## Core Concepts

### The Discovery Mechanism
The Endpoint Mapper operates on the principle of "Late Binding." Instead of a client knowing the destination port at compile-time or through static configuration, it queries the Mapper at runtime. This allows the server-side services to start on any available ephemeral port.

### The Registration Lifecycle
1.  **Service Initialization:** An RPC server starts and requests a dynamic port from the operating system.
2.  **Registration:** The server sends a registration request to the Endpoint Mapper (listening on Port 135), providing its Interface UUID, version, and the assigned dynamic port.
3.  **Maintenance:** The Mapper maintains this entry as long as the service process is active.
4.  **Resolution:** When a client wishes to communicate with that UUID, it first connects to Port 135 to ask, "Where is this interface located?"
5.  **Redirection:** The Mapper returns the dynamic port, and the client initiates a new connection to that specific port.

## Standard Model
The standard model for RPC Endpoint Mapping follows the DCE/RPC specification. 

1.  **Transport:** The Mapper must listen on a "Well-Known Endpoint," which is standardized as Port 135 (TCP and UDP).
2.  **Communication Flow:**
    *   **Client -> EPM (Port 135):** `ept_map` request containing the desired Interface UUID.
    *   **EPM -> Client:** Response containing the "Tower" (the protocol sequence and port number).
    *   **Client -> Service (Dynamic Port):** The actual RPC functional call.
3.  **Database Structure:** The Mapper maintains a volatile database. If the Mapper service restarts, all dynamic registrations are typically lost and must be re-registered by the individual services.

## Common Patterns

### Dynamic Port Allocation
The most common pattern where the RPC runtime environment assigns a port from the ephemeral range (typically 49152–65535) to a service upon startup. This maximizes flexibility and prevents port collisions.

### Fixed-Port Registration
In some scenarios, a service may be configured to always use a specific port. Even in these cases, the service still registers with the Endpoint Mapper so that clients can use the standard discovery flow regardless of whether the port is static or dynamic.

### Multi-Protocol Support
The Endpoint Mapper can store mappings for multiple transport protocols simultaneously (e.g., TCP, UDP, and Named Pipes), allowing the client to choose the most efficient transport available.

## Anti-Patterns

### Hardcoding Client-Side Ports
Bypassing the Endpoint Mapper by hardcoding dynamic port numbers in client applications. This leads to connection failures whenever the server service restarts and receives a different ephemeral port.

### Exposing Port 135 to Untrusted Networks
Exposing the Endpoint Mapper to the public internet or untrusted network segments. Because the Mapper reveals the internal service topology and available interfaces of a host, it is a high-value target for reconnaissance.

### Manual Port Management for RPC Services
Attempting to manually assign static ports to all RPC services to avoid using Port 135. This increases administrative overhead and negates the primary benefit of the RPC architecture.

## Edge Cases

### Port Exhaustion
If the ephemeral port range is exhausted, services may fail to register with the Endpoint Mapper, or the Mapper may return valid-looking but unreachable endpoints if the OS reclaims ports aggressively.

### Firewall/NAT Interference
In environments with strict firewalls, Port 135 may be open, but the dynamic port range (e.g., 49152+) may be closed. The client will successfully resolve the endpoint via the Mapper but fail to connect to the actual service. This is often mistaken for an RPC Mapper failure.

### Multi-Homed Hosts
On a server with multiple Network Interface Cards (NICs), the Endpoint Mapper must correctly identify which IP address is associated with the registered port. If the Mapper returns an IP address unreachable by the client, the resolution succeeds but the subsequent connection fails.

## Related Topics
*   **DCE/RPC Specification:** The underlying standard for distributed computing.
*   **Ephemeral Ports:** The range of ports used for dynamic assignment.
*   **Interface Definition Language (IDL):** The language used to define the RPC interfaces that are registered with the Mapper.
*   **Service Discovery Protocols:** Broader concepts of locating services in a network (e.g., DNS-SD, mDNS).

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |