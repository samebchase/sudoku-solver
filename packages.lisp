(ql:quickload 'iterate)

(in-package :cl-user)

(defpackage :sudoku-solver
  (:use common-lisp)
  (:use iterate))