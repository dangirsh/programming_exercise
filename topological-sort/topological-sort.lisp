;; Thanks Xach
(ql:quickload "lisp-unit" :silent t)

(defpackage topological-sort
  (:use #:cl #:lisp-unit)
  (:export #:topological-sort))

(in-package :topological-sort)

(cl:defstruct graph
  vertices
  edges
  )

(defvar *empty-graph*
  (make-graph :vertices '() :edges '()))

(defun find-entrypoint (graph)
  "Find some vertex with no parents (an entrypoint).
   Return the first vertex in the graph vertex list if several entrypoints exist.
   Return nil if no entrypoints exist."
  (flet ((no-parents (vertex)
           (null (rassoc vertex (graph-edges graph)))))
    (find-if #'no-parents (graph-vertices graph))))

(defun remove-vertex (graph vertex)
  "Return a new graph that's identical to the given graph, but with the given vertex removed."
  (make-graph :vertices (remove vertex (graph-vertices graph))
              :edges (remove-if (lambda (edge) (or (eql vertex (car edge))
                                              (eql vertex (cdr edge))))
                                (graph-edges graph))))

(defun %f (graph topological-ordering)
  "A function whose fixedpoint is
    (values *empty-graph* (topological-sort graph))
   when initially given (graph, nil)."
  (if (equalp graph *empty-graph*)
      (values graph topological-ordering)
      (let ((entrypoint (find-entrypoint graph)))
        (%f (remove-vertex graph entrypoint) (cons entrypoint topological-ordering)))))

(defun topological-sort (graph)
  (reverse (cadr (multiple-value-list (%f graph '())))))


(defvar *example-one*
  (make-graph :vertices '(a b c d)
              :edges '((a . b)
                       (a . c)
                       (b . d)
                       (c . d))))

(defvar *example-two*
  (make-graph :vertices '(a b c d e)
              :edges '((a . b)
                       (a . c)
                       (b . d)
                       (c . d)
                       (e . c))))

(define-test my-test
    (assert-equal (topological-sort *example-one*)
                  '(A B C D))
  (assert-equal (topological-sort *example-two*)
                  '(A B E C D)))
