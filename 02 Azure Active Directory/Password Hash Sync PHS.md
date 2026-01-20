# [Password Hash Sync PHS](02 Azure Active Directory/Password Hash Sync PHS.md)

Canonical documentation for [Password Hash Sync PHS](02 Azure Active Directory/Password Hash Sync PHS.md). This document defines concepts, terminology, and standard usage.

## Purpose
Password Hash Sync (PHS) exists to facilitate identity synchronization between disparate directory services, typically bridging an on-premises identity provider (IdP) and a cloud-based IdP. The primary problem space it addresses is the requirement for "Same Sign-On" (SMSO) capabilities, allowing users to utilize the same credentials across different environments without requiring a persistent, real-time network connection to the source directory during the authentication event.

PHS provides a high-availability alternative to federated authentication by localizing the validation process within the target environment, thereby reducing latency and eliminating the source directory as a single point of failure for authentication requests.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* The theoretical mechanism of extracting, transforming, and transmitting cryptographic representations of passwords.
* Security considerations regarding hash handling and transport.
* The architectural role of PHS in hybrid identity models.
* Synchronization logic and consistency requirements.

**Out of scope:**
* Specific vendor implementations (e.g., Microsoft Entra Connect, Okta AD Agent).
* Detailed cryptographic algorithm specifications (e.g., SHA-256 vs. PBKDF2) unless used as illustrative examples.
* Hardware-level performance tuning.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Source Directory** | The authoritative identity store where the original password is set and the initial hash is generated. |
| **Target Directory** | The destination identity store where the synchronized hash is stored to facilitate local authentication. |
| **Password Hash** | A fixed-size numerical representation of a password, generated via a one-way cryptographic function. |
| **Re-Hashing** | The process of applying a secondary cryptographic function to an existing hash to meet the security requirements of the Target Directory. |
| **Synchronization Cycle** | The interval or trigger-based event during which changes in the Source Directory are propagated to the Target Directory. |
| **Entropy Injection** | The addition of random data (salting) during the re-hashing process to prevent rainbow table attacks. |

## Core Concepts

### One-Way Cryptographic Transformation
PHS does not involve the transmission of plaintext passwords. Instead, it relies on the transmission of a hash. Because the Target Directory often requires a different format or higher security standard than the Source Directory, the synchronization agent typically performs a "hash of a hash" transformation. This ensures that even if the Target Directory is compromised, the original Source Directory hash (and the plaintext password) remains unrecoverable.

### Asynchronous Propagation
PHS is inherently asynchronous. There is a temporal gap between a password change in the Source Directory and its availability in the Target Directory. This "convergence time" is a critical factor in identity consistency.

### Decoupled Authentication
Unlike Federation or Pass-Through Authentication (PTA), PHS allows the Target Directory to validate credentials independently. This decoupling ensures that if the Source Directory or the network path to it is unavailable, users can still authenticate to services relying on the Target Directory.

## Standard Model

The standard model for PHS follows a linear pipeline:

1.  **Extraction:** A synchronization agent queries the Source Directory for the attribute containing the password hash. This usually requires elevated permissions (e.g., Directory Replication-like rights).
2.  **Transformation (Re-Hashing):** To ensure the hash is secure for transport and storage in a different environment, the agent applies additional layers of encryption or hashing (e.g., applying a per-user salt and a high-iteration HMAC).
3.  **Transmission:** The transformed hash is sent over a secure channel (TLS) to the Target Directory.
4.  **Persistence:** The Target Directory stores the transformed hash in its own secure metadata store, associated with the synchronized user object.
5.  **Validation:** When a user attempts to sign in to the Target Directory, the provided plaintext password is run through the exact same transformation logic. If the resulting hash matches the stored hash, access is granted.

## Common Patterns

### Hybrid Identity Redundancy
PHS is frequently used as a backup mechanism for Federated Identity. If the Federation Service (STS) fails, the system can failover to PHS to ensure business continuity.

### Cloud-Only Authentication for Hybrid Users
In this pattern, the Source Directory remains the authority for identity management (Joiners/Movers/Leavers), but the Target Directory (Cloud) handles all authentication traffic to reduce on-premises infrastructure load.

### Multi-Forest Consolidation
PHS is used to aggregate identities from multiple disconnected Source Forests into a single Target Directory tenant, providing a unified login experience across a complex enterprise landscape.

## Anti-Patterns

### Bidirectional Hash Sync
Attempting to sync hashes from the Target Directory back to the Source Directory. This creates circular dependencies, increases the attack surface, and risks overwriting authoritative data with stale hashes.

### Plaintext Interception
Any architecture that requires the synchronization agent to capture the plaintext password (e.g., via a filter driver) rather than the hash is generally considered a security risk and is not true PHS.

### Bypassing Source Policy
Failing to synchronize account states (e.g., "Account Disabled" or "Expired") alongside the hash. If a hash is synced but the account is disabled in the Source, the user might still gain access to the Target if the status is not also synchronized.

## Edge Cases

### Password Expiration Synchronicity
If the Source Directory enforces password expiration, the Target Directory must be configured to either respect that expiration date via attribute sync or be aware that the hash will stop working once the Source Directory invalidates it.

### Complex Character Handling
Differences in character encoding (UTF-8 vs. UTF-16) between the Source and Target environments can lead to hash mismatches for passwords containing non-ASCII characters.

### Temporary Password Flags
When a user is flagged for "Must change password at next logon" in the Source Directory, the PHS mechanism must decide whether to allow the hash to work in the Target Directory or block authentication until the change occurs at the source.

## Related Topics
* **Federated Identity:** A model where authentication is delegated back to the Source Directory.
* **Pass-Through Authentication (PTA):** A model where the Target Directory validates the password by passing it to an agent in the Source environment in real-time.
* **Identity Provisioning:** The broader process of creating and managing user objects across systems.
* **Zero Trust Architecture:** The security framework that often utilizes PHS as a signal for risk-based authentication.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |