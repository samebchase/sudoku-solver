(defpackage #:sudoku-solver-system (:use :cl :asdf))

(in-package :sudoku-solver-system)

(defsystem sudoku-solver
  :name "sudoku-solver"
  :author "Samuel Chase"
  :description "Sudoku solver"
  :serial t
  :components
  ((:file "package")
   (:file "utils")
   (:file "file-input")
   (:file "sudoku-puzzle")
   (:file "sudoku-solver"))
  :depends-on (alexandria fiveam)
  :in-order-to ((test-op (test-op sudoku-solver-test))))

(defsystem sudoku-solver-test
  :components
  ((:file "test"))
  :depends-on (sudoku-solver))

