;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage #:sudoku-solver-system (:use :cl :asdf))

(in-package :sudoku-solver-system)

(defsystem sudoku-solver
  :name "sudoku-solver"
  :author "Samuel"
  :description "Sudoku solver"
  :components
  ((:file "packages")
   (:file "sudoku-puzzle" :depends-on ("packages"))
   (:file "file-input" :depends-on ("packages" "sudoku-puzzle"))
   (:file "sudoku-solver" :depends-on ("file-input")))
  :depends-on (iterate alexandria))
