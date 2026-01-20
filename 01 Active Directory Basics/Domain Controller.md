## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Domain Controller

## One-line definition
A domain controller authenticates users and manages network resources.

## Why this matters in interviews
Domain controllers appear in enterprise networks, and interviewers care about them because they are crucial for security and access management. They want to assess your understanding of network infrastructure and authentication protocols.

## Core concepts (max 3)
* **Concept 1:** A domain controller is a server that stores and manages user accounts, groups, and permissions.
* **Concept 2:** Domain controllers use protocols like Kerberos for authentication and LDAP for directory services.
* **Concept 3:** They can be primary (master) or secondary (slave), with the primary controller holding the master copy of the directory database.

## Key constraints and invariants
* Constraint 1: A domain controller must be a trusted member of the domain.
* Constraint 2: All domain controllers must have a consistent view of the directory database.
* Constraint 3: Domain controllers must be able to communicate with each other to replicate changes.

## Common interview questions
* Explain the role of a domain controller in a network
* Compare a domain controller with a member server
* Given a scenario with multiple sites, how would you design a domain controller infrastructure?

## Tradeoffs and alternatives
* **Pros:** Centralized management, improved security, and simplified user authentication
* **Cons:** Single point of failure, increased complexity, and higher cost
* **When to use instead:** Consider using a member server or a cloud-based identity management service for smaller networks or those with limited IT resources.

## One worked example
* Input: A company with 100 employees and 2 sites
* Transformation / Logic: Design a domain controller infrastructure with 2 domain controllers (1 primary, 1 secondary) at each site, and configure replication and authentication protocols
* Output: A secure and fault-tolerant domain controller infrastructure

## Failure modes and debugging hints
* Failure mode 1: Domain controller failure due to hardware or software issues, resulting in authentication errors
* Failure mode 2: Inconsistent directory database due to replication issues, causing authentication problems
* Failure mode 3: Security breaches due to weak passwords or inadequate access controls, leading to unauthorized access

## One-minute interview answer
A domain controller is a server that manages user accounts, groups, and permissions, and is crucial for security and access management in enterprise networks. You would use a domain controller when you need centralized management and improved security, but be aware that it can be a single point of failure and increase complexity.

## Active practice (do immediately)
* **Task 1:** Draw a diagram of a simple domain controller infrastructure
* **Task 2:** Answer the question "What is the difference between a primary and secondary domain controller?" out loud without notes

## Cheat sheet (TL;DR)
* Key definition: A domain controller is a server that authenticates users and manages network resources
* Core rule: All domain controllers must have a consistent view of the directory database
* Common pitfall: Inconsistent directory database due to replication issues
* Typical use case: Enterprise networks with multiple sites and users
* One comparison point: Domain controller vs. member server
* One quick example: A company with 100 employees and 2 sites would need at least 2 domain controllers

## Sources and verification
* Source name or URL: Microsoft Documentation - Domain Controllers
* Mark anything time-sensitive as **NEEDS VERIFICATION**: Windows Server versions and updates

## Self-test
* **Conceptual:** Why is a domain controller necessary in a large enterprise network?
* **Applied:** How would you implement a domain controller infrastructure for a company with 500 employees and 5 sites?