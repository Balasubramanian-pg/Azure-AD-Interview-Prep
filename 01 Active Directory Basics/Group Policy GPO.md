# Topic: Group Policy GPO

## One-line definition
Group Policy Objects manage Windows settings.

## Why this matters in interviews
Group Policy appears in enterprise Windows systems, interviewers care about it for security and management, and it's crucial for IT professionals.

## Core concepts (max 3)
* **Concept 1:** Group Policy Objects (GPOs) are collections of settings that define user and computer configurations.
* **Concept 2:** GPOs are applied to Active Directory sites, domains, or organizational units (OUs) to enforce policies.
* **Concept 3:** GPOs can be linked to multiple OUs, and their settings can be filtered using WMI or security filters.

## Key constraints and invariants
* GPOs must be applied in a specific order (local, site, domain, OU) to avoid conflicts.
* GPOs must be linked to an OU or site to be applied.
* GPO settings must be consistent across all linked OUs to avoid inconsistencies.

## Common interview questions
* Explain Group Policy in simple terms
* Compare Group Policy with Local Security Policy
* Given a scenario with multiple OUs, how would you apply Group Policy to enforce password policies?

## Tradeoffs and alternatives
* **Pros:** Centralized management, easy to apply settings to multiple computers, and improved security.
* **Cons:** Can be complex to manage, may have performance impacts, and requires Active Directory infrastructure.
* **When to use instead:** Use Local Security Policy for standalone computers or when Active Directory is not available.

## One worked example
* Input: Create a GPO to enforce a password policy with 12-character minimum length.
* Transformation / Logic: Link the GPO to the "Employees" OU, and set the password policy settings.
* Output: All computers in the "Employees" OU will have the enforced password policy.

## Failure modes and debugging hints
* Failure mode 1: GPO not applying due to incorrect link order, and why it happens due to inheritance rules.
* Failure mode 2: GPO settings not being applied due to WMI filter errors, and how to detect it using the Group Policy Results tool.
* Failure mode 3: GPO causing performance issues due to excessive processing, and quick fix by optimizing GPO settings or using a faster processing method.

## One-minute interview answer
Group Policy is a collection of settings that define user and computer configurations, and it's used to enforce security and management settings in enterprise Windows systems. It's particularly useful when you need to apply settings to multiple computers, but it can be complex to manage and may have performance impacts, so it's essential to weigh the pros and cons before implementing it.

## Active practice (do immediately)
* **Task 1:** Create a simple GPO to enforce a password policy, and explain the steps involved.
* **Task 2:** Answer the question "How would you troubleshoot a GPO not applying to a specific computer?" out loud without notes.

## Cheat sheet (TL;DR)
* Key definition: Group Policy Objects manage Windows settings.
* Core rule: GPOs are applied in a specific order (local, site, domain, OU).
* Common pitfall: Incorrect link order or WMI filter errors.
* Typical use case: Enforcing password policies or configuring security settings.
* One comparison point: Group Policy vs. Local Security Policy.
* One quick example: Creating a GPO to enforce a 12-character minimum password length.

## Sources and verification
* Microsoft Documentation: Group Policy (https://docs.microsoft.com/en-us/windows/win32/adschema/group-policy)
* Microsoft TechNet: Group Policy Planning and Deployment (https://social.technet.microsoft.com/wiki/contents/articles/13430.group-policy-planning-and-deployment.aspx)
* **NEEDS VERIFICATION:** Group Policy updates and changes in Windows 11.

## Self-test
* **Conceptual:** Why is it essential to consider the link order when applying GPOs?
* **Applied:** How would you implement a GPO to enforce a specific password policy in a large enterprise environment?