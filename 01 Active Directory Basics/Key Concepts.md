# Topic: Key Concepts

## One-line definition
Key concepts are fundamental ideas and principles.

## Why this matters in interviews
Key concepts appear in system design and problem-solving, interviewers care about them because they indicate a deep understanding of the subject matter and ability to apply it in real-world scenarios.

## Core concepts (max 3)
* **Concept 1:** Abstraction is the practice of hiding implementation details to focus on essential features.
* **Concept 2:** Encapsulation is the idea of bundling data and methods that operate on that data into a single unit.
* **Concept 3:** Modularity is the concept of breaking down a system into smaller, independent components.

## Key constraints and invariants
* Data consistency must always be maintained.
* System security must always be ensured.
* Performance requirements must always be met.

## Common interview questions
* Explain key concepts in simple terms
* Compare object-oriented programming with functional programming
* Given a scenario where you need to design a database, how would you apply key concepts like normalization and denormalization?

## Tradeoffs and alternatives
* **Pros:** Improved modularity, reusability, and maintainability.
* **Cons:** Increased complexity, potential for over-engineering.
* **When to use instead:** Use a monolithic architecture when the system is small and simple.

## One worked example
* Input: A simple e-commerce system with users, products, and orders.
* Transformation / Logic: Apply key concepts like encapsulation and modularity to design a scalable system.
* Output: A system with separate modules for user management, product management, and order management.
* Time complexity: O(1) for basic operations like user authentication.
* Space complexity: O(n) for storing user data.

## Failure modes and debugging hints
* Failure mode 1: Tight coupling between modules, which can lead to a rigid and hard-to-maintain system.
* Failure mode 2: Inconsistent data, which can be detected by implementing data validation and testing.
* Failure mode 3: Poor performance, which can be fixed by optimizing database queries and implementing caching.

## One-minute interview answer
Key concepts are fundamental ideas and principles that are essential for designing and developing scalable and maintainable systems. They include concepts like abstraction, encapsulation, and modularity, which can be applied in various scenarios like system design and problem-solving. However, applying key concepts can also lead to increased complexity, so it's essential to weigh the tradeoffs and consider alternatives like monolithic architecture for small and simple systems.

## Active practice (do immediately)
* **Task 1:** Design a simple system using key concepts like encapsulation and modularity.
* **Task 2:** Answer the question "How would you apply key concepts to design a scalable e-commerce system?" out loud without notes.

## Cheat sheet (TL;DR)
* Key definition: Fundamental ideas and principles.
* Core rule: Apply key concepts to design scalable and maintainable systems.
* Common pitfall: Tight coupling between modules.
* Typical use case: System design and problem-solving.
* One comparison point: Object-oriented programming vs functional programming.
* One quick example or formula: Separation of Concerns (SoC) principle.

## Sources and verification
* Source: "Design Patterns: Elements of Reusable Object-Oriented Software" by Erich Gamma et al.
* Source: "Clean Code: A Handbook of Agile Software Craftsmanship" by Robert C. Martin.
* Source: **NEEDS VERIFICATION** "Software Engineering at Google" by Titus Winters et al.

## Self-test
* **Conceptual:** Why is encapsulation essential in object-oriented programming?
* **Applied:** How would you implement a modular system using key concepts like abstraction and modularity?