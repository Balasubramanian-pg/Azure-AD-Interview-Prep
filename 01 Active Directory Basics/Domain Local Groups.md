## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Domain Local Groups

## One-line definition
Domain Local Groups manage access to resources.

## Why this matters in interviews
Domain Local Groups appear in Active Directory systems, and interviewers care about them because they impact access control and security. They are crucial for managing permissions and ensuring that users have the necessary access to resources.

## Core concepts (max 3)
* **Concept 1:** Domain Local Groups are used to assign permissions to resources.
* **Concept 2:** These groups can contain members from any domain in the forest.
* **Concept 3:** Domain Local Groups are typically used to manage access to shared resources.

## Key constraints and invariants
* Constraint 1: Domain Local Groups can only be created in a domain.
* Constraint 2: These groups can only be used to assign permissions to resources in the same domain.
* Constraint 3: Domain Local Groups must have a unique name within the domain.

## Common interview questions
* Explain Domain Local Groups in simple terms
* Compare Domain Local Groups with Global Groups
* Given a scenario where you need to manage access to a shared resource, how would you apply Domain Local Groups?

## Tradeoffs and alternatives
* **Pros:** Flexible access control, easy to manage permissions
* **Cons:** Can become complex to manage, may lead to over-provisioning of access
* **When to use instead:** Use Global Groups when you need to manage access to resources across multiple domains.

## One worked example
* Input: A company has a shared resource that needs to be accessed by users from multiple departments.
* Transformation / Logic: Create a Domain Local Group, add the shared resource to the group, and assign permissions to the group.
* Output: Users from multiple departments can access the shared resource through the Domain Local Group.

## Failure modes and debugging hints
* Failure mode 1: Over-provisioning of access, where users have more permissions than necessary.
* Failure mode 2: Under-provisioning of access, where users do not have the necessary permissions.
* Failure mode 3: Incorrect group membership, where users are not added to the correct group.

## One-minute interview answer
Domain Local Groups are used to manage access to resources in a domain. They are useful when you need to assign permissions to a group of users who need access to a shared resource. However, they can become complex to manage, and it's essential to balance the need for flexibility with the risk of over-provisioning access.

## Active practice (do immediately)
* **Task 1:** Create a diagram showing the relationship between Domain Local Groups, Global Groups, and shared resources.
* **Task 2:** Answer the following question out loud: "How would you use Domain Local Groups to manage access to a shared resource in a company with multiple departments?"

## Cheat sheet (TL;DR)
* Key definition: Domain Local Groups manage access to resources in a domain.
* Core rule: These groups can contain members from any domain in the forest.
* Common pitfall: Over-provisioning of access.
* Typical use case: Managing access to shared resources.
* One comparison point: Global Groups are used to manage access across multiple domains.
* One quick example: Create a Domain Local Group to manage access to a shared printer.

## Sources and verification
* Source name or URL: Microsoft Active Directory documentation
* Mark anything time-sensitive as **NEEDS VERIFICATION**: Active Directory best practices may change over time.

## Self-test
* **Conceptual:** Why are Domain Local Groups useful in managing access to resources?
* **Applied:** How would you implement a Domain Local Group to manage access to a shared resource in a company with multiple departments?