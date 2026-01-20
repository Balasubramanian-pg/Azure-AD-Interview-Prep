## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Global Groups

## One-line definition
Global Groups are security entities containing users or groups.

## Why this matters in interviews
Global Groups appear in Active Directory systems, and interviewers care about them because they impact access control and security. They are crucial for managing user permissions.

## Core concepts (max 3)
* **Concept 1:** Global Groups are used to organize users with similar roles or responsibilities.
* **Concept 2:** They can be nested within other groups to create a hierarchical structure.
* **Concept 3:** Global Groups can be used to assign permissions to resources.

## Key constraints and invariants
* Constraint 1: A Global Group can only be created in the domain where the group will be used.
* Constraint 2: Global Groups must have a unique name within the domain.
* Constraint 3: A user can be a member of multiple Global Groups.

## Common interview questions
* Explain Global Groups in simple terms
* Compare Global Groups with Local Groups
* Given a scenario where a company has multiple departments, how would you apply Global Groups to manage access control?

## Tradeoffs and alternatives
* **Pros:** Easy to manage, flexible, and scalable
* **Cons:** Can become complex if not properly organized
* **When to use instead:** Use Local Groups when access needs to be restricted to a specific resource or server.

## One worked example
* Input: A company has three departments: Sales, Marketing, and IT. Each department has its own set of users.
* Transformation / Logic: Create a Global Group for each department and add the respective users to each group.
* Output: Three Global Groups (Sales, Marketing, IT) with the respective users as members.

## Failure modes and debugging hints
* Failure mode 1: Incorrect group nesting, which can lead to access control issues.
* Failure mode 2: Duplicate group names, which can cause confusion and errors.
* Failure mode 3: Insufficient permissions, which can prevent users from accessing necessary resources.

## One-minute interview answer
Global Groups are security entities used to organize users with similar roles or responsibilities. They are useful when managing access control and permissions across multiple resources. However, they can become complex if not properly organized, so it's essential to weigh the benefits against the potential drawbacks.

## Active practice (do immediately)
* **Task 1:** Create a diagram showing the hierarchy of Global Groups in a company with multiple departments.
* **Task 2:** Answer the following question out loud: "How would you use Global Groups to manage access control in a company with multiple locations?"

## Cheat sheet (TL;DR)
* Key definition: Global Groups are security entities containing users or groups.
* Core rule: Global Groups must have a unique name within the domain.
* Common pitfall: Incorrect group nesting.
* Typical use case: Managing access control across multiple resources.
* One comparison point: Global Groups vs. Local Groups.
* One quick example: Creating a Global Group for a department and adding users to it.

## Sources and verification
* Source name or URL: Microsoft Active Directory documentation
* Mark anything time-sensitive as **NEEDS VERIFICATION**: Active Directory best practices

## Self-test
* **Conceptual:** Why are Global Groups important in access control management?
* **Applied:** How would you implement Global Groups in a company with multiple departments and locations?