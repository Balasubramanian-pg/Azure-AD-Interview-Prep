# Topic: Common GPOs

## One-line definition
Group Policy Objects manage Windows settings.

## Why this matters in interviews
Common GPOs appear in Active Directory systems, interviewers care about efficient management, and they impact network security.

## Core concepts (max 3)
* **Concept 1:** GPOs define and apply settings to users and computers.
* **Concept 2:** GPOs can be linked to sites, domains, or organizational units.
* **Concept 3:** GPOs have a precedence order that determines which policy applies.

## Key constraints and invariants
* GPOs must be applied in a specific order.
* GPOs must not conflict with each other.
* GPOs must be regularly updated and reviewed.

## Common interview questions
* Explain Common GPOs in simple terms
* Compare GPOs with local group policies
* Given scenario X, how would you apply a GPO to a specific OU?

## Tradeoffs and alternatives
* **Pros:** Centralized management, easy to apply, and scalable.
* **Cons:** Complexity, potential for conflicts, and dependencies on AD.
* **When to use instead:** Local group policies for standalone machines.

## One worked example
* Input: Create a GPO to enforce a password policy.
* Transformation / Logic: Define the password requirements and link the GPO to the domain.
* Output: All users in the domain must comply with the new password policy.
Time complexity: O(1), Space complexity: O(1).

## Failure modes and debugging hints
* Failure mode 1: GPO not applied due to incorrect link order, check the link order.
* Failure mode 2: GPO conflict, use the Group Policy Management Console to detect and resolve.
* Failure mode 3: Outdated GPO, regularly review and update GPOs.

## One-minute interview answer
Common GPOs are used to manage Windows settings across an Active Directory network, they are particularly useful for large-scale deployments, but one tradeoff is the potential for complexity and conflicts, so it's essential to carefully plan and regularly review GPOs.

## Active practice (do immediately)
* **Task 1:** Create a simple GPO to enforce a desktop wallpaper.
* **Task 2:** Answer the question "How would you troubleshoot a GPO not being applied?" out loud without notes.

## Cheat sheet (TL;DR)
* Key definition: GPOs manage Windows settings.
* Core rule: GPOs have a precedence order.
* Common pitfall: GPO conflicts.
* Typical use case: Enforcing password policies.
* One comparison point: GPOs vs local group policies.
* One quick example: Create a GPO to enforce a desktop wallpaper.

## Sources and verification
* Microsoft Documentation: Group Policy Objects
* TechNet: Group Policy Planning and Deployment
* **NEEDS VERIFICATION:** Microsoft Support: Group Policy Troubleshooting

## Self-test
* **Conceptual:** Why are GPOs essential in a large Active Directory network?
* **Applied:** How would you implement a GPO to enforce a specific software installation?