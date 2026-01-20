# Topic: Organizational Unit

## One-line definition
An Organizational Unit is a subdivision of an organization.

## Why this matters in interviews
Organizational Units appear in real systems like Active Directory and LDAP, and interviewers care about it because it affects access control, security, and resource management.

## Core concepts (max 3)
* **Concept 1:** An Organizational Unit is a container that holds users, groups, and other units.
* **Concept 2:** Organizational Units can be nested to create a hierarchical structure.
* **Concept 3:** Each Organizational Unit has its own set of policies and permissions.

## Key constraints and invariants
* An Organizational Unit must have a unique name within its parent container.
* An Organizational Unit can only be a member of one parent container.
* An Organizational Unit must follow the naming conventions of the organization.

## Common interview questions
* Explain Organizational Unit in simple terms
* Compare Organizational Unit with a domain
* Given a company with multiple departments, how would you apply Organizational Units to manage access control?

## Tradeoffs and alternatives
* **Pros:** Easy to manage, flexible, and scalable.
* **Cons:** Can be complex to design and maintain.
* **When to use instead:** Use a flat structure when the organization is small and simple.

## One worked example
* Input: A company with three departments: Sales, Marketing, and IT.
* Transformation / Logic: Create an Organizational Unit for each department and assign users and groups accordingly.
* Output: A hierarchical structure with three Organizational Units, each with its own policies and permissions.

## Failure modes and debugging hints
* Failure mode 1: Incorrect naming conventions, which can cause conflicts and errors.
* Failure mode 2: Insufficient permissions, which can prevent users from accessing resources.
* Failure mode 3: Overly complex structure, which can make it difficult to manage and maintain.

## One-minute interview answer
An Organizational Unit is a subdivision of an organization that can be used to manage access control, security, and resource management. It's useful when an organization has multiple departments or teams that need to be managed separately. However, it can be complex to design and maintain, so it's essential to weigh the pros and cons before implementing it.

## Active practice (do immediately)
* **Task 1:** Draw a diagram of an Organizational Unit structure for a company with multiple departments.
* **Task 2:** Answer the following question out loud without notes: "How would you design an Organizational Unit structure for a company with 100 employees and five departments?"

## Cheat sheet (TL;DR)
* Key definition: An Organizational Unit is a subdivision of an organization.
* Core rule: Each Organizational Unit has its own set of policies and permissions.
* Common pitfall: Incorrect naming conventions.
* Typical use case: Managing access control and security for multiple departments.
* One comparison point: Organizational Units vs. domains.
* One quick example or formula: Create an Organizational Unit for each department and assign users and groups accordingly.

## Sources and verification
* Microsoft Active Directory documentation
* LDAP documentation
* **NEEDS VERIFICATION:** Latest security best practices for Organizational Units

## Self-test
* **Conceptual:** Why is it essential to have a unique name for each Organizational Unit?
* **Applied:** How would you implement an Organizational Unit structure for a company with multiple locations and departments?