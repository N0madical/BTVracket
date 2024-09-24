# BTVracket
Binary Tree Visualizer for the Racket Coding Language

====== Binary Tree Visualizer ======

To get started:
1. Define a config as a (make-tree-config left-func right-func id-func name-func)
2. Call (get-tree binary-tree a-config)

Requires at least intermediate student with lambda to run

A binary-tree is a Struct with at least two properties which contain other binary-trees

left-func is the function used to call the left-binary-tree property of a binary-tree struct
right-func is the function used to call the right-binary-tree property of a binary-tree struct
Both should take one argument, a binary-tree, and return a different binary-tree

id-func should take in a binary-tree node and return that node's ID
name-func should take in a binary-tree node and return that node's name

=====     =====     =====     ======

Example:
#|

;;Defining a binary-tree as a (define-struct projnode (project-id title left right))

(define BINARY-TREE (make-projnode ...)

(define MY-CONFIG (make-tree-config projnode-left projnode-right projnode-project-id projnode-title))

(gen-tree BINARY-TREE MY-CONFIG)

;;That's it!

|#

=====     =====     =====     ======
