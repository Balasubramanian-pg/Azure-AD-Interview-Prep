# Topic: Common GPOs

## One-line definition
Group Policy Objects manage Windows settings.

## Why this matters in interviews
Common GPOs appear in Active Directory systems, and interviewers care about them because they impact network security and management. Interviewers want to assess the ability to configure and troubleshoot GPOs.

## Core concepts (max 3)
* **Concept 1:** GPOs define and apply settings to users and computers.
* **Concept 2:** GPOs can be linked to sites, domains, or organizational units.
* **Concept 3:** GPOs have a precedence order that determines which settings are applied.

## Key constraints and invariants
* GPOs must be applied in a specific order.
* GPOs must be linked to a container.
* GPOs must have a unique name.

## Common interview questions
* Explain Common GPOs in simple terms
* Compare GPOs with local group policies
* Given a scenario with multiple GPOs, how would you troubleshoot a settings conflict?

## Tradeoffs and alternatives
* **Pros:** Centralized management, easy to apply settings to multiple computers.
* **Cons:** Can be complex to configure, may have performance impact.
* **When to use instead:** Local group policies for standalone computers or when AD is not available.

## One worked example
* Input: Create a GPO to enforce a password policy.
* Transformation / Logic: Link the GPO to the domain, configure the password settings.
* Output: The password policy is applied to all computers in the domain.

## Failure modes and debugging hints
* Failure mode 1: GPO not applied due to incorrect link order, and why it happens due to precedence rules.
* Failure mode 2: GPO settings conflict, and how to detect it using the Group Policy Results tool.
* Failure mode 3: GPO not applied due to blocked inheritance, and quick fix by removing the block.

## One-minute interview answer
Common GPOs are used to manage Windows settings across an Active Directory network. They are useful when you need to apply consistent settings to multiple computers, but may have a performance impact if not configured correctly. For example, a GPO can be used to enforce a password policy, but you need to consider the tradeoff between security and usability.

## Active practice (do immediately)
* **Task 1:** Create a diagram showing the GPO precedence order.
* **Task 2:** Answer the question: "How would you troubleshoot a GPO settings conflict?"

## Cheat sheet (TL;DR)
* Key definition: GPOs manage Windows settings.
* Core rule: GPOs are applied in a specific order.
* Common pitfall: GPO settings conflicts.
* Typical use case: Enforcing a password policy.
* One comparison point: GPOs vs local group policies.
* One quick example: Linking a GPO to a domain.

## Sources and verification
* Microsoft Documentation: Group Policy
* Microsoft TechNet: Group Policy Planning and Deployment
* **NEEDS VERIFICATION:** Microsoft Support: Group Policy Troubleshooting

## Self-test
* **Conceptual:** Why are GPOs important in an Active Directory network?
* **Applied:** How would you implement a GPO to enforce a password policy in a domain?