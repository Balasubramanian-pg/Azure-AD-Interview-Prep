## Copy-ready interview prep template (20-minute depth version)

Below is a clean, minimal template you can paste and reuse.
This is designed to be finished and revised inside **20 minutes per topic**, not admired like a museum artifact.

---

# Topic: Tree

## One-line definition
A tree is a hierarchical data structure.

## Why this matters in interviews
Trees appear in file systems, database indexing, and compiler design. Interviewers care about trees because they are fundamental to efficient data storage and retrieval.

## Core concepts (max 3)
* **Concept 1:** A tree consists of nodes with a value and child pointers.
* **Concept 2:** Each node in a tree has a unique path from the root node.
* **Concept 3:** Tree traversal algorithms visit nodes in a specific order.

## Key constraints and invariants
* Each node has a unique value or key.
* All nodes except the root have a parent node.
* The tree must be connected, with no isolated sub-trees.

## Common interview questions
* Explain a binary tree in simple terms
* Compare a tree with a graph
* Given a scenario where data needs to be efficiently searched, how would you apply a tree data structure?

## Tradeoffs and alternatives
* **Pros:** Efficient search, insertion, and deletion operations.
* **Cons:** Can be complex to implement and balance.
* **When to use instead:** Use a hash table for fast lookup, but no ordering.

## One worked example
* Input: A set of integers to be inserted into a binary search tree.
* Transformation / Logic: Insert each integer into the tree while maintaining the binary search tree property.
* Output: A balanced binary search tree with the inserted integers.

## Failure modes and debugging hints
* Failure mode 1: Unbalanced tree, causing search operations to degrade to O(n) time complexity.
* Failure mode 2: Incorrect tree traversal, resulting in incorrect results or infinite loops.
* Failure mode 3: Null pointer exceptions, caused by not checking for null child nodes.

## One-minute interview answer
A tree is a hierarchical data structure consisting of nodes with values and child pointers. It's useful for efficient data storage and retrieval, such as in file systems or database indexing. However, implementing a tree can be complex, and balancing the tree is crucial to maintain efficient search operations.

## Active practice (do immediately)
* **Task 1:** Draw a simple binary tree with 5 nodes and explain the tree traversal algorithms.
* **Task 2:** Answer the question "How would you implement a binary search tree in a programming language of your choice?" out loud without notes.

## Cheat sheet (TL;DR)
* Key definition: A tree is a hierarchical data structure.
* Core rule: Each node has a unique path from the root node.
* Common pitfall: Unbalanced trees can lead to inefficient search operations.
* Typical use case: File systems or database indexing.
* One comparison point: Trees are more efficient than linked lists for search operations.
* One quick example or formula: A balanced binary search tree has a height of log(n), where n is the number of nodes.

## Sources and verification
* Source name or URL: GeeksforGeeks - Tree Data Structure
* Mark anything time-sensitive as **NEEDS VERIFICATION**: No time-sensitive information.

## Self-test
* **Conceptual:** Why are trees useful for efficient data storage and retrieval?
* **Applied:** How would you implement a self-balancing binary search tree in a programming language of your choice?