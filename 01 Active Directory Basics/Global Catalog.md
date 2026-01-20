## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Global Catalog

## One-line definition
Global Catalog is a distributed repository of forest-wide data.

## Why this matters in interviews
Global Catalog appears in Active Directory systems, and interviewers care about it because it enables efficient searching and authentication across the forest, making it crucial for large-scale network management and security.

## Core concepts (max 3)
* **Concept 1:** Global Catalog stores a subset of attributes for all objects in the forest.
* **Concept 2:** It enables forest-wide searches and authentication, reducing the need for referrals.
* **Concept 3:** Global Catalog servers are responsible for replicating and maintaining the catalog data.

## Key constraints and invariants
* Constraint 1: Global Catalog must be accessible for forest-wide authentication and searches.
* Constraint 2: Global Catalog servers must be properly configured and replicated.
* Constraint 3: The catalog must contain a consistent subset of attributes for all objects.

## Common interview questions
* Explain Global Catalog in simple terms
* Compare Global Catalog with Domain Controller
* Given a multi-domain forest, how would you design Global Catalog servers for optimal performance?

## Tradeoffs and alternatives
* **Pros:** Enables efficient forest-wide searches and authentication, reduces referrals.
* **Cons:** Increases replication traffic, requires additional servers.
* **When to use instead:** Use a Domain Controller for single-domain authentication, or a third-party directory service for non-Active Directory environments.

## One worked example
* Input: A user attempts to log in to a domain in a multi-domain forest.
* Transformation / Logic: The Global Catalog is queried to resolve the user's identity and authenticate.
* Output: The user is authenticated and granted access to resources.

## Failure modes and debugging hints
* Failure mode 1: Global Catalog server failure, causing authentication issues.
* Failure mode 2: Inconsistent catalog data, leading to search errors.
* Failure mode 3: Insufficient replication, resulting in outdated catalog data.

## One-minute interview answer
The Global Catalog is a distributed repository of forest-wide data, enabling efficient searches and authentication across the forest. It's particularly useful in multi-domain environments, but requires careful planning and configuration to avoid increased replication traffic and server costs. For example, in a large enterprise with multiple domains, the Global Catalog can simplify user authentication and resource access.

## Active practice (do immediately)
* **Task 1:** Draw a diagram of a multi-domain forest with Global Catalog servers.
* **Task 2:** Answer the question: "How would you troubleshoot a Global Catalog server failure in a production environment?" out loud without notes.

## Cheat sheet (TL;DR)
* Key definition: Global Catalog is a distributed repository of forest-wide data.
* Core rule: Global Catalog servers must be properly configured and replicated.
* Common pitfall: Insufficient replication can lead to outdated catalog data.
* Typical use case: Multi-domain forest with thousands of users.
* One comparison point: Global Catalog vs. Domain Controller.
* One quick example: A user logging in to a domain in a multi-domain forest.

## Sources and verification
* Source name or URL: Microsoft Active Directory Documentation
* Mark anything time-sensitive as **NEEDS VERIFICATION**: Active Directory version-specific features.

## Self-test
* **Conceptual:** Why is the Global Catalog necessary in a multi-domain forest?
* **Applied:** How would you implement Global Catalog servers in a large enterprise with multiple domains and thousands of users?