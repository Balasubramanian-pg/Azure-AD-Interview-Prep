## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Computer Objects

## One-line definition
Computer objects represent real-world entities in code.

## Why this matters in interviews
Computer objects appear in object-oriented programming systems, and interviewers care about it because it shows understanding of abstraction and modularity, which are crucial for scalable and maintainable software design.

## Core concepts (max 3)
* **Concept 1:** Objects have properties and methods that define their behavior.
* **Concept 2:** Objects can inherit properties and methods from parent classes.
* **Concept 3:** Objects can be composed of other objects, enabling complex structures.

## Key constraints and invariants
* Constraint 1: Objects must have a unique identity.
* Constraint 2: Objects' properties and methods must be consistent with their class definition.
* Constraint 3: Objects' interactions must follow the rules of their class and the programming language.

## Common interview questions
* Explain computer objects in simple terms
* Compare object-oriented programming with functional programming
* Given scenario X, how would you apply object-oriented design principles?

## Tradeoffs and alternatives
* **Pros:** Modularity, reusability, and abstraction
* **Cons:** Increased complexity, potential for tight coupling
* **When to use instead:** Use functional programming for data processing and procedural programming for simple scripts

## One worked example
* Input: A car with properties (color, model) and methods (accelerate, brake)
* Transformation / Logic: Create a Car class with attributes and methods, then instantiate a Car object
* Output: A Car object with specific properties and behaviors
* Time complexity: O(1) for attribute access, O(n) for method execution
* Space complexity: O(n) for object storage

## Failure modes and debugging hints
* Failure mode 1: Null pointer exceptions due to uninitialized objects
* Failure mode 2: Inconsistent object state due to incorrect method calls
* Failure mode 3: Memory leaks due to unclosed resources

## One-minute interview answer
Computer objects represent real-world entities in code, enabling modularity and abstraction. Use object-oriented programming when designing complex systems with many interacting components, but be aware of the potential for increased complexity and tight coupling.

## Active practice (do immediately)
* **Task 1:** Draw a diagram of a simple object-oriented system with two classes and their relationships
* **Task 2:** Answer the question "How would you design a class to represent a bank account?" out loud without notes

## Cheat sheet (TL;DR)
* Key definition: Computer objects represent real-world entities in code
* Core rule: Objects have properties and methods that define their behavior
* Common pitfall: Null pointer exceptions due to uninitialized objects
* Typical use case: Designing complex systems with many interacting components
* One comparison point: Object-oriented programming vs. functional programming
* One quick example or formula: `class Car { attributes: color, model; methods: accelerate, brake }`

## Sources and verification
* Source name or URL: Oracle Java Documentation
* Mark anything time-sensitive as **NEEDS VERIFICATION**: **NEEDS VERIFICATION** for language-specific features

## Self-test
* **Conceptual:** Why do objects need to have a unique identity?
* **Applied:** How would you implement a class to represent a point in 3D space?