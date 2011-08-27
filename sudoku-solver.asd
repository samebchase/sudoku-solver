;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage #:sudoku-solver-asd
  (:use :cl :asdf))

(in-package :sudoku-solver-asd)

(defsystem sudoku-solver
  :name "sudoku-solver"
  :author "Samuel"
  :description "Sudoku solver"
  :serial t
  :components ((:file "sudoku-solver" :depends-on ("packages"))
	       (:file "packages")))
  