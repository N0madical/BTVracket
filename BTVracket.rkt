;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname BTVracket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;====== Binary Tree Visualizer ======

;;By Aiden C

;;To get started:
;;1. Define a config as a (make-tree-config left-func right-func id-func name-func)
;;2. Call (get-tree binary-tree a-config)

;;Requires at least intermediate student with lambda to run

;;A binary-tree is a Struct with at least two properties which contain other binary-trees

;;left-func is the function used to call the left-binary-tree property of a binary-tree struct
;;right-func is the function used to call the right-binary-tree property of a binary-tree struct
;;Both should take one argument, a binary-tree, and return a different binary-tree

;;id-func should take in a binary-tree node and return that node's ID
;;name-func should take in a binary-tree node and return that node's name

;;=====     =====     =====     ======

;;Example:
#|

;;Defining a binary-tree as a (define-struct projnode (project-id title left right))

(define BINARY-TREE (make-projnode ...)

(define MY-CONFIG (make-tree-config projnode-left projnode-right projnode-project-id projnode-title))

(gen-tree BINARY-TREE MY-CONFIG)

;; That's it!

|#

;;=====     =====     =====     ======

(require 2htdp/image)
(require racket/format)

(define-struct tree-config (left-func right-func id-func name-func))


(define (helper-tree-part id title)
   (overlay/offset
    (text (~r id) 15 "black")
    0 20
    (overlay
      (circle 40 "outline" "black")
      (text title (round (- 28 (* (string-length title) 1.4))) "black")
    )
   )
)

(define (helper-make-node BST1 BST2 rows-bl id-func title-func)
  (local [(define WIDTH (* 80 (expt 2 rows-bl)))]
  (place-images
     (list
      (line (/ WIDTH 4) -25 "black")
      (line (/ WIDTH -4) -25 "black")
      (if (boolean? BST1)
          (helper-tree-part 0 "leaf")
          (helper-tree-part (id-func BST1) (title-func BST1))
      )
      (if (boolean? BST2)
          (helper-tree-part 0 "leaf")
          (helper-tree-part (id-func BST2) (title-func BST2))
      )
     )
     (list
      (make-posn (* 1.5 (/ WIDTH 4)) 12.5)
      (make-posn (* 2.5 (/ WIDTH 4)) 12.5)
      (make-posn (/ WIDTH 4) 65)
      (make-posn (* 3 (/ WIDTH 4)) 65)
     )
    (rectangle WIDTH 105 "outline" "white")
  )
 )
)

(define (helper-filler-rect rows-bl)
  (local [(define WIDTH (* 80 (expt 2 rows-bl)))]
    (rectangle WIDTH 105 "solid" "white")
  )
)

(define (helper-get-bst-height a-BT left-func right-func)
  (cond
    [(or (boolean? a-BT) (empty? a-BT)) -1]
    [else (local [
                  (define LEFT (helper-get-bst-height (left-func a-BT) left-func right-func))
                  (define RIGHT (helper-get-bst-height (right-func a-BT) left-func right-func))
                 ]
            (if (> LEFT RIGHT) (+ 1 LEFT) (+ 1 RIGHT))
          )
    ]
  )
)

(define (helper-make-tree a-BT height-in left-func right-func id-func name-func)
  (cond
    [(or
      (boolean? a-BT)
      (and (boolean? (left-func a-BT)) (boolean? (right-func a-BT)))
     )
     (if (> height-in 0)
         (above
          (helper-filler-rect height-in)
          (beside
           (helper-make-tree #false (- height-in 1) left-func right-func id-func name-func)
           (helper-make-tree #false (- height-in 1) left-func right-func id-func name-func)
           )
          )
         (helper-filler-rect height-in)
     )
     ]
    [else
  (above (helper-make-node (left-func a-BT) (right-func a-BT) height-in id-func name-func)
      (beside
          (helper-make-tree (left-func a-BT) (- height-in 1) left-func right-func id-func name-func)
          (helper-make-tree (right-func a-BT) (- height-in 1) left-func right-func id-func name-func)
      )
  )])
)

(define (gen-tree a-BT config-in)
  (above
   (helper-tree-part ((tree-config-id-func config-in) a-BT) ((tree-config-name-func config-in) a-BT))
   (helper-make-tree a-BT
              (helper-get-bst-height a-BT (tree-config-left-func config-in) (tree-config-right-func config-in))
              (tree-config-left-func config-in) (tree-config-right-func config-in)
              (tree-config-id-func config-in) (tree-config-name-func config-in))
  )
)