# TREE

## Introduction  
A **tree** is a hierarchical data structure consisting of nodes connected by edges, forming a hierarchy without cycles. Trees are used to represent hierarchical relationships, sequences of decisions, and organizational structures in computer science, mathematics, biology, and other fields. Key characteristics of trees include their branching nature, root (topmost node), parent-child relationships, and constraints such as acyclicity and connectedness. Trees are foundational for applications like file systems, network routing, decision-making algorithms, and database indexing.  

---

## Core Concepts  

### Node  
- The basic unit of a tree, consisting of a **value** and **children pointers** (or edges connecting to other nodes).  
- Each node except the root has exactly one **parent node**.  

### Root  
- The single node at the top of the hierarchy (no parent).  
- Serves as the starting point for traversing the tree.  

### Parent and Child  
- A **parent node** has edges leading to **child nodes**.  
- Each node (except the root) has one parent and may have zero or more children.  

### Sibling  
- Nodes sharing the same parent are **siblings**.  

### Leaf (Terminal Node)  
- A node with no children.  

### Edge  
- A connection between a parent and child node.  

### Path  
- A sequence of nodes connected by edges, forming a traversal route from node to node.  
- The **distance** between nodes is the number of edges on the path.  

### Depth  
- The depth of a node is the number of edges from the root to the node (root depth is 0).  

### Height  
- The height of a node is the number of edges on the longest path from the node to a leaf.  
- The height of the tree is the height of its root.  

### Subtree  
- A subset of the tree formed by a node and its descendants, considered as a separate tree.  

### Tree Traversal  
- **DFS (Depth-First Search):**  
  - **Pre-order:** Visit node, then traverse left and right subtrees.  
  - **In-order:** Traverse left subtree, visit node, then traverse right subtree (common in BSTs).  
  - **Post-order:** Traverse left and right subtrees before visiting the node.  
- **BFS (Breadth-First Search):** Traverse nodes level by level, starting from the root.  

---

### Tree Types  
1. **Binary Tree**  
   - Each node has at most two children (left and right).  
2. **Binary Search Tree (BST)**  
   - Left child is ≤ parent; right child is ≥ parent. Enforces ordering for efficient insertion, deletion, and search.  
3. **AVL Tree**  
   - A self-balancing BST where the height difference between left and right subtrees is ≤ 1.  
4. **B-tree**  
   - Multiway tree optimized for disk storage; commonly used in databases.  
5. **Heap**  
   - A BST-like structure where every parent node is less than (min-heap) or greater than (max-heap) its children.  
6. **Huffman Tree**  
   - Used for data compression algorithms.  
7. **Decision Tree**  
   - Used in machine learning for classification or regression tasks.  

---

### Key Metrics  
- **Degree:** The number of children a node has.  
- **Depth:** See "Depth" above.  
- **Height:** See "Height" above.  
- **Size:** Total number of nodes in the tree.  

---

## Examples  

### 1. **File System Hierarchy**  
- A directory tree with the root as the main folder and subdirectories/files as children.  
  ```
  Root (/)  
  ├── Home  
  │   ├── User1  
  │   └── User2  
  └── Programs  
      ├── App1  
      └── App2  
  ```  

### 2. **Parse Tree in Compilers**  
- Represents the structure of an arithmetic expression:  
  ```
  *  
 / \  
+  5  
/ \  
3  2  
```  
Here, the `+` node has children `3` and `2`, and the `*` node is the root.  

### 3. **Decision Tree for Classification**  
- Used to predict outcomes based on features:  
  ```
  Should I play tennis?  
      / \  
  Sunny / \ Rainy  
   /     \  
Yes         No  
  ```  

### 4. **Sample Tree for Traversal**  
Consider the tree:  
```
A  
├── B  
│   ├── D  
│   └── E  
└── C  
```  
- **Pre-order:** `A -> B -> D -> E -> C`  
- **In-order (BST):** `D -> B -> E -> A -> C` (assuming node order follows BST properties).  
- **Post-order:** `D -> E -> B -> C -> A`  
- **BFS (Level-order):** `A -> B -> C -> D -> E`  

---

### 5. **Binary Search Tree (BST) Example**  
A BST with nodes: 8 (root), 3, 10, 1, 6, 14.  
```
    8  
   / \  
  3   10  
 / \    \  
1   6    14  
```  
- **In-order traversal** yields a sorted list: `1, 3, 6, 8, 10, 14`.  

---

## Summary  
Trees are versatile hierarchical structures with nodes and edges, critical for organizing and representing relationships. Core components include the **root**, **children**, **siblings**, **paths**, and **subtrees**. Key operations include traversal (DFS/BFS) and balancing (AVL/B-tree). Tree types like BST, AVL, and heaps enable optimized data storage and retrieval. Applications span file systems, databases, compilers, and machine learning. Understanding tree properties and traversal algorithms is essential for leveraging these structures effectively in problem-solving and algorithm design.

---
*Generated by Puter.js & Qwen*