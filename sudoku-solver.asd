;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

;;(ql:quickload 'iterate)

(defpackage #:sudoku-solver-system (:use :cl :asdf))

(in-package :sudoku-solver-system)

(defsystem sudoku-solver
  :name "sudoku-solver"
  :author "Samuel"
  :description "Sudoku solver"
  :components
  ((:file "packages")
   (:file "sudoku-solver" :depends-on ("packages")))
  :depends-on (iterate))
	  
	  