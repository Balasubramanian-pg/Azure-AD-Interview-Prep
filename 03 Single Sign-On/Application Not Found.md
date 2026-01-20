# [Application Not Found](03 Single Sign-On/Application Not Found.md)

Canonical documentation for [Application Not Found](03 Single Sign-On/Application Not Found.md). This document defines concepts, terminology, and standard usage.

## Purpose
The "[Application Not Found](03 Single Sign-On/Application Not Found.md)" state represents a critical resolution failure within a computing environment. It occurs when a system—acting as an orchestrator or user agent—receives a request to invoke a specific functional entity but cannot map the provided identifier to a valid, executable, or accessible resource. 

This topic addresses the mechanics of application discovery, the lifecycle of registration, and the failure modes of the resolution chain. It exists to provide a framework for understanding how systems manage the gap between a user's intent (e.g., "open this file type") and the system's capability (e.g., "no handler registered").

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* **Resolution Logic:** The theoretical process of mapping identifiers to targets.
* **Registration Lifecycle:** How applications announce their presence to a host system.
* **Invocation Failures:** The taxonomy of why a lookup fails.
* **State Management:** The condition of the system when a requested resource is missing.

**Out of scope:**
* **Specific Vendor Implementations:** Troubleshooting specific Windows Registry keys, Android Intent filters, or macOS Launch Services.
* **Network-level 404 Errors:** While conceptually similar, "[Application Not Found](03 Single Sign-On/Application Not Found.md)" refers to the execution layer rather than the transport layer.

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Identifier** | A unique token (URI, UUID, File Extension, or Protocol) used to reference a specific application or class of applications. |
| **Resolver** | The system component responsible for translating an Identifier into a physical path or execution context. |
| **Registry/Manifest** | The central database or configuration store where application capabilities are recorded. |
| **Invocation** | The act of attempting to initialize or call the target application. |
| **Association** | The logical link between a data type (e.g., `.pdf`) and a specific application handler. |
| **Zombie Registration** | A state where the Registry contains a reference to an application that has been deleted or moved without updating the Resolver. |

## Core Concepts

### The Resolution Chain
The "[Application Not Found](03 Single Sign-On/Application Not Found.md)" state is the terminal output of a failed Resolution Chain. This chain typically follows three steps:
1.  **Request:** A trigger (user click, script call, or system event) provides an Identifier.
2.  **Lookup:** The Resolver queries the Registry/Manifest for the Identifier.
3.  **Validation:** The Resolver verifies that the target located in the Registry actually exists and is executable in the current context.

### Intent vs. Implementation
Systems distinguish between **Explicit Intent** (calling a specific app by its unique ID) and **Implicit Intent** (requesting any app that can handle a specific data type). An "[Application Not Found](03 Single Sign-On/Application Not Found.md)" error occurs in Explicit Intent when the ID is missing, and in Implicit Intent when no handlers are registered for that type.

## Standard Model
The generally accepted model for handling application discovery follows the **Registry-Resolver-Target (RRT)** framework:

1.  **Registration:** Upon installation, an application must register its Identifiers and capabilities with the host system.
2.  **Discovery:** When an Invocation is triggered, the Resolver performs a prioritized search (e.g., User-level associations first, then System-level defaults).
3.  **Verification:** Before returning a "Success" state, the system performs a "Stat" check to ensure the binary or service is reachable.
4.  **Exception Handling:** If the lookup or verification fails, the system enters the "[Application Not Found](03 Single Sign-On/Application Not Found.md)" state and must emit a standardized exception to the caller.

## Common Patterns

### Fallback Handlers
To avoid the "[Application Not Found](03 Single Sign-On/Application Not Found.md)" state, systems often implement a "Generic Handler" or "Open With" dialog. This pattern shifts the resolution responsibility from the system back to the user.

### Store Redirection
In modern operating environments, if an application is not found, the Resolver may redirect the Identifier to a centralized repository (App Store/Package Manager) to suggest a download for the missing handler.

### Lazy Resolution
The system does not verify the existence of the application until the exact moment of invocation. This improves performance but increases the likelihood of encountering an "[Application Not Found](03 Single Sign-On/Application Not Found.md)" error during runtime.

## Anti-Patterns

### Hard-coded Pathing
Relying on absolute file system paths rather than symbolic Identifiers. If the application is moved, the system fails to find it despite the application being present.

### Silent Failure
Suppressing the "[Application Not Found](03 Single Sign-On/Application Not Found.md)" error without providing feedback to the user or the calling process. This leads to "Dead Clicks" where the system appears unresponsive.

### Orphaned Registries
Failing to clean up the Registry/Manifest during an application's decommissioning (uninstallation). This leads to the system attempting to launch non-existent targets.

## Edge Cases

### Sandboxed Isolation
An application may exist on the system, but the calling process lacks the permissions to "see" or "invoke" it. From the perspective of the caller, the application is "Not Found," even though it is physically present.

### Version Mismatch (Shadowing)
When multiple versions of an application exist, the Resolver may find an older version that does not support the requested intent, effectively resulting in a "Functional [Application Not Found](03 Single Sign-On/Application Not Found.md)" state.

### Race Conditions
An application is uninstalled or moved in the millisecond between the Resolver's "Validation" step and the "Invocation" step.

## Related Topics
* **Service Discovery:** The network-equivalent of application resolution.
* **Dependency Management:** Ensuring required applications/libraries are present before execution.
* **URI Scheme Handling:** The specific logic for resolving `protocol://` identifiers.
* **MIME Type Mapping:** The logic for resolving file-to-application associations.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |