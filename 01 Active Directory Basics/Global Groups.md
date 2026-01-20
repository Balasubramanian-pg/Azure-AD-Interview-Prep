# Topic: Global Groups

## One-line definition
Global Groups are security entities.

## Why this matters in interviews
Global Groups appear in Active Directory systems, and interviewers care about them because they impact access control and security. They are crucial for managing user permissions.

## Core concepts (max 3)
* **Concept 1:** Global Groups are used to manage access to resources across an organization.
* **Concept 2:** They can contain users and other Global Groups from the same domain.
* **Concept 3:** Global Groups are typically used in combination with Universal and Domain Local Groups.

## Key constraints and invariants
* Constraint 1: A Global Group can only be created in the domain where the group will be used.
* Constraint 2: A Global Group can only contain members from its own domain.
* Constraint 3: A Global Group must have a unique name within its domain.

## Common interview questions
* Explain Global Groups in simple terms
* Compare Global Groups with Universal Groups
* Given a scenario where you need to manage access to a resource for users from different domains, how would you apply Global Groups?

## Tradeoffs and alternatives
* **Pros:** Easy to manage, flexible, and scalable.
* **Cons:** Can lead to complexity if not properly managed, may require additional infrastructure.
* **When to use instead:** Use Universal Groups when you need to manage access to resources across multiple domains.

## One worked example
* Input: Create a Global Group called "Marketing" in the "example.com" domain.
* Transformation / Logic: Add users from the "example.com" domain to the "Marketing" Global Group.
* Output: The "Marketing" Global Group now contains users from the "example.com" domain, and these users can access resources assigned to the group.

## Failure modes and debugging hints
* Failure mode 1: Incorrect group scope, which can lead to access issues.
* Failure mode 2: Insufficient permissions, which can prevent users from accessing resources.
* Failure mode 3: Group name duplication, which can cause confusion and errors.

## One-minute interview answer
Global Groups are security entities used to manage access to resources across an organization. They are typically used in combination with Universal and Domain Local Groups, and are useful when you need to manage access to resources for users within the same domain. However, one tradeoff to consider is that Global Groups can lead to complexity if not properly managed.

## Active practice (do immediately)
* **Task 1:** Create a diagram showing the relationship between Global Groups, Universal Groups, and Domain Local Groups.
* **Task 2:** Answer the following question out loud without notes: "How would you use Global Groups to manage access to a resource for users from different departments within the same domain?"

## Cheat sheet (TL;DR)
* Key definition: Global Groups are security entities used to manage access to resources.
* Core rule: A Global Group can only contain members from its own domain.
* Common pitfall: Incorrect group scope.
* Typical use case: Managing access to resources for users within the same domain.
* One comparison point: Global Groups vs. Universal Groups.
* One quick example: Creating a Global Group for a department.

## Sources and verification
* Source: Microsoft Active Directory documentation
* Source: ITPro Today article on Group Policy management
* Source: **NEEDS VERIFICATION** Microsoft TechNet article on Windows Server security

## Self-test
* **Conceptual:** Why are Global Groups important in an Active Directory environment?
* **Applied:** How would you implement a Global Group to manage access to a shared resource for users from different departments within the same domain?