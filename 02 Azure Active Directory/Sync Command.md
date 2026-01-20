# [Sync Command](02 Azure Active Directory/Sync Command.md)

Canonical documentation for [Sync Command](02 Azure Active Directory/Sync Command.md). This document defines concepts, terminology, and standard usage.

## Purpose
The [Sync Command](02 Azure Active Directory/Sync Command.md) exists to resolve state divergence between two or more distinct data entities. In distributed systems, decoupled architectures, or tiered storage environments, data naturally drifts over time due to localized updates, network latency, or independent processing. 

The primary purpose of a [Sync Command](02 Azure Active Directory/Sync Command.md) is to perform **reconciliation**: the process of identifying differences (deltas) and applying the necessary operations to bring the target state into alignment with the source state (or to bring both into a unified state). It ensures data integrity, consistency, and availability across disparate environments.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* **State Reconciliation:** The logic of comparing and aligning datasets.
* **Directionality:** The flow of data (unidirectional vs. bidirectional).
* **Conflict Resolution:** Theoretical approaches to handling overlapping changes.
* **Atomicity and Integrity:** Ensuring the sync process leaves the system in a valid state.

**Out of scope:**
* **Specific Vendor Implementations:** CLI syntax for specific tools (e.g., `rsync`, `git sync`, `aws s3 sync`).
* **Hardware-level Synchronization:** Low-level CPU clock synchronization or memory barriers.
* **UI/UX Design:** The visual representation of sync progress bars or buttons.

## Definitions
| Term | Definition |
|------|------------|
| **Source** | The entity designated as the "truth" or the origin of the data to be propagated. |
| **Target** | The entity that receives updates to match the source; also referred to as the "Destination." |
| **State Drift** | The degree of divergence between the source and target since the last successful synchronization. |
| **Delta** | The specific set of changes (additions, modifications, deletions) required to align two states. |
| **Idempotency** | The property where a command can be executed multiple times without changing the result beyond the initial application. |
| **Reconciliation** | The algorithmic process of comparing states and determining the necessary actions to achieve consistency. |
| **Conflict** | A scenario where both source and target have changed the same data point in incompatible ways since the last sync. |

## Core Concepts

### 1. Directionality
*   **Unidirectional (Push/Pull):** Data flows in one direction. The source overwrites or updates the target.
*   **Bidirectional (Two-way):** Changes from both entities are merged. This requires more complex conflict resolution logic.

### 2. Granularity
*   **Full Sync:** The entire dataset is compared and transferred. This is highly reliable but resource-intensive.
*   **Incremental Sync:** Only the changes (deltas) since the last known synchronization point are transferred. This is efficient but relies on accurate change tracking.

### 3. Trigger Mechanisms
*   **Event-Driven:** Sync is triggered by a change in the source (e.g., a file save or database write).
*   **Scheduled:** Sync occurs at defined intervals (e.g., cron jobs).
*   **Manual:** Sync is initiated by an external actor or administrator.

## Standard Model
The standard model for a [Sync Command](02 Azure Active Directory/Sync Command.md) follows a four-phase lifecycle:

1.  **Discovery:** The system identifies the current state of both the source and the target.
2.  **Comparison:** An algorithm (often using checksums, timestamps, or version vectors) identifies the deltas.
3.  **Transfer/Application:** The identified deltas are transmitted and applied to the target.
4.  **Verification:** The system confirms that the target now matches the source (often via a post-sync hash check).

## Common Patterns

### Mirroring
The target is made to be an exact replica of the source. Any files or data present on the target but not the source are deleted. This is the strictest form of unidirectional sync.

### Delta Encoding
To save bandwidth, only the specific bytes or blocks that have changed within a file are transmitted, rather than the entire file.

### Checkpoint/Watermarking
The system maintains a "high-water mark" (such as a timestamp or transaction ID). The next sync command only requests data with a marker greater than the last recorded checkpoint.

## Anti-Patterns

### Blind Overwrite
Executing a sync without first verifying the state of the target. This can lead to "lost updates" if the target contained independent changes that were not accounted for.

### Circular Synchronization
In multi-node systems, a configuration where Node A syncs to Node B, and Node B syncs back to Node A without proper loop detection, leading to infinite data loops or "echoes."

### Lack of Idempotency
Designing a sync command that creates duplicate records if interrupted and restarted. A sync command should always be safe to retry.

### Dependency on System Clocks
Relying solely on local system timestamps for reconciliation. Clock skew between different servers can lead to incorrect "last writer wins" decisions.

## Edge Cases

*   **Network Partitioning:** If the connection drops mid-sync, the system must decide whether to roll back (atomicity) or allow a partial sync (resumability).
*   **Race Conditions:** If the source data is modified *while* the sync command is reading it, the resulting target state may be inconsistent.
*   **Deleted Item Tracking:** In incremental syncs, identifying that an item was deleted (rather than just missing) often requires "tombstones" or a persistent deletion log.
*   **Permission Mismatches:** The sync command may successfully move data but fail to replicate metadata like ownership, permissions, or attributes, leading to functional failures.

## Related Topics
*   **Eventual Consistency:** A theoretical guarantee that all nodes will eventually match if no new updates are made.
*   **Idempotency in APIs:** The design of operations that can be repeated safely.
*   **Conflict-free Replicated Data Types (CRDTs):** Data structures that resolve conflicts automatically by design.
*   **Version Control Systems:** Specialized implementations of sync commands for source code.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |