(in-package :sudoku-solver)

(defvar *path* "/home/samuel/projects/sudoku-solver/src/lisp/sudoku.txt")

(defmethod solve ((puzzle sudoku-puzzle))
  (grid puzzle))

(defun puzzle-list () 
  (loop for string-list in (group-into 9 (remove-if #'first-char-alphap (read-lines *path*)))
     for puzzle = (make-instance 'sudoku-puzzle) do (row-strings-to-puzzle puzzle string-list)
     collect puzzle))

(defparameter *puzzles* (puzzle-list))

;; (loop repeat 10 do 
;;      (loop for value being the hash-values of (unsolved-cells foo) do
;; 	  (if (= (length (row-col-subgrid-possibilities foo (car value) (cdr value))) 1)
;; 	      (setf (aref (grid foo) (car value) (cdr value)) (row-col-subgrid-possibilities foo (car value) (cdr value))))))
