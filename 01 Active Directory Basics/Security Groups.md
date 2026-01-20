## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Security Groups

## One-line definition
Security Groups control access to resources.

## Why this matters in interviews
Security Groups appear in cloud computing and network security, and interviewers care about them because they are crucial for securing infrastructure and data, and ensuring compliance with security policies.

## Core concepts (max 3)
* **Concept 1:** Security Groups are virtual firewalls that control inbound and outbound traffic to instances.
* **Concept 2:** Security Groups can be used to isolate resources and restrict access based on IP address, port, and protocol.
* **Concept 3:** Security Groups can be associated with multiple instances and can be used to scale security configurations.

## Key constraints and invariants
* Security Groups must be associated with a VPC or network.
* Security Groups must have a set of rules that define allowed inbound and outbound traffic.
* Security Groups must be configured to allow or deny traffic based on IP address, port, and protocol.

## Common interview questions
* Explain Security Groups in simple terms
* Compare Security Groups with Network Access Control Lists (NACLs)
* Given a scenario where you need to secure a web server, how would you apply Security Groups?

## Tradeoffs and alternatives
* **Pros:** Security Groups provide fine-grained control over traffic, are easy to manage, and can be used to scale security configurations.
* **Cons:** Security Groups can be complex to configure, and can have performance implications if not optimized.
* **When to use instead:** Use Network Access Control Lists (NACLs) when you need to control traffic at the subnet level, or use firewall rules when you need to control traffic at the instance level.

## One worked example
* Input: Create a Security Group to allow inbound HTTP traffic to a web server.
* Transformation / Logic: Create a Security Group with an inbound rule that allows TCP traffic on port 80 from any IP address.
* Output: The Security Group allows inbound HTTP traffic to the web server.

## Failure modes and debugging hints
* Failure mode 1: Incorrectly configured Security Group rules can block legitimate traffic, and why it happens is due to misunderstanding of the rules.
* Failure mode 2: Overly permissive Security Group rules can allow unauthorized access, and how to detect it is by monitoring traffic logs.
* Failure mode 3: Security Group rules can be outdated, and quick fix is to review and update the rules regularly.

## One-minute interview answer
Security Groups are virtual firewalls that control access to resources, and they are used to secure infrastructure and data by controlling inbound and outbound traffic. When to use Security Groups is when you need to isolate resources and restrict access based on IP address, port, and protocol. One tradeoff is that Security Groups can be complex to configure, but they provide fine-grained control over traffic.

## Active practice (do immediately)
* **Task 1:** Create a Security Group to allow inbound SSH traffic to a Linux instance.
* **Task 2:** Answer the interview-style question "How would you use Security Groups to secure a database instance?" out loud without notes.

## Cheat sheet (TL;DR)
* Key definition: Security Groups control access to resources.
* Core rule: Security Groups must be associated with a VPC or network.
* Common pitfall: Incorrectly configured Security Group rules can block legitimate traffic.
* Typical use case: Securing web servers and database instances.
* One comparison point: Security Groups vs Network Access Control Lists (NACLs).
* One quick example: Create a Security Group to allow inbound HTTP traffic to a web server.

## Sources and verification
* AWS Documentation: Security Groups
* Azure Documentation: Network Security Groups
* **NEEDS VERIFICATION:** Check the latest documentation for updates on Security Groups.

## Self-test
* **Conceptual:** Why are Security Groups important for securing infrastructure and data?
* **Applied:** How would you implement Security Groups to secure a web server and a database instance?